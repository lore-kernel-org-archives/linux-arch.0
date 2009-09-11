Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:60136 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752790AbZIKVhJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 11 Sep 2009 17:37:09 -0400
Subject: Re: [PATCH 0/6] fix xfs by making I/O to vmap/vmalloc areas work
From: James Bottomley <James.Bottomley@suse.de>
In-Reply-To: <20090910061422.GA31781@console-pimps.org>
References: <1252511536-22066-1-git-send-email-James.Bottomley@suse.de>
	 <20090910061422.GA31781@console-pimps.org>
Content-Type: text/plain
Date: Fri, 11 Sep 2009 21:37:03 +0000
Message-ID: <1252705023.13282.66.camel@mulgrave.site>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Fleming <matt@console-pimps.org>
Cc: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Paul Mundt <lethal@linux-sh.org>
Message-ID: <20090911213703.LVhdcD7cWxLQcKVo0pLAV1H58w-OM3mFniIOdDyqdMQ@z>

On Thu, 2009-09-10 at 07:14 +0100, Matt Fleming wrote:
> On Wed, Sep 09, 2009 at 10:52:10AM -0500, James Bottomley wrote:
> > Here's version two of the patch set.  It actually compiles on both x86
> > and parisc.  I could do with someone to test it on arm and sh.
> > 
> > The key test is how xfs behaves.  What I did to recreate the problem
> > on parisc was simply create an 8GB xfs filesystem, use cp -a to pump
> > about a GB of data into it from my git trees, then unmount and run
> > xfs_check.  Before the patches, xfs_check reports the whole fs to be
> > corrupt.  After the patches it reports everything to be OK.
> > 
> > James
> > 
> 
> I'm seeing some corruption with these patches on SH and a 4GB XFS
> filesystem. However, I am currently seeing other cache aliasing issues
> on this board anyway. I'll do some more analysis tonight, unless Paul
> can prove it's just my setup being weird again.

Did some debug checking, and it turns out that the invalidation logic is
bogus (the bio parameters get updated before the request completes).  Of
course, we wouldn't see this on parisc because we don't require
invalidation ....

I'll try to fix and then repost.

Thanks for testing.

James


