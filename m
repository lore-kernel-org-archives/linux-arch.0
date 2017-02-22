Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11626 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932287AbdBVSOO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Feb 2017 13:14:14 -0500
Subject: Re: [RFC PATCH v4 07/28] x86: Provide general kernel support for
 memory encryption
References: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
 <20170216154332.19244.55451.stgit@tlendack-t1.amdoffice.net>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <cd11c396-d5d2-9f06-086e-6d6f54352fa6@intel.com>
Date: Wed, 22 Feb 2017 10:13:57 -0800
MIME-Version: 1.0
In-Reply-To: <20170216154332.19244.55451.stgit@tlendack-t1.amdoffice.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc: Rik van Riel <riel@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170222181357.vB1TXBpiYmEhmSLX9w1gL6Nccefe-PHaEmX08CLQfwI@z>

On 02/16/2017 07:43 AM, Tom Lendacky wrote:
> )
> @@ -673,7 +683,7 @@ static inline unsigned long pgd_page_vaddr(pgd_t pgd)
>   * Currently stuck as a macro due to indirect forward reference to
>   * linux/mmzone.h's __section_mem_map_addr() definition:
>   */
> -#define pgd_page(pgd)		pfn_to_page(pgd_val(pgd) >> PAGE_SHIFT)
> +#define pgd_page(pgd)	pfn_to_page(pgd_pfn(pgd))

FWIW, these seem like good cleanups that can go in separately from the
rest of your series.
