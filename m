From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 08/24] C6X: process management
Date: Tue, 9 Aug 2011 18:31:40 +0200
Message-ID: <201108091831.40862.arnd@arndb.de>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com> <1312839879-13592-9-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64579 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595Ab1HIQbp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2011 12:31:45 -0400
In-Reply-To: <1312839879-13592-9-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Monday 08 August 2011, Mark Salter wrote:

> +static void halt_loop(void)
> +{
> +	printk(KERN_EMERG "System Halted, OK to turn off power\n");
> +	local_irq_disable();
> +	while (1)
> +		;
> +}

How about calling default_idle in the loop? There is no reason to burn
CPU cycles when the machine is stopped.

> +/*
> + * vfork syscall is deprecated but uClibc tests for _NR_vfork as a check
> + * for __libc_vfork() existence. So we provide the syscall even though
> + * __libc_vfork() actually uses the clone syscall.
> + */
> +asmlinkage int c6x_vfork(struct pt_regs *regs)
> +{
> +	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs->sp, regs,
> +		       0, NULL, NULL);
> +}
> +
> +asmlinkage int c6x_clone(struct pt_regs *regs)
> +{
> +	unsigned long clone_flags;
> +	unsigned long newsp;
> +
> +	/* syscall puts clone_flags in A4 and usp in B4 */
> +	clone_flags = regs->orig_a4;
> +	if (regs->b4)
> +		newsp = regs->b4;
> +	else
> +		newsp = regs->sp;
> +
> +	return do_fork(clone_flags, newsp, regs, 0, (int __user *)regs->a6,
> +		       (int __user *)regs->b6);
> +}

> +/*
> + * c6x_execve() executes a new program.
> + */
> +asmlinkage long c6x_execve(const char __user *name,
> +			   const char __user *const __user *argv,
> +			   const char __user *const __user *envp,
> +			   struct pt_regs *regs)
> +{
> +	int error;
> +	char *filename;
> +
> +	filename = getname(name);
> +	error = PTR_ERR(filename);
> +	if (IS_ERR(filename))
> +		goto out;
> +
> +	error = do_execve(filename, argv, envp, regs);
> +	putname(filename);
> +out:
> +	return error;
> +}

better use SYSCALL_DEFINE1/4 to make these an actual syscalls that can be
grepped for. In a lot of cases, the SYSCALL_DEFINE* is actually required
for security reasons, although these specific cases don't seem to need it.

	Arnd
