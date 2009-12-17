Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37674 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934997AbZLQSRf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Dec 2009 13:17:35 -0500
Date: Thu, 17 Dec 2009 10:17:03 -0800 (PST)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] xfs and block fixes for virtually indexed arches
In-Reply-To: <20091217180802.GA1546@flint.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.0912171016430.15740@localhost.localdomain>
References: <20091216043618.GB9104@hera.kernel.org> <20091217132256.GO28962@bombadil.infradead.org> <alpine.LFD.2.00.0912170811130.15740@localhost.localdomain> <20091217163036.GE2123@thunk.org> <alpine.LFD.2.00.0912170839550.15740@localhost.localdomain>
 <20091217170743.GA10431@infradead.org> <alpine.LFD.2.00.0912170928310.15740@localhost.localdomain> <20091217180802.GA1546@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, tytso@mit.edu, Kyle McMartin <kyle@mcmartin.ca>, linux-parisc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, James.Bottomley@suse.de, linux-arch@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>
Message-ID: <20091217181703.pXRPRnFuN3KdAPXthSFpknPep-X-DkkoZSvep3CMGWk@z>



On Thu, 17 Dec 2009, Russell King wrote:
> 
> That's not entirely true.  If you have write back caches which are not DMA
> coherent, you need to as a minimum:
> 
> - on write, clean the cache to ensure that the page is up to date with data
>   held in cache.
> 
> - on read, you must ensure that there are no potential write-backs before
>   the read commenses and invalidate at some point.

Right you are.

		Linus
