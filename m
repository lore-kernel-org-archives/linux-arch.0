From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 1/5] mips: don't block signals if we'd failed setting
 sigframe up
Date: Tue, 28 Sep 2010 18:50:17 +0100
Message-ID: <E1P0eJl-0006im-4g__29784.5264584341$1287052932$gmane$org@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
Resent-Message-ID: <20101014104142.GA28911@linux-mips.org>
Resent-To: linux-mips@linux-mips.org
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: ralf@linux-mips.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/mips/kernel/signal.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 2099d5a..b3273ae 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -575,6 +575,9 @@ static int handle_signal(unsigned long sig, siginfo_t *info,
 		ret = abi->setup_frame(vdso + abi->signal_return_offset,
 				       ka, regs, sig, oldset);
 
+	if (ret)
+		return ret;
+
 	spin_lock_irq(&current->sighand->siglock);
 	sigorsets(&current->blocked, &current->blocked, &ka->sa.sa_mask);
 	if (!(ka->sa.sa_flags & SA_NODEFER))
-- 
1.5.6.5
