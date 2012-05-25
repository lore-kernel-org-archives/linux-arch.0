From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 08/20] openrisc: Do not call do_signal() with irqs
	disabled
Date: Sat, 26 May 2012 00:04:24 +0200
Message-ID: <1337983476-22081-8-git-send-email-richard@nod.at>
References: <1337983476-22081-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
In-Reply-To: <1337983476-22081-1-git-send-email-richard@nod.at>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Richard Weinberger <richard@nod.at>, linux@lists.openrisc.net
List-Id: linux-arch.vger.kernel.org

get_signal_to_deliver() calls try_to_freeze() which might sleep.

Cc: Jonas Bonn <jonas@southpole.se>
Cc: linux@lists.openrisc.net
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/openrisc/kernel/signal.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index e970743..f2ae7ac 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -26,6 +26,7 @@
 #include <linux/unistd.h>
 #include <linux/stddef.h>
 #include <linux/tracehook.h>
+#include <linux/irqflags.h>
 
 #include <asm/processor.h>
 #include <asm/ucontext.h>
@@ -370,6 +371,8 @@ void do_signal(struct pt_regs *regs)
 
 asmlinkage void do_notify_resume(struct pt_regs *regs)
 {
+	local_irq_enable();
+
 	if (current_thread_info()->flags & _TIF_SIGPENDING)
 		do_signal(regs);
 
-- 
1.7.7.3
