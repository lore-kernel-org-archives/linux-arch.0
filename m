From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [PATCH 0/6] fix xfs by making I/O to vmap/vmalloc areas work
Date: Fri, 11 Sep 2009 21:37:03 +0000
Message-ID: <1252705023.13282.66.camel@mulgrave.site>
References: <1252511536-22066-1-git-send-email-James.Bottomley@suse.de>
	 <20090910061422.GA31781@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20090910061422.GA31781@console-pimps.org>
Sender: linux-parisc-owner@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-arch.vger.kernel.org

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


