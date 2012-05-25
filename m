From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 13/20] arm: Do not call try_to_freeze() in do_signal()
Date: Sat, 26 May 2012 00:04:29 +0200
Message-ID: <1337983476-22081-13-git-send-email-richard@nod.at>
References: <1337983476-22081-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1337983476-22081-1-git-send-email-richard@nod.at>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Richard Weinberger <richard@nod.at>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

get_signal_to_deliver() already calls try_to_freeze(), there is no
need to call it directly.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/arm/kernel/signal.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 434a1f3..aeebb46 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -10,7 +10,6 @@
 #include <linux/errno.h>
 #include <linux/signal.h>
 #include <linux/personality.h>
-#include <linux/freezer.h>
 #include <linux/uaccess.h>
 #include <linux/tracehook.h>
 #include <linux/irqflags.h>
@@ -636,9 +635,6 @@ static void do_signal(struct pt_regs *regs, int syscall)
 		}
 	}
 
-	if (try_to_freeze())
-		goto no_signal;
-
 	/*
 	 * Get the signal to deliver.  When running under ptrace, at this
 	 * point the debugger may change all our registers ...
@@ -678,7 +674,6 @@ static void do_signal(struct pt_regs *regs, int syscall)
 		return;
 	}
 
- no_signal:
 	if (syscall) {
 		/*
 		 * Handle restarting a different system call.  As above,
-- 
1.7.7.3
