Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750746AbdCHG6q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Mar 2017 01:58:46 -0500
Date: Wed, 8 Mar 2017 14:55:55 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [RFC PATCH v4 14/28] Add support to access boot related data in
 the clear
Message-ID: <20170308065555.GA11045@dhcp-128-65.nay.redhat.com>
References: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
 <20170216154508.19244.58580.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170216154508.19244.58580.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170308065555.eYrgubD4QtSSPwhPbu5v1tq3kAZOThPEtgJ24KuW7SA@z>

On 02/16/17 at 09:45am, Tom Lendacky wrote:
[snip]
> + * This function determines if an address should be mapped encrypted.
> + * Boot setup data, EFI data and E820 areas are checked in making this
> + * determination.
> + */
> +static bool memremap_should_map_encrypted(resource_size_t phys_addr,
> +					  unsigned long size)
> +{
> +	/*
> +	 * SME is not active, return true:
> +	 *   - For early_memremap_pgprot_adjust(), returning true or false
> +	 *     results in the same protection value
> +	 *   - For arch_memremap_do_ram_remap(), returning true will allow
> +	 *     the RAM remap to occur instead of falling back to ioremap()
> +	 */
> +	if (!sme_active())
> +		return true;
