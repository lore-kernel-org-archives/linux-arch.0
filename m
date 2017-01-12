From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 09/10] arm64/sve: Enable default vector length control via procfs
Date: Thu, 12 Jan 2017 11:26:08 +0000
Message-ID: <1484220369-23970-10-git-send-email-Dave.Martin@arm.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751504AbdALL14 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Jan 2017 06:27:56 -0500
In-Reply-To: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Alan Hayward <alan.hayward@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Florian Weimer <fweimer@redhat.com>, Joseph Myers <joseph@codesourcery.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Torvald Riegel <triegel@redhat.com>, gdb@sourceware.org, Yao Qi <qiyaoltc@gmail.com>

This patch makes the default SVE vector length at exec() for user tasks
controllable via procfs, in /proc/cpu/sve_default_vector_length.

Limited effort is made to return sensible errors when writing the
procfs file, and anyway the value gets silently clamped to the
maximum VL supported by the platform: users should close and reopen
the file and read back to see the result.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---

Caveats:

 * /proc may not be the correct place for this (but it's not clear
   where in sysfs it should go either, and it's a global control with
   no corresponding kobject)

 * There seems to be no suitable framework for writable controls of
   this sort in /proc (unlike debugfs or sysfs).  So, I had to write a
   suspiciously large amount of code -- I may have missed an obvious
   trick :P


 arch/arm64/kernel/fpsimd.c | 160 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 158 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index f010a1c..3c0e08c 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -22,8 +22,12 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/prctl.h>
+#include <linux/proc_fs.h>
 #include <linux/sched.h>
+#include <linux/seq_file.h>
 #include <linux/signal.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
 #include <linux/hardirq.h>
 
 #include <asm/fpsimd.h>
@@ -102,9 +106,132 @@ void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
 
 /* Maximum supported vector length across all CPUs (initially poisoned) */
 int sve_max_vl = -1;
+/* Default VL for tasks that don't set it explicitly: */
+int sve_default_vl = -1;
 
 #ifdef CONFIG_ARM64_SVE
 
+#ifdef CONFIG_PROC_FS
+
+struct default_vl_write_state {
+	bool invalid;
+	size_t len;
+	char buf[40];	/* enough for "0x" + 64-bit hex integer + NUL */
+};
+
+static int sve_default_vl_show(struct seq_file *s, void *data)
+{
+	seq_printf(s, "%d\n", sve_default_vl);
+	return 0;
+}
+
+static ssize_t sve_default_vl_write(struct file *f, const char __user *buf,
+				    size_t size, loff_t *pos)
+{
+	struct default_vl_write_state *state =
+		((struct seq_file *)f->private_data)->private;
+	long ret;
+
+	if (!size)
+		return 0;
+
+	if (*pos > sizeof(state->buf) ||
+	    size >= sizeof(state->buf) - *pos) {
+		ret = -ENOSPC;
+		goto error;
+	}
+
+	ret = copy_from_user(state->buf + *pos, buf, size);
+	if (ret > 0)
+		ret = -EINVAL;
+	if (ret)
+		goto error;
+
+	*pos += size;
+	if (*pos > state->len)
+		state->len = *pos;
+
+	return size;
+
+error:
+	state->invalid = true;
+	return ret;
+}
+
+static int sve_default_vl_release(struct inode *i, struct file *f)
+{
+	int ret = 0;
+	int t;
+	unsigned long value;
+	struct default_vl_write_state *state =
+		((struct seq_file *)f->private_data)->private;
+
+	if (!(f->f_mode & FMODE_WRITE))
+		goto out;
+
+	if (state->invalid)
+		goto out;
+
+	if (state->len >= sizeof(state->buf)) {
+		WARN_ON(1);
+		state->len = sizeof(state->buf) - 1;
+	}
+
+	state->buf[state->len] = '\0';
+	t = kstrtoul(state->buf, 0, &value);
+	if (t)
+		ret = t;
+
+	if (!sve_vl_valid(value))
+		ret = -EINVAL;
+
+	if (!sve_vl_valid(sve_max_vl)) {
+		WARN_ON(1);
+		ret = -EINVAL;
+	}
+
+	if (value > sve_max_vl)
+		value = sve_max_vl;
+
+	if (!ret)
+		sve_default_vl = value;
+
+out:
+	t = seq_release_private(i, f);
+	return ret ? ret : t;
+}
+
+static int sve_default_vl_open(struct inode *i, struct file *f)
+{
+	struct default_vl_write_state *data = NULL;
+	int ret;
+
+	if (f->f_mode & FMODE_WRITE) {
+		data = kzalloc(sizeof(*data), GFP_KERNEL);
+		if (!data)
+			return -ENOMEM;
+
+		data->invalid = false;
+		data->len = 0;
+	}
+
+	ret = single_open(f, sve_default_vl_show, data);
+	if (ret)
+		kfree(data);
+
+	return ret;
+}
+
+static const struct file_operations sve_default_vl_fops = {
+	.open		= sve_default_vl_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= sve_default_vl_release,
+	.write		= sve_default_vl_write,
+};
+
+#endif /* !CONFIG_PROC_FS */
+
 static void task_fpsimd_to_sve(struct task_struct *task);
 static void task_fpsimd_load(struct task_struct *task);
 static void task_fpsimd_save(struct task_struct *task);
@@ -299,7 +426,7 @@ void fpsimd_flush_thread(void)
 		    !(current->thread.sve_flags & THREAD_VL_INHERIT)) {
 			BUG_ON(!sve_vl_valid(sve_max_vl));
 
-			current->thread.sve_vl = sve_max_vl;
+			current->thread.sve_vl = sve_default_vl;
 			current->thread.sve_flags = 0;
 		}
 	}
@@ -723,6 +850,14 @@ void __init fpsimd_init_task_struct_size(void)
 	     & 0xf) == 1) {
 		/* FIXME: This should be the minimum across all CPUs */
 		sve_max_vl = sve_get_vl();
+		sve_default_vl = sve_max_vl;
+
+		/*
+		 * To avoid enlarging the signal frame by default, clamp to
+		 * 512 bits until/unless overridden by userspace:
+		 */
+		if (sve_default_vl > 512 / 8)
+			sve_default_vl = 512 / 8;
 
 		arch_task_struct_size = sizeof(struct task_struct) +
 			35 * sve_max_vl;
@@ -734,6 +869,27 @@ void __init fpsimd_init_task_struct_size(void)
 /*
  * FP/SIMD support code initialisation.
  */
+static int __init sve_procfs_init(void)
+{
+#if defined(CONFIG_ARM64_SVE) && defined(CONFIG_PROC_FS)
+	struct proc_dir_entry *dir;
+
+	if (!(elf_hwcap & HWCAP_SVE))
+		return 0;
+
+	/* This should be moved elsewhere is anything else ever uses it: */
+	dir = proc_mkdir("cpu", NULL);
+	if (!dir)
+		return -ENOMEM;
+
+	if (!proc_create("sve_default_vector_length",
+			 S_IRUGO | S_IWUSR, dir, &sve_default_vl_fops))
+		return -ENOMEM;
+#endif
+
+	return 0;
+}
+
 static int __init fpsimd_init(void)
 {
 	if (elf_hwcap & HWCAP_FP) {
@@ -749,6 +905,6 @@ static int __init fpsimd_init(void)
 	if (!(elf_hwcap & HWCAP_SVE))
 		pr_info("Scalable Vector Extension available\n");
 
-	return 0;
+	return sve_procfs_init();
 }
 late_initcall(fpsimd_init);
-- 
2.1.4
