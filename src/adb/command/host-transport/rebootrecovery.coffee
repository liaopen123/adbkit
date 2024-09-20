const Command = require('../../command');
const Protocol = require('../../protocol');

class RebootRecoveryCommand extends Command {
  execute() {
    // 发送 'reboot:recovery' 指令
    this._send('reboot:recovery');
    
    return this.parser.readAscii(4)
      .then((reply) => {
        switch (reply) {
          case Protocol.OKAY:
            return this.parser.readAll().then(() => true);
          case Protocol.FAIL:
            return this.parser.readError();
          default:
            return this.parser.unexpected(reply, 'OKAY or FAIL');
        }
      });
  }
}

module.exports = RebootRecoveryCommand;
