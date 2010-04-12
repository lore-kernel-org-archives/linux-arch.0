From: David VomLehn <dvomlehn@cisco.com>
Subject: [PATCH 21/23] Make register values available to UM panic notifiers
Date: Sun, 11 Apr 2010 23:07:13 -0700
Message-ID: <20100412060713.GA25950@dvomlehn-lnx2.corp.sa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: to@dvomlehn-lnx2.corp.sa.net, "linux-arch@vger.kernel.org"@cisco.comlinux-arch@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, maint_arch@dvomlehn-lnx2.corp.sa.net
List-Id: linux-arch.vger.kernel.org

Changes for User Mode Linux. Not clear whether this needs save_ptregs()
or not.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 arch/um/kernel/trap.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 637c650..c917f26 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -168,7 +168,7 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 	}
 	else if (current->mm == NULL) {
 		show_regs(container_of(regs, struct pt_regs, regs));
-		panic("Segfault with no mm");
+		panic_with_regs(regs, "Segfault with no mm");
 	}
 
 	if (SEGV_IS_FIXABLE(&fi) || SEGV_MAYBE_FIXABLE(&fi))
@@ -192,13 +192,14 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 		UML_LONGJMP(catcher, 1);
 	}
 	else if (current->thread.fault_addr != NULL)
-		panic("fault_addr set but no fault catcher");
+		panic_with_regs(regs, "fault_addr set but no fault catcher");
 	else if (!is_user && arch_fixup(ip, regs))
 		return 0;
 
 	if (!is_user) {
 		show_regs(container_of(regs, struct pt_regs, regs));
-		panic("Kernel mode fault at addr 0x%lx, ip 0x%lx",
+		panic_with_regs(regs,
+			"Kernel mode fault at addr 0x%lx, ip 0x%lx",
 		      address, ip);
 	}
 
@@ -225,7 +226,7 @@ void relay_signal(int sig, struct uml_pt_regs *regs)
 		if (sig == SIGBUS)
 			printk(KERN_ERR "Bus error - the host /dev/shm or /tmp "
 			       "mount likely just ran out of space\n");
-		panic("Kernel mode signal %d", sig);
+		panic_with_regs(regs, "Kernel mode signal %d", sig);
 	}
 
 	arch_examine_signal(sig, regs);
