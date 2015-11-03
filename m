From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 13/28] lkl: initialization and cleanup
Date: Tue,  3 Nov 2015 22:20:44 +0200
Message-ID: <1446582059-17355-14-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-arch.vger.kernel.org

Add the lkl_start_kernel and lkl_sys_halt APIs that start and
respectively stops the Linux kernel.

lkl_start_kernel creates a separate threads that will run the initial
and idle kernel thread. It waits for the kernel to complete
initialization before returning, to avoid races with system calls
issues by the host application.

During the setup phase, we create "/init" in initial ramfs root
filesystem to avoid mounting the "real" rootfs since ramfs is good
enough for now.

lkl_stop_kernel will shutdown the kernel, terminate all threads and
free all host resources used by the kernel before returning.

This patch also introduces idle CPU handling since it is closely
related to the shutdown process. A host semaphore is used to wait for
new interrupts when the kernel switches the CPU to idle to avoid
wasting host CPU cycles. When the kernel is shutdown we terminate the
idle thread at the first CPU idle event.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 arch/lkl/include/asm/setup.h |  12 +++
 arch/lkl/kernel/setup.c      | 176 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 188 insertions(+)
 create mode 100644 arch/lkl/include/asm/setup.h
 create mode 100644 arch/lkl/kernel/setup.c

diff --git a/arch/lkl/include/asm/setup.h b/arch/lkl/include/asm/setup.h
new file mode 100644
index 0000000..b82cdbf
--- /dev/null
+++ b/arch/lkl/include/asm/setup.h
@@ -0,0 +1,12 @@
+#ifndef _ASM_LKL_SETUP_H
+#define _ASM_LKL_SETUP_H
+
+#define COMMAND_LINE_SIZE 4096
+
+#ifndef __ASSEMBLY__
+#define ARCH_RUN_INIT_PROCESS
+int run_init_process(const char *init_filename);
+void wakeup_cpu(void);
+#endif
+
+#endif
diff --git a/arch/lkl/kernel/setup.c b/arch/lkl/kernel/setup.c
new file mode 100644
index 0000000..aad2ad7
--- /dev/null
+++ b/arch/lkl/kernel/setup.c
@@ -0,0 +1,176 @@
+#include <linux/init.h>
+#include <linux/init_task.h>
+#include <linux/reboot.h>
+#include <linux/fs.h>
+#include <linux/start_kernel.h>
+#include <linux/syscalls.h>
+#include <asm/host_ops.h>
+#include <asm/irq.h>
+#include <asm/unistd.h>
+
+struct lkl_host_operations *lkl_ops;
+static char cmd_line[COMMAND_LINE_SIZE];
+static void *idle_sem;
+static void *init_sem;
+static void *halt_sem;
+static bool halt;
+void (*pm_power_off)(void) = NULL;
+static unsigned long mem_size;
+
+long lkl_panic_blink(int state)
+{
+	lkl_ops->panic();
+	return 0;
+}
+
+void __init setup_arch(char **cl)
+{
+	*cl = cmd_line;
+	panic_blink = lkl_panic_blink;
+	bootmem_init(mem_size);
+}
+
+int run_init_process(const char *init_filename)
+{
+	lkl_ops->sem_up(init_sem);
+
+	run_syscalls();
+
+	kernel_halt();
+
+	/* We want to kill init without panic()ing */
+	init_pid_ns.child_reaper = 0;
+	do_exit(0);
+
+	return 0;
+}
+
+static void __init lkl_run_kernel(void *arg)
+{
+	start_kernel();
+}
+
+int __init lkl_start_kernel(struct lkl_host_operations *ops,
+			    unsigned long _mem_size,
+			    const char *fmt, ...)
+{
+	va_list ap;
+	int ret;
+
+	lkl_ops = ops;
+	mem_size = _mem_size;
+
+	va_start(ap, fmt);
+	ret = vsnprintf(boot_command_line, COMMAND_LINE_SIZE, fmt, ap);
+	va_end(ap);
+
+	if (ops->virtio_devices)
+		strncpy(boot_command_line + ret, ops->virtio_devices,
+			COMMAND_LINE_SIZE - ret);
+
+	memcpy(cmd_line, boot_command_line, COMMAND_LINE_SIZE);
+
+	ret = threads_init();
+	if (ret)
+		return ret;
+
+	init_sem = lkl_ops->sem_alloc(0);
+	if (!init_sem)
+		return -ENOMEM;
+
+	idle_sem = lkl_ops->sem_alloc(0);
+	if (!idle_sem) {
+		ret = -ENOMEM;
+		goto out_free_init_sem;
+	}
+
+	ret = lkl_ops->thread_create(lkl_run_kernel, NULL);
+	if (ret) {
+		ret = -ENOMEM;
+		goto out_free_idle_sem;
+	}
+
+	lkl_ops->sem_down(init_sem);
+
+	return 0;
+
+out_free_idle_sem:
+	lkl_ops->sem_free(idle_sem);
+
+out_free_init_sem:
+	lkl_ops->sem_free(init_sem);
+
+	return ret;
+}
+
+void machine_halt(void)
+{
+	halt = true;
+}
+
+void machine_power_off(void)
+{
+	machine_halt();
+}
+
+void machine_restart(char *unused)
+{
+	machine_halt();
+}
+
+long lkl_sys_halt(void)
+{
+	long err;
+	long params[6] = { 0, };
+
+	halt_sem = lkl_ops->sem_alloc(0);
+	if (!halt_sem)
+		return -ENOMEM;
+
+	err = lkl_syscall(__NR_reboot, params);
+	if (err < 0) {
+		lkl_ops->sem_free(halt_sem);
+		return err;
+	}
+
+	lkl_ops->sem_down(halt_sem);
+
+	lkl_ops->sem_free(halt_sem);
+	lkl_ops->sem_free(idle_sem);
+	lkl_ops->sem_free(init_sem);
+
+	return 0;
+}
+
+void arch_cpu_idle(void)
+{
+	if (halt) {
+		threads_cleanup();
+		free_IRQ();
+		free_mem();
+		lkl_ops->sem_up(halt_sem);
+		lkl_ops->thread_exit();
+	}
+
+	lkl_ops->sem_down(idle_sem);
+
+	local_irq_enable();
+}
+
+void wakeup_cpu(void)
+{
+	lkl_ops->sem_up(idle_sem);
+}
+
+/* skip mounting the "real" rootfs. ramfs is good enough. */
+static int __init fs_setup(void)
+{
+	int fd;
+
+	fd = sys_open("/init", O_CREAT, 0600);
+	WARN_ON(fd < 0);
+	sys_close(fd);
+
+	return 0;
+}
+late_initcall(fs_setup);
-- 
2.1.0
