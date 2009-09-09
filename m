From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 6/6] xfs: fix xfs to work with Virtually Indexed
	architectures
Date: Wed, 9 Sep 2009 13:55:41 -0400
Message-ID: <20090909175541.GA9766@infradead.org>
References: <1252511536-22066-1-git-send-email-James.Bottomley@suse.de> <1252511536-22066-2-git-send-email-James.Bottomley@suse.de> <1252511536-22066-3-git-send-email-James.Bottomley@suse.de> <1252511536-22066-4-git-send-email-James.Bottomley@suse.de> <1252511536-22066-5-git-send-email-James.Bottomley@suse.de> <1252511536-22066-6-git-send-email-James.Bottomley@suse.de> <1252511536-22066-7-git-send-email-James.Bottomley@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1252511536-22066-7-git-send-email-James.Bottomley@suse.de>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 09, 2009 at 10:52:16AM -0500, James Bottomley wrote:
> xfs_buf.c includes what is essentially a hand rolled version of
> blk_rq_map_kern().  In order to work properly with the vmalloc buffers
> that xfs uses, this hand rolled routine must also implement the flushing
> API for vmap/vmalloc areas.

It's not really a handcrafted version of blk_rq_map_kern because it
can add discontinuous into a single bio.

The patches look fine to (not pretty but fine :)), and I'll make sure
they get added once those two helpers made it, probably augmented by
a comment explaining what's going on here.

