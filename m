From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ARM: add support to dump the kernel page tables
Date: Thu, 31 Oct 2013 17:40:50 +0000
Message-ID: <20131031174050.GF16735@n2100.arm.linux.org.uk>
References: <20131024071600.GC16735@n2100.arm.linux.org.uk> <52729346.7080709@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42200 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab3JaRl3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2013 13:41:29 -0400
Content-Disposition: inline
In-Reply-To: <52729346.7080709@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laura Abbott <lauraa@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org

On Thu, Oct 31, 2013 at 10:28:38AM -0700, Laura Abbott wrote:
> On 10/24/2013 12:16 AM, Russell King - ARM Linux wrote:
> ...
>> +	}, {
>> +		.mask	= L_PTE_MT_MASK,
>> +		.val	= L_PTE_MT_DEV_SHARED,
>> +		.set	= "DEV/SHARED",
>> +	}, {
>> +		.mask	= L_PTE_MT_MASK,
>> +		.val	= L_PTE_MT_DEV_NONSHARED,
>> +		.set	= "DEV/NONSHARED",
>> +	}, {
>
> L_PTE_MT_DEV_SHARED and L_PTE_MT_DEV_NONSHARED are the same on LPAE  
> systems which leads to bad output:
>
> 0xcd400000-0xcd401000           4K     RW NX SHD DEV/SHARED DEV/NONSHARED

So we probably want to make this conditional:

#if L_PTE_MT_DEV_SHARED != L_PTE_MT_DEV_NONSHARED
	... dev/non-shared entry
#endif

or we use a separate table for LPAE.

>> +		.mask	= L_PTE_MT_MASK,
>> +		.val	= L_PTE_MT_DEV_WC,
>> +		.set	= "DEV/WC",
>> +	}, {
>> +		.mask	= L_PTE_MT_MASK,
>> +		.val	= L_PTE_MT_DEV_CACHED,
>> +		.set	= "DEV/CACHED",
>> +	},
>> +};
>> +
>> +static const struct prot_bits section_bits[] = {
>> +	/* These are approximate */
>> +	{
>> +		.mask	= PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
>> +		.val	= 0,
>> +		.set	= "    ro",
>> +	}, {
>> +		.mask	= PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
>> +		.val	= PMD_SECT_AP_WRITE,
>> +		.set	= "    RW",
>> +	}, {
>> +		.mask	= PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
>> +		.val	= PMD_SECT_AP_READ,
>> +		.set	= "USR RO",
>> +	}, {
>> +		.mask	= PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
>> +		.val	= PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
>> +		.set	= "USR RW",
>> +	}, {
>
> Same issue here for PMD_SECT_AP_READ and PMD_SEC_AP_WRITE, both of those  
> are 0 on LPAE so the output looks strange:
>
> 0xc0000000-0xcd400000         212M     ro     RW USR RO USR RW x  SHD

I think this needs to be a separate table - it's just too different,
and it looks like the PMD_SECT_USER and PMD_SECT_RDONLY can be
separately decoded.
