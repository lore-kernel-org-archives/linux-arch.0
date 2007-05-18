Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:52797 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755599AbXERJml (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 May 2007 05:42:41 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20070518040854.GA15654@wotan.suse.de>
References: <20070518040854.GA15654@wotan.suse.de>
Subject: Re: [rfc] increase struct page size?!
Date: Fri, 18 May 2007 10:42:30 +0100
Message-ID: <7554.1179481350@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Nick Piggin <npiggin@suse.de> wrote:

> I'd like to be the first to propose an increase to the size of struct page
> just for the sake of increasing it!

Heh.  I'm surprised you haven't got more adverse reactions.

> If we add 8 bytes to struct page on 64-bit machines, it becomes 64 bytes,
> which is quite a nice number for cache purposes.

Whilst that's true, if you have to deal with a run of contiguous page structs
(eg: the page allocator, perhaps) it's actually less efficient because it
takes more cache to do it.  But, hey, it's a compromise whatever.

In the scheme of things, if we're mostly dealing with individual page structs
(as I think we are), then yes, I think it's probably a good thing to do -
especially with larger page sizes.

> However we don't have to let those 8 bytes go to waste: we can use them
> to store the virtual address of the page, which kind of makes sense for
> 64-bit, because they can likely to use complicated memory models.

That's a good idea, one that's implemented on some platforms anyway.  It'll be
especially good with NUMA, I suspect.

> I'd say all up this is going to decrease overall cache footprint in 
> fastpaths, both by reducing text and data footprint of page_address and
> related operations, and by reducing cacheline footprint of most batched
> operations on struct pages.

kmap, filling in scatter/gather lists, crypto stuff.  I like it.

Can you do this just by turning on WANT_PAGE_VIRTUAL on all 64-bit platforms?

David
