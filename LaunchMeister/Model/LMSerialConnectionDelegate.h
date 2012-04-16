@protocol LMSerialConnectionDelegate <NSObject>
- (void)didReceiveSignal:(NSString *)address;

@optional

- (void)connectionFailed;
- (void)connectionEstablished;
@end