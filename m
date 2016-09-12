Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33975 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbcILQzb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Sep 2016 12:55:31 -0400
Received: by mail-vk0-f45.google.com with SMTP id v189so143464465vkv.1
        for <linux-arch@vger.kernel.org>; Mon, 12 Sep 2016 09:55:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160822223738.29880.6909.stgit@tlendack-t1.amdoffice.net>
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net> <20160822223738.29880.6909.stgit@tlendack-t1.amdoffice.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 12 Sep 2016 09:55:09 -0700
Message-ID: <CALCETrUk2kRSzKfwhio6KV3iuYaSV2uxybd-e95kK3vY=yTSfg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/20] mm: Access BOOT related data in the clear
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>, Matt Fleming <mfleming@suse.de>
Cc: kasan-dev <kasan-dev@googlegroups.com>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, iommu@lists.linux-foundation.org, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Matt Fleming <matt@codeblueprint.co.uk>, Alexander Potapenko <glider@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, kvm list <kvm@vger.kernel.org>
Message-ID: <20160912165509.lYc8RTgL3TkhyUNBnbVm76z8sqImEDwE0gu3rOMwNvU@z>

On Aug 22, 2016 6:53 PM, "Tom Lendacky" <thomas.lendacky@amd.com> wrote:
>
> BOOT data (such as EFI related data) is not encyrpted when the system is
> booted and needs to be accessed as non-encrypted.  Add support to the
> early_memremap API to identify the type of data being accessed so that
> the proper encryption attribute can be applied.  Currently, two types
> of data are defined, KERNEL_DATA and BOOT_DATA.

What happens when you memremap boot services data outside of early
boot?  Matt just added code that does this.

IMO this API is not so great.  It scatters a specialized consideration
all over the place.  Could early_memremap not look up the PA to figure
out what to do?

--Andy

[leaving the rest here for Matt's benefit]

>                      unsigned long size,
> +                                                   enum memremap_owner owner,
> +                                                   pgprot_t prot)
> +{
> +       return prot;
> +}
> +
>  void __init early_ioremap_reset(void)
>  {
>         early_ioremap_shutdown();
> @@ -213,16 +221,23 @@ early_ioremap(resource_size_t phys_addr, unsigned long size)
>
>  /* Remap memory */
>  void __init *
> -early_memremap(resource_size_t phys_addr, unsigned long size)
> +early_memremap(resource_size_t phys_addr, unsigned long size,
> +              enum memremap_owner owner)
>  {
> -       return (__force void *)__early_ioremap(phys_addr, size,
> -                                              FIXMAP_PAGE_NORMAL);
> +       pgprot_t prot = early_memremap_pgprot_adjust(phys_addr, size, owner,
> +                                                    FIXMAP_PAGE_NORMAL);
> +
> +       return (__force void *)__early_ioremap(phys_addr, size, prot);
>  }
>  #ifdef FIXMAP_PAGE_RO
>  void __init *
> -early_memremap_ro(resource_size_t phys_addr, unsigned long size)
> +early_memremap_ro(resource_size_t phys_addr, unsigned long size,
> +                 enum memremap_owner owner)
>  {
> -       return (__force void *)__early_ioremap(phys_addr, size, FIXMAP_PAGE_RO);
> +       pgprot_t prot = early_memremap_pgprot_adjust(phys_addr, size, owner,
> +                                                    FIXMAP_PAGE_RO);
> +
> +       return (__force void *)__early_ioremap(phys_addr, size, prot);
>  }
>  #endif
>
> @@ -236,7 +251,8 @@ early_memremap_prot(resource_size_t phys_addr, unsigned long size,
>
>  #define MAX_MAP_CHUNK  (NR_FIX_BTMAPS << PAGE_SHIFT)
>
> -void __init copy_from_early_mem(void *dest, phys_addr_t src, unsigned long size)
> +void __init copy_from_early_mem(void *dest, phys_addr_t src, unsigned long size,
> +                               enum memremap_owner owner)
>  {
>         unsigned long slop, clen;
>         char *p;
> @@ -246,7 +262,7 @@ void __init copy_from_early_mem(void *dest, phys_addr_t src, unsigned long size)
>                 clen = size;
>                 if (clen > MAX_MAP_CHUNK - slop)
>                         clen = MAX_MAP_CHUNK - slop;
> -               p = early_memremap(src & PAGE_MASK, clen + slop);
> +               p = early_memremap(src & PAGE_MASK, clen + slop, owner);
>                 memcpy(dest, p + slop, clen);
>                 early_memunmap(p, clen + slop);
>                 dest += clen;
> @@ -265,12 +281,14 @@ early_ioremap(resource_size_t phys_addr, unsigned long size)
>
>  /* Remap memory */
>  void __init *
> -early_memremap(resource_size_t phys_addr, unsigned long size)
> +early_memremap(resource_size_t phys_addr, unsigned long size,
> +              enum memremap_owner owner)
>  {
>         return (void *)phys_addr;
>  }
>  void __init *
> -early_memremap_ro(resource_size_t phys_addr, unsigned long size)
> +early_memremap_ro(resource_size_t phys_addr, unsigned long size,
> +                 enum memremap_owner owner)
>  {
>         return (void *)phys_addr;
>  }
>
