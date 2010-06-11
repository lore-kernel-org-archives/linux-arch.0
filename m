From: Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH v2] sata_sil24: Use memory barriers before issuing
 commands
Date: Fri, 11 Jun 2010 20:11:17 +1000
Message-ID: <20100611101117.GD16436@laptop>
References: <20100611013829.GB16436@laptop>
 <1276249306.12258.38.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1276249306.12258.38.camel@e102109-lin.cambridge.arm.com>
Sender: linux-ide-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Colin Tuckley <colin.tuckley@arm.com>, Jeff Garzik <jeff@garzik.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Jun 11, 2010 at 10:41:46AM +0100, Catalin Marinas wrote:
> On Fri, 2010-06-11 at 02:38 +0100, Nick Piggin wrote:
> > On Thu, Jun 10, 2010 at 06:43:03PM -0600, Robert Hancock wrote:
> > > IMHO, it would be better for the platform code to ensure that MMIO
> > > access was strongly ordered with respect to each other and to RAM
> > > access. Drivers are just too likely to get this wrong, especially
> > > when x86, the most tested platform, doesn't have such issues.
> > 
> > The plan is to make all platforms do this. writes should be
> > strongly ordered with memory. That serves to keep them inside
> > critical sections as well.
> 
> Are there any public references to this discussion? Maybe a
> Documentation/ file (or update the memory-barriers.txt one would be
> useful).

It was on the mailing list, don't have a ref off the top of my
head. Primarily between the ia64 and powerpc people and myself
IIRC.

They thought it would also be too expensive to do, but it turned
out not to be noticable with a few simple tests. It will obviously
depend on a lot of factors...

Also I think most high performance drivers tend to have just a few
critical mmios so they should be able to be identified and improved
relatively easily (relatively, as in: much  more easily than trying to
find all the obscure ordering problems).

So anyway powerpc were reluctant because they try to fix it in their
spinlocks, but I demonstrated that there were drivers using mutexes
and other synchronization and found one or two broken ones in the
first place I looked.

 
> I guess correctness takes precedence here but on ARM, the only way to
> ensure relative ordering between non-cacheable writes and I/O writes is
> by flushing the write buffer (and an L2 write buffer if external cache
> is present). Hence the expensive mb().

Default IO accessors would be a little more expensive, yes.

 
> The only reference of DMA buffers vs I/O I found in the DMA-API.txt
> file:
> 
>         Consistent memory is memory for which a write by either the
>         device or the processor can immediately be read by the processor
>         or device without having to worry about caching effects. (You
>         may however need to make sure to flush the processor's write
>         buffers before telling devices to read that memory.)
> 
> But there is no API for "flushing the processor's write buffers". Does
> it mean that this should be taken care of in writel()? We would make the
> I/O accessors pretty expensive on some architectures.

The APIs for that are mb/wmb/rmb ones.


