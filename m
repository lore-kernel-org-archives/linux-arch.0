Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:34796 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932856AbcIEPaZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Sep 2016 11:30:25 -0400
Date: Mon, 5 Sep 2016 17:22:12 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v2 07/20] x86: Provide general kernel support for
 memory encryption
Message-ID: <20160905152211.GD18856@pd.tnic>
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223646.29880.28794.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160822223646.29880.28794.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160905152212.f2zAX-fpatPUPRPGbXQ9fdjIIsj4K89GMcPbrkLQwJQ@z>

On Mon, Aug 22, 2016 at 05:36:46PM -0500, Tom Lendacky wrote:
> Adding general kernel support for memory encryption includes:
> - Modify and create some page table macros to include the Secure Memory
>   Encryption (SME) memory encryption mask
> - Update kernel boot support to call an SME routine that checks for and
>   sets the SME capability (the SME routine will grow later and for now
>   is just a stub routine)
> - Update kernel boot support to call an SME routine that encrypts the
>   kernel (the SME routine will grow later and for now is just a stub
>   routine)
> - Provide an SME initialization routine to update the protection map with
>   the memory encryption mask so that it is used by default
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

...

> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index c98a559..30f7715 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -95,6 +95,13 @@ startup_64:
>  	jnz	bad_address
>  
>  	/*
> +	 * Enable memory encryption (if available). Add the memory encryption
> +	 * mask to %rbp to include it in the the page table fixup.
> +	 */
> +	call	sme_enable
> +	addq	sme_me_mask(%rip), %rbp
> +
> +	/*
>  	 * Fixup the physical addresses in the page table
>  	 */
>  	addq	%rbp, early_level4_pgt + (L4_START_KERNEL*8)(%rip)
> @@ -116,7 +123,8 @@ startup_64:
>  	movq	%rdi, %rax
>  	shrq	$PGDIR_SHIFT, %rax
>  
> -	leaq	(4096 + _KERNPG_TABLE)(%rbx), %rdx
> +	leaq	(4096 + __KERNPG_TABLE)(%rbx), %rdx
> +	addq	sme_me_mask(%rip), %rdx		/* Apply mem encryption mask */

Please add comments over the line and not at the side...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
