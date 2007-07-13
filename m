Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:43495 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751458AbXGMREq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 13 Jul 2007 13:04:46 -0400
Date: Fri, 13 Jul 2007 10:04:45 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 0/7] Sparsemem Virtual Memmap V5
In-Reply-To: <exportbomb.1184333503@pinky>
Message-ID: <Pine.LNX.4.64.0707131001060.21777@schroedinger.engr.sgi.com>
References: <exportbomb.1184333503@pinky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Nick Piggin <npiggin@suse.de>, Mel Gorman <mel@csn.ul.ie>
List-ID: <linux-arch.vger.kernel.org>

On Fri, 13 Jul 2007, Andy Whitcroft wrote:

> Andrew, please consider for -mm.
> 
> Note that I am away from my keyboard all of next week, but I figured
> it better to get this out for testing.

Yes grumble. Why does it take so long...

Would it be possible to merge this for 2.6.23 (maybe late?). This has been 
around for 6 months now. It removes the troubling lookups in 
virt_to_page and page_address in sparsemem that have spooked many of us. 

virt_to_page efficiency is a performance issue for kfree and 
kmem_cache_free in the slab allocators. I inserted probles and saw 
that the patchset cuts down the cycles spend in virt_to_page by 50%.
