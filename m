From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 099/109] x86/ioport: add ksys_ioperm() helper; remove in-kernel calls to sys_ioperm()
Date: Thu, 29 Mar 2018 13:24:16 +0200
Message-ID: <20180329112426.23043-100-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

Using this helper allows us to avoid the in-kernel calls to the
sys_ioperm() syscall. The ksys_ prefix denotes that this function is meant
as a drop-in replacement for the syscall. In particular, it uses the same
calling convention as sys_ioperm().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: x86@kernel.org
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/include/asm/syscalls.h | 1 +
 arch/x86/kernel/ioport.c        | 7 ++++++-
 drivers/tty/vt/vt_ioctl.c       | 6 +++---
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/syscalls.h b/arch/x86/include/asm/syscalls.h
index bad25bb80679..1c0bebbd039e 100644
--- a/arch/x86/include/asm/syscalls.h
+++ b/arch/x86/include/asm/syscalls.h
@@ -17,6 +17,7 @@
 
 /* Common in X86_32 and X86_64 */
 /* kernel/ioport.c */
+long ksys_ioperm(unsigned long from, unsigned long num, int turn_on);
 asmlinkage long sys_ioperm(unsigned long, unsigned long, int);
 asmlinkage long sys_iopl(unsigned int);
 
diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 38deafebb21b..0fe1c8782208 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -23,7 +23,7 @@
 /*
  * this changes the io permissions bitmap in the current task.
  */
-SYSCALL_DEFINE3(ioperm, unsigned long, from, unsigned long, num, int, turn_on)
+long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 {
 	struct thread_struct *t = &current->thread;
 	struct tss_struct *tss;
@@ -96,6 +96,11 @@ SYSCALL_DEFINE3(ioperm, unsigned long, from, unsigned long, num, int, turn_on)
 	return 0;
 }
 
+SYSCALL_DEFINE3(ioperm, unsigned long, from, unsigned long, num, int, turn_on)
+{
+	return ksys_ioperm(from, num, turn_on);
+}
+
 /*
  * sys_iopl has to be used when you want to access the IO ports
  * beyond the 0x3ff range: to get the full 65536 ports bitmapped
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index d61be307256a..a78ad10a119b 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -57,7 +57,7 @@ extern struct tty_driver *console_driver;
  */
 
 #ifdef CONFIG_X86
-#include <linux/syscalls.h>
+#include <asm/syscalls.h>
 #endif
 
 static void complete_change_console(struct vc_data *vc);
@@ -420,12 +420,12 @@ int vt_ioctl(struct tty_struct *tty,
 			ret = -EINVAL;
 			break;
 		}
-		ret = sys_ioperm(arg, 1, (cmd == KDADDIO)) ? -ENXIO : 0;
+		ret = ksys_ioperm(arg, 1, (cmd == KDADDIO)) ? -ENXIO : 0;
 		break;
 
 	case KDENABIO:
 	case KDDISABIO:
-		ret = sys_ioperm(GPFIRST, GPNUM,
+		ret = ksys_ioperm(GPFIRST, GPNUM,
 				  (cmd == KDENABIO)) ? -ENXIO : 0;
 		break;
 #endif
-- 
2.16.3
