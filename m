From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] make INIT_FS use the __RW_LOCK_UNLOCKED initialization
Date: Wed, 10 Dec 2008 18:37:28 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0812101832200.21545@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:60215 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbYLJXhc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Dec 2008 18:37:32 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>


The following patch is in:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git

    branch: cleanups


Steven Rostedt (1):
      make INIT_FS use the __RW_LOCK_UNLOCKED initialization

----
 arch/alpha/kernel/init_task.c     |    2 +-
 arch/arm/kernel/init_task.c       |    2 +-
 arch/avr32/kernel/init_task.c     |    2 +-
 arch/blackfin/kernel/init_task.c  |    2 +-
 arch/cris/kernel/process.c        |    2 +-
 arch/frv/kernel/init_task.c       |    2 +-
 arch/h8300/kernel/init_task.c     |    2 +-
 arch/ia64/kernel/init_task.c      |    2 +-
 arch/m32r/kernel/init_task.c      |    2 +-
 arch/m68k/kernel/process.c        |    2 +-
 arch/m68knommu/kernel/init_task.c |    2 +-
 arch/mips/kernel/init_task.c      |    2 +-
 arch/mn10300/kernel/init_task.c   |    2 +-
 arch/parisc/kernel/init_task.c    |    2 +-
 arch/powerpc/kernel/init_task.c   |    2 +-
 arch/s390/kernel/init_task.c      |    2 +-
 arch/sh/kernel/init_task.c        |    2 +-
 arch/sparc/kernel/init_task.c     |    2 +-
 arch/sparc64/kernel/init_task.c   |    2 +-
 arch/um/kernel/init_task.c        |    2 +-
 arch/x86/kernel/init_task.c       |    2 +-
 arch/xtensa/kernel/init_task.c    |    2 +-
 include/linux/fs_struct.h         |    8 ++++----
 23 files changed, 26 insertions(+), 26 deletions(-)
---------------------------
commit a01548072bd37397057019f8eec5b8a12f364763
Author: Steven Rostedt <srostedt@redhat.com>
Date:   Wed Dec 10 16:55:00 2008 -0500

    make INIT_FS use the __RW_LOCK_UNLOCKED initialization
    
    Impact: clean up
    
    The INIT_FS macro still uses the deprecated RW_LOCK_UNLOCKED macro.
    This patch updates it to use the __RW_LOCK_UNLOCKED(lock) macro.
    
    Signed-off-by: Steven Rostedt <srostedt@redhat.com>

