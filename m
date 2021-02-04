Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5B8C433DB
	for <linux-arch@archiver.kernel.org>; Thu,  4 Feb 2021 14:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBC1D64F3F
	for <linux-arch@archiver.kernel.org>; Thu,  4 Feb 2021 14:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbhBDORd (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 4 Feb 2021 09:17:33 -0500
Received: from smtp-bc0e.mail.infomaniak.ch ([45.157.188.14]:48737 "EHLO
        smtp-bc0e.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236613AbhBDORZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 09:17:25 -0500
X-Greylist: delayed 164944 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Feb 2021 09:17:24 EST
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4DWgZy0krkzMq77N;
        Thu,  4 Feb 2021 15:16:26 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4DWgZx1Jz4zlh8TH;
        Thu,  4 Feb 2021 15:16:25 +0100 (CET)
Subject: Re: [PATCH 02/27] x86/syscalls: fix -Wmissing-prototypes warnings
 from COND_SYSCALL()
To:     Masahiro Yamada <masahiroy@kernel.org>, linux-arch@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20210128005110.2613902-1-masahiroy@kernel.org>
 <20210128005110.2613902-3-masahiroy@kernel.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <41f7ad59-6ee7-db95-0e56-861c61e8318f@digikod.net>
Date:   Thu, 4 Feb 2021 15:16:29 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20210128005110.2613902-3-masahiroy@kernel.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 28/01/2021 01:50, Masahiro Yamada wrote:
> Building kernel/sys_ni.c with W=1 omits tons of -Wmissing-prototypes
> warnings.
> 
> $ make W=1 kernel/sys_ni.o
>   [ snip ]
>   CC      kernel/sys_ni.o
> In file included from kernel/sys_ni.c:10:
> ./arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__x64_sys_io_setup' [-Wmissing-prototypes]
>    83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
>       |              ^~
> ./arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of macro '__COND_SYSCALL'
>   100 |  __COND_SYSCALL(x64, sys_##name)
>       |  ^~~~~~~~~~~~~~
> ./arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of macro '__X64_COND_SYSCALL'
>   256 |  __X64_COND_SYSCALL(name)     \
>       |  ^~~~~~~~~~~~~~~~~~
> kernel/sys_ni.c:39:1: note: in expansion of macro 'COND_SYSCALL'
>    39 | COND_SYSCALL(io_setup);
>       | ^~~~~~~~~~~~
> ./arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous prototype for '__ia32_sys_io_setup' [-Wmissing-prototypes]
>    83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) \
>       |              ^~
> ./arch/x86/include/asm/syscall_wrapper.h:120:2: note: in expansion of macro '__COND_SYSCALL'
>   120 |  __COND_SYSCALL(ia32, sys_##name)
>       |  ^~~~~~~~~~~~~~
> ./arch/x86/include/asm/syscall_wrapper.h:257:2: note: in expansion of macro '__IA32_COND_SYSCALL'
>   257 |  __IA32_COND_SYSCALL(name)
>       |  ^~~~~~~~~~~~~~~~~~~
> kernel/sys_ni.c:39:1: note: in expansion of macro 'COND_SYSCALL'
>    39 | COND_SYSCALL(io_setup);
>       | ^~~~~~~~~~~~
>   ...
> 
> __SYS_STUB0() and __SYS_STUBx() defined a few lines above have forward
> declarations. Let's do likewise for __COND_SYSCALL() to fix the
> warnings.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Tested-by: Mickaël Salaün <mic@linux.microsoft.com>

Thanks to this patch we avoid multiple emails from Intel's bot when
adding new syscalls. :)


> ---
> 
>  arch/x86/include/asm/syscall_wrapper.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
> index a84333adeef2..80c08c7d5e72 100644
> --- a/arch/x86/include/asm/syscall_wrapper.h
> +++ b/arch/x86/include/asm/syscall_wrapper.h
> @@ -80,6 +80,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
>  	}
>  
>  #define __COND_SYSCALL(abi, name)					\
> +	__weak long __##abi##_##name(const struct pt_regs *__unused);	\
>  	__weak long __##abi##_##name(const struct pt_regs *__unused)	\
>  	{								\
>  		return sys_ni_syscall();				\
> 
