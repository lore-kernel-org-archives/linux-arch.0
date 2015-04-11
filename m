From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 09/24] m32r: Autogenerate offsets in struct thread_info
Date: Sat, 11 Apr 2015 22:47:48 +0200
Message-ID: <1428785283-20501-10-git-send-email-richard@nod.at>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428785283-20501-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, yasutake.koichi@jp.panasonic.com, lftan@altera.com, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, liqin.linux@gmail.com, lennox.wu@gmail.com, davem@davemloft.net, cmetcalf@ezchip.com, jdike@addtoit.com, akpm@linux-foundation.org, oleg@redhat.com, hch@inf
List-Id: linux-arch.vger.kernel.org

Maintaining offsets by hand is no fun.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/m32r/include/asm/asm-offsets.h |  1 +
 arch/m32r/include/asm/thread_info.h | 13 +------------
 arch/m32r/kernel/asm-offsets.c      | 15 ++++++++++++++-
 arch/m32r/kernel/entry.S            |  1 +
 4 files changed, 17 insertions(+), 13 deletions(-)
 create mode 100644 arch/m32r/include/asm/asm-offsets.h

diff --git a/arch/m32r/include/asm/asm-offsets.h b/arch/m32r/include/asm/asm-offsets.h
new file mode 100644
index 0000000..d370ee3
--- /dev/null
+++ b/arch/m32r/include/asm/asm-offsets.h
@@ -0,0 +1 @@
+#include <generated/asm-offsets.h>
diff --git a/arch/m32r/include/asm/thread_info.h b/arch/m32r/include/asm/thread_info.h
index 32422d0..034d1ab 100644
--- a/arch/m32r/include/asm/thread_info.h
+++ b/arch/m32r/include/asm/thread_info.h
@@ -38,18 +38,7 @@ struct thread_info {
 	__u8			supervisor_stack[0];
 };
 
-#else /* !__ASSEMBLY__ */
-
-/* offsets into the thread_info struct for assembly code access */
-#define TI_TASK		0x00000000
-#define TI_EXEC_DOMAIN	0x00000004
-#define TI_FLAGS	0x00000008
-#define TI_STATUS	0x0000000C
-#define TI_CPU		0x00000010
-#define TI_PRE_COUNT	0x00000014
-#define TI_ADDR_LIMIT	0x00000018
-
-#endif
+#endif /* !__ASSEMBLY__ */
 
 #define THREAD_SIZE		(PAGE_SIZE << 1)
 #define THREAD_SIZE_ORDER	1
diff --git a/arch/m32r/kernel/asm-offsets.c b/arch/m32r/kernel/asm-offsets.c
index 9e26311..cd3d2fc 100644
--- a/arch/m32r/kernel/asm-offsets.c
+++ b/arch/m32r/kernel/asm-offsets.c
@@ -1 +1,14 @@
-/* Dummy asm-offsets.c file. Required by kbuild and ready to be used - hint! */
+#include <linux/thread_info.h>
+#include <linux/kbuild.h>
+
+int foo(void)
+{
+	OFFSET(TI_TASK, thread_info, task);
+	OFFSET(TI_FLAGS, thread_info, flags);
+	OFFSET(TI_STATUS, thread_info, status);
+	OFFSET(TI_CPU, thread_info, cpu);
+	OFFSET(TI_PRE_COUNT, thread_info, preempt_count);
+	OFFSET(TI_ADDR_LIMIT, thread_info, addr_limit);
+
+	return 0;
+}
diff --git a/arch/m32r/kernel/entry.S b/arch/m32r/kernel/entry.S
index 7c3db99..c639bfa 100644
--- a/arch/m32r/kernel/entry.S
+++ b/arch/m32r/kernel/entry.S
@@ -65,6 +65,7 @@
 #include <asm/page.h>
 #include <asm/m32r.h>
 #include <asm/mmu_context.h>
+#include <asm/asm-offsets.h>
 
 #if !defined(CONFIG_MMU)
 #define sys_madvise		sys_ni_syscall
-- 
1.8.4.5