diff --git a/arch/alpha/kernel/init_task.c b/arch/alpha/kernel/init_task.c
index 1f76218..e2470eb 100644
--- a/arch/alpha/kernel/init_task.c
+++ b/arch/alpha/kernel/init_task.c
@@ -8,7 +8,7 @@
 #include <asm/uaccess.h>
 
 
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
diff --git a/arch/arm/kernel/init_task.c b/arch/arm/kernel/init_task.c
index 0bbf806..cd2cd8f 100644
--- a/arch/arm/kernel/init_task.c
+++ b/arch/arm/kernel/init_task.c
@@ -12,7 +12,7 @@
 
 #include <asm/pgtable.h>
 
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
diff --git a/arch/avr32/kernel/init_task.c b/arch/avr32/kernel/init_task.c
index 4405846..f5fe900 100644
--- a/arch/avr32/kernel/init_task.c
+++ b/arch/avr32/kernel/init_task.c
@@ -13,7 +13,7 @@
 
 #include <asm/pgtable.h>
 
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
diff --git a/arch/blackfin/kernel/init_task.c b/arch/blackfin/kernel/init_task.c
index 6bdba7b..6cd2bc9 100644
--- a/arch/blackfin/kernel/init_task.c
+++ b/arch/blackfin/kernel/init_task.c
@@ -33,7 +33,7 @@
 #include <linux/mqueue.h>
 #include <linux/fs.h>
 
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 
diff --git a/arch/cris/kernel/process.c b/arch/cris/kernel/process.c
index 5933656..78002b9 100644
--- a/arch/cris/kernel/process.c
+++ b/arch/cris/kernel/process.c
@@ -37,7 +37,7 @@
  * setup.
  */
 
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
diff --git a/arch/frv/kernel/init_task.c b/arch/frv/kernel/init_task.c
index e219881..749091c 100644
--- a/arch/frv/kernel/init_task.c
+++ b/arch/frv/kernel/init_task.c
@@ -10,7 +10,7 @@
 #include <asm/pgtable.h>
 
 
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
diff --git a/arch/h8300/kernel/init_task.c b/arch/h8300/kernel/init_task.c
index 93a4899..67c5a74 100644
--- a/arch/h8300/kernel/init_task.c
+++ b/arch/h8300/kernel/init_task.c
@@ -12,7 +12,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
diff --git a/arch/ia64/kernel/init_task.c b/arch/ia64/kernel/init_task.c
index 9d7e1c6..d793c55 100644
--- a/arch/ia64/kernel/init_task.c
+++ b/arch/ia64/kernel/init_task.c
@@ -17,7 +17,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
diff --git a/arch/m32r/kernel/init_task.c b/arch/m32r/kernel/init_task.c
index 0d658db..c4cc7a3 100644
--- a/arch/m32r/kernel/init_task.c
+++ b/arch/m32r/kernel/init_task.c
@@ -11,7 +11,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index 3042c2b..480b4cf 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -40,7 +40,7 @@
  * alignment requirements and potentially different initial
  * setup.
  */
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
diff --git a/arch/m68knommu/kernel/init_task.c b/arch/m68knommu/kernel/init_task.c
index 344c01a..4669391 100644
--- a/arch/m68knommu/kernel/init_task.c
+++ b/arch/m68knommu/kernel/init_task.c
@@ -12,7 +12,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
diff --git a/arch/mips/kernel/init_task.c b/arch/mips/kernel/init_task.c
index d72487a..9e31228 100644
--- a/arch/mips/kernel/init_task.c
+++ b/arch/mips/kernel/init_task.c
@@ -9,7 +9,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
diff --git a/arch/mn10300/kernel/init_task.c b/arch/mn10300/kernel/init_task.c
index af16f6e..2cc5046 100644
--- a/arch/mn10300/kernel/init_task.c
+++ b/arch/mn10300/kernel/init_task.c
@@ -18,7 +18,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
diff --git a/arch/parisc/kernel/init_task.c b/arch/parisc/kernel/init_task.c
index f5941c0..c83e11d 100644
--- a/arch/parisc/kernel/init_task.c
+++ b/arch/parisc/kernel/init_task.c
@@ -34,7 +34,7 @@
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
diff --git a/arch/powerpc/kernel/init_task.c b/arch/powerpc/kernel/init_task.c
index 4c85b8d..c96b1c2 100644
--- a/arch/powerpc/kernel/init_task.c
+++ b/arch/powerpc/kernel/init_task.c
@@ -7,7 +7,7 @@
 #include <linux/mqueue.h>
 #include <asm/uaccess.h>
 
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
diff --git a/arch/s390/kernel/init_task.c b/arch/s390/kernel/init_task.c
index e807168..c99c903 100644
--- a/arch/s390/kernel/init_task.c
+++ b/arch/s390/kernel/init_task.c
@@ -16,7 +16,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
diff --git a/arch/sh/kernel/init_task.c b/arch/sh/kernel/init_task.c
index b151a25..c5b1c3e 100644
--- a/arch/sh/kernel/init_task.c
+++ b/arch/sh/kernel/init_task.c
@@ -7,7 +7,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct pt_regs fake_swapper_regs;
diff --git a/arch/sparc/kernel/init_task.c b/arch/sparc/kernel/init_task.c
index 8e64ebc..d39d22e 100644
--- a/arch/sparc/kernel/init_task.c
+++ b/arch/sparc/kernel/init_task.c
@@ -8,7 +8,7 @@
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
 
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
diff --git a/arch/sparc64/kernel/init_task.c b/arch/sparc64/kernel/init_task.c
index d2b3123..8995483 100644
--- a/arch/sparc64/kernel/init_task.c
+++ b/arch/sparc64/kernel/init_task.c
@@ -9,7 +9,7 @@
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
diff --git a/arch/um/kernel/init_task.c b/arch/um/kernel/init_task.c
index 910eda8..cb33b7d 100644
--- a/arch/um/kernel/init_task.c
+++ b/arch/um/kernel/init_task.c
@@ -10,7 +10,7 @@
 #include "linux/mqueue.h"
 #include "asm/uaccess.h"
 
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 struct mm_struct init_mm = INIT_MM(init_mm);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
diff --git a/arch/x86/kernel/init_task.c b/arch/x86/kernel/init_task.c
index a4f93b4..479cc0f 100644
--- a/arch/x86/kernel/init_task.c
+++ b/arch/x86/kernel/init_task.c
@@ -10,7 +10,7 @@
 #include <asm/pgtable.h>
 #include <asm/desc.h>
 
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
diff --git a/arch/xtensa/kernel/init_task.c b/arch/xtensa/kernel/init_task.c
index 3df469d..2841b55 100644
--- a/arch/xtensa/kernel/init_task.c
+++ b/arch/xtensa/kernel/init_task.c
@@ -21,7 +21,7 @@
 
 #include <asm/uaccess.h>
 
-static struct fs_struct init_fs = INIT_FS;
+static struct fs_struct init_fs = INIT_FS(init_fs);
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 9e5a06e..407cd69 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -10,10 +10,10 @@ struct fs_struct {
 	struct path root, pwd;
 };
 
-#define INIT_FS {				\
-	.count		= ATOMIC_INIT(1),	\
-	.lock		= RW_LOCK_UNLOCKED,	\
-	.umask		= 0022, \
+#define INIT_FS(name) {						\
+	.count		= ATOMIC_INIT(1),			\
+	.lock		= __RW_LOCK_UNLOCKED((name).lock),	\
+	.umask		= 0022,					\
 }
 
 extern struct kmem_cache *fs_cachep;
