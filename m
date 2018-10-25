From: Nick Hu <nickhu@andestech.com>
Subject: [PATCH v4 2/4] nds32: Perf porting
Date: Thu, 25 Oct 2018 10:24:15 +0800
Message-ID: <358e2a41f774e4dc25b1d6bb9e3abf38fab4cfd1.1540430862.git.nickhu@andestech.com>
References: <cover.1540430861.git.nickhu@andestech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1540430861.git.nickhu@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, robh+dt@kernel.org, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, ebiederm@xmission.com, gregkh@linuxfoundation.org, kstewart@linuxfoundation.org, tglx@linutronix.de, pombredanne@nexb.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, zong@andestech.com, alankao@andestech.com, deanbo422@gmail.com
Cc: Nickhu <nickhu@andestech.com>, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

From: Nickhu <nickhu@andestech.com>

This is the commit that porting the perf for nds32.

1.Raw event:
	The raw events start with 'r'.
		Usage:
			perf stat -e rXYZ ./app
			X: the index of performance counter.
			YZ: the index(convert to hexdecimal) of events

		Example:
			'perf stat -e r101 ./app' means the counter 1 will count the instruction
		event.

		The index of counter and events can be found in
		"Andes System Privilege Architecture Version 3 Manual".

Or you can perform the 'perf list' to find the symbolic name of raw events.

2.Perf mmap2:

	Fix unexpected perf mmap2() page fault

	When the mmap2() called by perf application,
	you will encounter such condition:"failed to write."
	With return value -EFAULT

	This is due to the page fault caused by "reading" buffer
	from the mapped legal address region to write to the descriptor.
	The page_fault handler will get a VM_FAULT_SIGBUS return value,
	which should not happens here.(Due to this is a read request.)

	You can refer to kernel/events/core.c:perf_mmap_fault(...)
	If "(vmf->pgoff && (vmf->flags & FAULT_FLAG_WRITE))" is evaluated
	as true, you will get VM_FAULT_SIGBUS as return value.

	However, this is not an write request. The flags which indicated
	why the page fault happens is wrong.

	Furthermore, NDS32 SPAv3 is not able to detect it is read or write.
	It only know  either it is instruction fetch or data access.

	Therefore, by removing the wrong flag assignment(actually, the hardware
	is not able to show the reason), we can fix this bug.

3.Perf multiple events map to same counter.

	When there are multiple events map to the same counter, the counter
	counts inaccurately. This is because each counter only counts one event
	in the same time.
	So when there are multiple events map to same counter, they have to take
	turns in each context.

	There are two solution:
	1. Print the error message when multiple events map to the same counter.
	But print the error message would let the program hang in loop. The ltp
	(linux test program) would be failed when the program hang in loop.

	2. Don't print the error message, the ltp would pass. But the user need to
	have the knowledge that don't count the events which map to the same
	counter, or the user will get the inaccurate results.

	We choose method 2 for the solution

Signed-off-by: Nickhu <nickhu@andestech.com>
---
 arch/nds32/Kconfig                            |    1 +
 arch/nds32/boot/dts/ae3xx.dts                 |    5 +
 arch/nds32/include/asm/Kbuild                 |    1 +
 arch/nds32/include/asm/perf_event.h           |   16 +
 arch/nds32/include/asm/pmu.h                  |  386 ++++++
 arch/nds32/include/asm/stacktrace.h           |   39 +
 arch/nds32/kernel/Makefile                    |    3 +-
 arch/nds32/kernel/perf_event_cpu.c            | 1223 +++++++++++++++++
 arch/nds32/mm/fault.c                         |   13 +-
 tools/include/asm/barrier.h                   |    2 +
 tools/perf/arch/nds32/Build                   |    1 +
 tools/perf/arch/nds32/util/Build              |    1 +
 tools/perf/arch/nds32/util/header.c           |   29 +
 tools/perf/pmu-events/arch/nds32/mapfile.csv  |   15 +
 .../pmu-events/arch/nds32/n13/atcpmu.json     |  290 ++++
 15 files changed, 2019 insertions(+), 6 deletions(-)
 create mode 100644 arch/nds32/include/asm/perf_event.h
 create mode 100644 arch/nds32/include/asm/pmu.h
 create mode 100644 arch/nds32/include/asm/stacktrace.h
 create mode 100644 arch/nds32/kernel/perf_event_cpu.c
 create mode 100644 tools/perf/arch/nds32/Build
 create mode 100644 tools/perf/arch/nds32/util/Build
 create mode 100644 tools/perf/arch/nds32/util/header.c
 create mode 100644 tools/perf/pmu-events/arch/nds32/mapfile.csv
 create mode 100644 tools/perf/pmu-events/arch/nds32/n13/atcpmu.json

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 7068f341133d..dd448d431f5a 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -31,6 +31,7 @@ config NDS32
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_MEMBLOCK
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_PERF_EVENTS
 	select IRQ_DOMAIN
 	select LOCKDEP_SUPPORT
 	select MODULES_USE_ELF_RELA
diff --git a/arch/nds32/boot/dts/ae3xx.dts b/arch/nds32/boot/dts/ae3xx.dts
index bb39749a6673..16a9f54a805e 100644
--- a/arch/nds32/boot/dts/ae3xx.dts
+++ b/arch/nds32/boot/dts/ae3xx.dts
@@ -82,4 +82,9 @@
 			interrupts = <18>;
 		};
 	};
+
+	pmu {
+		compatible = "andestech,nds32v3-pmu";
+		interrupts= <13>;
+	};
 };
diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
index dbc4e5422550..f81b633d5379 100644
--- a/arch/nds32/include/asm/Kbuild
+++ b/arch/nds32/include/asm/Kbuild
@@ -36,6 +36,7 @@ generic-y += kprobes.h
 generic-y += kvm_para.h
 generic-y += limits.h
 generic-y += local.h
+generic-y += local64.h
 generic-y += mm-arch-hooks.h
 generic-y += mman.h
 generic-y += parport.h
