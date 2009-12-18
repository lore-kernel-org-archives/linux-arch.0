From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [git patches] xfs and block fixes for virtually indexed arches
Date: Fri, 18 Dec 2009 19:24:12 +0900
Message-ID: <20091218192401D.fujita.tomonori@lab.ntt.co.jp>
References: <1261120128.3013.8.camel@mulgrave.site>
	<20091218183353I.fujita.tomonori@lab.ntt.co.jp>
	<1261130489.3013.41.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:51568 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900AbZLRKZM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 Dec 2009 05:25:12 -0500
In-Reply-To: <1261130489.3013.41.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James.Bottomley@suse.de
Cc: fujita.tomonori@lab.ntt.co.jp, jens.axboe@oracle.com, torvalds@linux-foundation.org, tytso@mit.edu, kyle@mcmartin.ca, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, hch@infradead.org, linux-arch@vger.kernel.org

On Fri, 18 Dec 2009 11:01:29 +0100
James Bottomley <James.Bottomley@suse.de> wrote:

> > Yeah, but now only XFS passes vmap'ed pages to the block layer. Isn't
> > it better to wait until we have real users of the API?
> 
> XFS is a real user ... the XFS filesystem is our most trusted code base
> that can break the 8TB limit, which hard disks are already at.  Ext4 may
> be ready, but it's not universally present in enterprise distros like
> XFS.

XFS already has the own code to handle that, which works fine (with
your patchset except for 5/6 for the block layer). Not much motivation
for XFS to move to the generic API?


> > > That would ensure the architecturally
> > > correct flushing of the aliases, and would satisfy the expectations of
> > > blk_rq_map_kern().  The down side is that vmap/vmalloc set up and clear
> > > page tables, which isn't necessary and might impact performance (xfs
> > > people?)
> > 
> > btw, I'm not sure that the existing blk_rq_map_* API isn't fit well to
> > file systems since blk_rq_map_user and blk_rq_map_kern takes a request
> > structure.
> 
> OK, so that was illustrative.  The meat of the change is at the bio
> layer anyway (fss tend to speak bios).

Yeah, I think so, it's up to Jens to add new APIs for vmap there.
