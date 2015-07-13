From: Matthew Wilcox <willy@linux.intel.com>
Subject: Re: [PATCH] fs: dax: do not build on ARC or SH
Date: Mon, 13 Jul 2015 10:35:45 -0400
Message-ID: <20150713143545.GF13681@linux.intel.com>
References: <1436781167-14446-1-git-send-email-geert+renesas@glider.be>
 <55A3A796.4050108@plexistor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43425 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292AbbGMOft (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Jul 2015 10:35:49 -0400
Content-Disposition: inline
In-Reply-To: <55A3A796.4050108@plexistor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boaz Harrosh <boaz@plexistor.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Andrew Morton <akpm@linux-foundation.org>, Paul Bolle <pebolle@tiscali.nl>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Mon, Jul 13, 2015 at 02:57:10PM +0300, Boaz Harrosh wrote:
> I do not understand why we need to call copy_user_page here at all?
> the destination is kmap_atomic() so it must be there right? also the
> destination is the cow-to page so surly it is not yet mapped to user-space
> mapping.
> 
> the from is pmem which is just there.
> 
> >From what I understand copy_user_page means:
>     On these ARCHs that each user-mapping has its own VM cache, please invalidate
>     the other VM caches.
> Like on arm64 (arch/arm64/mm/copypage.c):
> 	copy_page(kto, kfrom);
> 	__flush_dcache_area(kto, PAGE_SIZE);

You're confusing implementation with guaranteed semantics.  The problem
is for architectures which have virtually indexed caches, the kernel
virtual address does not necessarily map to the same cacheline as user
virtual addresses.  The solution that has been adopted for page cache
pages is that user addresses are flushed before the kernel reads from a
page, and kernel addresses are flushed before the kernel writes to a page.

Now, imagine task A mmaps a file using MAP_SHARED.  Task B mmaps the
same file using MAP_PRIVATE.  Task A & B have a communication channel,
maybe a socket.  Task A stores a few bytes to a page in the mmap, and
then sends a message down the communication channel.  Task B stores a
byte to a different part of the same page (causing the COW) and then
examines the bytes that task A wrote.

To avoid violating causality, we must have copied the bytes that task
B would have seen at that time, as opposed to the bytes which were in
storage before task A overwrote them.  So either we flush the bytes that
task A wrote before doing the COW, or we copy from an address that is
cache-coherent with the address that A used to do the store.

> So what I do not understand is why copy_user_page does not have a default
> implementation for those ARCHs that don't override it.

copy_user_page() is a documented part of the cache flushing protocols.
Some architectures have chosen to not implement it, even though they
actually need the flushing.

There is a separate issue which is that DAX is not currently doing enough
flushing.  Fixing that is about fourth on my priority list right now.
2MB pages, RDMA access and a rather interesting bug reported to me last
week are all higher priority.
