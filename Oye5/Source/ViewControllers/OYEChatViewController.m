//
//  OYEChatViewController.m
//  Oye5
//
//  Created by Rita Kyauk on 4/24/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

#import "OYEChatViewController.h"
#import "OYEChatMessageTableViewCell.h"
#import "OYEChatMessage.h"
#import "Oye5-Swift.h"

static NSString * const OYEChatIncomingMessageResuseCellIdentifier = @"OYEChatIncomingMessage";
static NSString * const OYEChatOutgoingMessageResuseCellIdentifier = @"OYEChatOutgoingMessage";

@interface OYEChatViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendButtonWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *editViewBottomSpace;

@property (strong, nonatomic) NSMutableArray *messages;
@property (strong, nonatomic) SocketIOClient *socket;

@end

@implementation OYEChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self setupTableView];
    [self setupEditView];
    [self setupMessages];
    [self setupSocketIO];
    [self setupNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OYEChatMessageTableViewCell class]) bundle:[NSBundle bundleForClass:[OYEChatMessageTableViewCell class]]] forCellReuseIdentifier:OYEChatIncomingMessageResuseCellIdentifier];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:OYEChatOutgoingMessageResuseCellIdentifier];
}

- (void)setupEditView {
    [self setupTextField];
    [self setupSendButton];
}

- (void)setupTextField {
}

- (void)setupSendButton {
    [self setupSendButtonWithString:self.textField.text];
}

- (void)setupSendButtonWithString:(NSString *)string {
    self.sendButton.hidden = (string.length == 0);
    [UIView animateWithDuration:0.3 animations:^{
        if (self.sendButton.hidden) {
            self.sendButtonWidth.constant = 0;
        } else {
            self.sendButtonWidth.constant = 46;
        }
        
        [self.sendButton layoutIfNeeded];
        [self.textField layoutIfNeeded];
    }];
}

- (void)setupMessages {
    self.messages = [NSMutableArray array];
}

- (void)setupSocketIO {
    self.socket = [[SocketIOClient alloc] initWithSocketURLString:@"http://localhost:3000" options:nil];
    
    [self setupHandlers];
    
    [self.socket connect];
}

- (void)setupHandlers {
    
    [self.socket on:@"chat message" callback:^(NSArray * _Nonnull messages, SocketAckEmitter * _Nonnull emitter) {
        DDLogDebug(@"messages: %@ emitter: %@", messages, emitter);
        [self addChatMessage:messages.firstObject type:OYEChatMessageTypeIncoming];
    }];
    
    [self.socket onAny:^(SocketAnyEvent * _Nonnull event) {
        DDLogDebug(@"Got event: %@, with items: %@", event.event, event.items);
    }];
}

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (void)addChatMessage:(NSString *)chatMessage type:(OYEChatMessageType)type {
    OYEChatMessage *message = [OYEChatMessage new];
    message.message = chatMessage;
    message.type = type;
    
    [self.messages addObject:message];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.messages.count - 1) inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OYEChatMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OYEChatIncomingMessageResuseCellIdentifier forIndexPath:indexPath];
    OYEChatMessage *message = self.messages[indexPath.row];
    cell.message = message;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    OYEChatMessage *message = self.messages[indexPath.row];
    
    return [OYEChatMessageTableViewCell cellHeightWithMessage:message.message width:self.view.width];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    DDLogDebug(@"*");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableString *changedString = [NSMutableString stringWithString:textField.text];
    [changedString replaceCharactersInRange:range withString:string];
    
    [self setupSendButtonWithString:changedString];
    
    return YES;
}

#pragma mark - IBAction

- (IBAction)sendMessage:(id)sender {
    [self addChatMessage:self.textField.text type:OYEChatMessageTypeOutgoing];
    
    [self.socket emit:@"chat message" withItems:@[self.textField.text]];
    self.textField.text = nil;

    [self setupSendButtonWithString:nil];
}

#pragma mark - NSNotifications

- (void)keyboardWillShow:(NSNotification *)notification {
    
    // Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    //Given size may not account for screen rotation
    int height = MIN(keyboardSize.height,keyboardSize.width);
    
    [UIView animateWithDuration:1.0 animations:^{
        self.editViewBottomSpace.constant = height;
        [self.editView layoutIfNeeded];
    }];
}

@end
