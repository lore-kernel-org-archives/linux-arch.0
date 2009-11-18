Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:60632 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756638AbZKROPt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Nov 2009 09:15:49 -0500
Date: Wed, 18 Nov 2009 23:15:48 +0900
Subject: Re: [PATCH 5/6] block: permit I/O to vmalloc/vmap kernel pages
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1258552240.2540.0.camel@mulgrave.site>
References: <1258477432-2513-6-git-send-email-James.Bottomley@suse.de>
	<20091118191031Q.fujita.tomonori@lab.ntt.co.jp>
	<1258552240.2540.0.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <20091118231538D.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James.Bottomley@suse.de
Cc: fujita.tomonori@lab.ntt.co.jp, linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org
Message-ID: <20091118141548.P_ssFTPdS4OQiwgVV8OVQXjIGyf7xCpLU6o-m3ouwOM@z>

On Wed, 18 Nov 2009 08:50:40 -0500
James Bottomley <James.Bottomley@suse.de> wrote:

> On Wed, 2009-11-18 at 19:10 +0900, FUJITA Tomonori wrote:
> > On Tue, 17 Nov 2009 11:03:51 -0600
> > James Bottomley <James.Bottomley@suse.de> wrote:
> > 
> > > This updates bio_map_kern() to check for pages in the vmalloc address
> > > range and call the new kernel flushing APIs if the are.  This should
> > > allow any kernel user to pass a vmalloc/vmap area to block.
> > >
> > > Signed-off-by: James Bottomley <James.Bottomley@suse.de>
> > > ---
> > >  fs/bio.c |   20 ++++++++++++++++++--
> > >  1 files changed, 18 insertions(+), 2 deletions(-)
> > 
> > Do we need this?
> > 
> > Buffers that xfs_buf.c passes to block doesn't go to bio_map_kern()?
> 
> For completeness, yes ... because xfs *should* be passing its buffers to
> bio_map_kern() ... it just happens to roll its own.

Ok, you mean that we will convert XFS to use bio_map_kern().

But adding another trick to bio_map_kern() to handle a vmalloc/vmap
area is a good move? Only XFS do such, right?
