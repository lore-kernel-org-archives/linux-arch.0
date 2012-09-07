From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 17/31] arm64: System calls handling
Date: Fri, 7 Sep 2012 19:43:36 +0000
Message-ID: <201209071943.37184.arnd@arndb.de>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com> <1347035226-18649-18-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:50723 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024Ab2IGTnr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 15:43:47 -0400
In-Reply-To: <1347035226-18649-18-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Friday 07 September 2012, Catalin Marinas wrote:
> +/*
> + * sys_execve() executes a new program.
> + */
> +asmlinkage long sys_execve(const char __user *filenamei,
> +                          const char __user *const __user *argv,
> +                          const char __user *const __user *envp,
> +                          struct pt_regs *regs)
> +{
> +       long error;
> +       char * filename;
> +
> +       filename = getname(filenamei);
> +       error = PTR_ERR(filename);
> +       if (IS_ERR(filename))
> +               goto out;
> +       error = do_execve(filename, argv, envp, regs);
> +       putname(filename);
> +out:
> +       return error;
> +}
> +
> +int kernel_execve(const char *filename,
> +                 const char *const argv[],
> +                 const char *const envp[])
> +{
> +       struct pt_regs regs;
> +       int ret;
> +
> +       memset(&regs, 0, sizeof(struct pt_regs));
> +       ret = do_execve(filename,
> +                       (const char __user *const __user *)argv,
> +                       (const char __user *const __user *)envp, &regs);
> +       if (ret < 0)
> +               goto out;
> +
> +       /*
> +        * Save argc to the register structure for userspace.
> +        */
> +       regs.regs[0] = ret;
> +
> +       /*
> +        * We were successful.  We won't be returning to our caller, but
> +        * instead to user space by manipulating the kernel stack.
> +        */
> +       asm(    "add    x0, %0, %1\n\t"
> +               "mov    x1, %2\n\t"
> +               "mov    x2, %3\n\t"
> +               "bl     memmove\n\t"    /* copy regs to top of stack */
> +               "mov    x27, #0\n\t"    /* not a syscall */
> +               "mov    x28, %0\n\t"    /* thread structure */
> +               "mov    sp, x0\n\t"     /* reposition stack pointer */
> +               "b      ret_to_user"
> +               :
> +               : "r" (current_thread_info()),
> +                 "Ir" (THREAD_START_SP - sizeof(regs)),
> +                 "r" (&regs),
> +                 "Ir" (sizeof(regs))
> +               : "x0", "x1", "x2", "x27", "x28", "x30", "memory");
> +
> + out:
> +       return ret;
> +}

Al Viro is currently reworking this code across all architectures, please have a look
at https://git.kernel.org/?p=linux/kernel/git/viro/signal.git;a=shortlog;h=refs/heads/execve2

> +EXPORT_SYMBOL(kernel_execve);

You certainly don't need to export it.

	Arnd
