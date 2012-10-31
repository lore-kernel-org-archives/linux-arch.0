From: James Hogan <james.hogan@imgtec.com>
Subject: [RFC PATCH v1 37/40] metag: Various sysfs drivers
Date: Wed, 31 Oct 2012 16:14:18 +0000
Message-ID: <1351700061-7203-38-git-send-email-james.hogan@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:55171 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423221Ab2JaQPZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2012 12:15:25 -0400
In-Reply-To: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>

Add various Meta specific sysfs drivers.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 arch/metag/Kconfig                          |    2 +
 arch/metag/include/asm/core-sysfs.h         |    9 +
 arch/metag/kernel/cpu/Kconfig               |   53 +++++
 arch/metag/kernel/cpu/Makefile              |    8 +
 arch/metag/kernel/cpu/core-sysfs.c          |   60 ++++++
 arch/metag/kernel/cpu/counters/Makefile     |    7 +
 arch/metag/kernel/cpu/counters/amacount.c   |  227 +++++++++++++++++++++
 arch/metag/kernel/cpu/counters/cyclecount.c |  135 +++++++++++++
 arch/metag/kernel/cpu/counters/perfcount.c  |  154 ++++++++++++++
 arch/metag/kernel/cpu/l2cache-control.c     |  289 +++++++++++++++++++++++++++
 arch/metag/kernel/cpu/memory-arbiter.c      |  133 ++++++++++++
 arch/metag/kernel/cpu/write-combiner.c      |  215 ++++++++++++++++++++
 12 files changed, 1292 insertions(+), 0 deletions(-)
 create mode 100644 arch/metag/include/asm/core-sysfs.h
 create mode 100644 arch/metag/kernel/cpu/Kconfig
 create mode 100644 arch/metag/kernel/cpu/Makefile
 create mode 100644 arch/metag/kernel/cpu/core-sysfs.c
 create mode 100644 arch/metag/kernel/cpu/counters/Makefile
 create mode 100644 arch/metag/kernel/cpu/counters/amacount.c
 create mode 100644 arch/metag/kernel/cpu/counters/cyclecount.c
 create mode 100644 arch/metag/kernel/cpu/counters/perfcount.c
 create mode 100644 arch/metag/kernel/cpu/l2cache-control.c
 create mode 100644 arch/metag/kernel/cpu/memory-arbiter.c
 create mode 100644 arch/metag/kernel/cpu/write-combiner.c

diff --git a/arch/metag/Kconfig b/arch/metag/Kconfig
index 74cc946..103b1b2 100644
--- a/arch/metag/Kconfig
+++ b/arch/metag/Kconfig
@@ -278,6 +278,8 @@ menu "Board support"
 
 endmenu
 
+source "arch/metag/kernel/cpu/Kconfig"
+
 source "kernel/Kconfig.preempt"
 
 source kernel/Kconfig.hz
