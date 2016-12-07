Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wj0-f169.google.com ([209.85.210.169]:32817 "EHLO
        mail-wj0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932283AbcLGNTG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Dec 2016 08:19:06 -0500
Received: by mail-wj0-f169.google.com with SMTP id xy5so360347845wjc.0
        for <linux-arch@vger.kernel.org>; Wed, 07 Dec 2016 05:19:05 -0800 (PST)
Date: Wed, 7 Dec 2016 13:19:03 +0000
From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [RFC PATCH v3 10/20] Add support to access boot related data in
 the clear
Message-ID: <20161207131903.GU20785@codeblueprint.co.uk>
References: <20161110003426.3280.2999.stgit@tlendack-t1.amdoffice.net>
 <20161110003631.3280.73292.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161110003631.3280.73292.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Message-ID: <20161207131903.DOkEpuh6tawd0qKY9Dwvp27Q0Qa8sgXlX8GIRKtX1H8@z>

On Wed, 09 Nov, at 06:36:31PM, Tom Lendacky wrote:
> Boot data (such as EFI related data) is not encrypted when the system is
> booted and needs to be accessed unencrypted.  Add support to apply the
> proper attributes to the EFI page tables and to the early_memremap and
> memremap APIs to identify the type of data being accessed so that the
> proper encryption attribute can be applied.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/e820.h    |    1 
>  arch/x86/kernel/e820.c         |   16 +++++++
>  arch/x86/mm/ioremap.c          |   89 ++++++++++++++++++++++++++++++++++++++++
>  arch/x86/platform/efi/efi_64.c |   12 ++++-
>  drivers/firmware/efi/efi.c     |   33 +++++++++++++++
>  include/linux/efi.h            |    2 +
>  kernel/memremap.c              |    8 +++-
>  mm/early_ioremap.c             |   18 +++++++-
>  8 files changed, 172 insertions(+), 7 deletions(-)
 
FWIW, I think this version is an improvement over all the previous
ones.

[...]

> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index ff542cd..ee347c2 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -20,6 +20,9 @@
>  #include <asm/tlbflush.h>
>  #include <asm/pgalloc.h>
>  #include <asm/pat.h>
> +#include <asm/e820.h>
> +#include <asm/setup.h>
> +#include <linux/efi.h>
>  
>  #include "physaddr.h"
>  
> @@ -418,6 +421,92 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
>  	iounmap((void __iomem *)((unsigned long)addr & PAGE_MASK));
>  }
>  
> +static bool memremap_setup_data(resource_size_t phys_addr,
> +				unsigned long size)
> +{
> +	u64 paddr;
> +
> +	if (phys_addr == boot_params.hdr.setup_data)
> +		return true;
> +

Why is the setup_data linked list not traversed when checking for
matching addresses? Am I reading this incorrectly? I don't see how
this can work.

> +	paddr = boot_params.efi_info.efi_memmap_hi;
> +	paddr <<= 32;
> +	paddr |= boot_params.efi_info.efi_memmap;
> +	if (phys_addr == paddr)
> +		return true;
> +
> +	paddr = boot_params.efi_info.efi_systab_hi;
> +	paddr <<= 32;
> +	paddr |= boot_params.efi_info.efi_systab;
> +	if (phys_addr == paddr)
> +		return true;
> +
> +	if (efi_table_address_match(phys_addr))
> +		return true;
> +
> +	return false;
> +}
> +
> +static bool memremap_apply_encryption(resource_size_t phys_addr,
> +				      unsigned long size)
> +{
> +	/* SME is not active, just return true */
> +	if (!sme_me_mask)
> +		return true;
> +
> +	/* Check if the address is part of the setup data */
> +	if (memremap_setup_data(phys_addr, size))
> +		return false;
> +
> +	/* Check if the address is part of EFI boot/runtime data */
> +	switch (efi_mem_type(phys_addr)) {
> +	case EFI_BOOT_SERVICES_DATA:
> +	case EFI_RUNTIME_SERVICES_DATA:
> +		return false;
> +	}

EFI_LOADER_DATA is notable by its absence.

We use that memory type for allocations inside of the EFI boot stub
that are than used while the kernel is running. One use that comes to
mind is for initrd files, see handle_cmdline_files().

Oh I see you handle that in PATCH 9, never mind.

> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index 58b0f80..3f89179 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -221,7 +221,13 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
>  	if (efi_enabled(EFI_OLD_MEMMAP))
>  		return 0;
>  
> -	efi_scratch.efi_pgt = (pgd_t *)__pa(efi_pgd);
> +	/*
> +	 * Since the PGD is encrypted, set the encryption mask so that when
> +	 * this value is loaded into cr3 the PGD will be decrypted during
> +	 * the pagetable walk.
> +	 */
> +	efi_scratch.efi_pgt = (pgd_t *)__sme_pa(efi_pgd);
> +
>  	pgd = efi_pgd;
>  
>  	/*

Do all callers of __pa() in arch/x86 need fixing up like this?
