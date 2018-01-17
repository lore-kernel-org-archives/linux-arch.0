From: David Howells <dhowells@redhat.com>
Subject: [PATCH 1/8] cris: Make THREAD_SIZE available to vmlinux.lds
Date: Wed, 17 Jan 2018 15:25:02 +0000
Message-ID: <151620270203.22429.2757290992238483064.stgit@warthog.procyon.org.uk>
References: <151620268761.22429.14193525405303696385.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <151620268761.22429.14193525405303696385.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Make THREAD_SIZE available to vmlinux.lds on cris by moving it to
asm/thread_info.h and including that from the linker script.

This allows init_stack to be allocated in the linker script in a subsequent
patch.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
cc: Mikael Starvik <starvik@axis.com>
cc: Jesper Nilsson <jesper.nilsson@axis.com>
cc: linux-cris-kernel@axis.com
---

 arch/cris/include/asm/processor.h   |    7 -------
 arch/cris/include/asm/thread_info.h |    7 +++++++
 arch/cris/kernel/vmlinux.lds.S      |    1 +
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/cris/include/asm/processor.h b/arch/cris/include/asm/processor.h
index 124dd5ec7f65..b50907799cb2 100644
--- a/arch/cris/include/asm/processor.h
+++ b/arch/cris/include/asm/processor.h
@@ -26,13 +26,6 @@ struct task_struct;
  */
 #define TASK_UNMAPPED_BASE      (PAGE_ALIGN(TASK_SIZE / 3))
 
-/* THREAD_SIZE is the size of the thread_info/kernel_stack combo.
- * normally, the stack is found by doing something like p + THREAD_SIZE
- * in CRIS, a page is 8192 bytes, which seems like a sane size
- */
-#define THREAD_SIZE       PAGE_SIZE
-#define THREAD_SIZE_ORDER (0)
-
 /*
  * At user->kernel entry, the pt_regs struct is stacked on the top of the kernel-stack.
  * This macro allows us to find those regs for a task.
diff --git a/arch/cris/include/asm/thread_info.h b/arch/cris/include/asm/thread_info.h
index 472830c90997..108f77081a3c 100644
--- a/arch/cris/include/asm/thread_info.h
+++ b/arch/cris/include/asm/thread_info.h
@@ -20,6 +20,13 @@
 #endif
 
 
+/* THREAD_SIZE is the size of the thread_info/kernel_stack combo.
+ * normally, the stack is found by doing something like p + THREAD_SIZE
+ * in CRIS, a page is 8192 bytes, which seems like a sane size
+ */
+#define THREAD_SIZE       PAGE_SIZE
+#define THREAD_SIZE_ORDER (0)
+
 /*
  * low level task data that entry.S needs immediate access to
  * - this struct should fit entirely inside of one cache line
diff --git a/arch/cris/kernel/vmlinux.lds.S b/arch/cris/kernel/vmlinux.lds.S
index 6d1dbc1ba767..9b232e0f673e 100644
--- a/arch/cris/kernel/vmlinux.lds.S
+++ b/arch/cris/kernel/vmlinux.lds.S
@@ -11,6 +11,7 @@
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/page.h>
+#include <asm/thread_info.h>
 
 #ifdef CONFIG_ETRAX_VMEM_SIZE
 #define __CONFIG_ETRAX_VMEM_SIZE CONFIG_ETRAX_VMEM_SIZE
