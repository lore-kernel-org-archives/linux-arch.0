Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.89.28.114]:39964 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbaCFIw7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Mar 2014 03:52:59 -0500
Message-ID: <531833F0.8080300@imgtec.com>
Date: Thu, 6 Mar 2014 08:38:08 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/6][RFC] syscall: define syscall_get_arch() for each
 audit-supported arch
References: <cover.1393974970.git.rgb@redhat.com> <cb88576237b1bc4fc7981200c2c23ae05790db0d.1393974970.git.rgb@redhat.com>
In-Reply-To: <cb88576237b1bc4fc7981200c2c23ae05790db0d.1393974970.git.rgb@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Guy Briggs <rgb@redhat.com>, linux-audit@redhat.com, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, sgrubb@redhat.com, oleg@redhat.com, linux-mips@linux-mips.org, user-mode-linux-devel@lists.sourceforge.net, linux-arch@vger.kernel.org
Message-ID: <20140306083808.N8U8blkBtKDc5xDM-f-KsBVcmvFXknC7CtznlHQPtgM@z>

Hi Richard,

On 03/05/2014 09:27 PM, Richard Guy Briggs wrote:
> Each arch that supports audit requires syscall_get_arch() to able to log and
> identify architecture-dependent syscall numbers.  The information is used in at
> least two different subsystems, so standardize it in the same call across all
> arches.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>
> ---
> diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
> index 81c8913..41ecde4 100644
> --- a/arch/mips/include/asm/syscall.h
> +++ b/arch/mips/include/asm/syscall.h
> @@ -103,7 +103,7 @@ extern const unsigned long sysn32_call_table[];
>
>   static inline int __syscall_get_arch(void)
>   {
> -	int arch = EM_MIPS;
> +	int arch = AUDIT_ARCH_MIPS;
>   #ifdef CONFIG_64BIT
>   	arch |=  __AUDIT_ARCH_64BIT;
>   #endif
> @@ -113,4 +113,10 @@ static inline int __syscall_get_arch(void)
>   	return arch;
>   }
>
> +static inline int syscall_get_arch(struct task_struct *task,
> +				   struct pt_regs *regs)
> +{
> +	return __syscall_get_arch();
> +}
> +
>   #endif	/* __ASM_MIPS_SYSCALL_H */

This is already fixed for MIPS

http://patchwork.linux-mips.org/patch/6398/

The code is in linux-next targeting 3.15 as far as I can tell.

-- 
markos
