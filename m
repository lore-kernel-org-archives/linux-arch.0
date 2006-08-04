Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:30673 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161334AbWHDRSa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2006 13:18:30 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k74HIUAC019272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-arch@vger.kernel.org>; Fri, 4 Aug 2006 13:18:30 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k74HIUqo292354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-arch@vger.kernel.org>; Fri, 4 Aug 2006 13:18:30 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k74HITrV004721
	for <linux-arch@vger.kernel.org>; Fri, 4 Aug 2006 13:18:29 -0400
Subject: Re: [RFC] Generic ioremap_page_range
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20060804094700.40a63a78@cad-250-152.norway.atmel.com>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
	 <1152892123.24925.67.camel@localhost.localdomain>
	 <20060804094700.40a63a78@cad-250-152.norway.atmel.com>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 10:18:25 -0700
Message-Id: <1154711905.10109.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2006-08-04 at 09:47 +0200, Haavard Skinnemoen wrote:
> On Fri, 14 Jul 2006 08:48:43 -0700
> Dave Hansen <haveblue@us.ibm.com> wrote:
> > It would also be nice to see a _couple_ of patches that perhaps
> > abstract a thing or two into generic code.  I know that new
> > architectures usually begin with a 'cp -r', but it would be nice to
> > see a wee bit of code refactoring as a small price of admission.
> > Some of the ioremap and other pagetable code looked pretty generic to
> > me.
> 
> Ok, here's a first try.
> 
> This patch moves the i386 implementation of ioremap_page_range() into
> lib/ioremap.c for use by other architectures.

Wow.  Very nice.

> There's one difference between the generic ioremap_page_range and the
> i386 version: it takes a pgprot_t argument instead of unsigned long
> flags, meaning that the arch-specific ioremap() implementation must
> set all pte flags before calling ioremap_page_range() instead of
> in the lowest-level page remapping function.

It looks like they were pretty static before, anyway.  I guess, in the
worst case, you could make a weak symbol in lib/ioremap.c that does
arch_ioremap_pgprot().  If an architecture needs to do something
special, they could override it.

But, unless this is causing real problems, I don't see any serious
reason to do it.  It can wail until we actually run into a user that
needs it.

> If you think this looks like a good idea, I'll split out the i386
> modifications in a separate patch and submit patches for several other
> architectures as well.
> 
> To get the review started, here are a couple of questions:
>   * Wouldn't it make more sense to call flush_cache_vmap() instead of
>     flush_cache_all()?

Yup, probably.  The ioremap code probably predates the existence of 
flush_cache_vmap().

>   * Why do we need to call flush_tlb_all()? I thought you only needed
>     to do that when changing/removing existing mappings...

I must not be understanding the flush_cache*() functions correctly
because the vmalloc() code does its flush_cache_vmap() _after_ the
vmalloc area is set up.

In any case, vmalloc() apparently does something very close to what you
need, and it does what you suggest: use flush_cache_vmap(), intends to
only work on pte_none() ptes, and doesn't call a tlb flush function
afterwords.  Unless there is something to differentiate ioremap's
functionality (say, the random pte flags you can set with ioremap) I
can't think of why ioremap is different.

BTW, does this new generic ioremap code work on _your_ architecture? ;)
Have you done a quick survey to see how many other architectures can use
it?

-- Dave

