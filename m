From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 2/3] bug: Define the "cut here" string in a single place
Date: Tue,  7 Nov 2017 16:27:48 -0800
Message-ID: <1510100869-73751-3-git-send-email-keescook@chromium.org>
References: <1510100869-73751-1-git-send-email-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510100869-73751-1-git-send-email-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Joe Perches <joe@perches.com>, Fengguang Wu <fengguang.wu@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-am33-list@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The "cut here" string is used in a few paths. Define it in a single place.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/mn10300/mm/fault.c   | 2 +-
 include/asm-generic/bug.h | 2 ++
 kernel/panic.c            | 2 +-
 lib/bug.c                 | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mn10300/mm/fault.c b/arch/mn10300/mm/fault.c
index f23781d6bbb3..f0bfa1448744 100644
--- a/arch/mn10300/mm/fault.c
+++ b/arch/mn10300/mm/fault.c
@@ -60,7 +60,7 @@ void bust_spinlocks(int yes)
 void do_BUG(const char *file, int line)
 {
 	bust_spinlocks(1);
-	printk(KERN_EMERG "------------[ cut here ]------------\n");
+	printk(KERN_EMERG CUT_HERE);
 	printk(KERN_EMERG "kernel BUG at %s:%d!\n", file, line);
 }
 
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 87191357d303..673a79dd3928 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -3,6 +3,8 @@
 
 #include <linux/compiler.h>
 
+#define CUT_HERE		"------------[ cut here ]------------\n"
+
 #ifdef CONFIG_GENERIC_BUG
 #define BUGFLAG_WARNING		(1 << 0)
 #define BUGFLAG_ONCE		(1 << 1)
diff --git a/kernel/panic.c b/kernel/panic.c
index bdd18afa19a4..ab210714f2f3 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -518,7 +518,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 {
 	disable_trace_on_warning();
 
-	pr_warn("------------[ cut here ]------------\n");
+	pr_warn(CUT_HERE);
 
 	if (file)
 		pr_warn("WARNING: CPU: %d PID: %d at %s:%d %pS\n",
diff --git a/lib/bug.c b/lib/bug.c
index a6a1137d06db..2c9e04621638 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -185,7 +185,7 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 		return BUG_TRAP_TYPE_WARN;
 	}
 
-	printk(KERN_DEFAULT "------------[ cut here ]------------\n");
+	printk(KERN_DEFAULT CUT_HERE);
 
 	if (file)
 		pr_crit("kernel BUG at %s:%u!\n", file, line);
-- 
2.7.4
