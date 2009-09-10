Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:45040 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754758AbZIJAaC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Sep 2009 20:30:02 -0400
Subject: Re: [PATCH 1/5] mm: add coherence API for DMA to vmalloc/vmap areas
From: James Bottomley <James.Bottomley@HansenPartnership.com>
In-Reply-To: <20090910002409.GB23674@linux-sh.org>
References: <20090908190031.GF6538@flint.arm.linux.org.uk>
	 <1252437112.13003.39.camel@mulgrave.site>
	 <20090908201619.GG6538@flint.arm.linux.org.uk>
	 <1252442352.13003.132.camel@mulgrave.site>
	 <20090908213910.GH6538@flint.arm.linux.org.uk>
	 <1252466070.13003.365.camel@mulgrave.site>
	 <1252466226.13003.367.camel@mulgrave.site>
	 <1252466601.13003.374.camel@mulgrave.site>
	 <20090909033532.GD23049@linux-sh.org>
	 <1252506878.3918.32.camel@mulgrave.site>
	 <20090910002409.GB23674@linux-sh.org>
Content-Type: text/plain
Date: Thu, 10 Sep 2009 00:30:01 +0000
Message-ID: <1252542601.18356.64.camel@mulgrave.site>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mundt <lethal@linux-sh.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Parisc List <linux-parisc@vger.kernel.org>, Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>, linux-arch@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Message-ID: <20090910003001.XE3L5EfPuSNJwu1KtnjIkflAcQlHBNJQ3nzDACywrj4@z>

On Thu, 2009-09-10 at 09:24 +0900, Paul Mundt wrote:
> On Wed, Sep 09, 2009 at 09:34:38AM -0500, James Bottomley wrote:
> > On Wed, 2009-09-09 at 12:35 +0900, Paul Mundt wrote:
> > > And here I thought it was a new gcc construct along the lines of
> > > inline-if-so-inclined.. :-)
> > 
> > Actually, I missed the fact that sh also sets
> > ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE, so you'll need implementations of
> > these functions too.  Does this look right?
> > 
> Yes, I was planning on just wiring it up later, but this looks correct.

Great, thanks!

Give me an ack and I'll take care of submitting it ... although it would
be nice to test it out with the xfs problem case.

James


