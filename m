From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Fri, 30 Nov 2018 14:17:42 +1100
Message-ID: <53c18168393e3134f7e4120a2528f972b1002c01.camel@kernel.crashing.org>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181127074253.GB30186-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Tue, 2018-11-27 at 08:42 +0100, Christoph Hellwig wrote:
> Any comments?  I'd like to at least get the ball moving on the easy
> bits.

So I had to cleanup some dust but it works on G5 with and without iommu
and 32-bit powermacs at least.

We're doing more tests, hopefully mpe can dig out some PASemi and
NXP/FSL HW as well. I'll try to review & ack the patches over the next
few days too.

Cheers,
Ben.

> On Wed, Nov 14, 2018 at 09:22:40AM +0100, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series switches the powerpc port to use the generic swiotlb and
> > noncoherent dma ops, and to use more generic code for the coherent
> > direct mapping, as well as removing a lot of dead code.
> > 
> > As this series is very large and depends on the dma-mapping tree I've
> > also published a git tree:
> > 
> >     git://git.infradead.org/users/hch/misc.git powerpc-dma.4
> > 
> > Gitweb:
> > 
> >     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.4
> > 
> > Changes since v3:
> >  - rebase on the powerpc fixes tree
> >  - add a new patch to actually make the baseline amigaone config
> >    configure without warnings
> >  - only use ZONE_DMA for 64-bit embedded CPUs, on pseries an IOMMU is
> >    always present
> >  - fix compile in mem.c for one configuration
> >  - drop the full npu removal for now, will be resent separately
> >  - a few git bisection fixes
> > 
> > The changes since v1 are to big to list and v2 was not posted in public.
> > 
> > _______________________________________________
> > iommu mailing list
> > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> ---end quoted text---
