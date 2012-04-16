@protocol LMSerialConnectionDelegate <NSObject>
- (void)didReceiveSignal:(NSString *)text;

@optional

- (void)connectionFailed;
- (void)connectionEstablished;
@end