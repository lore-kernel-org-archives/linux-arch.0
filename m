Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:34419 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755450AbZLRDwO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Dec 2009 22:52:14 -0500
Date: Fri, 18 Dec 2009 12:51:15 +0900
Subject: Re: [git patches] xfs and block fixes for virtually indexed arches
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20091218024440.GG4850@discord.disaster>
References: <1261094220.2752.27.camel@mulgrave.site>
	<20091218095944G.fujita.tomonori@lab.ntt.co.jp>
	<20091218024440.GG4850@discord.disaster>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <20091218125047U.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: david@fromorbit.com
Cc: fujita.tomonori@lab.ntt.co.jp, James.Bottomley@suse.de, jens.axboe@oracle.com, torvalds@linux-foundation.org, tytso@mit.edu, kyle@mcmartin.ca, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, hch@infradead.org, linux-arch@vger.kernel.org
Message-ID: <20091218035115.zRXidSWJar33Qfr6Ekz0esCTqsd7jQtdJtT-Tvw3SvU@z>

On Fri, 18 Dec 2009 13:44:40 +1100
Dave Chinner <david@fromorbit.com> wrote:

> > > So it sounds like we only need a blk_rq_map_vmalloc() using the same
> > > techniques as the patch set and we're good to go.
> > 
> > I'm not sure about it.
> > 
> > As I said before (when I was against this 'adding vmalloc support to
> > the block layer' stuff), are there potential users of this except for
> > XFS? Are there anyone who does such a thing now?
> 
> As Christoph already mentioned, XFS is not passing the vmalloc'd
> range to the block layer

Oops, I should have said a vmalloc/vmap area.


> > This API might be useful for only journaling file systems using log
> > formats that need large contiguous buffer. Sound like only XFS?
> 
> FWIW, mapped buffers larger than PAGE_SIZE are used for more than just log
> recovery in XFS. e.g. filesystems with directory block size larger
> than page size uses mapped buffers.

I see, thanks.
