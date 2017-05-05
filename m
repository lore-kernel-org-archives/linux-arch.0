Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:49020 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750990AbdEERMY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 May 2017 13:12:24 -0400
Date: Fri, 5 May 2017 19:11:55 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 13/32] x86/boot/e820: Add support to determine the
 E820 type of an address
Message-ID: <20170505171155.4fm22ks6m5j7lpjm@pd.tnic>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418211831.10190.80158.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170418211831.10190.80158.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170505171155.s7bIRBTmXz4X9ajeb_wZV7k39D5LU6j5CwyI_bSIdlU@z>

On Tue, Apr 18, 2017 at 04:18:31PM -0500, Tom Lendacky wrote:
> Add a function that will return the E820 type associated with an address
> range.

...

> @@ -110,9 +111,28 @@ bool __init e820__mapped_all(u64 start, u64 end, enum e820_type type)
>  		 * coverage of the desired range exists:
>  		 */
>  		if (start >= end)
> -			return 1;
> +			return entry;
>  	}
> -	return 0;
> +
> +	return NULL;
> +}
> +
> +/*
> + * This function checks if the entire range <start,end> is mapped with type.
> + */
> +bool __init e820__mapped_all(u64 start, u64 end, enum e820_type type)
> +{
> +	return __e820__mapped_all(start, end, type) ? 1 : 0;

	return !!__e820__mapped_all(start, end, type);

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
