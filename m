From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] generic debug pagealloc (-v2)
Date: Fri, 6 Mar 2009 12:28:14 +0900
Message-ID: <20090306032814.GA9874@localhost.localdomain>
References: <20090305145926.GA27015@localhost.localdomain> <20090305143150.136e2708.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:13805 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbZCFD2W (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 Mar 2009 22:28:22 -0500
Content-Disposition: inline
In-Reply-To: <20090305143150.136e2708.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, mingo@elte.hu, jirislaby@gmail.com, rmk+lkml@arm.linux.org.uk

On Thu, Mar 05, 2009 at 02:31:50PM -0800, Andrew Morton wrote:
> > +#include <linux/kernel.h>
> > +#include <linux/mm.h>
> > +
> > +static void poison_page(struct page *page)
> > +{
> > +	void *addr;
> > +
> > +	if (PageHighMem(page))
> > +		return; /* i goofed */
> 
> heh.  A more complete comment would be needed here.
> 
> Also, as this is a kernel bug, perhaps some sort of runtime warning?

It just skips the poisoning for highmem pages.
Any page poisoning can be skipped safely if it doesn't set the page->poison
flag. So I'm going to put

/*
 * skipping the page poisoning for highmem pages
 */

> > +	page->poison = true;
> > +	addr = page_address(page);
> > +	memset(addr, PAGE_POISON, PAGE_SIZE);
> > +}

...

> > +static void unpoison_page(struct page *page)
> > +{
> > +	void *addr;
> > +
> 
> Shouldn't we check PageHighmem() here also?

It should not happen because page->poison flag is not set for highmem pages.
But it's good for sanity checking. So I'll have a BUG_ON here.

> > +	if (!page->poison)
> > +		return;
> > +

	BUG_ON(PageHighMem(page));

> > +	addr = page_address(page);
> > +	check_poison_mem(addr, PAGE_SIZE);
> > +	page->poison = false;
> > +}