diff --git a/arch/metag/include/asm/core-sysfs.h b/arch/metag/include/asm/core-sysfs.h
new file mode 100644
index 0000000..b2168b1
--- /dev/null
+++ b/arch/metag/include/asm/core-sysfs.h
@@ -0,0 +1,9 @@
+#ifndef _METAG_ASM_CORE_SYSFS_H
+#define _METAG_ASM_CORE_SYSFS_H
+
+#include <linux/device.h>
+
+extern struct bus_type performance_subsys;
+extern struct bus_type cache_subsys;
+
+#endif /* _METAG_ASM_CORE_SYSFS_H */
diff --git a/arch/metag/kernel/cpu/Kconfig b/arch/metag/kernel/cpu/Kconfig
new file mode 100644
index 0000000..f4224b6
--- /dev/null
+++ b/arch/metag/kernel/cpu/Kconfig
@@ -0,0 +1,53 @@
+config META_CORE_SYSFS
+	bool "Meta core sysfs interface"
+	select SYSFS
+	help
+	  This enables a sysfs driver that gives access to the CPU core
+	  parameters such as cycle counters and configuration registers.
+
+config META_WRITE_COMBINER
+	bool "Meta write combiner sysfs interface"
+	depends on META_CORE_SYSFS
+	help
+	  This enables a sysfs driver that gives access to the CPU core
+	  write combiner hardware.
+
+config META_MEM_ARBITER
+	bool "Meta memory arbiter sysfs interface"
+	depends on META_CORE_SYSFS
+	help
+	  This enables a sysfs driver that gives access to the CPU core
+	  memory arbiter hardware.
+
+config META_CYCLE_COUNTER
+	bool "Meta cycle counters"
+	depends on META_CORE_SYSFS
+	help
+	  This enables a sysfs driver that gives access to the CPU core
+	  cycle counters.
+
+config META_PERFORMANCE_COUNTER
+	bool "Meta performance counters"
+	depends on META_CORE_SYSFS
+	help
+	  This enables a sysfs driver that gives access to the CPU core
+	  performance counters.
+
+config META_AMA_COUNTER
+	bool "Meta Automatic MIPs Allocation counters"
+	depends on META_CORE_SYSFS
+	help
+	  This enables a sysfs driver that gives access to the CPU core
+	  Automatic MIPs Allocation counters.
+
+config META_L2C_CONTROL
+	bool "Level 2 Cache control"
+	depends on META_CORE_SYSFS && META_L2C
+	help
+	  This enables a sysfs driver that provides access to the CPU core level
+	  2 cache configuration (information like line size, ways of
+	  associativity, total size, whether unified, and the hardware revision
+	  number). It also provides controls to enable and disable the L2 cache,
+	  to enable and disable prefetch, and to trigger write backs and
+	  flushes, mostly for debug purposes. They can be found in
+	  /sys/devices/system/cache/l2/.
diff --git a/arch/metag/kernel/cpu/Makefile b/arch/metag/kernel/cpu/Makefile
new file mode 100644
index 0000000..f898af1
--- /dev/null
+++ b/arch/metag/kernel/cpu/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for the Linux Meta-specific sysfs interfaces.
+#
+
+obj-$(CONFIG_META_CORE_SYSFS)		+= core-sysfs.o counters/
+obj-$(CONFIG_META_WRITE_COMBINER)	+= write-combiner.o
+obj-$(CONFIG_META_MEM_ARBITER)		+= memory-arbiter.o
+obj-$(CONFIG_META_L2C_CONTROL)		+= l2cache-control.o
diff --git a/arch/metag/kernel/cpu/core-sysfs.c b/arch/metag/kernel/cpu/core-sysfs.c
new file mode 100644
index 0000000..ebb5d8b
--- /dev/null
+++ b/arch/metag/kernel/cpu/core-sysfs.c
@@ -0,0 +1,60 @@
+/*
+ * linux/arch/metag/drivers/core-sysfs.c
+ *
+ * Meta core sysfs interface, including cycle counters, perf counters and AMA
+ * configuration registers.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <asm/core-sysfs.h>
+#include <linux/device.h>
+#include <linux/init.h>
+
+struct bus_type performance_subsys = {
+	.name = "performance",
+	.dev_name = "counter",
+};
+
+struct bus_type cache_subsys = {
+	.name = "cache",
+	.dev_name = "cache",
+};
+
+static int __init meta_core_sysfs_init(void)
+{
+	int err, ret = 0;
+
+	err = subsys_system_register(&performance_subsys, NULL);
+	if (err) {
+		performance_subsys.name = NULL;
+		ret = err;
+	}
+
+	err = subsys_system_register(&cache_subsys, NULL);
+	if (err) {
+		cache_subsys.name = NULL;
+		ret = err;
+	}
+
+	return ret;
+}
+arch_initcall(meta_core_sysfs_init);
diff --git a/arch/metag/kernel/cpu/counters/Makefile b/arch/metag/kernel/cpu/counters/Makefile
new file mode 100644
index 0000000..6dc877b
--- /dev/null
+++ b/arch/metag/kernel/cpu/counters/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for the Meta performance counter specific device drivers.
+#
+
+obj-$(CONFIG_META_CYCLE_COUNTER)	+= cyclecount.o
+obj-$(CONFIG_META_PERFORMANCE_COUNTER)	+= perfcount.o
+obj-$(CONFIG_META_AMA_COUNTER)		+= amacount.o
diff --git a/arch/metag/kernel/cpu/counters/amacount.c b/arch/metag/kernel/cpu/counters/amacount.c
new file mode 100644
index 0000000..86f1859
--- /dev/null
+++ b/arch/metag/kernel/cpu/counters/amacount.c
@@ -0,0 +1,227 @@
+/*
+ * linux/arch/metag/drivers/amacount.c
+ *
+ * Meta core Automatic MIPs Allocation (AMA) sysfs interface
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <asm/core_reg.h>
+#include <asm/core-sysfs.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+/* Control unit registers for AMA */
+static unsigned int cu_ama_regs[] = {
+	TXAMAREG0_REGNUM,
+	TXAMAREG1_REGNUM,
+	TXAMAREG2_REGNUM,
+	TXAMAREG3_REGNUM,
+};
+
+#define CU_AMA_REG(thread, reg)					\
+	(T0UCTREG0 + (TnUCTRX_STRIDE * thread) +		\
+	 (TXUCTREGn_STRIDE * cu_ama_regs[reg]))
+
+/* Memory mapped registers for AMA */
+static unsigned int mmap_ama_regs[] = {
+	T0AMAREG4,
+	T0AMAREG5,
+	T0AMAREG6,
+};
+
+#define MMAP_AMA_REG(thread, reg)				\
+	((TnAMAREGX_STRIDE * thread) + mmap_ama_regs[reg])
+
+enum cu_reg_num {reg0, reg1, reg2, reg3};
+enum mmap_reg_num {reg4, reg5, reg6};
+
+static ssize_t show_cu_amareg(unsigned int thread,
+	enum cu_reg_num reg, char *buf)
+{
+	ssize_t err;
+	u32 val;
+
+	val = readl(CU_AMA_REG(thread, reg));
+	err = sprintf(buf, "%u\n", val);
+
+	return err;
+}
+
+static ssize_t store_cu_amareg(unsigned int thread,
+	enum mmap_reg_num reg, const char *buf, size_t count)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	writel(val, CU_AMA_REG(thread, reg));
+
+	return count;
+}
+
+#define SYSFS_CUREG_SETUP(REG) \
+static ssize_t show_##REG(struct device *dev, \
+			  struct device_attribute *attr, char *buf) \
+{ \
+	return show_cu_amareg(dev->id, REG, buf); \
+} \
+static ssize_t store_##REG(struct device *dev, \
+			   struct device_attribute *attr, const char *buf, \
+			   size_t count) \
+{ \
+	return store_cu_amareg(dev->id, REG, buf, count); \
+}
+
+static ssize_t show_mmap_amareg(unsigned int thread,
+	enum mmap_reg_num reg, char *buf)
+{
+	ssize_t err;
+	u32 val;
+
+	val = readl(MMAP_AMA_REG(thread, reg));
+	err = sprintf(buf, "%u\n", val);
+
+	return err;
+}
+
+static ssize_t store_mmap_amareg(unsigned int thread,
+				 enum mmap_reg_num reg, const char *buf,
+				 size_t count)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	writel(val, MMAP_AMA_REG(thread, reg));
+
+	return count;
+}
+
+#define SYSFS_MMAPREG_SETUP(REG) \
+static ssize_t show_##REG(struct device *dev, \
+			  struct device_attribute *attr, char *buf) \
+{ \
+	return show_mmap_amareg(dev->id, REG, buf); \
+} \
+static ssize_t store_##REG(struct device *dev, \
+			   struct device_attribute *attr, \
+			   const char *buf, size_t count) \
+{ \
+	return store_mmap_amareg(dev->id, REG, buf, count); \
+}
+
+SYSFS_CUREG_SETUP(reg0);
+SYSFS_CUREG_SETUP(reg1);
+SYSFS_CUREG_SETUP(reg2);
+SYSFS_CUREG_SETUP(reg3);
+
+SYSFS_MMAPREG_SETUP(reg4);
+SYSFS_MMAPREG_SETUP(reg5);
+SYSFS_MMAPREG_SETUP(reg6);
+
+static struct device_attribute cu_ama_attrs[] = {
+	__ATTR(amareg0, 0644, show_reg0, store_reg0),
+	__ATTR(amareg1, 0644, show_reg1, store_reg1),
+	__ATTR(amareg2, 0644, show_reg2, store_reg2),
+	__ATTR(amareg3, 0644, show_reg3, store_reg3),
+};
+
+static struct device_attribute mmap_ama_attrs[] = {
+	__ATTR(amareg4, 0644, show_reg4, store_reg4),
+	__ATTR(amareg5, 0644, show_reg5, store_reg5),
+	__ATTR(amareg6, 0644, show_reg6, store_reg6),
+};
+
+static struct device device_ama = {
+	.bus = &performance_subsys,
+	.init_name = "ama",
+};
+
+static struct device device_ama_threads[4] = {
+	{
+		.id = 0,
+		.bus = &performance_subsys,
+		.parent = &device_ama,
+		.init_name = "thread0",
+	},
+	{
+		.id = 1,
+		.bus = &performance_subsys,
+		.parent = &device_ama,
+		.init_name = "thread1",
+	},
+	{
+		.id = 2,
+		.bus = &performance_subsys,
+		.parent = &device_ama,
+		.init_name = "thread2",
+	},
+	{
+		.id = 3,
+		.bus = &performance_subsys,
+		.parent = &device_ama,
+		.init_name = "thread3",
+	},
+};
+
+static int __init meta_amacount_init(void)
+{
+	int i, thread, exists, ret;
+
+	if (!performance_subsys.name)
+		return -EINVAL;
+
+	ret = device_register(&device_ama);
+	if (ret)
+		return ret;
+
+	for (thread = 0; thread < 4; thread++) {
+		exists = core_reg_read(TXUCT_ID, TXENABLE_REGNUM, thread);
+		if (!exists)
+			break;
+
+		ret = device_register(&device_ama_threads[thread]);
+		if (ret)
+			return ret;
+
+		for (i = 0; i < ARRAY_SIZE(cu_ama_attrs); i++) {
+			ret = device_create_file(&device_ama_threads[thread],
+						 &cu_ama_attrs[i]);
+			if (ret)
+				return ret;
+		}
+		for (i = 0; i < ARRAY_SIZE(mmap_ama_attrs); i++) {
+			ret = device_create_file(&device_ama_threads[thread],
+						 &mmap_ama_attrs[i]);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+device_initcall(meta_amacount_init);
diff --git a/arch/metag/kernel/cpu/counters/cyclecount.c b/arch/metag/kernel/cpu/counters/cyclecount.c
new file mode 100644
index 0000000..3ac8b28
--- /dev/null
+++ b/arch/metag/kernel/cpu/counters/cyclecount.c
@@ -0,0 +1,135 @@
+/*
+ * linux/arch/metag/drivers/cyclecount.c
+ *
+ * Meta core cycle counter sysfs interface
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/*
+ * Make sure we include these first with the TXUXXRX values available,
+ * or else we cannot get hold of them later on after somebody else has
+ * included them from the arch headers.
+ */
+
+#include <asm/core_reg.h>
+#include <asm/core-sysfs.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+#define IDLE_COUNTER()	(T0UCTREG0 + TXUCTREGn_STRIDE * TXIDLECYC_REGNUM)
+
+#define CYCLE_COUNTER(thread)					\
+	(T0UCTREG0 + (TnUCTRX_STRIDE * thread) +		\
+	 (TXUCTREGn_STRIDE * TXTACTCYC_REGNUM))
+
+enum thread_id {
+	thread0,
+	thread1,
+	thread2,
+	thread3,
+	idle
+};
+
+static ssize_t show_cycles(enum thread_id thread, char *buf)
+{
+	int err = -EINVAL;
+	unsigned int cycles;
+
+	switch (thread) {
+	case thread0:
+	case thread1:
+	case thread2:
+	case thread3:
+		cycles = readl(CYCLE_COUNTER(thread));
+		writel(0, CYCLE_COUNTER(thread));
+		err = sprintf(buf, "%u\n", cycles);
+		break;
+	case idle:
+		cycles = readl(IDLE_COUNTER());
+		writel(0, IDLE_COUNTER());
+		err = sprintf(buf, "%u\n", cycles);
+	}
+
+	return err;
+}
+
+#define SYSFS_CYCLE_SETUP(NAME) \
+static ssize_t show_##NAME(struct device *dev,  \
+			   struct device_attribute *attr, char *buf) \
+{ \
+	return show_cycles(NAME, buf); \
+}
+
+SYSFS_CYCLE_SETUP(thread0);
+SYSFS_CYCLE_SETUP(thread1);
+SYSFS_CYCLE_SETUP(thread2);
+SYSFS_CYCLE_SETUP(thread3);
+SYSFS_CYCLE_SETUP(idle);
+
+static struct device_attribute thread_attrs[] = {
+	__ATTR(thread0, 0444, show_thread0, NULL),
+	__ATTR(thread1, 0444, show_thread1, NULL),
+	__ATTR(thread2, 0444, show_thread2, NULL),
+	__ATTR(thread3, 0444, show_thread3, NULL),
+};
+
+static DEVICE_ATTR(idle, 0444, show_idle, NULL);
+
+static struct device device_perf_cycles = {
+	.bus = &performance_subsys,
+	.init_name = "cycles",
+};
+
+static int __init meta_cyclecount_init(void)
+{
+	int i, exists, ret;
+
+	if (!performance_subsys.name)
+		return -EINVAL;
+
+	ret = device_register(&device_perf_cycles);
+	if (ret)
+		return ret;
+
+
+	/* We always have an idle counter */
+	ret = device_create_file(&device_perf_cycles, &dev_attr_idle);
+	if (ret)
+		return ret;
+
+	/* Check for up to four threads */
+	for (i = 0; i < ARRAY_SIZE(thread_attrs); i++) {
+		exists = core_reg_read(TXUCT_ID, TXENABLE_REGNUM, i);
+		if (exists) {
+			ret = device_create_file(&device_perf_cycles,
+						 &thread_attrs[i]);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+device_initcall(meta_cyclecount_init);
diff --git a/arch/metag/kernel/cpu/counters/perfcount.c b/arch/metag/kernel/cpu/counters/perfcount.c
new file mode 100644
index 0000000..0c982d1
--- /dev/null
+++ b/arch/metag/kernel/cpu/counters/perfcount.c
@@ -0,0 +1,154 @@
+/*
+ * linux/arch/metag/drivers/perfcount.c
+ *
+ * Meta core performance counter sysfs interface
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <asm/core-sysfs.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+#define METAC_PERF_VALUES
+#include <asm/tbx/machine.inc>
+
+static int counter_map[] = {
+	PERF_COUNT0,
+	PERF_COUNT1
+};
+
+static ssize_t show_counter(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	u32 perf, val;
+
+	val = readl(counter_map[dev->id]);
+	perf = val & PERF_COUNT_BITS;
+	writel(val & ~PERF_COUNT_BITS, counter_map[dev->id]);
+
+	return sprintf(buf, "%u\n", perf);
+}
+
+static ssize_t show_mask(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	u32 mask;
+
+	mask = readl(counter_map[dev->id]) & PERF_THREAD_BITS;
+	return sprintf(buf, "%u\n", mask);
+}
+
+static ssize_t store_mask(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	unsigned long val;
+	u32 read_val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	read_val = readl(counter_map[dev->id]) & ~PERF_THREAD_BITS;
+	val <<= PERF_THREAD_S;
+	writel(read_val | val, counter_map[dev->id]);
+
+	return count;
+}
+
+static ssize_t show_ctrl(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	u32 ctrl;
+
+	ctrl = readl(counter_map[dev->id]) & PERF_CTRL_BITS;
+	return sprintf(buf, "%u\n", ctrl);
+}
+
+static ssize_t store_ctrl(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	unsigned long val;
+	u32 read_val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	read_val = readl(counter_map[dev->id]) & ~PERF_CTRL_BITS;
+	val <<= PERF_CTRL_S;
+	writel(read_val | val, counter_map[dev->id]);
+
+	return count;
+}
+
+static struct device_attribute perf_attrs[] = {
+	__ATTR(counter,	0644, show_counter, NULL),
+	__ATTR(mask,	0644, show_mask, store_mask),
+	__ATTR(ctrl,	0644, show_ctrl, store_ctrl),
+};
+
+static struct device device_perfcount = {
+	.bus = &performance_subsys,
+	.init_name = "perfcount",
+};
+
+static struct device device_perf_counters[] = {
+	{
+		.id = 0,
+		.parent = &device_perfcount,
+		.bus = &performance_subsys,
+	},
+	{
+		.id = 1,
+		.parent = &device_perfcount,
+		.bus = &performance_subsys,
+	},
+};
+
+static int __init meta_perfcount_init(void)
+{
+	int i, j, ret;
+
+	if (!performance_subsys.name)
+		return -EINVAL;
+
+	ret = device_register(&device_perfcount);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(device_perf_counters); ++i) {
+		ret = device_register(&device_perf_counters[i]);
+		if (ret)
+			return ret;
+
+		for (j = 0; j < ARRAY_SIZE(perf_attrs); ++j) {
+			ret = device_create_file(&device_perf_counters[i],
+						 &perf_attrs[j]);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+device_initcall(meta_perfcount_init);
diff --git a/arch/metag/kernel/cpu/l2cache-control.c b/arch/metag/kernel/cpu/l2cache-control.c
new file mode 100644
index 0000000..5d17dbe
--- /dev/null
+++ b/arch/metag/kernel/cpu/l2cache-control.c
@@ -0,0 +1,289 @@
+/*
+ * l2cache-control.c
+ *
+ * Meta Level 2 cache sysfs interface
+ *
+ * Copyright (C) 2011-2012 Imagination Technologies Ltd.
+ * Written by James Hogan <james.hogan@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <asm/core-sysfs.h>
+#include <asm/l2cache.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+static ssize_t show_l2c_enabled(struct device *sysdev,
+				struct device_attribute *attr, char *buf)
+{
+	ssize_t err;
+	int val;
+
+	val = !!meta_l2c_is_enabled();
+	err = sprintf(buf, "%d\n", val);
+	return err;
+}
+
+static ssize_t store_l2c_enabled(struct device *sysdev,
+				 struct device_attribute *attr, const char *buf,
+				 size_t count)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	if (val) {
+		pr_info("L2 Cache: Enabling... ");
+		if (meta_l2c_enable())
+			pr_cont("already enabled\n");
+		else
+			pr_cont("done\n");
+	} else {
+		pr_info("L2 Cache: Disabling... ");
+		if (meta_l2c_disable())
+			pr_cont("already disabled\n");
+		else
+			pr_cont("done\n");
+	}
+
+	return count;
+}
+
+static ssize_t show_l2c_prefetch(struct device *sysdev,
+				 struct device_attribute *attr, char *buf)
+{
+	ssize_t err;
+	int val;
+
+	val = !!meta_l2c_pf_is_enabled();
+	err = sprintf(buf, "%d\n", val);
+	return err;
+}
+
+static ssize_t store_l2c_prefetch(struct device *sysdev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	if (val) {
+		pr_info("L2 Cache: Enabling prefetch... ");
+		if (meta_l2c_pf_enable(1))
+			pr_cont("already enabled\n");
+		else
+			pr_cont("done\n");
+	} else {
+		pr_info("L2 Cache: Disabling prefetch... ");
+		if (!meta_l2c_pf_enable(0))
+			pr_cont("already disabled\n");
+		else
+			pr_cont("done\n");
+	}
+
+	return count;
+}
+
+static ssize_t show_l2c_writeback(struct device *sysdev,
+				  struct device_attribute *attr, char *buf)
+{
+	ssize_t err;
+
+	/* when read, we return whether the L2 is a writeback cache */
+	err = sprintf(buf, "%d\n", !!meta_l2c_is_writeback());
+	return err;
+}
+
+static ssize_t store_l2c_writeback(struct device *sysdev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	if (val)
+		meta_l2c_writeback();
+
+	return count;
+}
+
+static ssize_t show_l2c_flush(struct device *sysdev,
+			      struct device_attribute *attr, char *buf)
+{
+	ssize_t err;
+
+	err = sprintf(buf, "%d\n", 0);
+	return err;
+}
+
+static ssize_t store_l2c_flush(struct device *sysdev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	if (val)
+		meta_l2c_flush();
+
+	return count;
+}
+
+static ssize_t type_show(struct device *sysdev, struct device_attribute *attr,
+			    char *buf)
+{
+	ssize_t err;
+	const char *type;
+
+	if (meta_l2c_is_unified()) {
+		type = "Unified";
+	} else {
+		/*
+		 * Should be "Instruction" or "Data" really, but we're
+		 * representing the L2 cache as a whole.
+		 */
+		type = "Separate";
+	}
+	err = sprintf(buf, "%s\n", type);
+	return err;
+}
+
+static ssize_t level_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	ssize_t err;
+
+	err = sprintf(buf, "%d\n", 2);
+	return err;
+}
+
+static ssize_t size_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	ssize_t err;
+
+	err = sprintf(buf, "%uK\n", meta_l2c_size() >> 10);
+	return err;
+}
+
+static ssize_t coherency_line_size_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	ssize_t err;
+
+	err = sprintf(buf, "%u\n", meta_l2c_linesize());
+	return err;
+}
+
+static ssize_t number_of_sets_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	ssize_t err;
+	unsigned int sets;
+
+	sets = meta_l2c_size() / (meta_l2c_ways() * meta_l2c_linesize());
+	err = sprintf(buf, "%u\n", sets);
+	return err;
+}
+
+static ssize_t ways_of_associativity_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	ssize_t err;
+
+	err = sprintf(buf, "%u\n", meta_l2c_ways());
+	return err;
+}
+
+static ssize_t revision_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	ssize_t err;
+
+	err = sprintf(buf, "%u\n", meta_l2c_revision());
+	return err;
+}
+
+static ssize_t config_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	ssize_t err;
+
+	err = sprintf(buf, "0x%08x\n", meta_l2c_config());
+	return err;
+}
+
+static struct device_attribute l2c_attrs[] = {
+	/*
+	 * These are fairly standard attributes, used by other architectures in
+	 * /sys/devices/system/cpu/cpuX/cache/indexX/ (but on Meta they're
+	 * elsewhere).
+	 */
+	__ATTR_RO(type),
+	__ATTR_RO(level),
+	__ATTR_RO(size),
+	__ATTR_RO(coherency_line_size),
+	__ATTR_RO(number_of_sets),
+	__ATTR_RO(ways_of_associativity),
+
+	/*
+	 * Other read only attributes, specific to Meta.
+	 */
+	__ATTR_RO(revision),
+	__ATTR_RO(config),
+
+	/*
+	 * These can be used to perform operations on the cache, such as
+	 * enabling the cache and prefetch, and triggering a full writeback or
+	 * flush.
+	 */
+	__ATTR(enabled,   0644, show_l2c_enabled, store_l2c_enabled),
+	__ATTR(prefetch,  0644, show_l2c_prefetch, store_l2c_prefetch),
+	__ATTR(writeback, 0644, show_l2c_writeback, store_l2c_writeback),
+	__ATTR(flush,     0644, show_l2c_flush, store_l2c_flush),
+};
+
+static struct device device_cache_l2 = {
+	.bus = &cache_subsys,
+	.init_name = "l2",
+};
+
+static int __init meta_l2c_sysfs_init(void)
+{
+	int i, ret;
+
+	if (!cache_subsys.name)
+		return -EINVAL;
+
+	/* if there's no L2 cache, don't add the sysfs nodes */
+	if (!meta_l2c_is_present())
+		return 0;
+
+	ret = device_register(&device_cache_l2);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(l2c_attrs); i++) {
+		ret = device_create_file(&device_cache_l2,
+					 &l2c_attrs[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+device_initcall(meta_l2c_sysfs_init);
diff --git a/arch/metag/kernel/cpu/memory-arbiter.c b/arch/metag/kernel/cpu/memory-arbiter.c
new file mode 100644
index 0000000..85bda71
--- /dev/null
+++ b/arch/metag/kernel/cpu/memory-arbiter.c
@@ -0,0 +1,133 @@
+/*
+ * linux/arch/metag/drivers/write_combiner.c
+ *
+ * Meta memory arbiter sysfs interface
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/*
+ * Make sure we include these first with the TXUXXRX values available,
+ * or else we cannot get hold of them later on after somebody else has
+ * included them from the arch headers.
+ */
+
+#include <asm/core_reg.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+#define MEMARBITER_REG(thread)						\
+	(EXPAND_T0ARBITER + (EXPAND_TnARBITER_STRIDE * thread))
+
+enum thread_id {
+	thread0,
+	thread1,
+	thread2,
+	thread3
+};
+
+static ssize_t show_memarbiter(enum thread_id thread, char *buf)
+{
+	ssize_t err;
+	u32 val;
+
+	val = readl(MEMARBITER_REG(thread));
+	err = sprintf(buf, "%u\n", val);
+	return err;
+}
+
+static void store_memarbiter(enum thread_id thread, const char *buf)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return;
+
+	writel(val, MEMARBITER_REG(thread));
+}
+
+#define SYSFS_MEMARBITER_SETUP(NAME) \
+static ssize_t show_##NAME##_ma(struct device *dev,  \
+				struct device_attribute *attr, char *buf) \
+{ \
+	return show_memarbiter(NAME, buf); \
+} \
+static ssize_t store_##NAME##_ma(struct device *dev, \
+				struct device_attribute *attr, \
+				const char *buf, size_t count) \
+{ \
+	store_memarbiter(NAME, buf); \
+	return count; \
+}
+
+SYSFS_MEMARBITER_SETUP(thread0);
+SYSFS_MEMARBITER_SETUP(thread1);
+SYSFS_MEMARBITER_SETUP(thread2);
+SYSFS_MEMARBITER_SETUP(thread3);
+
+static DEVICE_ATTR(thread0, 0644, show_thread0_ma, store_thread0_ma);
+static DEVICE_ATTR(thread1, 0644, show_thread1_ma, store_thread1_ma);
+static DEVICE_ATTR(thread2, 0644, show_thread2_ma, store_thread2_ma);
+static DEVICE_ATTR(thread3, 0644, show_thread3_ma, store_thread3_ma);
+
+static struct attribute *memory_arbiter_root_attrs[] = {
+	&dev_attr_thread0.attr,
+	&dev_attr_thread1.attr,
+	&dev_attr_thread2.attr,
+	&dev_attr_thread3.attr,
+	NULL,
+};
+
+static struct attribute_group memory_arbiter_root_attr_group = {
+	.attrs = memory_arbiter_root_attrs,
+};
+
+static const struct attribute_group *memory_arbiter_root_attr_groups[] = {
+	&memory_arbiter_root_attr_group,
+	NULL,
+};
+
+struct bus_type memory_arbiter_subsys = {
+	.name = "memory_arbiter",
+	.dev_name = "ma",
+};
+
+static int __init meta_memarbiter_init(void)
+{
+	int i, exists, ret;
+
+	/* modify number of threads displayed */
+	for (i = 0; i < ARRAY_SIZE(memory_arbiter_root_attrs); i++) {
+		exists = core_reg_read(TXUCT_ID, TXENABLE_REGNUM, i);
+		if (!exists) {
+			memory_arbiter_root_attrs[i] = NULL;
+			break;
+		}
+	}
+
+	ret = subsys_system_register(&memory_arbiter_subsys,
+				     memory_arbiter_root_attr_groups);
+	return ret;
+}
+device_initcall(meta_memarbiter_init);
diff --git a/arch/metag/kernel/cpu/write-combiner.c b/arch/metag/kernel/cpu/write-combiner.c
new file mode 100644
index 0000000..fe9fb35
--- /dev/null
+++ b/arch/metag/kernel/cpu/write-combiner.c
@@ -0,0 +1,215 @@
+/*
+ * linux/arch/metag/drivers/write_combiner.c
+ *
+ * Meta write combiner sysfs interface
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/*
+ * Make sure we include these first with the TXUXXRX values available,
+ * or else we cannot get hold of them later on after somebody else has
+ * included them from the arch headers.
+ */
+
+#include <asm/core_reg.h>
+#include <asm/core-sysfs.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+#define WRCOMBINER_REG(thread)						\
+	(EXPAND_T0WRCOMBINE + (EXPAND_TnWRCOMBINE_STRIDE * thread))
+
+enum thread_id {
+	thread0,
+	thread1,
+	thread2,
+	thread3
+};
+
+static ssize_t show_wrcombiner(enum thread_id thread, char *buf)
+{
+	ssize_t err;
+	u32 val;
+
+	val = readl(WRCOMBINER_REG(thread));
+	err = sprintf(buf, "%u\n", val);
+	return err;
+}
+
+static ssize_t store_wrcombiner(enum thread_id thread, const char *buf,
+				size_t count)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	writel(val, WRCOMBINER_REG(thread));
+
+	return count;
+}
+
+#define SYSFS_WRCOMBINER_SETUP(NAME) \
+static ssize_t show_##NAME##_wc(struct device *dev,  \
+				struct device_attribute *attr, char *buf) \
+{ \
+	return show_wrcombiner(NAME, buf); \
+} \
+static ssize_t store_##NAME##_wc(struct device *dev, \
+				 struct device_attribute *attr, \
+				 const char *buf, size_t count) \
+{ \
+	return store_wrcombiner(NAME, buf, count); \
+}
+
+static ssize_t show_perfchan0(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	ssize_t err;
+	u32 val;
+
+	val = readl(EXPAND_PERFCHAN0);
+	err = sprintf(buf, "%u\n", val);
+	return err;
+}
+
+static ssize_t store_perfchan0(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	u32 read_val;
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	read_val = readl(EXPAND_PERFCHAN0) & ~EXPPERF_CTRL_BITS;
+	writel(read_val | val, EXPAND_PERFCHAN0);
+	return count;
+}
+
+static ssize_t show_perfchan1(struct device *sysdev,
+			      struct device_attribute *attr, char *buf)
+{
+	ssize_t err;
+	u32 val;
+
+	val = readl(EXPAND_PERFCHAN1);
+	err = sprintf(buf, "%u\n", val);
+	return err;
+}
+
+static ssize_t store_perfchan1(struct device *sysdev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	u32 read_val;
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	read_val = readl(EXPAND_PERFCHAN1) & ~EXPPERF_CTRL_BITS;
+	writel(read_val | val, EXPAND_PERFCHAN1);
+	return count;
+}
+
+SYSFS_WRCOMBINER_SETUP(thread0);
+SYSFS_WRCOMBINER_SETUP(thread1);
+SYSFS_WRCOMBINER_SETUP(thread2);
+SYSFS_WRCOMBINER_SETUP(thread3);
+
+static DEVICE_ATTR(thread0, 0644, show_thread0_wc, store_thread0_wc);
+static DEVICE_ATTR(thread1, 0644, show_thread1_wc, store_thread1_wc);
+static DEVICE_ATTR(thread2, 0644, show_thread2_wc, store_thread2_wc);
+static DEVICE_ATTR(thread3, 0644, show_thread3_wc, store_thread3_wc);
+
+static struct attribute *write_combiner_root_attrs[] = {
+	&dev_attr_thread0.attr,
+	&dev_attr_thread1.attr,
+	&dev_attr_thread2.attr,
+	&dev_attr_thread3.attr,
+	NULL,
+};
+
+static struct attribute_group write_combiner_root_attr_group = {
+	.attrs = write_combiner_root_attrs,
+};
+
+static const struct attribute_group *write_combiner_root_attr_groups[] = {
+	&write_combiner_root_attr_group,
+	NULL,
+};
+
+static struct device_attribute perfchan_attrs[] = {
+	__ATTR(perfchan0, 0644, show_perfchan0, store_perfchan0),
+	__ATTR(perfchan1, 0644, show_perfchan1, store_perfchan1),
+};
+
+struct bus_type write_combiner_subsys = {
+	.name = "write_combiner",
+	.dev_name = "wc",
+};
+
+static struct device device_perf_write_combiner = {
+	.bus = &performance_subsys,
+	.init_name = "write_combiner",
+};
+
+static int __init meta_writecombiner_init(void)
+{
+	int i, exists, ret;
+
+	/* modify number of threads displayed */
+	for (i = 0; i < ARRAY_SIZE(write_combiner_root_attrs); i++) {
+		exists = core_reg_read(TXUCT_ID, TXENABLE_REGNUM, i);
+		if (!exists) {
+			write_combiner_root_attrs[i] = NULL;
+			break;
+		}
+	}
+
+	ret = subsys_system_register(&write_combiner_subsys,
+				     write_combiner_root_attr_groups);
+	if (ret)
+		return ret;
+
+	if (!performance_subsys.name)
+		return -EINVAL;
+
+	ret = device_register(&device_perf_write_combiner);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(perfchan_attrs); i++) {
+		ret = device_create_file(&device_perf_write_combiner,
+					 &perfchan_attrs[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+device_initcall(meta_writecombiner_init);
-- 
1.7.7.6
