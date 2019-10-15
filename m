Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:57978 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfJOREE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Oct 2019 13:04:04 -0400
Date: Tue, 15 Oct 2019 19:03:58 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v9 15/28] x86/asm/purgatory: Start using annotations
Message-ID: <20191015170358.GE596@zn.tnic>
References: <20191011115108.12392-1-jslaby@suse.cz>
 <20191011115108.12392-16-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191011115108.12392-16-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20191015170358.M1Ax_qs40SQdBYvyPaexUD2kvsK0gNWgWr9ol85KOgk@z>

On Fri, Oct 11, 2019 at 01:50:55PM +0200, Jiri Slaby wrote:
> Purgatory used no annotations at all. So include linux/linkage.h and
> annotate everything:
> * code by SYM_CODE_*
> * data by SYM_DATA_*
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> ---
>  arch/x86/purgatory/entry64.S      | 21 ++++++++++++---------
>  arch/x86/purgatory/setup-x86_64.S | 14 ++++++++------
>  arch/x86/purgatory/stack.S        |  7 ++++---
>  3 files changed, 24 insertions(+), 18 deletions(-)

...

> @@ -75,12 +76,12 @@ r13:	.quad 0x0
>  r14:	.quad 0x0
>  r15:	.quad 0x0
>  rip:	.quad 0x0
> -	.size entry64_regs, . - entry64_regs
> +SYM_DATA_END(entry64_regs)
>  
>  	/* GDT */
>  	.section ".rodata"
>  	.balign 16
> -gdt:
> +SYM_DATA_START_LOCAL(gdt)
>  	/* 0x00 unusable segment

Note for the applier: Fixup that comment:

	/*
	 * 0x00 ...
	 * ...

>  	 * 0x08 unused
>  	 * so use them as gdt ptr

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
