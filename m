From: Rabin Vincent <rabin@rab.in>
Subject: [PATCH] tracing: add support for tracing MMIO helpers
Date: Tue, 26 Apr 2016 21:04:42 +0200
Message-ID: <1461697482-32406-1-git-send-email-rabin@rab.in>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33912 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbcDZTFK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2016 15:05:10 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Rabin Vincent <rabin@rab.in>

Add support for tracing the MMIO helpers readl()/writel() (and their
variants), for use while developing and debugging device drivers.

The address and the value are saved along with the C expressions used in
the driver when calling these MMIO access functions, leading to a trace
of the driver's interactions with the hardware's registers:

 mmcqd/0-659 [000] d.H3 95.600911: mmio_write: mmci_request_end: 0xa08d200c [host->base + MMCICOMMAND] <= 0x00000000 [0]
 mmcqd/0-659 [000] d.H3 95.600945: mmio_read: mmci_irq: 0xa08d2034 [host->base + MMCISTATUS] => 0x00000400
 mmcqd/0-659 [000] d.H3 95.600953: mmio_read: mmci_irq: 0xa08d203c [host->base + MMCIMASK0] => 0x000003ff
 mmcqd/0-659 [000] d.H3 95.600961: mmio_write: mmci_irq: 0xa08d2038 [host->base + MMCICLEAR] <= 0x00000000 [status]
 mmcqd/0-659 [000] d..2 95.601476: mmio_write: mmci_start_data: 0xa08d2024 [base + MMCIDATATIMER] <= 0x00124f80 [timeout]
 mmcqd/0-659 [000] d..2 95.601498: mmio_write: mmci_start_data: 0xa08d2028 [base + MMCIDATALENGTH] <= 0x00003e00 [host->size]
 mmcqd/0-659 [000] d..2 95.601512: mmio_write: mmci_write_datactrlreg: 0xa08d202c [host->base + MMCIDATACTRL] <= 0x00000093 [datactrl]
 mmcqd/0-659 [000] d..2 95.601522: mmio_read: mmci_start_data: 0xa08d203c [base + MMCIMASK0] => 0x000003ff
 mmcqd/0-659 [000] d..2 95.601531: mmio_write: mmci_start_data: 0xa08d203c [base + MMCIMASK0] <= 0x000002ff [readl(base + MMCIMASK0) & ~MCI_DATAENDMASK]
 mmcqd/0-659 [000] d..2 95.601540: mmio_write: mmci_set_mask1: 0xa08d2040 [base + MMCIMASK1] <= 0x00008000 [mask]
 mmcqd/0-659 [000] d..2 95.601550: mmio_read: mmci_start_command: 0xa08d200c [base + MMCICOMMAND] => 0x00000000
 mmcqd/0-659 [000] d..2 95.601559: mmio_write: mmci_start_command: 0xa08d2008 [base + MMCIARGUMENT] <= 0x00007c00 [cmd->arg]
 mmcqd/0-659 [000] d..2 95.601568: mmio_write: mmci_start_command: 0xa08d200c [base + MMCICOMMAND] <= 0x00000452 [c]
 mmcqd/0-659 [000] d.h3 95.601688: mmio_read: mmci_irq: 0xa08d2034 [host->base + MMCISTATUS] => 0x0022a440
 mmcqd/0-659 [000] d.h3 95.601708: mmio_read: mmci_irq: 0xa08d203c [host->base + MMCIMASK0] => 0x000002ff
 mmcqd/0-659 [000] d.h3 95.601718: mmio_write: mmci_irq: 0xa08d2038 [host->base + MMCICLEAR] <= 0x00000040 [status]

We do not globally replace the MMIO helpers.  Instead, tracing must be
explicitly enabled in the required driver source files by #defining
TRACE_MMIO_HELPERS at the top of the file.

