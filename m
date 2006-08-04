Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:38530 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1422649AbWHEAGj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2006 20:06:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17619.56062.114311.902273@cargo.ozlabs.ibm.com>
Date: Sat, 5 Aug 2006 09:40:46 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC] Generic ioremap_page_range
In-Reply-To: <20060804094700.40a63a78@cad-250-152.norway.atmel.com>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
	<1152892123.24925.67.camel@localhost.localdomain>
	<20060804094700.40a63a78@cad-250-152.norway.atmel.com>
Sender: linux-arch-owner@vger.kernel.org
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Haavard Skinnemoen writes:

> This patch moves the i386 implementation of ioremap_page_range() into
> lib/ioremap.c for use by other architectures.

[snip]

> +static int ioremap_pte_range(pmd_t *pmd, unsigned long addr,
> +		unsigned long end, unsigned long phys_addr, pgprot_t prot)
> +{
> +	pte_t *pte;
> +	unsigned long pfn;
> +
> +	pfn = phys_addr >> PAGE_SHIFT;
> +	pte = pte_alloc_kernel(pmd, addr);
> +	if (!pte)
> +		return -ENOMEM;
> +	do {
> +		BUG_ON(!pte_none(*pte));
> +		set_pte(pte, pfn_pte(pfn, prot));

This would need to be set_pte_at(...) for this to be useful on
PowerPC.

Paul.
