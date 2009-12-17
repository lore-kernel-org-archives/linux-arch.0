Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from THUNK.ORG ([69.25.196.29]:48035 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765116AbZLQRdt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Dec 2009 12:33:49 -0500
Date: Thu, 17 Dec 2009 12:33:27 -0500
From: tytso@mit.edu
Subject: Re: [git patches] xfs and block fixes for virtually indexed arches
Message-ID: <20091217173327.GF2123@thunk.org>
References: <20091216043618.GB9104@hera.kernel.org>
 <20091217132256.GO28962@bombadil.infradead.org>
 <alpine.LFD.2.00.0912170811130.15740@localhost.localdomain>
 <20091217163036.GE2123@thunk.org>
 <20091217171025.GB10431@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091217171025.GB10431@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kyle McMartin <kyle@mcmartin.ca>, linux-parisc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, James.Bottomley@suse.de, linux-arch@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>
Message-ID: <20091217173327.psjUhUaiK2D2kDBYnY4y16sQMRxy-OfPgdJFkjRsLfU@z>

On Thu, Dec 17, 2009 at 12:10:25PM -0500, Christoph Hellwig wrote:
> On Thu, Dec 17, 2009 at 11:30:36AM -0500, tytso@mit.edu wrote:
> > That's because apparently the iSCSI and DMA blocks assume that they
> > have Real Pages (tm) passed to block I/O requests, and apparently XFS
> > ran into problems when sending vmalloc'ed pages.  I don't know if this
> > is a problem if we pass the bio layer addresses coming from the SLAB
> > allocator, but oral tradition seems to indicate this is problematic,
> > although no one has given me the full chapter and verse explanation
> > about why this is so.
> 
> Actually at least iscsi now has a workaround for that by checking for
> PageSlab.  Back when we deal with the XFS issue that check was only
> available with debug options enabled.  I tried to sort it out by
> agreeing with the block and iscsi folks that either
> 
>  a) we need to send down refcountable pages
>  b) block drivers need to accept kmalloced pages
> 
> I could not get any afreement, and thus we stopped using the kmalloced
> pages in XFS which was easy enough.  A bit later people fixed iscsi,
> but we still don't have formal rules about what is acceptable to the
> block layer.

It would be good to get some formal rules articulated.  Someone has
asserted that the AoE (ATA over Ethernet) driver will barf on
SLAB/kmalloc allocated memory.   True, false?

					- Ted
