Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:59292 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754078AbdEDOgf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 May 2017 10:36:35 -0400
Date: Thu, 4 May 2017 16:36:22 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 06/32] x86/mm: Add Secure Memory Encryption (SME)
 support
Message-ID: <20170504143622.zy2f66e4mkm6xvsq@pd.tnic>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418211727.10190.18774.stgit@tlendack-t1.amdoffice.net>
 <20170427154631.2tsqgax4kqcvydnx@pd.tnic>
 <d9d9f10a-0ce5-53e8-41f5-f8690dbd7362@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9d9f10a-0ce5-53e8-41f5-f8690dbd7362@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170504143622.z1q-2BjqcAO9S7WQmbarJgveuJ-hel74228Y5kmrKv0@z>

On Thu, May 04, 2017 at 09:24:11AM -0500, Tom Lendacky wrote:
> I did this so that an the include order wouldn't cause issues (including
> asm/mem_encrypt.h followed by later by a linux/mem_encrypt.h include).
> I can make this a bit clearer by having separate #defines for each
> thing, e.g.:
> 
> #ifndef sme_me_mask
> #define sme_me_mask 0UL
> #endif
> 
> #ifndef sme_active
> #define sme_active sme_active
> static inline ...
> #endif
> 
> Is that better/clearer?

I guess but where do we have to include both the asm/ and the linux/
version?

IOW, can we avoid these issues altogether by partitioning symbol
declarations differently among the headers?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
