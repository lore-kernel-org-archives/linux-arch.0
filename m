From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 1/5] mm: add coherence API for DMA to vmalloc/vmap areas
Date: Thu, 10 Sep 2009 09:24:09 +0900
Message-ID: <20090910002409.GB23674@linux-sh.org>
References: <20090908190031.GF6538@flint.arm.linux.org.uk> <1252437112.13003.39.camel@mulgrave.site> <20090908201619.GG6538@flint.arm.linux.org.uk> <1252442352.13003.132.camel@mulgrave.site> <20090908213910.GH6538@flint.arm.linux.org.uk> <1252466070.13003.365.camel@mulgrave.site> <1252466226.13003.367.camel@mulgrave.site> <1252466601.13003.374.camel@mulgrave.site> <20090909033532.GD23049@linux-sh.org> <1252506878.3918.32.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:38398 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbZIJAYN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Sep 2009 20:24:13 -0400
Content-Disposition: inline
In-Reply-To: <1252506878.3918.32.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Parisc List <linux-parisc@vger.kernel.org>, Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>, linux-arch@vger.kernel.org, Christoph Hellwig <hch@lst.de>

On Wed, Sep 09, 2009 at 09:34:38AM -0500, James Bottomley wrote:
> On Wed, 2009-09-09 at 12:35 +0900, Paul Mundt wrote:
> > And here I thought it was a new gcc construct along the lines of
> > inline-if-so-inclined.. :-)
> 
> Actually, I missed the fact that sh also sets
> ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE, so you'll need implementations of
> these functions too.  Does this look right?
> 
Yes, I was planning on just wiring it up later, but this looks correct.