diff --git a/arch/nds32/include/asm/perf_event.h b/arch/nds32/include/asm/perf_event.h
new file mode 100644
index 000000000000..fcdff02acc14
--- /dev/null
+++ b/arch/nds32/include/asm/perf_event.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2008-2018 Andes Technology Corporation */
+
+#ifndef __ASM_PERF_EVENT_H
+#define __ASM_PERF_EVENT_H
+
+/*
+ * This file is request by Perf,
+ * please refer to tools/perf/design.txt for more details
+ */
+struct pt_regs;
+unsigned long perf_instruction_pointer(struct pt_regs *regs);
+unsigned long perf_misc_flags(struct pt_regs *regs);
+#define perf_misc_flags(regs)   perf_misc_flags(regs)
+
+#endif
diff --git a/arch/nds32/include/asm/pmu.h b/arch/nds32/include/asm/pmu.h
new file mode 100644
index 000000000000..e1ac0b0b8bcf
--- /dev/null
+++ b/arch/nds32/include/asm/pmu.h
@@ -0,0 +1,386 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2008-2018 Andes Technology Corporation */
+
+#ifndef __ASM_PMU_H
+#define __ASM_PMU_H
+
+#include <linux/interrupt.h>
+#include <linux/perf_event.h>
+#include <asm/unistd.h>
+#include <asm/bitfield.h>
+
+/* Has special meaning for perf core implementation */
+#define HW_OP_UNSUPPORTED		0x0
+#define C(_x)				PERF_COUNT_HW_CACHE_##_x
+#define CACHE_OP_UNSUPPORTED		0x0
+
+/* Enough for both software and hardware defined events */
+#define SOFTWARE_EVENT_MASK		0xFF
+
+#define PFM_OFFSET_MAGIC_0		2	/* DO NOT START FROM 0 */
+#define PFM_OFFSET_MAGIC_1		(PFM_OFFSET_MAGIC_0 + 36)
+#define PFM_OFFSET_MAGIC_2		(PFM_OFFSET_MAGIC_1 + 36)
+
+enum { PFMC0, PFMC1, PFMC2, MAX_COUNTERS };
+
+u32 PFM_CTL_OVF[3] = { PFM_CTL_mskOVF0, PFM_CTL_mskOVF1,
+		       PFM_CTL_mskOVF2 };
+u32 PFM_CTL_EN[3] = { PFM_CTL_mskEN0, PFM_CTL_mskEN1,
+		      PFM_CTL_mskEN2 };
+u32 PFM_CTL_OFFSEL[3] = { PFM_CTL_offSEL0, PFM_CTL_offSEL1,
+			  PFM_CTL_offSEL2 };
+u32 PFM_CTL_IE[3] = { PFM_CTL_mskIE0, PFM_CTL_mskIE1, PFM_CTL_mskIE2 };
+u32 PFM_CTL_KS[3] = { PFM_CTL_mskKS0, PFM_CTL_mskKS1, PFM_CTL_mskKS2 };
+u32 PFM_CTL_KU[3] = { PFM_CTL_mskKU0, PFM_CTL_mskKU1, PFM_CTL_mskKU2 };
+u32 PFM_CTL_SEL[3] = { PFM_CTL_mskSEL0, PFM_CTL_mskSEL1, PFM_CTL_mskSEL2 };
+/*
+ * Perf Events' indices
+ */
+#define NDS32_IDX_CYCLE_COUNTER			0
+#define NDS32_IDX_COUNTER0			1
+#define NDS32_IDX_COUNTER1			2
+
+/* The events for a given PMU register set. */
+struct pmu_hw_events {
+	/*
+	 * The events that are active on the PMU for the given index.
+	 */
+	struct perf_event *events[MAX_COUNTERS];
+
+	/*
+	 * A 1 bit for an index indicates that the counter is being used for
+	 * an event. A 0 means that the counter can be used.
+	 */
+	unsigned long used_mask[BITS_TO_LONGS(MAX_COUNTERS)];
+
+	/*
+	 * Hardware lock to serialize accesses to PMU registers. Needed for the
+	 * read/modify/write sequences.
+	 */
+	raw_spinlock_t pmu_lock;
+};
+
+struct nds32_pmu {
+	struct pmu pmu;
+	cpumask_t active_irqs;
+	char *name;
+	 irqreturn_t (*handle_irq)(int irq_num, void *dev);
+	void (*enable)(struct perf_event *event);
+	void (*disable)(struct perf_event *event);
+	int (*get_event_idx)(struct pmu_hw_events *hw_events,
+			     struct perf_event *event);
+	int (*set_event_filter)(struct hw_perf_event *evt,
+				struct perf_event_attr *attr);
+	u32 (*read_counter)(struct perf_event *event);
+	void (*write_counter)(struct perf_event *event, u32 val);
+	void (*start)(struct nds32_pmu *nds32_pmu);
+	void (*stop)(struct nds32_pmu *nds32_pmu);
+	void (*reset)(void *data);
+	int (*request_irq)(struct nds32_pmu *nds32_pmu, irq_handler_t handler);
+	void (*free_irq)(struct nds32_pmu *nds32_pmu);
+	int (*map_event)(struct perf_event *event);
+	int num_events;
+	atomic_t active_events;
+	u64 max_period;
+	struct platform_device *plat_device;
+	struct pmu_hw_events *(*get_hw_events)(void);
+};
+
+#define to_nds32_pmu(p)			(container_of(p, struct nds32_pmu, pmu))
+
+int nds32_pmu_register(struct nds32_pmu *nds32_pmu, int type);
+
+u64 nds32_pmu_event_update(struct perf_event *event);
+
+int nds32_pmu_event_set_period(struct perf_event *event);
+
+/*
+ * Common NDS32 SPAv3 event types
+ *
+ * Note: An implementation may not be able to count all of these events
+ * but the encodings are considered to be `reserved' in the case that
+ * they are not available.
+ *
+ * SEL_TOTAL_CYCLES will add an offset is due to ZERO is defined as
+ * NOT_SUPPORTED EVENT mapping in generic perf code.
+ * You will need to deal it in the event writing implementation.
+ */
+enum spav3_counter_0_perf_types {
+	SPAV3_0_SEL_BASE = -1 + PFM_OFFSET_MAGIC_0,	/* counting symbol */
+	SPAV3_0_SEL_TOTAL_CYCLES = 0 + PFM_OFFSET_MAGIC_0,
+	SPAV3_0_SEL_COMPLETED_INSTRUCTION = 1 + PFM_OFFSET_MAGIC_0,
+	SPAV3_0_SEL_LAST	/* counting symbol */
+};
+
+enum spav3_counter_1_perf_types {
+	SPAV3_1_SEL_BASE = -1 + PFM_OFFSET_MAGIC_1,	/* counting symbol */
+	SPAV3_1_SEL_TOTAL_CYCLES = 0 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_COMPLETED_INSTRUCTION = 1 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_CONDITIONAL_BRANCH = 2 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_TAKEN_CONDITIONAL_BRANCH = 3 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_PREFETCH_INSTRUCTION = 4 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_RET_INST = 5 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_JR_INST = 6 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_JAL_JRAL_INST = 7 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_NOP_INST = 8 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_SCW_INST = 9 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_ISB_DSB_INST = 10 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_CCTL_INST = 11 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_TAKEN_INTERRUPTS = 12 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_LOADS_COMPLETED = 13 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_UITLB_ACCESS = 14 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_UDTLB_ACCESS = 15 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_MTLB_ACCESS = 16 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_CODE_CACHE_ACCESS = 17 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_DATA_DEPENDENCY_STALL_CYCLES = 18 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_DATA_CACHE_MISS_STALL_CYCLES = 19 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_DATA_CACHE_ACCESS = 20 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_DATA_CACHE_MISS = 21 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_LOAD_DATA_CACHE_ACCESS = 22 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_STORE_DATA_CACHE_ACCESS = 23 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_ILM_ACCESS = 24 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_LSU_BIU_CYCLES = 25 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_HPTWK_BIU_CYCLES = 26 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_DMA_BIU_CYCLES = 27 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_CODE_CACHE_FILL_BIU_CYCLES = 28 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_LEGAL_UNALIGN_DCACHE_ACCESS = 29 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_PUSH25 = 30 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_SYSCALLS_INST = 31 + PFM_OFFSET_MAGIC_1,
+	SPAV3_1_SEL_LAST	/* counting symbol */
+};
+
+enum spav3_counter_2_perf_types {
+	SPAV3_2_SEL_BASE = -1 + PFM_OFFSET_MAGIC_2,	/* counting symbol */
+	SPAV3_2_SEL_TOTAL_CYCLES = 0 + PFM_OFFSET_MAGIC_2,
+	SPAV3_2_SEL_COMPLETED_INSTRUCTION = 1 + PFM_OFFSET_MAGIC_2,
+	SPAV3_2_SEL_CONDITIONAL_BRANCH_MISPREDICT = 2 + PFM_OFFSET_MAGIC_2,
+	SPAV3_2_SEL_TAKEN_CONDITIONAL_BRANCH_MISPREDICT =
+	    3 + PFM_OFFSET_MAGIC_2,
+	SPAV3_2_SEL_PREFETCH_INSTRUCTION_CACHE_HIT = 4 + PFM_OFFSET_MAGIC_2,
+	SPAV3_1_SEL_RET_MISPREDICT = 5 + PFM_OFFSET_MAGIC_2,
+	SPAV3_1_SEL_IMMEDIATE_J_INST = 6 + PFM_OFFSET_MAGIC_2,
+	SPAV3_1_SEL_MULTIPLY_INST = 7 + PFM_OFFSET_MAGIC_2,
+	SPAV3_1_SEL_16_BIT_INST = 8 + PFM_OFFSET_MAGIC_2,
+	SPAV3_1_SEL_FAILED_SCW_INST = 9 + PFM_OFFSET_MAGIC_2,
+	SPAV3_1_SEL_LD_AFTER_ST_CONFLICT_REPLAYS = 10 + PFM_OFFSET_MAGIC_2,
+	SPAV3_1_SEL_TAKEN_EXCEPTIONS = 12 + PFM_OFFSET_MAGIC_2,
+	SPAV3_1_SEL_STORES_COMPLETED = 13 + PFM_OFFSET_MAGIC_2,
+	SPAV3_2_SEL_UITLB_MISS = 14 + PFM_OFFSET_MAGIC_2,
+	SPAV3_2_SEL_UDTLB_MISS = 15 + PFM_OFFSET_MAGIC_2,
+	SPAV3_2_SEL_MTLB_MISS = 16 + PFM_OFFSET_MAGIC_2,
+	SPAV3_2_SEL_CODE_CACHE_MISS = 17 + PFM_OFFSET_MAGIC_2,
+	SPAV3_1_SEL_EMPTY_INST_QUEUE_STALL_CYCLES = 18 + PFM_OFFSET_MAGIC_2,
+	SPAV3_1_SEL_DATA_WRITE_BACK = 19 + PFM_OFFSET_MAGIC_2,
+	SPAV3_2_SEL_DATA_CACHE_MISS = 21 + PFM_OFFSET_MAGIC_2,
+	SPAV3_2_SEL_LOAD_DATA_CACHE_MISS = 22 + PFM_OFFSET_MAGIC_2,
+	SPAV3_2_SEL_STORE_DATA_CACHE_MISS = 23 + PFM_OFFSET_MAGIC_2,
+	SPAV3_1_SEL_DLM_ACCESS = 24 + PFM_OFFSET_MAGIC_2,
+	SPAV3_1_SEL_LSU_BIU_REQUEST = 25 + PFM_OFFSET_MAGIC_2,
+	SPAV3_1_SEL_HPTWK_BIU_REQUEST = 26 + PFM_OFFSET_MAGIC_2,
+	SPAV3_1_SEL_DMA_BIU_REQUEST = 27 + PFM_OFFSET_MAGIC_2,
+	SPAV3_1_SEL_CODE_CACHE_FILL_BIU_REQUEST = 28 + PFM_OFFSET_MAGIC_2,
+	SPAV3_1_SEL_EXTERNAL_EVENTS = 29 + PFM_OFFSET_MAGIC_2,
+	SPAV3_1_SEL_POP25 = 30 + PFM_OFFSET_MAGIC_2,
+	SPAV3_2_SEL_LAST	/* counting symbol */
+};
+
+/* Get converted event counter index */
+static inline int get_converted_event_idx(unsigned long event)
+{
+	int idx;
+
+	if ((event) > SPAV3_0_SEL_BASE && event < SPAV3_0_SEL_LAST) {
+		idx = 0;
+	} else if ((event) > SPAV3_1_SEL_BASE && event < SPAV3_1_SEL_LAST) {
+		idx = 1;
+	} else if ((event) > SPAV3_2_SEL_BASE && event < SPAV3_2_SEL_LAST) {
+		idx = 2;
+	} else {
+		pr_err("GET_CONVERTED_EVENT_IDX PFM counter range error\n");
+		return -EPERM;
+	}
+
+	return idx;
+}
+
+/* Get converted hardware event number */
+static inline u32 get_converted_evet_hw_num(u32 event)
+{
+	if (event > SPAV3_0_SEL_BASE && event < SPAV3_0_SEL_LAST)
+		event -= PFM_OFFSET_MAGIC_0;
+	else if (event > SPAV3_1_SEL_BASE && event < SPAV3_1_SEL_LAST)
+		event -= PFM_OFFSET_MAGIC_1;
+	else if (event > SPAV3_2_SEL_BASE && event < SPAV3_2_SEL_LAST)
+		event -= PFM_OFFSET_MAGIC_2;
+	else if (event != 0)
+		pr_err("GET_CONVERTED_EVENT_HW_NUM PFM counter range error\n");
+
+	return event;
+}
+
+/*
+ * NDS32 HW events mapping
+ *
+ * The hardware events that we support. We do support cache operations but
+ * we have harvard caches and no way to combine instruction and data
+ * accesses/misses in hardware.
+ */
+static const unsigned int nds32_pfm_perf_map[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES] = SPAV3_0_SEL_TOTAL_CYCLES,
+	[PERF_COUNT_HW_INSTRUCTIONS] = SPAV3_1_SEL_COMPLETED_INSTRUCTION,
+	[PERF_COUNT_HW_CACHE_REFERENCES] = SPAV3_1_SEL_DATA_CACHE_ACCESS,
+	[PERF_COUNT_HW_CACHE_MISSES] = SPAV3_2_SEL_DATA_CACHE_MISS,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_BRANCH_MISSES] = HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_BUS_CYCLES] = HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_REF_CPU_CYCLES] = HW_OP_UNSUPPORTED
+};
+
+static const unsigned int nds32_pfm_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+	[PERF_COUNT_HW_CACHE_OP_MAX]
+	[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	[C(L1D)] = {
+		    [C(OP_READ)] = {
+				    [C(RESULT_ACCESS)] =
+				    SPAV3_1_SEL_LOAD_DATA_CACHE_ACCESS,
+				    [C(RESULT_MISS)] =
+				    SPAV3_2_SEL_LOAD_DATA_CACHE_MISS,
+				    },
+		    [C(OP_WRITE)] = {
+				     [C(RESULT_ACCESS)] =
+				     SPAV3_1_SEL_STORE_DATA_CACHE_ACCESS,
+				     [C(RESULT_MISS)] =
+				     SPAV3_2_SEL_STORE_DATA_CACHE_MISS,
+				     },
+		    [C(OP_PREFETCH)] = {
+					[C(RESULT_ACCESS)] =
+						CACHE_OP_UNSUPPORTED,
+					[C(RESULT_MISS)] =
+						CACHE_OP_UNSUPPORTED,
+					},
+		    },
+	[C(L1I)] = {
+		    [C(OP_READ)] = {
+				    [C(RESULT_ACCESS)] =
+				    SPAV3_1_SEL_CODE_CACHE_ACCESS,
+				    [C(RESULT_MISS)] =
+				    SPAV3_2_SEL_CODE_CACHE_MISS,
+				    },
+		    [C(OP_WRITE)] = {
+				     [C(RESULT_ACCESS)] =
+				     SPAV3_1_SEL_CODE_CACHE_ACCESS,
+				     [C(RESULT_MISS)] =
+				     SPAV3_2_SEL_CODE_CACHE_MISS,
+				     },
+		    [C(OP_PREFETCH)] = {
+					[C(RESULT_ACCESS)] =
+					CACHE_OP_UNSUPPORTED,
+					[C(RESULT_MISS)] = CACHE_OP_UNSUPPORTED,
+					},
+		    },
+	/* TODO: L2CC */
+	[C(LL)] = {
+		   [C(OP_READ)] = {
+				   [C(RESULT_ACCESS)] = CACHE_OP_UNSUPPORTED,
+				   [C(RESULT_MISS)] = CACHE_OP_UNSUPPORTED,
+				   },
+		   [C(OP_WRITE)] = {
+				    [C(RESULT_ACCESS)] = CACHE_OP_UNSUPPORTED,
+				    [C(RESULT_MISS)] = CACHE_OP_UNSUPPORTED,
+				    },
+		   [C(OP_PREFETCH)] = {
+				       [C(RESULT_ACCESS)] =
+				       CACHE_OP_UNSUPPORTED,
+				       [C(RESULT_MISS)] = CACHE_OP_UNSUPPORTED,
+				       },
+		   },
+	/* NDS32 PMU does not support TLB read/write hit/miss,
+	 * However, it can count access/miss, which mixed with read and write.
+	 * Therefore, only READ counter will use it.
+	 * We do as possible as we can.
+	 */
+	[C(DTLB)] = {
+		     [C(OP_READ)] = {
+				     [C(RESULT_ACCESS)] =
+					SPAV3_1_SEL_UDTLB_ACCESS,
+				     [C(RESULT_MISS)] =
+					SPAV3_2_SEL_UDTLB_MISS,
+				     },
+		     [C(OP_WRITE)] = {
+				      [C(RESULT_ACCESS)] = CACHE_OP_UNSUPPORTED,
+				      [C(RESULT_MISS)] = CACHE_OP_UNSUPPORTED,
+				      },
+		     [C(OP_PREFETCH)] = {
+					 [C(RESULT_ACCESS)] =
+					 CACHE_OP_UNSUPPORTED,
+					 [C(RESULT_MISS)] =
+					 CACHE_OP_UNSUPPORTED,
+					 },
+		     },
+	[C(ITLB)] = {
+		     [C(OP_READ)] = {
+				     [C(RESULT_ACCESS)] =
+					SPAV3_1_SEL_UITLB_ACCESS,
+				     [C(RESULT_MISS)] =
+					SPAV3_2_SEL_UITLB_MISS,
+				     },
+		     [C(OP_WRITE)] = {
+				      [C(RESULT_ACCESS)] =
+					CACHE_OP_UNSUPPORTED,
+				      [C(RESULT_MISS)] =
+					CACHE_OP_UNSUPPORTED,
+				      },
+		     [C(OP_PREFETCH)] = {
+					 [C(RESULT_ACCESS)] =
+						CACHE_OP_UNSUPPORTED,
+					 [C(RESULT_MISS)] =
+						CACHE_OP_UNSUPPORTED,
+					 },
+		     },
+	[C(BPU)] = {		/* What is BPU? */
+		    [C(OP_READ)] = {
+				    [C(RESULT_ACCESS)] =
+					CACHE_OP_UNSUPPORTED,
+				    [C(RESULT_MISS)] =
+					CACHE_OP_UNSUPPORTED,
+				    },
+		    [C(OP_WRITE)] = {
+				     [C(RESULT_ACCESS)] =
+					CACHE_OP_UNSUPPORTED,
+				     [C(RESULT_MISS)] =
+					CACHE_OP_UNSUPPORTED,
+				     },
+		    [C(OP_PREFETCH)] = {
+					[C(RESULT_ACCESS)] =
+						CACHE_OP_UNSUPPORTED,
+					[C(RESULT_MISS)] =
+						CACHE_OP_UNSUPPORTED,
+					},
+		    },
+	[C(NODE)] = {		/* What is NODE? */
+		     [C(OP_READ)] = {
+				     [C(RESULT_ACCESS)] = CACHE_OP_UNSUPPORTED,
+				     [C(RESULT_MISS)] = CACHE_OP_UNSUPPORTED,
+				     },
+		     [C(OP_WRITE)] = {
+				      [C(RESULT_ACCESS)] = CACHE_OP_UNSUPPORTED,
+				      [C(RESULT_MISS)] = CACHE_OP_UNSUPPORTED,
+				      },
+		     [C(OP_PREFETCH)] = {
+					 [C(RESULT_ACCESS)] =
+						CACHE_OP_UNSUPPORTED,
+					 [C(RESULT_MISS)] =
+						CACHE_OP_UNSUPPORTED,
+					 },
+		     },
+};
+
+int nds32_pmu_map_event(struct perf_event *event,
+			const unsigned int (*event_map)[PERF_COUNT_HW_MAX],
+			const unsigned int (*cache_map)[PERF_COUNT_HW_CACHE_MAX]
+			[PERF_COUNT_HW_CACHE_OP_MAX]
+			[PERF_COUNT_HW_CACHE_RESULT_MAX], u32 raw_event_mask);
+
+#endif /* __ASM_PMU_H */
diff --git a/arch/nds32/include/asm/stacktrace.h b/arch/nds32/include/asm/stacktrace.h
new file mode 100644
index 000000000000..6bf7c777bda4
--- /dev/null
+++ b/arch/nds32/include/asm/stacktrace.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2008-2018 Andes Technology Corporation */
+
+#ifndef __ASM_STACKTRACE_H
+#define __ASM_STACKTRACE_H
+
+/* Kernel callchain */
+struct stackframe {
+	unsigned long fp;
+	unsigned long sp;
+	unsigned long lp;
+};
+
+/*
+ * struct frame_tail: User callchain
+ * IMPORTANT:
+ * This struct is used for call-stack walking,
+ * the order and types matters.
+ * Do not use array, it only stores sizeof(pointer)
+ *
+ * The details can refer to arch/arm/kernel/perf_event.c
+ */
+struct frame_tail {
+	unsigned long stack_fp;
+	unsigned long stack_lp;
+};
+
+/* For User callchain with optimize for size */
+struct frame_tail_opt_size {
+	unsigned long stack_r6;
+	unsigned long stack_fp;
+	unsigned long stack_gp;
+	unsigned long stack_lp;
+};
+
+extern void
+get_real_ret_addr(unsigned long *addr, struct task_struct *tsk, int *graph);
+
+#endif /* __ASM_STACKTRACE_H */
diff --git a/arch/nds32/kernel/Makefile b/arch/nds32/kernel/Makefile
index 27cded39fa66..f52bd2744f50 100644
--- a/arch/nds32/kernel/Makefile
+++ b/arch/nds32/kernel/Makefile
@@ -4,7 +4,6 @@
 
 CPPFLAGS_vmlinux.lds	:= -DTEXTADDR=$(TEXTADDR)
 AFLAGS_head.o		:= -DTEXTADDR=$(TEXTADDR)
