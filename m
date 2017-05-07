Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:43178 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753337AbdEGWIQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 7 May 2017 18:08:16 -0400
Date: Sun, 7 May 2017 19:18:22 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 15/32] efi: Update efi_mem_type() to return an error
 rather than 0
Message-ID: <20170507171822.x7grrqg2tcvbv6j5@pd.tnic>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418211900.10190.98158.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170418211900.10190.98158.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170507171822.Cc-K97lA3jFGCtFZ06S9tHXF6raP2cgZW8wgl-T8doU@z>

On Tue, Apr 18, 2017 at 04:19:00PM -0500, Tom Lendacky wrote:
> The efi_mem_type() function currently returns a 0, which maps to
> EFI_RESERVED_TYPE, if the function is unable to find a memmap entry for
> the supplied physical address. Returning EFI_RESERVED_TYPE implies that
> a memmap entry exists, when it doesn't.  Instead of returning 0, change
> the function to return a negative error value when no memmap entry is
> found.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---

...

> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index cd768a1..a27bb3f 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -973,7 +973,7 @@ static inline void efi_esrt_init(void) { }
>  extern int efi_config_parse_tables(void *config_tables, int count, int sz,
>  				   efi_config_table_type_t *arch_tables);
>  extern u64 efi_get_iobase (void);
> -extern u32 efi_mem_type (unsigned long phys_addr);
> +extern int efi_mem_type (unsigned long phys_addr);

WARNING: space prohibited between function name and open parenthesis '('
#101: FILE: include/linux/efi.h:976:
+extern int efi_mem_type (unsigned long phys_addr);

Please integrate scripts/checkpatch.pl in your patch creation workflow.
Some of the warnings/errors *actually* make sense.

I know, the other function prototypes have a space too but that's not
our coding style. Looks like this trickled in from ia64, from looking at
arch/ia64/kernel/efi.c.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
