From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: New helper to free highmem pages in larger chunks
Date: Mon, 5 Oct 2015 15:09:55 -0700
Message-ID: <20151005150955.3e1da261449ae046e1be3989@linux-foundation.org>
References: <560FD031.3030909@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:50360 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbbJEWJ5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 5 Oct 2015 18:09:57 -0400
In-Reply-To: <560FD031.3030909@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Robin Holt <robin.m.holt@gmail.com>, Nathan Zimmer <nzimmer@sgi.com>, Jiang Liu <liuj97@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>

On Sat, 3 Oct 2015 18:25:13 +0530 Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:

> Hi,
> 
> I noticed increased boot time when enabling highmem for ARC. Turns out that
> freeing highmem pages into buddy allocator is done page at a time, while it is
> batched for low mem pages. Below is call flow.
> 
> I'm thinking of writing free_highmem_pages() which takes start and end pfn and
> want to solicit some ideas whether to write it from scratch or preferably call
> existing __free_pages_memory() to reuse the logic to convert a pfn range into
> {pfn, order} tuples.
> 
> For latter however there are semantical differences as you can see below which I'm
> not sure of:
>   -highmem page->count is set to 1, while 0 for low mem

That would be weird.

Look more closely at __free_pages_boot_core() - it uses
set_page_refcounted() to set the page's refcount to 1.  Those
set_page_count() calls look superfluous to me.

>   -atomic clearing of page reserved flag vs. non atomic

I doubt if the atomic is needed - who else can be looking at this page
at this time?
