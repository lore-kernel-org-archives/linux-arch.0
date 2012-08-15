From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 23/31] arm64: Debugging support
Date: Wed, 15 Aug 2012 15:07:36 +0000
Message-ID: <201208151507.36174.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-24-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:51916 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202Ab2HOPHp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2012 11:07:45 -0400
In-Reply-To: <1344966752-16102-24-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Tuesday 14 August 2012, Catalin Marinas wrote:

> +const struct user_regset_view *task_user_regset_view(struct task_struct *task)
> +{
> +#ifdef CONFIG_AARCH32_EMULATION
> +	if (test_tsk_thread_flag(task, TIF_32BIT))
> +		return &user_aarch32_view;
> +#endif
> +	return &user_aarch64_view;
> +}

Ah, nice. So you support 64 bit debuggers debugging 32 bit processes, right?

From what I can tell, there is no support for 32 bit processes debugging
64 bit ones. Is that something you plan to add in the future, or do you
consider that out of scope? In either case, a comment would be helpful.

> +long arch_ptrace(struct task_struct *child, long request,
> +		 unsigned long addr, unsigned long data)
> +{
> +	int ret;
> +	unsigned long *datap = (unsigned long __user *)data;
> +
> +	switch (request) {
> +		case PTRACE_GET_THREAD_AREA:
> +			ret = put_user(child->thread.tp_value, datap);
> +			break;
> +
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +		case PTRACE_GETHBPREGS:
> +			ret = ptrace_gethbpregs(child, addr, datap);
> +			break;
> +
> +		case PTRACE_SETHBPREGS:
> +			ret = ptrace_sethbpregs(child, addr, datap);
> +			break;
> +#endif
> +
> +		default:
> +			ret = ptrace_request(child, request, addr, data);
> +			break;
> +	}
> +
> +	return ret;
> +}

Is there a reaons why these are not regsets but have their own ptrace
commands? I believe new architectures should generally not add ptrace
commands any more.

	Arnd
