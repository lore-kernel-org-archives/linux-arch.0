From: Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: dma_sync_*_for_cpu and direction=TO_DEVICE (was Re: [PATCH
	02/20] dma-mapping: provide a generic dma-noncoherent implementation)
Date: Fri, 18 May 2018 19:57:34 +0000
Message-ID: <182840dedb4890a88c672b1c5d556920bf89a8fb.camel@synopsys.com>
References: <20180511075945.16548-1-hch@lst.de>
	<20180511075945.16548-3-hch@lst.de>
	<bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
	<5ac5b1e3-9b96-9c7c-4dfe-f65be45ec179@synopsys.com>
	<20180518175004.GF17671@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180518175004.GF17671-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
Content-Language: en-US
Content-ID: <FBDD463EE3FC3543A056335FD62CF42C-z7JfP6tgrtVBCHUSTMH8dZqQE7yCjDx5@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org" <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org" <linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org>, "linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org" <linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org>, "Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org" <linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org>, "openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org" <openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org>, "green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, monstr@mons
List-Id: linux-arch.vger.kernel.org

Hi Russel,

On Fri, 2018-05-18 at 18:50 +0100, Russell King - ARM Linux wrote:
> It's necessary.  Take a moment to think carefully about this:
> 
>         dma_map_single(, dir)
> 
>         dma_sync_single_for_cpu(, dir)
> 
>         dma_sync_single_for_device(, dir)
> 
>         dma_unmap_single(, dir)
> 
> In the case of a DMA-incoherent architecture, the operations done at each
> stage depend on the direction argument:
> 
>         map             for_cpu         for_device      unmap
> TO_DEV  writeback       none            writeback       none
> TO_CPU  invalidate      invalidate*     invalidate      invalidate*
> BIDIR   writeback       invalidate      writeback       invalidate
> 
> * - only necessary if the CPU speculatively prefetches.

I think invalidation of DMA buffer is required on for_cpu(TO_CPU) even
if CPU doesn't preferch - what if we reuse the same buffer for multiple
reads from DMA device?

> The multiple invalidations for the TO_CPU case handles different
> conditions that can result in data corruption, and for some CPUs, all
> four are necessary.

I would agree that map()/unmap() a quite a special cases and so depending
on direction we need to execute in them either for_cpu() or for_device()
call-backs depending on direction.

As for invalidation in case of for_device(TO_CPU) I still don't see
a rationale behind it. Would be interesting to see a real example where
we benefit from this.

> This is what is implemented for 32-bit ARM, depending on the CPU
> capabilities, as we have DMA incoherent devices and we have CPUs that
> speculatively prefetch data, and so may load data into the caches while
> DMA is in operation.
> 
> 
> Things get more interesting if the implementation behind the DMA API has
> to copy data between the buffer supplied to the mapping and some DMA
> accessible buffer:
> 
>         map             for_cpu         for_device      unmap
> TO_DEV  copy to dma     none            copy to dma     none
> TO_CPU  none            copy to cpu     none            copy to cpu
> BIDIR   copy to dma     copy to cpu     copy to dma     copy to cpu
> 
> So, in both cases, the value of the direction argument defines what you
> need to do in each call.

Interesting enough in your seond table (which describes more complicated
case indeed) you set "none" for for_device(TO_CPU) which looks logical
to me.

So IMHO that's what make sense:
---------------------------->8-----------------------------
        map             for_cpu         for_device      unmap
TO_DEV  writeback       none            writeback       none
TO_CPU  none            invalidate      none            invalidate*
BIDIR   writeback       invalidate      writeback       invalidate*
---------------------------->8-----------------------------

* is the case for prefetching CPU.

-Alexey
