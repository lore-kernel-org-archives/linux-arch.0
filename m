Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:33008 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754086AbcIFJUH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Sep 2016 05:20:07 -0400
Date: Tue, 6 Sep 2016 11:31:13 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v2 07/20] x86: Provide general kernel support for
 memory encryption
Message-ID: <20160906093113.GA18319@pd.tnic>
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
Message-ID: <20160906093113.D74BPjr0ZZufuvG6owRHYhk86cszEcYyzN1fhdlWY5I@z>

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

> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 54a2372..88c7bae 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -28,6 +28,7 @@
>  #include <asm/bootparam_utils.h>
>  #include <asm/microcode.h>
>  #include <asm/kasan.h>
> +#include <asm/mem_encrypt.h>
>  
>  /*
>   * Manage page tables very early on.
> @@ -42,7 +43,7 @@ static void __init reset_early_page_tables(void)
>  {
>  	memset(early_level4_pgt, 0, sizeof(pgd_t)*(PTRS_PER_PGD-1));
>  	next_early_pgt = 0;
> -	write_cr3(__pa_nodebug(early_level4_pgt));
> +	write_cr3(__sme_pa_nodebug(early_level4_pgt));
>  }
>  
>  /* Create a new PMD entry */
> @@ -54,7 +55,7 @@ int __init early_make_pgtable(unsigned long address)
>  	pmdval_t pmd, *pmd_p;
>  
>  	/* Invalid address or early pgt is done ?  */
> -	if (physaddr >= MAXMEM || read_cr3() != __pa_nodebug(early_level4_pgt))
> +	if (physaddr >= MAXMEM || read_cr3() != __sme_pa_nodebug(early_level4_pgt))
>  		return -1;
>  
>  again:
> @@ -157,6 +158,11 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
>  
>  	clear_page(init_level4_pgt);
>  
> +	/* Update the early_pmd_flags with the memory encryption mask */
> +	early_pmd_flags |= _PAGE_ENC;
> +
> +	sme_early_init();
> +

So maybe this comes later but you're setting _PAGE_ENC unconditionally
*before* sme_early_init().

I think you should set it in sme_early_init() and iff SME is enabled.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
