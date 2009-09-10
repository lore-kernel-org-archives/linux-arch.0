From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH 0/6] fix xfs by making I/O to vmap/vmalloc areas work
Date: Thu, 10 Sep 2009 07:14:24 +0100
Message-ID: <20090910061422.GA31781@console-pimps.org>
References: <1252511536-22066-1-git-send-email-James.Bottomley@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1252511536-22066-1-git-send-email-James.Bottomley@suse.de>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 09, 2009 at 10:52:10AM -0500, James Bottomley wrote:
> Here's version two of the patch set.  It actually compiles on both x86
> and parisc.  I could do with someone to test it on arm and sh.
> 
> The key test is how xfs behaves.  What I did to recreate the problem
> on parisc was simply create an 8GB xfs filesystem, use cp -a to pump
> about a GB of data into it from my git trees, then unmount and run
> xfs_check.  Before the patches, xfs_check reports the whole fs to be
> corrupt.  After the patches it reports everything to be OK.
> 
> James
> 

I'm seeing some corruption with these patches on SH and a 4GB XFS
filesystem. However, I am currently seeing other cache aliasing issues
on this board anyway. I'll do some more analysis tonight, unless Paul
can prove it's just my setup being weird again.
