From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/34] powerpc: use mm zones more sensibly
Date: Fri, 7 Dec 2018 15:09:10 +0100
Message-ID: <20181207140910.GA23609@lst.de>
References: <20181114082314.8965-1-hch@lst.de> <20181114082314.8965-2-hch@lst.de> <20181206140948.GB29741@infradead.org> <87sgz9jzsl.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87sgz9jzsl.fsf@concordia.ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christoph Hellwig <hch@infradead.org>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Dec 07, 2018 at 11:18:18PM +1100, Michael Ellerman wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> 
> > Ben / Michael,
> >
> > can we get this one queued up for 4.21 to prepare for the DMA work later
> > on?
> 
> I was hoping the PASEMI / NXP regressions could be solved before
> merging.
> 
> My p5020ds is booting fine with this series, so I'm not sure why it's
> causing problems on Christian's machine.
> 
> The last time I turned on my PASEMI board it tripped some breakers, so I
> need to investigate that before I can help test that.
> 
> I'll see how things look on Monday and either merge the commits you
> identified or the whole series depending on if there's any more info
> from Christian.

Christian just confirmed everything up to at least
"powerpc/dma: stop overriding dma_get_required_mask" works for his
setups.
