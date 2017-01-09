From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 08/10] sh: migrate exception table users off module.h and onto extable.h
Date: Mon, 9 Jan 2017 15:40:08 -0500
Message-ID: <20170109204010.5047-9-paul.gortmaker@windriver.com>
References: <20170109204010.5047-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20170109204010.5047-1-paul.gortmaker@windriver.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

These files were only including module.h for exception table
related functions.  We've now separated that content out into its
own file "extable.h" so now move over to that and avoid all the
extra header content in module.h that we don't really need to compile
these files.

One uses "print_modules" so that prevents us removing module.h in
that case, however.

We also delete a duplicate prototype that doesn't need to exist, as
it duplicates content in extable.h

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/sh/include/asm/uaccess.h | 1 -
 arch/sh/kernel/kprobes.c      | 2 +-
 arch/sh/kernel/traps.c        | 3 ++-
 arch/sh/mm/extable_32.c       | 2 +-
 arch/sh/mm/extable_64.c       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sh/include/asm/uaccess.h b/arch/sh/include/asm/uaccess.h
index a38d0c7b818f..c4f0fee812c3 100644
--- a/arch/sh/include/asm/uaccess.h
+++ b/arch/sh/include/asm/uaccess.h
@@ -192,7 +192,6 @@ struct exception_table_entry {
 #endif
 
 int fixup_exception(struct pt_regs *regs);
-const struct exception_table_entry *search_exception_tables(unsigned long addr);
 
 extern void *set_exception_table_vec(unsigned int vec, void *handler);
 
diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index 1653ff64b103..52a5e11247d1 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -9,7 +9,7 @@
  * for more details.
  */
 #include <linux/kprobes.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/ptrace.h>
 #include <linux/preempt.h>
 #include <linux/kdebug.h>
diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
index dfdad72c61ca..9513fa7840aa 100644
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -8,7 +8,8 @@
 #include <linux/hardirq.h>
 #include <linux/kernel.h>
 #include <linux/kexec.h>
-#include <linux/module.h>
+#include <linux/extable.h>
+#include <linux/module.h>	/* print_modules */
 #include <asm/unwinder.h>
 #include <asm/traps.h>
 
diff --git a/arch/sh/mm/extable_32.c b/arch/sh/mm/extable_32.c
index 9cfcbb5848e4..24a75d315dcb 100644
--- a/arch/sh/mm/extable_32.c
+++ b/arch/sh/mm/extable_32.c
@@ -4,7 +4,7 @@
  *   linux/arch/i386/mm/extable.c
  */
 
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/uaccess.h>
 
 int fixup_exception(struct pt_regs *regs)
diff --git a/arch/sh/mm/extable_64.c b/arch/sh/mm/extable_64.c
index 96edaff8c983..b90cdfad2c78 100644
--- a/arch/sh/mm/extable_64.c
+++ b/arch/sh/mm/extable_64.c
@@ -11,7 +11,7 @@
  * for more details.
  */
 #include <linux/rwsem.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/uaccess.h>
 
 extern unsigned long copy_user_memcpy, copy_user_memcpy_end;
-- 
2.11.0