The support is added via <asm-generic/io.h> and as such is only
available on the archs which use that header.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 include/asm-generic/io.h           |  4 ++
 include/linux/trace_mmio_helpers.h | 98 ++++++++++++++++++++++++++++++++++++++
 include/trace/events/mmio.h        | 84 ++++++++++++++++++++++++++++++++
 kernel/trace/Kconfig               | 16 +++++++
 kernel/trace/Makefile              |  1 +
 kernel/trace/trace_mmio_helpers.c  | 45 +++++++++++++++++
 6 files changed, 248 insertions(+)
 create mode 100644 include/linux/trace_mmio_helpers.h
 create mode 100644 include/trace/events/mmio.h
 create mode 100644 kernel/trace/trace_mmio_helpers.c

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index eed3bbe88c8a..676ed9d4cddf 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -699,6 +699,10 @@ static inline void iowrite32_rep(volatile void __iomem *addr,
 #endif
 #endif /* CONFIG_GENERIC_IOMAP */
 
+#ifdef TRACE_MMIO_HELPERS
+#include <linux/trace_mmio_helpers.h>
+#endif
+
 #ifdef __KERNEL__
 
 #include <linux/vmalloc.h>
diff --git a/include/linux/trace_mmio_helpers.h b/include/linux/trace_mmio_helpers.h
new file mode 100644
index 000000000000..463f2e38adad
--- /dev/null
+++ b/include/linux/trace_mmio_helpers.h
@@ -0,0 +1,98 @@
+#ifndef _LINUX_TRACE_MMIO_HELPERS_H
+#define _LINUX_TRACE_MMIO_HELPERS_H
+
+#ifdef CONFIG_TRACE_MMIO_HELPERS
+
+#define DECLARE_MMIO_RW_TRACE(c, type)					\
+static inline type							\
+read ## c ## _notrace(const volatile void __iomem *addr)		\
+{									\
+	return read ## c(addr);						\
+}									\
+									\
+static inline type							\
+read ## c ## _relaxed_notrace(const volatile void __iomem *addr)	\
+{									\
+	return read ## c ## _relaxed(addr);				\
+}									\
+									\
+static inline void							\
+write ## c ## _notrace(type value, volatile void __iomem *addr)		\
+{									\
+	write ## c(value, addr);					\
+}									\
+									\
+static inline void							\
+write ## c ## _relaxed_notrace(type value,				\
+			       volatile void __iomem *addr)		\
+{									\
+	write ## c ## _relaxed(value, addr);				\
+}									\
+									\
+type read ## c ## _trace(const volatile void __iomem *addr,		\
+		    const char *addrexp, bool relaxed,			\
+		    unsigned long caller);				\
+									\
+void write ## c ##_trace(volatile void __iomem *addr,			\
+		    const char *addrexp,				\
+		    type value, const char *valueexp,			\
+		    bool relaxed, unsigned long caller);		\
+
+DECLARE_MMIO_RW_TRACE(b, u8)
+DECLARE_MMIO_RW_TRACE(w, u16)
+DECLARE_MMIO_RW_TRACE(l, u32)
+#ifdef CONFIG_64BIT
+DECLARE_MMIO_RW_TRACE(q, u64)
+#endif
+
+#undef readb
+#undef readw
+#undef readl
+#undef readq
+
+#undef readb_relaxed
+#undef readw_relaxed
+#undef readl_relaxed
+#undef readq_relaxed
+
+#undef writeb
+#undef writew
+#undef writel
+#undef writeq
+
+#undef writeb_relaxed
+#undef writew_relaxed
+#undef writel_relaxed
+#undef writeq_relaxed
+
+#define readb(addr) readb_trace(addr, #addr, false, _THIS_IP_)
+#define readw(addr) readw_trace(addr, #addr, false, _THIS_IP_)
+#define readl(addr) readl_trace(addr, #addr, false, _THIS_IP_)
+#define readq(addr) readq_trace(addr, #addr, false, _THIS_IP_)
+
+#define readb_relaxed(addr) readb_trace(addr, #addr, true, _THIS_IP_)
+#define readw_relaxed(addr) readw_trace(addr, #addr, true, _THIS_IP_)
+#define readl_relaxed(addr) readl_trace(addr, #addr, true, _THIS_IP_)
+#define readq_relaxed(addr) readq_trace(addr, #addr, true, _THIS_IP_)
+
+#define writeb(value, addr) \
+		writeb_trace(addr, #addr, value, #value, false, _THIS_IP_)
+#define writew(value, addr) \
+		writew_trace(addr, #addr, value, #value, false, _THIS_IP_)
+#define writel(value, addr) \
+		writel_trace(addr, #addr, value, #value, false, _THIS_IP_)
+#define writeq(value, addr) \
+		writeq_trace(addr, #addr, value, #value, false, _THIS_IP_)
+
+#define writeb_relaxed(value, addr) \
+		writeb_trace(addr, #addr, value, #value, true, _THIS_IP_)
+#define writew_relaxed(value, addr) \
+		writew_trace(addr, #addr, value, #value, true, _THIS_IP_)
+#define writel_relaxed(value, addr) \
+		writel_trace(addr, #addr, value, #value, true, _THIS_IP_)
+#define writeq_relaxed(value, addr) \
+		writeq_trace(addr, #addr, value, #value, true, _THIS_IP_)
+
+#endif /* CONFIG_TRACE_MMIO_HELPERS */
+
+#endif /* _LINUX_TRACE_MMIO_HELPERS_H */
diff --git a/include/trace/events/mmio.h b/include/trace/events/mmio.h
new file mode 100644
index 000000000000..3fa2c51be2aa
--- /dev/null
+++ b/include/trace/events/mmio.h
@@ -0,0 +1,84 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM mmio
+
+#if !defined(_TRACE_MMIO_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_MMIO_H
+
+#include <linux/tracepoint.h>
+#include <linux/trace_events.h>
+
+TRACE_EVENT(mmio_read,
+	TP_PROTO(const volatile void __iomem *addr,
+		 const char *addrexp, unsigned long value,
+		 unsigned char size, bool relaxed,
+		 unsigned long caller),
+
+	TP_ARGS(addr, addrexp, value, size, relaxed, caller),
+
+	TP_STRUCT__entry(
+		__field(const volatile void __iomem *, addr)
+		__field(const char *, addrexp)
+		__field(unsigned long, value)
+		__field(unsigned char, size)
+		__field(bool, relaxed)
+		__field(unsigned long, caller)
+	),
+
+	TP_fast_assign(
+		__entry->addr = addr;
+		__entry->addrexp = addrexp;
+		__entry->value = value;
+		__entry->size = size;
+		__entry->relaxed = relaxed;
+		__entry->caller = caller;
+	),
+
+	TP_printk("%pf: 0x%p [%s] %c> 0x%0*lx",
+		(void *) __entry->caller,
+		__entry->addr, __entry->addrexp,
+		__entry->relaxed ? '-' : '=',
+		__entry->size * 2,
+		__entry->value)
+);
+
+TRACE_EVENT(mmio_write,
+	TP_PROTO(volatile void __iomem *addr,
+		 const char *addrexp, unsigned long value,
+		 const char *valueexp,
+		 unsigned char size, bool relaxed,
+		 unsigned long caller),
+
+	TP_ARGS(addr, addrexp, value, valueexp, size, relaxed, caller),
+
+	TP_STRUCT__entry(
+		__field(volatile void __iomem *, addr)
+		__field(const char *, addrexp)
+		__field(unsigned long, value)
+		__field(const char *, valueexp)
+		__field(unsigned char, size)
+		__field(bool, relaxed)
+		__field(unsigned long, caller)
+	),
+
+	TP_fast_assign(
+		__entry->caller = caller;
+		__entry->addr = addr;
+		__entry->addrexp = addrexp;
+		__entry->value = value;
+		__entry->valueexp = valueexp;
+		__entry->size = size;
+		__entry->relaxed = relaxed;
+	),
+
+	TP_printk("%pf: 0x%p [%s] <%c 0x%0*lx [%s]",
+		(void *) __entry->caller,
+		__entry->addr, __entry->addrexp,
+		__entry->relaxed ? '-' : '=',
+		__entry->size * 2,
+		__entry->value, __entry->valueexp)
+);
+
+#endif /* _TRACE_MMIO_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e45db6b0d878..feca834436c5 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -372,6 +372,22 @@ config STACK_TRACER
 
 	  Say N if unsure.
 
+config TRACE_MMIO_HELPERS
+       bool "Support for tracing MMIO helpers"
+       select GENERIC_TRACER
+       help
+	  Provide support for overriding the MMIO access helpers readl/writel
+	  (and their variants) with an implementation which embeds trace
+	  points.
+
+	  Simply enabling this configuration option will not enable any
+	  invocations of these trace points.  These tracepoints are only
+	  intended to be used while developing or debugging device drivers and
+	  must be explicitly enabled by adding a "#define TRACE_MMIO_HELPERS"
+	  line at the top of the driver's source file(s).
+
+	  If unsure, say N.
+
 config BLK_DEV_IO_TRACE
 	bool "Support for tracing block IO actions"
 	depends on SYSFS
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 9b1044e936a6..9319f501c970 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_STACK_TRACER) += trace_stack.o
 obj-$(CONFIG_MMIOTRACE) += trace_mmiotrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += trace_functions_graph.o
 obj-$(CONFIG_TRACE_BRANCH_PROFILING) += trace_branch.o
+obj-$(CONFIG_TRACE_MMIO_HELPERS) += trace_mmio_helpers.o
 obj-$(CONFIG_BLK_DEV_IO_TRACE) += blktrace.o
 ifeq ($(CONFIG_BLOCK),y)
 obj-$(CONFIG_EVENT_TRACING) += blktrace.o
diff --git a/kernel/trace/trace_mmio_helpers.c b/kernel/trace/trace_mmio_helpers.c
new file mode 100644
index 000000000000..dbd8f725e7b8
--- /dev/null
+++ b/kernel/trace/trace_mmio_helpers.c
@@ -0,0 +1,45 @@
+#define TRACE_MMIO_HELPERS
+#include <linux/io.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/mmio.h>
+
+#define DEFINE_MMIO_RW_TRACE(c, type)					\
+type read ## c ## _trace(const volatile void __iomem *addr,		\
+		    const char *addrexp, bool relaxed,			\
+		    unsigned long caller)				\
+{									\
+	type value;							\
+									\
+	if (relaxed)							\
+		value = read ## c ## _relaxed_notrace(addr);		\
+	else								\
+		value = read ## c ## _notrace(addr);			\
+									\
+	trace_mmio_read(addr, addrexp, value,				\
+			sizeof(value), relaxed, caller);		\
+									\
+	return value;							\
+}									\
+									\
+void write ## c ##_trace(volatile void __iomem *addr,			\
+		    const char *addrexp,				\
+		    type value, const char *valueexp,			\
+		    bool relaxed, unsigned long caller)			\
+{									\
+	trace_mmio_write(addr, addrexp, value, valueexp,		\
+			 sizeof(value), relaxed, caller);		\
+									\
+	if (relaxed)							\
+		write ## c ## _relaxed_notrace(value, addr);		\
+	else								\
+		write ## c ## _notrace(value, addr);			\
+}
+
+DEFINE_MMIO_RW_TRACE(b, u8)
+DEFINE_MMIO_RW_TRACE(w, u16)
+DEFINE_MMIO_RW_TRACE(l, u32)
+#ifdef CONFIG_64BIT
+DEFINE_MMIO_RW_TRACE(q, u64)
+#endif
+
-- 
2.8.0.rc3
