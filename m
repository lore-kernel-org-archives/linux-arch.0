From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 20/20] powerpc64: convert to dynamic percpu allocator
Date: Tue, 21 Jul 2009 19:26:19 +0900
Message-ID: <1248171979-29166-21-git-send-email-tj@kernel.org>
References: <1248171979-29166-1-git-send-email-tj@kernel.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755299AbZGUKbG@vger.kernel.org>
In-Reply-To: <1248171979-29166-1-git-send-email-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, benh@kernel.crashing.org, davem@davemloft.net, dhowells@redhat.com, npiggin@suse.de, JBeulich@novell.comc
Cc: Tejun Heo <tj@kernel.org>
List-Id: linux-arch.vger.kernel.org

Now that percpu allows arbitrary embedding of the first chunk,
powerpc64 can easily be converted to dynamic percpu allocator.
Convert it.  powerpc supports several large page sizes.  Cap atom_size
at 1M.  There isn't much to gain by going above that anyway.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/Kconfig           |    4 +-
 arch/powerpc/kernel/setup_64.c |   61 +++++++++++++++++++++++++++++----------
 2 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 61bbffa..2c42e15 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -46,10 +46,10 @@ config GENERIC_HARDIRQS_NO__DO_IRQ
 	bool
 	default y
 
-config HAVE_LEGACY_PER_CPU_AREA
+config HAVE_SETUP_PER_CPU_AREA
 	def_bool PPC64
 
-config HAVE_SETUP_PER_CPU_AREA
+config NEED_PER_CPU_EMBED_FIRST_CHUNK
 	def_bool PPC64
 
 config IRQ_PER_CPU
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 1f68160..aa6e450 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -57,6 +57,7 @@
 #include <asm/cache.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
+#include <asm/mmu-hash64.h>
 #include <asm/firmware.h>
 #include <asm/xmon.h>
 #include <asm/udbg.h>
@@ -569,25 +570,53 @@ void cpu_die(void)
 }
 
 #ifdef CONFIG_SMP
-void __init setup_per_cpu_areas(void)
+#define PCPU_DYN_SIZE		()
+
+static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size, size_t align)
 {
-	int i;
-	unsigned long size;
-	char *ptr;
-
-	/* Copy section for each CPU (we discard the original) */
-	size = ALIGN(__per_cpu_end - __per_cpu_start, PAGE_SIZE);
-#ifdef CONFIG_MODULES
-	if (size < PERCPU_ENOUGH_ROOM)
-		size = PERCPU_ENOUGH_ROOM;
-#endif
+	return __alloc_bootmem_node(NODE_DATA(cpu_to_node(cpu)), size, align,
+				    __pa(MAX_DMA_ADDRESS));
+}
 
-	for_each_possible_cpu(i) {
-		ptr = alloc_bootmem_pages_node(NODE_DATA(cpu_to_node(i)), size);
+static void __init pcpu_fc_free(void *ptr, size_t size)
+{
+	free_bootmem(__pa(ptr), size);
+}
 
-		paca[i].data_offset = ptr - __per_cpu_start;
-		memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);
-	}
+static int pcpu_cpu_distance(unsigned int from, unsigned int to)
+{
+	if (cpu_to_node(from) == cpu_to_node(to))
+		return LOCAL_DISTANCE;
+	else
+		return REMOTE_DISTANCE;
+}
+
+void __init setup_per_cpu_areas(void)
+{
+	const size_t dyn_size = PERCPU_MODULE_RESERVE + PERCPU_DYNAMIC_RESERVE;
+	size_t atom_size;
+	unsigned long delta;
+	unsigned int cpu;
+	int rc;
+
+	/*
+	 * Linear mapping is one of 4K, 1M and 16M.  For 4K, no need
+	 * to group units.  For larger mappings, use 1M atom which
+	 * should be large enough to contain a number of units.
+	 */
+	if (mmu_linear_psize == MMU_PAGE_4K)
+		atom_size = PAGE_SIZE;
+	else
+		atom_size = 1 << 20;
+
+	rc = pcpu_embed_first_chunk(0, dyn_size, atom_size, pcpu_cpu_distance,
+				    pcpu_fc_alloc, pcpu_fc_free);
+	if (rc < 0)
+		panic("cannot initialize percpu area (err=%d)", rc);
+
+	delta = (unsigned long)pcpu_base_addr - (unsigned long)__per_cpu_start;
+	for_each_possible_cpu(cpu)
+		paca[cpu].data_offset = delta + pcpu_unit_offsets[cpu];
 }
 #endif
 
-- 
1.6.0.2
