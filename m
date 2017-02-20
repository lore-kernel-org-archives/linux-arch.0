Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:35874 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751071AbdBTUKe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Feb 2017 15:10:34 -0500
Date: Mon, 20 Feb 2017 21:09:55 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v4 11/28] x86: Add support to determine the E820 type
 of an address
Message-ID: <20170220200955.32e2wqxgulswnr55@pd.tnic>
References: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
 <20170216154430.19244.95519.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170216154430.19244.95519.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170220200955.XjVPBVAxfhmssn4L5OhnzEbp9ZjS8piun8LejeEMQso@z>

On Thu, Feb 16, 2017 at 09:44:30AM -0600, Tom Lendacky wrote:
> This patch adds support to return the E820 type associated with an address

s/This patch adds/Add/

> range.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/e820/api.h   |    2 ++
>  arch/x86/include/asm/e820/types.h |    2 ++
>  arch/x86/kernel/e820.c            |   26 +++++++++++++++++++++++---
>  3 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
> index 8e0f8b8..7c1bdc9 100644
> --- a/arch/x86/include/asm/e820/api.h
> +++ b/arch/x86/include/asm/e820/api.h
> @@ -38,6 +38,8 @@
>  extern void e820__reallocate_tables(void);
>  extern void e820__register_nosave_regions(unsigned long limit_pfn);
>  
> +extern enum e820_type e820__get_entry_type(u64 start, u64 end);
> +
>  /*
>   * Returns true iff the specified range [start,end) is completely contained inside
>   * the ISA region.
> diff --git a/arch/x86/include/asm/e820/types.h b/arch/x86/include/asm/e820/types.h
> index 4adeed0..bf49591 100644
> --- a/arch/x86/include/asm/e820/types.h
> +++ b/arch/x86/include/asm/e820/types.h
> @@ -7,6 +7,8 @@
>   * These are the E820 types known to the kernel:
>   */
>  enum e820_type {
> +	E820_TYPE_INVALID	= 0,
> +

Now this is strange - ACPI spec doesn't explicitly say that range type 0
is invalid. Am I looking at the wrong place?

"Table 15-312 Address Range Types12" in ACPI spec 6.

If 0 is really the invalid entry, then e820_print_type() needs updating
too. And then the invalid-entry-add should be a separate patch.

>  	E820_TYPE_RAM		= 1,
>  	E820_TYPE_RESERVED	= 2,
>  	E820_TYPE_ACPI		= 3,

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
