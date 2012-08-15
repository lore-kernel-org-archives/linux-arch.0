From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 21/31] arm64: 32-bit (compat) applications support
Date: Wed, 15 Aug 2012 14:34:04 +0000
Message-ID: <201208151434.05145.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-22-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:50142 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833Ab2HOOeN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2012 10:34:13 -0400
In-Reply-To: <1344966752-16102-22-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Tuesday 14 August 2012, Catalin Marinas wrote:

> +#ifdef CONFIG_AARCH32_EMULATION
> +#include <linux/compat.h>
> +
> +#define AARCH32_KERN_SIGRET_CODE_OFFSET	0x500
> +
> +extern const compat_ulong_t aarch32_sigret_code[6];
> +
> +int compat_setup_frame(int usig, struct k_sigaction *ka, sigset_t *set,
> +		       struct pt_regs *regs);
> +int compat_setup_rt_frame(int usig, struct k_sigaction *ka, siginfo_t *info,
> +			  sigset_t *set, struct pt_regs *regs);
> +
> +void compat_setup_restart_syscall(struct pt_regs *regs);
> +#else
> +
> +static inline int compat_setup_frame(int usid, struct k_sigaction *ka,
> +				     sigset_t *set, struct pt_regs *regs)
> +{
> +	BUG();
> +}

What good is the run-time BUG() here? Nothing should be calling these
when CONFIG_COMPAT is disabled, so I think you should just remove
the #ifdef around the declarations, and the entire #else case.


> +asmlinkage int compat_sys_sched_rr_get_interval(compat_pid_t pid,
> +						struct compat_timespec __user *interval)
> +{
> +	struct timespec t;
> +	int ret;
> +	mm_segment_t old_fs = get_fs();
> +
> +	set_fs(KERNEL_DS);
> +	ret = sys_sched_rr_get_interval(pid, (struct timespec __user *)&t);
> +	set_fs(old_fs);
> +	if (put_compat_timespec(&t, interval))
> +		return -EFAULT;
> +	return ret;
> +}
> +
> +asmlinkage int compat_sys_sendfile(int out_fd, int in_fd,
> +				   compat_off_t __user *offset, s32 count)
> +{
> +	mm_segment_t old_fs = get_fs();
> +	int ret;
> +	off_t of;
> +
> +	if (offset && get_user(of, offset))
> +		return -EFAULT;
> +
> +	set_fs(KERNEL_DS);
> +	ret = sys_sendfile(out_fd, in_fd, offset ? (off_t __user *)&of : NULL,
> +			   count);
> +	set_fs(old_fs);
> +
> +	if (offset && put_user(of, offset))
> +		return -EFAULT;
> +	return ret;
> +}

I guess it's time to move these two into common code. They look like they should
be shared across most architectures that have compat support.

> +asmlinkage int compat_sys_personality(compat_ulong_t personality)
> +{
> +	int ret;
> +
> +	if (personality(current->personality) == PER_LINUX32 &&
> +		personality == PER_LINUX)
> +		personality = PER_LINUX32;
> +	ret = sys_personality(personality);
> +	if (ret == PER_LINUX32)
> +		ret = PER_LINUX;
> +	return ret;
> +}

Where did you get this from?

You should not need compat_sys_personality, just call the native function.

	Arnd