-
 # Object file lists.
 
 obj-y			:= ex-entry.o ex-exit.o ex-scall.o irq.o \
@@ -16,10 +15,10 @@ obj-$(CONFIG_MODULES)		+= nds32_ksyms.o module.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_OF)		+= devtree.o
 obj-$(CONFIG_CACHE_L2)		+= atl2c.o
+obj-$(CONFIG_PERF_EVENTS) += perf_event_cpu.o
 
 extra-y := head.o vmlinux.lds
 
-
 obj-y				+= vdso/
 
 obj-$(CONFIG_FUNCTION_TRACER)   += ftrace.o
diff --git a/arch/nds32/kernel/perf_event_cpu.c b/arch/nds32/kernel/perf_event_cpu.c
new file mode 100644
index 000000000000..a6e723d0fdbc
--- /dev/null
+++ b/arch/nds32/kernel/perf_event_cpu.c
@@ -0,0 +1,1223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2008-2017 Andes Technology Corporation
+ *
+ * Reference ARMv7: Jean Pihet <jpihet@mvista.com>
+ * 2010 (c) MontaVista Software, LLC.
+ */
+
+#include <linux/perf_event.h>
+#include <linux/bitmap.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/pm_runtime.h>
+#include <linux/ftrace.h>
+#include <linux/uaccess.h>
+#include <linux/sched/clock.h>
+#include <linux/percpu-defs.h>
+
+#include <asm/pmu.h>
+#include <asm/irq_regs.h>
+#include <asm/nds32.h>
+#include <asm/stacktrace.h>
+#include <asm/perf_event.h>
+#include <nds32_intrinsic.h>
+
+/* Set at runtime when we know what CPU type we are. */
+static struct nds32_pmu *cpu_pmu;
+
+static DEFINE_PER_CPU(struct pmu_hw_events, cpu_hw_events);
+static void nds32_pmu_start(struct nds32_pmu *cpu_pmu);
+static void nds32_pmu_stop(struct nds32_pmu *cpu_pmu);
+static struct platform_device_id cpu_pmu_plat_device_ids[] = {
+	{.name = "nds32-pfm"},
+	{},
+};
+
+static int nds32_pmu_map_cache_event(const unsigned int (*cache_map)
+				  [PERF_COUNT_HW_CACHE_MAX]
+				  [PERF_COUNT_HW_CACHE_OP_MAX]
+				  [PERF_COUNT_HW_CACHE_RESULT_MAX], u64 config)
+{
+	unsigned int cache_type, cache_op, cache_result, ret;
+
+	cache_type = (config >> 0) & 0xff;
+	if (cache_type >= PERF_COUNT_HW_CACHE_MAX)
+		return -EINVAL;
+
+	cache_op = (config >> 8) & 0xff;
+	if (cache_op >= PERF_COUNT_HW_CACHE_OP_MAX)
+		return -EINVAL;
+
+	cache_result = (config >> 16) & 0xff;
+	if (cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
+		return -EINVAL;
+
+	ret = (int)(*cache_map)[cache_type][cache_op][cache_result];
+
+	if (ret == CACHE_OP_UNSUPPORTED)
+		return -ENOENT;
+
+	return ret;
+}
+
+static int
+nds32_pmu_map_hw_event(const unsigned int (*event_map)[PERF_COUNT_HW_MAX],
+		       u64 config)
+{
+	int mapping;
+
+	if (config >= PERF_COUNT_HW_MAX)
+		return -ENOENT;
+
+	mapping = (*event_map)[config];
+	return mapping == HW_OP_UNSUPPORTED ? -ENOENT : mapping;
+}
+
+static int nds32_pmu_map_raw_event(u32 raw_event_mask, u64 config)
+{
+	int ev_type = (int)(config & raw_event_mask);
+	int idx = config >> 8;
+
+	switch (idx) {
+	case 0:
+		ev_type = PFM_OFFSET_MAGIC_0 + ev_type;
+		if (ev_type >= SPAV3_0_SEL_LAST || ev_type <= SPAV3_0_SEL_BASE)
+			return -ENOENT;
+		break;
+	case 1:
+		ev_type = PFM_OFFSET_MAGIC_1 + ev_type;
+		if (ev_type >= SPAV3_1_SEL_LAST || ev_type <= SPAV3_1_SEL_BASE)
+			return -ENOENT;
+		break;
+	case 2:
+		ev_type = PFM_OFFSET_MAGIC_2 + ev_type;
+		if (ev_type >= SPAV3_2_SEL_LAST || ev_type <= SPAV3_2_SEL_BASE)
+			return -ENOENT;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return ev_type;
+}
+
+int
+nds32_pmu_map_event(struct perf_event *event,
+		    const unsigned int (*event_map)[PERF_COUNT_HW_MAX],
+		    const unsigned int (*cache_map)
+		    [PERF_COUNT_HW_CACHE_MAX]
+		    [PERF_COUNT_HW_CACHE_OP_MAX]
+		    [PERF_COUNT_HW_CACHE_RESULT_MAX], u32 raw_event_mask)
+{
+	u64 config = event->attr.config;
+
+	switch (event->attr.type) {
+	case PERF_TYPE_HARDWARE:
+		return nds32_pmu_map_hw_event(event_map, config);
+	case PERF_TYPE_HW_CACHE:
+		return nds32_pmu_map_cache_event(cache_map, config);
+	case PERF_TYPE_RAW:
+		return nds32_pmu_map_raw_event(raw_event_mask, config);
+	}
+
+	return -ENOENT;
+}
+
+static int nds32_spav3_map_event(struct perf_event *event)
+{
+	return nds32_pmu_map_event(event, &nds32_pfm_perf_map,
+				&nds32_pfm_perf_cache_map, SOFTWARE_EVENT_MASK);
+}
+
+static inline u32 nds32_pfm_getreset_flags(void)
+{
+	/* Read overflow status */
+	u32 val = __nds32__mfsr(NDS32_SR_PFM_CTL);
+	u32 old_val = val;
+
+	/* Write overflow bit to clear status, and others keep it 0 */
+	u32 ov_flag = PFM_CTL_OVF[0] | PFM_CTL_OVF[1] | PFM_CTL_OVF[2];
+
+	__nds32__mtsr(val | ov_flag, NDS32_SR_PFM_CTL);
+
+	return old_val;
+}
+
+static inline int nds32_pfm_has_overflowed(u32 pfm)
+{
+	u32 ov_flag = PFM_CTL_OVF[0] | PFM_CTL_OVF[1] | PFM_CTL_OVF[2];
+
+	return pfm & ov_flag;
+}
+
+static inline int nds32_pfm_counter_has_overflowed(u32 pfm, int idx)
+{
+	u32 mask = 0;
+
+	switch (idx) {
+	case 0:
+		mask = PFM_CTL_OVF[0];
+		break;
+	case 1:
+		mask = PFM_CTL_OVF[1];
+		break;
+	case 2:
+		mask = PFM_CTL_OVF[2];
+		break;
+	default:
+		pr_err("%s index wrong\n", __func__);
+		break;
+	}
+	return pfm & mask;
+}
+
+/*
+ * Set the next IRQ period, based on the hwc->period_left value.
+ * To be called with the event disabled in hw:
+ */
+int nds32_pmu_event_set_period(struct perf_event *event)
+{
+	struct nds32_pmu *nds32_pmu = to_nds32_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	s64 left = local64_read(&hwc->period_left);
+	s64 period = hwc->sample_period;
+	int ret = 0;
+
+	/* The period may have been changed by PERF_EVENT_IOC_PERIOD */
+	if (unlikely(period != hwc->last_period))
+		left = period - (hwc->last_period - left);
+
+	if (unlikely(left <= -period)) {
+		left = period;
+		local64_set(&hwc->period_left, left);
+		hwc->last_period = period;
+		ret = 1;
+	}
+
+	if (unlikely(left <= 0)) {
+		left += period;
+		local64_set(&hwc->period_left, left);
+		hwc->last_period = period;
+		ret = 1;
+	}
+
+	if (left > (s64)nds32_pmu->max_period)
+		left = nds32_pmu->max_period;
+
+	/*
+	 * The hw event starts counting from this event offset,
+	 * mark it to be able to extract future "deltas":
+	 */
+	local64_set(&hwc->prev_count, (u64)(-left));
+
+	nds32_pmu->write_counter(event, (u64)(-left) & nds32_pmu->max_period);
+
+	perf_event_update_userpage(event);
+
+	return ret;
+}
+
+static irqreturn_t nds32_pmu_handle_irq(int irq_num, void *dev)
+{
+	u32 pfm;
+	struct perf_sample_data data;
+	struct nds32_pmu *cpu_pmu = (struct nds32_pmu *)dev;
+	struct pmu_hw_events *cpuc = cpu_pmu->get_hw_events();
+	struct pt_regs *regs;
+	int idx;
+	/*
+	 * Get and reset the IRQ flags
+	 */
+	pfm = nds32_pfm_getreset_flags();
+
+	/*
+	 * Did an overflow occur?
+	 */
+	if (!nds32_pfm_has_overflowed(pfm))
+		return IRQ_NONE;
+
+	/*
+	 * Handle the counter(s) overflow(s)
+	 */
+	regs = get_irq_regs();
+
+	nds32_pmu_stop(cpu_pmu);
+	for (idx = 0; idx < cpu_pmu->num_events; ++idx) {
+		struct perf_event *event = cpuc->events[idx];
+		struct hw_perf_event *hwc;
+
+		/* Ignore if we don't have an event. */
+		if (!event)
+			continue;
+
+		/*
+		 * We have a single interrupt for all counters. Check that
+		 * each counter has overflowed before we process it.
+		 */
+		if (!nds32_pfm_counter_has_overflowed(pfm, idx))
+			continue;
+
+		hwc = &event->hw;
+		nds32_pmu_event_update(event);
+		perf_sample_data_init(&data, 0, hwc->last_period);
+		if (!nds32_pmu_event_set_period(event))
+			continue;
+
+		if (perf_event_overflow(event, &data, regs))
+			cpu_pmu->disable(event);
+	}
+	nds32_pmu_start(cpu_pmu);
+	/*
+	 * Handle the pending perf events.
+	 *
+	 * Note: this call *must* be run with interrupts disabled. For
+	 * platforms that can have the PMU interrupts raised as an NMI, this
+	 * will not work.
+	 */
+	irq_work_run();
+
+	return IRQ_HANDLED;
+}
+
+static inline int nds32_pfm_counter_valid(struct nds32_pmu *cpu_pmu, int idx)
+{
+	return ((idx >= 0) && (idx < cpu_pmu->num_events));
+}
+
+static inline int nds32_pfm_disable_counter(int idx)
+{
+	unsigned int val = __nds32__mfsr(NDS32_SR_PFM_CTL);
+	u32 mask = 0;
+
+	mask = PFM_CTL_EN[idx];
+	val &= ~mask;
+	val &= ~(PFM_CTL_OVF[0] | PFM_CTL_OVF[1] | PFM_CTL_OVF[2]);
+	__nds32__mtsr_isb(val, NDS32_SR_PFM_CTL);
+	return idx;
+}
+
+/*
+ * Add an event filter to a given event.
+ */
+static int nds32_pmu_set_event_filter(struct hw_perf_event *event,
+				      struct perf_event_attr *attr)
+{
+	unsigned long config_base = 0;
+	int idx = event->idx;
+	unsigned long no_kernel_tracing = 0;
+	unsigned long no_user_tracing = 0;
+	/* If index is -1, do not do anything */
+	if (idx == -1)
+		return 0;
+
+	no_kernel_tracing = PFM_CTL_KS[idx];
+	no_user_tracing = PFM_CTL_KU[idx];
+	/*
+	 * Default: enable both kernel and user mode tracing.
+	 */
+	if (attr->exclude_user)
+		config_base |= no_user_tracing;
+
+	if (attr->exclude_kernel)
+		config_base |= no_kernel_tracing;
+
+	/*
+	 * Install the filter into config_base as this is used to
+	 * construct the event type.
+	 */
+	event->config_base |= config_base;
+	return 0;
+}
+
+static inline void nds32_pfm_write_evtsel(int idx, u32 evnum)
+{
+	u32 offset = 0;
+	u32 ori_val = __nds32__mfsr(NDS32_SR_PFM_CTL);
+	u32 ev_mask = 0;
+	u32 no_kernel_mask = 0;
+	u32 no_user_mask = 0;
+	u32 val;
+
+	offset = PFM_CTL_OFFSEL[idx];
+	/* Clear previous mode selection, and write new one */
+	no_kernel_mask = PFM_CTL_KS[idx];
+	no_user_mask = PFM_CTL_KU[idx];
+	ori_val &= ~no_kernel_mask;
+	ori_val &= ~no_user_mask;
+	if (evnum & no_kernel_mask)
+		ori_val |= no_kernel_mask;
+
+	if (evnum & no_user_mask)
+		ori_val |= no_user_mask;
+
+	/* Clear previous event selection */
+	ev_mask = PFM_CTL_SEL[idx];
+	ori_val &= ~ev_mask;
+	evnum &= SOFTWARE_EVENT_MASK;
+
+	/* undo the linear mapping */
+	evnum = get_converted_evet_hw_num(evnum);
+	val = ori_val | (evnum << offset);
+	val &= ~(PFM_CTL_OVF[0] | PFM_CTL_OVF[1] | PFM_CTL_OVF[2]);
+	__nds32__mtsr_isb(val, NDS32_SR_PFM_CTL);
+}
+
+static inline int nds32_pfm_enable_counter(int idx)
+{
+	unsigned int val = __nds32__mfsr(NDS32_SR_PFM_CTL);
+	u32 mask = 0;
+
+	mask = PFM_CTL_EN[idx];
+	val |= mask;
+	val &= ~(PFM_CTL_OVF[0] | PFM_CTL_OVF[1] | PFM_CTL_OVF[2]);
+	__nds32__mtsr_isb(val, NDS32_SR_PFM_CTL);
+	return idx;
+}
+
+static inline int nds32_pfm_enable_intens(int idx)
+{
+	unsigned int val = __nds32__mfsr(NDS32_SR_PFM_CTL);
+	u32 mask = 0;
+
+	mask = PFM_CTL_IE[idx];
+	val |= mask;
+	val &= ~(PFM_CTL_OVF[0] | PFM_CTL_OVF[1] | PFM_CTL_OVF[2]);
+	__nds32__mtsr_isb(val, NDS32_SR_PFM_CTL);
+	return idx;
+}
+
+static inline int nds32_pfm_disable_intens(int idx)
+{
+	unsigned int val = __nds32__mfsr(NDS32_SR_PFM_CTL);
+	u32 mask = 0;
+
+	mask = PFM_CTL_IE[idx];
+	val &= ~mask;
+	val &= ~(PFM_CTL_OVF[0] | PFM_CTL_OVF[1] | PFM_CTL_OVF[2]);
+	__nds32__mtsr_isb(val, NDS32_SR_PFM_CTL);
+	return idx;
+}
+
+static int event_requires_mode_exclusion(struct perf_event_attr *attr)
+{
+	/* Other modes NDS32 does not support */
+	return attr->exclude_user || attr->exclude_kernel;
+}
+
+static void nds32_pmu_enable_event(struct perf_event *event)
+{
+	unsigned long flags;
+	unsigned int evnum = 0;
+	struct hw_perf_event *hwc = &event->hw;
+	struct nds32_pmu *cpu_pmu = to_nds32_pmu(event->pmu);
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	int idx = hwc->idx;
+
+	if (!nds32_pfm_counter_valid(cpu_pmu, idx)) {
+		pr_err("CPU enabling wrong pfm counter IRQ enable\n");
+		return;
+	}
+
+	/*
+	 * Enable counter and interrupt, and set the counter to count
+	 * the event that we're interested in.
+	 */
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+
+	/*
+	 * Disable counter
+	 */
+	nds32_pfm_disable_counter(idx);
+
+	/*
+	 * Check whether we need to exclude the counter from certain modes.
+	 */
+	if ((!cpu_pmu->set_event_filter ||
+	     cpu_pmu->set_event_filter(hwc, &event->attr)) &&
+	     event_requires_mode_exclusion(&event->attr)) {
+		pr_notice
+		("NDS32 performance counters do not support mode exclusion\n");
+		hwc->config_base = 0;
+	}
+	/* Write event */
+	evnum = hwc->config_base;
+	nds32_pfm_write_evtsel(idx, evnum);
+
+	/*
+	 * Enable interrupt for this counter
+	 */
+	nds32_pfm_enable_intens(idx);
+
+	/*
+	 * Enable counter
+	 */
+	nds32_pfm_enable_counter(idx);
+
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+}
+
+static void nds32_pmu_disable_event(struct perf_event *event)
+{
+	unsigned long flags;
+	struct hw_perf_event *hwc = &event->hw;
+	struct nds32_pmu *cpu_pmu = to_nds32_pmu(event->pmu);
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	int idx = hwc->idx;
+
+	if (!nds32_pfm_counter_valid(cpu_pmu, idx)) {
+		pr_err("CPU disabling wrong pfm counter IRQ enable %d\n", idx);
+		return;
+	}
+
+	/*
+	 * Disable counter and interrupt
+	 */
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+
+	/*
+	 * Disable counter
+	 */
+	nds32_pfm_disable_counter(idx);
+
+	/*
+	 * Disable interrupt for this counter
+	 */
+	nds32_pfm_disable_intens(idx);
+
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+}
+
+static inline u32 nds32_pmu_read_counter(struct perf_event *event)
+{
+	struct nds32_pmu *cpu_pmu = to_nds32_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+	u32 count = 0;
+
+	if (!nds32_pfm_counter_valid(cpu_pmu, idx)) {
+		pr_err("CPU reading wrong counter %d\n", idx);
+	} else {
+		switch (idx) {
+		case PFMC0:
+			count = __nds32__mfsr(NDS32_SR_PFMC0);
+			break;
+		case PFMC1:
+			count = __nds32__mfsr(NDS32_SR_PFMC1);
+			break;
+		case PFMC2:
+			count = __nds32__mfsr(NDS32_SR_PFMC2);
+			break;
+		default:
+			pr_err
+			    ("%s: CPU has no performance counters %d\n",
+			     __func__, idx);
+		}
+	}
+	return count;
+}
+
+static inline void nds32_pmu_write_counter(struct perf_event *event, u32 value)
+{
+	struct nds32_pmu *cpu_pmu = to_nds32_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	if (!nds32_pfm_counter_valid(cpu_pmu, idx)) {
+		pr_err("CPU writing wrong counter %d\n", idx);
+	} else {
+		switch (idx) {
+		case PFMC0:
+			__nds32__mtsr_isb(value, NDS32_SR_PFMC0);
+			break;
+		case PFMC1:
+			__nds32__mtsr_isb(value, NDS32_SR_PFMC1);
+			break;
+		case PFMC2:
+			__nds32__mtsr_isb(value, NDS32_SR_PFMC2);
+			break;
+		default:
+			pr_err
+			    ("%s: CPU has no performance counters %d\n",
+			     __func__, idx);
+		}
+	}
+}
+
+static int nds32_pmu_get_event_idx(struct pmu_hw_events *cpuc,
+				   struct perf_event *event)
+{
+	int idx;
+	struct hw_perf_event *hwc = &event->hw;
+	/*
+	 * Current implementation maps cycles, instruction count and cache-miss
+	 * to specific counter.
+	 * However, multiple of the 3 counters are able to count these events.
+	 *
+	 *
+	 * SOFTWARE_EVENT_MASK mask for getting event num ,
+	 * This is defined by Jia-Rung, you can change the polocies.
+	 * However, do not exceed 8 bits. This is hardware specific.
+	 * The last number is SPAv3_2_SEL_LAST.
+	 */
+	unsigned long evtype = hwc->config_base & SOFTWARE_EVENT_MASK;
+
+	idx = get_converted_event_idx(evtype);
+	/*
+	 * Try to get the counter for correpsonding event
+	 */
+	if (evtype == SPAV3_0_SEL_TOTAL_CYCLES) {
+		if (!test_and_set_bit(idx, cpuc->used_mask))
+			return idx;
+		if (!test_and_set_bit(NDS32_IDX_COUNTER0, cpuc->used_mask))
+			return NDS32_IDX_COUNTER0;
+		if (!test_and_set_bit(NDS32_IDX_COUNTER1, cpuc->used_mask))
+			return NDS32_IDX_COUNTER1;
+	} else if (evtype == SPAV3_1_SEL_COMPLETED_INSTRUCTION) {
+		if (!test_and_set_bit(idx, cpuc->used_mask))
+			return idx;
+		else if (!test_and_set_bit(NDS32_IDX_COUNTER1, cpuc->used_mask))
+			return NDS32_IDX_COUNTER1;
+		else if (!test_and_set_bit
+			 (NDS32_IDX_CYCLE_COUNTER, cpuc->used_mask))
+			return NDS32_IDX_CYCLE_COUNTER;
+	} else {
+		if (!test_and_set_bit(idx, cpuc->used_mask))
+			return idx;
+	}
+	return -EAGAIN;
+}
+
+static void nds32_pmu_start(struct nds32_pmu *cpu_pmu)
+{
+	unsigned long flags;
+	unsigned int val;
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+
+	/* Enable all counters , NDS PFM has 3 counters */
+	val = __nds32__mfsr(NDS32_SR_PFM_CTL);
+	val |= (PFM_CTL_EN[0] | PFM_CTL_EN[1] | PFM_CTL_EN[2]);
+	val &= ~(PFM_CTL_OVF[0] | PFM_CTL_OVF[1] | PFM_CTL_OVF[2]);
+	__nds32__mtsr_isb(val, NDS32_SR_PFM_CTL);
+
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+}
+
+static void nds32_pmu_stop(struct nds32_pmu *cpu_pmu)
+{
+	unsigned long flags;
+	unsigned int val;
+	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+
+	/* Disable all counters , NDS PFM has 3 counters */
+	val = __nds32__mfsr(NDS32_SR_PFM_CTL);
+	val &= ~(PFM_CTL_EN[0] | PFM_CTL_EN[1] | PFM_CTL_EN[2]);
+	val &= ~(PFM_CTL_OVF[0] | PFM_CTL_OVF[1] | PFM_CTL_OVF[2]);
+	__nds32__mtsr_isb(val, NDS32_SR_PFM_CTL);
+
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+}
+
+static void nds32_pmu_reset(void *info)
+{
+	u32 val = 0;
+
+	val |= (PFM_CTL_OVF[0] | PFM_CTL_OVF[1] | PFM_CTL_OVF[2]);
+	__nds32__mtsr(val, NDS32_SR_PFM_CTL);
+	__nds32__mtsr(0, NDS32_SR_PFM_CTL);
+	__nds32__mtsr(0, NDS32_SR_PFMC0);
+	__nds32__mtsr(0, NDS32_SR_PFMC1);
+	__nds32__mtsr(0, NDS32_SR_PFMC2);
+}
+
+static void nds32_pmu_init(struct nds32_pmu *cpu_pmu)
+{
+	cpu_pmu->handle_irq = nds32_pmu_handle_irq;
+	cpu_pmu->enable = nds32_pmu_enable_event;
+	cpu_pmu->disable = nds32_pmu_disable_event;
+	cpu_pmu->read_counter = nds32_pmu_read_counter;
+	cpu_pmu->write_counter = nds32_pmu_write_counter;
+	cpu_pmu->get_event_idx = nds32_pmu_get_event_idx;
+	cpu_pmu->start = nds32_pmu_start;
+	cpu_pmu->stop = nds32_pmu_stop;
+	cpu_pmu->reset = nds32_pmu_reset;
+	cpu_pmu->max_period = 0xFFFFFFFF;	/* Maximum counts */
+};
+
+static u32 nds32_read_num_pfm_events(void)
+{
+	/* NDS32 SPAv3 PMU support 3 counter */
+	return 3;
+}
+
+static int device_pmu_init(struct nds32_pmu *cpu_pmu)
+{
+	nds32_pmu_init(cpu_pmu);
+	/*
+	 * This name should be devive-specific name, whatever you like :)
+	 * I think "PMU" will be a good generic name.
+	 */
+	cpu_pmu->name = "nds32v3-pmu";
+	cpu_pmu->map_event = nds32_spav3_map_event;
+	cpu_pmu->num_events = nds32_read_num_pfm_events();
+	cpu_pmu->set_event_filter = nds32_pmu_set_event_filter;
+	return 0;
+}
+
+/*
+ * CPU PMU identification and probing.
+ */
+static int probe_current_pmu(struct nds32_pmu *pmu)
+{
+	int ret;
+
+	get_cpu();
+	ret = -ENODEV;
+	/*
+	 * If ther are various CPU types with its own PMU, initialize with
+	 *
+	 * the corresponding one
+	 */
+	device_pmu_init(pmu);
+	put_cpu();
+	return ret;
+}
+
+static void nds32_pmu_enable(struct pmu *pmu)
+{
+	struct nds32_pmu *nds32_pmu = to_nds32_pmu(pmu);
+	struct pmu_hw_events *hw_events = nds32_pmu->get_hw_events();
+	int enabled = bitmap_weight(hw_events->used_mask,
+				    nds32_pmu->num_events);
+
+	if (enabled)
+		nds32_pmu->start(nds32_pmu);
+}
+
+static void nds32_pmu_disable(struct pmu *pmu)
+{
+	struct nds32_pmu *nds32_pmu = to_nds32_pmu(pmu);
+
+	nds32_pmu->stop(nds32_pmu);
+}
+
+static void nds32_pmu_release_hardware(struct nds32_pmu *nds32_pmu)
+{
+	nds32_pmu->free_irq(nds32_pmu);
+	pm_runtime_put_sync(&nds32_pmu->plat_device->dev);
+}
+
+static irqreturn_t nds32_pmu_dispatch_irq(int irq, void *dev)
+{
+	struct nds32_pmu *nds32_pmu = (struct nds32_pmu *)dev;
+	int ret;
+	u64 start_clock, finish_clock;
+
+	start_clock = local_clock();
+	ret = nds32_pmu->handle_irq(irq, dev);
+	finish_clock = local_clock();
+
+	perf_sample_event_took(finish_clock - start_clock);
+	return ret;
+}
+
+static int nds32_pmu_reserve_hardware(struct nds32_pmu *nds32_pmu)
+{
+	int err;
+	struct platform_device *pmu_device = nds32_pmu->plat_device;
+
+	if (!pmu_device)
+		return -ENODEV;
+
+	pm_runtime_get_sync(&pmu_device->dev);
+	err = nds32_pmu->request_irq(nds32_pmu, nds32_pmu_dispatch_irq);
+	if (err) {
+		nds32_pmu_release_hardware(nds32_pmu);
+		return err;
+	}
+
+	return 0;
+}
+
+static int
+validate_event(struct pmu *pmu, struct pmu_hw_events *hw_events,
+	       struct perf_event *event)
+{
+	struct nds32_pmu *nds32_pmu = to_nds32_pmu(event->pmu);
+
+	if (is_software_event(event))
+		return 1;
+
+	if (event->pmu != pmu)
+		return 0;
+
+	if (event->state < PERF_EVENT_STATE_OFF)
+		return 1;
+
+	if (event->state == PERF_EVENT_STATE_OFF && !event->attr.enable_on_exec)
+		return 1;
+
+	return nds32_pmu->get_event_idx(hw_events, event) >= 0;
+}
+
+static int validate_group(struct perf_event *event)
+{
+	struct perf_event *sibling, *leader = event->group_leader;
+	struct pmu_hw_events fake_pmu;
+	DECLARE_BITMAP(fake_used_mask, MAX_COUNTERS);
+	/*
+	 * Initialize the fake PMU. We only need to populate the
+	 * used_mask for the purposes of validation.
+	 */
+	memset(fake_used_mask, 0, sizeof(fake_used_mask));
+
+	if (!validate_event(event->pmu, &fake_pmu, leader))
+		return -EINVAL;
+
+	for_each_sibling_event(sibling, leader) {
+		if (!validate_event(event->pmu, &fake_pmu, sibling))
+			return -EINVAL;
+	}
+
+	if (!validate_event(event->pmu, &fake_pmu, event))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int __hw_perf_event_init(struct perf_event *event)
+{
+	struct nds32_pmu *nds32_pmu = to_nds32_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int mapping;
+
+	mapping = nds32_pmu->map_event(event);
+
+	if (mapping < 0) {
+		pr_debug("event %x:%llx not supported\n", event->attr.type,
+			 event->attr.config);
+		return mapping;
+	}
+
+	/*
+	 * We don't assign an index until we actually place the event onto
+	 * hardware. Use -1 to signify that we haven't decided where to put it
+	 * yet. For SMP systems, each core has it's own PMU so we can't do any
+	 * clever allocation or constraints checking at this point.
+	 */
+	hwc->idx = -1;
+	hwc->config_base = 0;
+	hwc->config = 0;
+	hwc->event_base = 0;
+
+	/*
+	 * Check whether we need to exclude the counter from certain modes.
+	 */
+	if ((!nds32_pmu->set_event_filter ||
+	     nds32_pmu->set_event_filter(hwc, &event->attr)) &&
+	    event_requires_mode_exclusion(&event->attr)) {
+		pr_debug
+			("NDS performance counters do not support mode exclusion\n");
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * Store the event encoding into the config_base field.
+	 */
+	hwc->config_base |= (unsigned long)mapping;
+
+	if (!hwc->sample_period) {
+		/*
+		 * For non-sampling runs, limit the sample_period to half
+		 * of the counter width. That way, the new counter value
+		 * is far less likely to overtake the previous one unless
+		 * you have some serious IRQ latency issues.
+		 */
+		hwc->sample_period = nds32_pmu->max_period >> 1;
+		hwc->last_period = hwc->sample_period;
+		local64_set(&hwc->period_left, hwc->sample_period);
+	}
+
+	if (event->group_leader != event) {
+		if (validate_group(event) != 0)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int nds32_pmu_event_init(struct perf_event *event)
+{
+	struct nds32_pmu *nds32_pmu = to_nds32_pmu(event->pmu);
+	int err = 0;
+	atomic_t *active_events = &nds32_pmu->active_events;
+
+	/* does not support taken branch sampling */
+	if (has_branch_stack(event))
+		return -EOPNOTSUPP;
+
+	if (nds32_pmu->map_event(event) == -ENOENT)
+		return -ENOENT;
+
+	if (!atomic_inc_not_zero(active_events)) {
+		if (atomic_read(active_events) == 0) {
+			/* Register irq handler */
+			err = nds32_pmu_reserve_hardware(nds32_pmu);
+		}
+
+		if (!err)
+			atomic_inc(active_events);
+	}
+
+	if (err)
+		return err;
+
+	err = __hw_perf_event_init(event);
+
+	return err;
+}
+
+static void nds32_start(struct perf_event *event, int flags)
+{
+	struct nds32_pmu *nds32_pmu = to_nds32_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	/*
+	 * NDS pmu always has to reprogram the period, so ignore
+	 * PERF_EF_RELOAD, see the comment below.
+	 */
+	if (flags & PERF_EF_RELOAD)
+		WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
+
+	hwc->state = 0;
+	/* Set the period for the event. */
+	nds32_pmu_event_set_period(event);
+
+	nds32_pmu->enable(event);
+}
+
+static int nds32_pmu_add(struct perf_event *event, int flags)
+{
+	struct nds32_pmu *nds32_pmu = to_nds32_pmu(event->pmu);
+	struct pmu_hw_events *hw_events = nds32_pmu->get_hw_events();
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+	int err = 0;
+
+	perf_pmu_disable(event->pmu);
+
+	/* If we don't have a space for the counter then finish early. */
+	idx = nds32_pmu->get_event_idx(hw_events, event);
+	if (idx < 0) {
+		err = idx;
+		goto out;
+	}
+
+	/*
+	 * If there is an event in the counter we are going to use then make
+	 * sure it is disabled.
+	 */
+	event->hw.idx = idx;
+	nds32_pmu->disable(event);
+	hw_events->events[idx] = event;
+
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	if (flags & PERF_EF_START)
+		nds32_start(event, PERF_EF_RELOAD);
+
+	/* Propagate our changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+
+out:
+	perf_pmu_enable(event->pmu);
+	return err;
+}
+
+u64 nds32_pmu_event_update(struct perf_event *event)
+{
+	struct nds32_pmu *nds32_pmu = to_nds32_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 delta, prev_raw_count, new_raw_count;
+
+again:
+	prev_raw_count = local64_read(&hwc->prev_count);
+	new_raw_count = nds32_pmu->read_counter(event);
+
+	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
+			    new_raw_count) != prev_raw_count) {
+		goto again;
+	}
+	/*
+	 * Whether overflow or not, "unsigned substraction"
+	 * will always get their delta
+	 */
+	delta = (new_raw_count - prev_raw_count) & nds32_pmu->max_period;
+
+	local64_add(delta, &event->count);
+	local64_sub(delta, &hwc->period_left);
+
+	return new_raw_count;
+}
+
+static void nds32_stop(struct perf_event *event, int flags)
+{
+	struct nds32_pmu *nds32_pmu = to_nds32_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	/*
+	 * NDS pmu always has to update the counter, so ignore
+	 * PERF_EF_UPDATE, see comments in nds32_start().
+	 */
+	if (!(hwc->state & PERF_HES_STOPPED)) {
+		nds32_pmu->disable(event);
+		nds32_pmu_event_update(event);
+		hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	}
+}
+
+static void nds32_pmu_del(struct perf_event *event, int flags)
+{
+	struct nds32_pmu *nds32_pmu = to_nds32_pmu(event->pmu);
+	struct pmu_hw_events *hw_events = nds32_pmu->get_hw_events();
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	nds32_stop(event, PERF_EF_UPDATE);
+	hw_events->events[idx] = NULL;
+	clear_bit(idx, hw_events->used_mask);
+
+	perf_event_update_userpage(event);
+}
+
+static void nds32_pmu_read(struct perf_event *event)
+{
+	nds32_pmu_event_update(event);
+}
+
+/* Please refer to SPAv3 for more hardware specific details */
+PMU_FORMAT_ATTR(event, "config:0-63");
+
+static struct attribute *nds32_arch_formats_attr[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group nds32_pmu_format_group = {
+	.name = "format",
+	.attrs = nds32_arch_formats_attr,
+};
+
+static ssize_t nds32_pmu_cpumask_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	return 0;
+}
+
+static DEVICE_ATTR(cpus, 0444, nds32_pmu_cpumask_show, NULL);
+
+static struct attribute *nds32_pmu_common_attrs[] = {
+	&dev_attr_cpus.attr,
+	NULL,
+};
+
+static struct attribute_group nds32_pmu_common_group = {
+	.attrs = nds32_pmu_common_attrs,
+};
+
+static const struct attribute_group *nds32_pmu_attr_groups[] = {
+	&nds32_pmu_format_group,
+	&nds32_pmu_common_group,
+	NULL,
+};
+
+static void nds32_init(struct nds32_pmu *nds32_pmu)
+{
+	atomic_set(&nds32_pmu->active_events, 0);
+
+	nds32_pmu->pmu = (struct pmu) {
+		.pmu_enable = nds32_pmu_enable,
+		.pmu_disable = nds32_pmu_disable,
+		.attr_groups = nds32_pmu_attr_groups,
+		.event_init = nds32_pmu_event_init,
+		.add = nds32_pmu_add,
+		.del = nds32_pmu_del,
+		.start = nds32_start,
+		.stop = nds32_stop,
+		.read = nds32_pmu_read,
+	};
+}
+
+int nds32_pmu_register(struct nds32_pmu *nds32_pmu, int type)
+{
+	nds32_init(nds32_pmu);
+	pm_runtime_enable(&nds32_pmu->plat_device->dev);
+	pr_info("enabled with %s PMU driver, %d counters available\n",
+		nds32_pmu->name, nds32_pmu->num_events);
+	return perf_pmu_register(&nds32_pmu->pmu, nds32_pmu->name, type);
+}
+
+static struct pmu_hw_events *cpu_pmu_get_cpu_events(void)
+{
+	return this_cpu_ptr(&cpu_hw_events);
+}
+
+static int cpu_pmu_request_irq(struct nds32_pmu *cpu_pmu, irq_handler_t handler)
+{
+	int err, irq, irqs;
+	struct platform_device *pmu_device = cpu_pmu->plat_device;
+
+	if (!pmu_device)
+		return -ENODEV;
+
+	irqs = min(pmu_device->num_resources, num_possible_cpus());
+	if (irqs < 1) {
+		pr_err("no irqs for PMUs defined\n");
+		return -ENODEV;
+	}
+
+	irq = platform_get_irq(pmu_device, 0);
+	err = request_irq(irq, handler, IRQF_NOBALANCING, "nds32-pfm",
+			  cpu_pmu);
+	if (err) {
+		pr_err("unable to request IRQ%d for NDS PMU counters\n",
+		       irq);
+		return err;
+	}
+	return 0;
+}
+
+static void cpu_pmu_free_irq(struct nds32_pmu *cpu_pmu)
+{
+	int irq;
+	struct platform_device *pmu_device = cpu_pmu->plat_device;
+
+	irq = platform_get_irq(pmu_device, 0);
+	if (irq >= 0)
+		free_irq(irq, cpu_pmu);
+}
+
+static void cpu_pmu_init(struct nds32_pmu *cpu_pmu)
+{
+	int cpu;
+	struct pmu_hw_events *events = &per_cpu(cpu_hw_events, cpu);
+
+	raw_spin_lock_init(&events->pmu_lock);
+
+	cpu_pmu->get_hw_events = cpu_pmu_get_cpu_events;
+	cpu_pmu->request_irq = cpu_pmu_request_irq;
+	cpu_pmu->free_irq = cpu_pmu_free_irq;
+
+	/* Ensure the PMU has sane values out of reset. */
+	if (cpu_pmu->reset)
+		on_each_cpu(cpu_pmu->reset, cpu_pmu, 1);
+}
+
+const static struct of_device_id cpu_pmu_of_device_ids[] = {
+	{.compatible = "andestech,nds32v3-pmu",
+	 .data = device_pmu_init},
+	{},
+};
+
+static int cpu_pmu_device_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *of_id;
+	int (*init_fn)(struct nds32_pmu *nds32_pmu);
+	struct device_node *node = pdev->dev.of_node;
+	struct nds32_pmu *pmu;
+	int ret = -ENODEV;
+
+	if (cpu_pmu) {
+		pr_notice("[perf] attempt to register multiple PMU devices!\n");
+		return -ENOSPC;
+	}
+
+	pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
+	if (!pmu)
+		return -ENOMEM;
+
+	of_id = of_match_node(cpu_pmu_of_device_ids, pdev->dev.of_node);
+	if (node && of_id) {
+		init_fn = of_id->data;
+		ret = init_fn(pmu);
+	} else {
+		ret = probe_current_pmu(pmu);
+	}
+
+	if (ret) {
+		pr_notice("[perf] failed to probe PMU!\n");
+		goto out_free;
+	}
+
+	cpu_pmu = pmu;
+	cpu_pmu->plat_device = pdev;
+	cpu_pmu_init(cpu_pmu);
+	ret = nds32_pmu_register(cpu_pmu, PERF_TYPE_RAW);
+
+	if (!ret)
+		return 0;
+
+out_free:
+	pr_notice("[perf] failed to register PMU devices!\n");
+	kfree(pmu);
+	return ret;
+}
+
+static struct platform_driver cpu_pmu_driver = {
+	.driver = {
+		   .name = "nds32-pfm",
+		   .of_match_table = cpu_pmu_of_device_ids,
+		   },
+	.probe = cpu_pmu_device_probe,
+	.id_table = cpu_pmu_plat_device_ids,
+};
+
+static int __init register_pmu_driver(void)
+{
+	int err = 0;
+
+	err = platform_driver_register(&cpu_pmu_driver);
+	if (err)
+		pr_notice("[perf] PMU initialization failed\n");
+	else
+		pr_notice("[perf] PMU initialization done\n");
+
+	return err;
+}
+
+device_initcall(register_pmu_driver);
+
+unsigned long perf_instruction_pointer(struct pt_regs *regs)
+{
+	/* However, NDS32 does not support virtualization */
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest())
+		return perf_guest_cbs->get_guest_ip();
+
+	return instruction_pointer(regs);
+}
+
+unsigned long perf_misc_flags(struct pt_regs *regs)
+{
+	int misc = 0;
+
+	/* However, NDS32 does not support virtualization */
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+		if (perf_guest_cbs->is_user_mode())
+			misc |= PERF_RECORD_MISC_GUEST_USER;
+		else
+			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
+	} else {
+		if (user_mode(regs))
+			misc |= PERF_RECORD_MISC_USER;
+		else
+			misc |= PERF_RECORD_MISC_KERNEL;
+	}
+
+	return misc;
+}
diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index b740534b152c..68d5f2a27f38 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/hardirq.h>
 #include <linux/uaccess.h>
+#include <linux/perf_event.h>
 
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
@@ -169,8 +170,6 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 			mask = VM_EXEC;
 		else {
 			mask = VM_READ | VM_WRITE;
-			if (vma->vm_flags & VM_WRITE)
-				flags |= FAULT_FLAG_WRITE;
 		}
 	} else if (entry == ENTRY_TLB_MISC) {
 		switch (error_code & ITYPE_mskETYPE) {
@@ -231,11 +230,17 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	 * attempt. If we go through a retry, it is extremely likely that the
 	 * page will be found in page cache at that point.
 	 */
+	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR)
+		if (fault & VM_FAULT_MAJOR) {
 			tsk->maj_flt++;
-		else
+			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ,
+				      1, regs, addr);
+		} else {
 			tsk->min_flt++;
+			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN,
+				      1, regs, addr);
+		}
 		if (fault & VM_FAULT_RETRY) {
 			flags &= ~FAULT_FLAG_ALLOW_RETRY;
 			flags |= FAULT_FLAG_TRIED;
diff --git a/tools/include/asm/barrier.h b/tools/include/asm/barrier.h
index 391d942536e5..5531becf0ba7 100644
--- a/tools/include/asm/barrier.h
+++ b/tools/include/asm/barrier.h
@@ -23,6 +23,8 @@
 #include "../../arch/ia64/include/asm/barrier.h"
 #elif defined(__xtensa__)
 #include "../../arch/xtensa/include/asm/barrier.h"
+#elif defined(__nds32__)
+#include "../../arch/nds32/include/asm/barrier.h"
 #else
 #include <asm-generic/barrier.h>
 #endif
diff --git a/tools/perf/arch/nds32/Build b/tools/perf/arch/nds32/Build
new file mode 100644
index 000000000000..54afe4a467e7
--- /dev/null
+++ b/tools/perf/arch/nds32/Build
@@ -0,0 +1 @@
+libperf-y += util/
diff --git a/tools/perf/arch/nds32/util/Build b/tools/perf/arch/nds32/util/Build
new file mode 100644
index 000000000000..ca623bbf993c
--- /dev/null
+++ b/tools/perf/arch/nds32/util/Build
@@ -0,0 +1 @@
+libperf-y += header.o
diff --git a/tools/perf/arch/nds32/util/header.c b/tools/perf/arch/nds32/util/header.c
new file mode 100644
index 000000000000..ef9dbdbe7968
--- /dev/null
+++ b/tools/perf/arch/nds32/util/header.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <api/fs/fs.h>
+#include "header.h"
+
+#define STR_LEN 1024
+
+char *get_cpuid_str(struct perf_pmu *pmu)
+{
+	/* In nds32, we only have one cpu */
+	char *buf = NULL;
+	struct cpu_map *cpus;
+	const char *sysfs = sysfs__mountpoint();
+
+	if (!sysfs || !pmu || !pmu->cpus)
+		return NULL;
+
+	buf = malloc(STR_LEN);
+	if (!buf)
+		return NULL;
+
+	cpus = cpu_map__get(pmu->cpus);
+	sprintf(buf, "0x%x", cpus->nr - 1);
+	cpu_map__put(cpus);
+	return buf;
+}
diff --git a/tools/perf/pmu-events/arch/nds32/mapfile.csv b/tools/perf/pmu-events/arch/nds32/mapfile.csv
new file mode 100644
index 000000000000..efb395f26883
--- /dev/null
+++ b/tools/perf/pmu-events/arch/nds32/mapfile.csv
@@ -0,0 +1,15 @@
+# Format:
+#	MIDR,Version,JSON/file/pathname,Type
+#
+# where
+#	MIDR	Processor version
+#		Variant[23:20] and Revision [3:0] should be zero.
+#	Version could be used to track version of of JSON file
+#		but currently unused.
+#	JSON/file/pathname is the path to JSON file, relative
+#		to tools/perf/pmu-events/arch/arm64/.
+#	Type is core, uncore etc
+#
+#
+#Family-model,Version,Filename,EventType
+0x0,v3,n13,core
diff --git a/tools/perf/pmu-events/arch/nds32/n13/atcpmu.json b/tools/perf/pmu-events/arch/nds32/n13/atcpmu.json
new file mode 100644
index 000000000000..5347350c360c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/nds32/n13/atcpmu.json
@@ -0,0 +1,290 @@
+[
+  {
+	"PublicDescription": "Conditional branch",
+    "EventCode": "0x102",
+    "EventName": "cond_br",
+    "BriefDescription": "V3 Conditional branch"
+  },
+  {
+	"PublicDescription": "Taken conditional branches",
+    "EventCode": "0x103",
+    "EventName": "taken_cond_br",
+    "BriefDescription": "V3 Taken Conditional branch"
+  },
+  {
+	"PublicDescription": "Prefetch Instruction",
+    "EventCode": "0x104",
+    "EventName": "prefetch_inst",
+    "BriefDescription": "V3 Prefetch Instruction"
+  },
+  {
+	"PublicDescription": "RET Inst",
+    "EventCode": "0x105",
+    "EventName": "ret_inst",
+    "BriefDescription": "V3 RET Inst"
+  },
+  {
+	"PublicDescription": "JR(non-RET) instructions",
+    "EventCode": "0x106",
+    "EventName": "jr_inst",
+    "BriefDescription": "V3 JR(non-RET) instructions"
+  },
+  {
+	"PublicDescription": "JAL/JRAL instructions",
+    "EventCode": "0x107",
+    "EventName": "jal_jral_inst",
+    "BriefDescription": "V3 JAL/JRAL instructions"
+  },
+  {
+	"PublicDescription": "NOP instructions",
+    "EventCode": "0x108",
+    "EventName": "nop_inst",
+    "BriefDescription": "V3 NOP instructions"
+  },
+  {
+	"PublicDescription": "SCW instructions",
+    "EventCode": "0x109",
+    "EventName": "scw_inst",
+    "BriefDescription": "V3 SCW instructions"
+  },
+  {
+	"PublicDescription": "ISB/DSB instructions",
+    "EventCode": "0x10a",
+    "EventName": "isb_dsb_inst",
+    "BriefDescription": "V3 ISB/DSB instructions"
+  },
+  {
+	"PublicDescription": "CCTL instructions",
+    "EventCode": "0x10b",
+    "EventName": "cctl_inst",
+    "BriefDescription": "V3 CCTL instructions"
+  },
+  {
+	"PublicDescription": "Taken Interrupts",
+    "EventCode": "0x10c",
+    "EventName": "taken_interrupts",
+    "BriefDescription": "V3 Taken Interrupts"
+  },
+  {
+	"PublicDescription": "Loads Completed",
+    "EventCode": "0x10d",
+    "EventName": "load_completed",
+    "BriefDescription": "V3 Loads Completed"
+  },
+  {
+	"PublicDescription": "uITLB accesses",
+    "EventCode": "0x10e",
+    "EventName": "uitlb_access",
+    "BriefDescription": "V3 uITLB accesses"
+  },
+  {
+	"PublicDescription": "uDTLB accesses",
+    "EventCode": "0x10f",
+    "EventName": "udtlb_access",
+    "BriefDescription": "V3 uDTLB accesses"
+  },
+  {
+	"PublicDescription": "MTLB accesses",
+    "EventCode": "0x110",
+    "EventName": "mtlb_access",
+    "BriefDescription": "V3 MTLB accesses"
+  },
+  {
+	"PublicDescription": "DATA_DEPENDENCY_STALL_CYCLES",
+    "EventCode": "0x112",
+    "EventName": "data_dependency_stall",
+    "BriefDescription": "V3 DATA_DEPENDENCY_STALL_CYCLES"
+  },
+  {
+	"PublicDescription": "DATA_CACHE_MISS_STALL_CYCLES",
+    "EventCode": "0x113",
+    "EventName": "dcache_miss_stall",
+    "BriefDescription": "V3 DATA_CACHE_MISS_STALL_CYCLES"
+  },
+  {
+	"PublicDescription": "ILM access",
+    "EventCode": "0x118",
+    "EventName": "ilm_access",
+    "BriefDescription": "V3 ILM accesses"
+  },
+  {
+	"PublicDescription": "LSU BIU CYCLES",
+    "EventCode": "0x119",
+    "EventName": "lsu_biu_cycles",
+    "BriefDescription": "V3 LSU BIU CYCLES"
+  },
+  {
+	"PublicDescription": "HPTWK BIU CYCLES",
+    "EventCode": "0x11a",
+    "EventName": "hptwk_biu_cycles",
+    "BriefDescription": "V3 HPTWK BIU CYCLES"
+  },
+  {
+	"PublicDescription": "DMA BIU CYCLES",
+    "EventCode": "0x11b",
+    "EventName": "dma_biu_cycles",
+    "BriefDescription": "V3 DMA BIU CYCLES"
+  },
+  {
+	"PublicDescription": "CODE CACHE FILL BIU CYCLES",
+    "EventCode": "0x11c",
+    "EventName": "icache_fill_biu_cycles",
+    "BriefDescription": "V3 CODE CACHE FILL BIU CYCLES"
+  },
+  {
+	"PublicDescription": "LEAGAL UNALIGN DCACHE ACCESS",
+    "EventCode": "0x11d",
+    "EventName": "legal_unalined_dcache_access",
+    "BriefDescription": "V3 LEAGAL UNALIGN DCACHE ACCESS"
+  },
+  {
+	"PublicDescription": "PUSH25 instructions",
+    "EventCode": "0x11e",
+    "EventName": "push25_inst",
+    "BriefDescription": "V3 PUSH25 instructions"
+  },
+  {
+	"PublicDescription": "SYSCALL instructions",
+    "EventCode": "0x11f",
+    "EventName": "syscall_inst",
+    "BriefDescription": "V3 SYSCALL instructions"
+  },
+  {
+	"PublicDescription": "conditional branch miss",
+    "EventCode": "0x202",
+    "EventName": "cond_br_miss",
+    "BriefDescription": "V3 conditional branch miss"
+  },
+  {
+	"PublicDescription": "taken conditional branch miss",
+    "EventCode": "0x203",
+    "EventName": "taken_cond_br_miss",
+    "BriefDescription": "V3 taken conditional branch miss"
+  },
+  {
+	"PublicDescription": "Prefetch Instructions with cache hit",
+    "EventCode": "0x204",
+    "EventName": "prefetch_icache_hit",
+    "BriefDescription": "V3 Prefetch Instructions with cache hit"
+  },
+  {
+	"PublicDescription": "RET mispredict",
+    "EventCode": "0x205",
+    "EventName": "ret_mispredict",
+    "BriefDescription": "V3 RET mispredict"
+  },
+  {
+	"PublicDescription": "Immediate J instructions",
+    "EventCode": "0x206",
+    "EventName": "imm_j_inst",
+    "BriefDescription": "V3 Immediate J instructions"
+  },
+  {
+	"PublicDescription": "Multiply instructions",
+    "EventCode": "0x207",
+    "EventName": "mul_inst",
+    "BriefDescription": "V3 Multiply instructions"
+  },
+  {
+	"PublicDescription": "16 bits instructions",
+    "EventCode": "0x208",
+    "EventName": "sixteen_bits_inst",
+    "BriefDescription": "V3 16 bits instructions"
+  },
+  {
+	"PublicDescription": "Failed SCW instructions",
+    "EventCode": "0x209",
+    "EventName": "fail_scw_inst",
+    "BriefDescription": "V3 Failed SCW instructions"
+  },
+  {
+	"PublicDescription": "ld-after-st conflict replays",
+    "EventCode": "0x20a",
+    "EventName": "ld_af_st_conflict",
+    "BriefDescription": "V3 ld-after-st conflict replays"
+  },
+  {
+	"PublicDescription": "Exception taken",
+    "EventCode": "0x20c",
+    "EventName": "exception_taken",
+    "BriefDescription": "V3 Exception taken"
+  },
+  {
+	"PublicDescription": "Stores completed",
+    "EventCode": "0x20d",
+    "EventName": "store_completed",
+    "BriefDescription": "V3 Stores completed"
+  },
+  {
+	"PublicDescription": "uITLB miss",
+    "EventCode": "0x20e",
+    "EventName": "uitlb_miss",
+    "BriefDescription": "V3 uITLB miss"
+  },
+  {
+	"PublicDescription": "uDTLB miss",
+    "EventCode": "0x20f",
+    "EventName": "udtlb_miss",
+    "BriefDescription": "V3 uDTLB miss"
+  },
+  {
+	"PublicDescription": "MTLB miss",
+    "EventCode": "0x210",
+    "EventName": "mtlb_miss",
+    "BriefDescription": "V3 MTLB miss"
+  },
+  {
+	"PublicDescription": "Empty instructions queue stall cycles",
+    "EventCode": "0x212",
+    "EventName": "empty_inst_q_stall",
+    "BriefDescription": "V3 Empty instructions queue stall cycles"
+  },
+  {
+	"PublicDescription": "Data write back",
+    "EventCode": "0x213",
+    "EventName": "data_wb",
+    "BriefDescription": "V3 Data write back"
+  },
+  {
+	"PublicDescription": "DLM access",
+    "EventCode": "0x218",
+    "EventName": "dlm_access",
+    "BriefDescription": "V3 DLM access"
+  },
+  {
+	"PublicDescription": "LSU BIU request",
+    "EventCode": "0x219",
+    "EventName": "lsu_biu_req",
+    "BriefDescription": "V3 LSU BIU request"
+  },
+  {
+	"PublicDescription": "HPTWK BIU request",
+    "EventCode": "0x21a",
+    "EventName": "hptwk_biu_req",
+    "BriefDescription": "V3 HPTWK BIU request"
+  },
+  {
+	"PublicDescription": "DMA BIU request",
+    "EventCode": "0x21b",
+    "EventName": "dma_biu_req",
+    "BriefDescription": "V3 DMA BIU request"
+  },
+  {
+	"PublicDescription": "Icache fill BIU request",
+    "EventCode": "0x21c",
+    "EventName": "icache_fill_biu_req",
+    "BriefDescription": "V3 Icache fill BIU request"
+  },
+  {
+	"PublicDescription": "External events",
+    "EventCode": "0x21d",
+    "EventName": "external_events",
+    "BriefDescription": "V3 External events"
+  },
+  {
+	"PublicDescription": "POP25 instructions",
+    "EventCode": "0x21e",
+    "EventName": "pop25_inst",
+    "BriefDescription": "V3 POP25 instructions"
+  },
+]
-- 
2.17.0
