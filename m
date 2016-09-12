Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:37351 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932172AbcILLqA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Sep 2016 07:46:00 -0400
Date: Mon, 12 Sep 2016 13:45:50 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v2 15/20] iommu/amd: AMD IOMMU support for memory
 encryption
Message-ID: <20160912114550.nwhtpmncwp22l7vy@pd.tnic>
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223820.29880.17752.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160822223820.29880.17752.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160912114550.ID1Ok7d_UESCaP7BoRjdXsgZQYwRsmbZ1rWX2AwLPEI@z>

On Mon, Aug 22, 2016 at 05:38:20PM -0500, Tom Lendacky wrote:
> Add support to the AMD IOMMU driver to set the memory encryption mask if
> memory encryption is enabled.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/mem_encrypt.h |    2 ++
>  arch/x86/mm/mem_encrypt.c          |    5 +++++
>  drivers/iommu/amd_iommu.c          |   10 ++++++++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 384fdfb..e395729 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -36,6 +36,8 @@ void __init sme_early_init(void);
>  /* Architecture __weak replacement functions */
>  void __init mem_encrypt_init(void);
>  
> +unsigned long amd_iommu_get_me_mask(void);
> +
>  unsigned long swiotlb_get_me_mask(void);
>  void swiotlb_set_mem_dec(void *vaddr, unsigned long size);
>  
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 6b2e8bf..2f28d87 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -185,6 +185,11 @@ void __init mem_encrypt_init(void)
>  	swiotlb_clear_encryption();
>  }
>  
> +unsigned long amd_iommu_get_me_mask(void)
> +{
> +	return sme_me_mask;
> +}
> +
>  unsigned long swiotlb_get_me_mask(void)
>  {
>  	return sme_me_mask;
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 96de97a..63995e3 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -166,6 +166,15 @@ struct dma_ops_domain {
>  static struct iova_domain reserved_iova_ranges;
>  static struct lock_class_key reserved_rbtree_key;
>  
> +/*
> + * Support for memory encryption. If memory encryption is supported, then an
> + * override to this function will be provided.
> + */
> +unsigned long __weak amd_iommu_get_me_mask(void)
> +{
> +	return 0;
> +}

So instead of adding a function each time which returns sme_me_mask
for each user it has, why don't you add a single function which
returns sme_me_mask in mem_encrypt.c and add an inline in the header
mem_encrypt.h which returns 0 for the !CONFIG_AMD_MEM_ENCRYPT case.

This all is still funny because we access sme_me_mask directly for the
different KERNEL_* masks but then you're adding an accessor function.

So what you should do instead, IMHO, is either hide sme_me_mask
altogether and use the accessor functions only (not sure if that would
work in all cases) or expose sme_me_mask unconditionally and have it be
0 if CONFIG_AMD_MEM_ENCRYPT is not enabled so that it just works.

Or is there a third, more graceful variant?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
