From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: fix various asm-generic abuses
Date: Sat, 29 Aug 2015 15:49:37 +0200
Message-ID: <20150829134937.GA13103@lst.de>
References: <1440746842-19029-1-git-send-email-hch@lst.de>
	<22516156.tfGZvl13aG@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <22516156.tfGZvl13aG@wuerfel>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org>
List-Help: <mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=subscribe>
Sender: drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
Errors-To: drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, herbert-lOAM2aK0SrRLBo1qDEOMRrpzq4S04n8Q@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oded.gabbay-5C7GfCeVMHo@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eli-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org, james_p_freyensee-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, drbd-dev-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, mitake-uo9agqpHHEbPUJYwFPjUlCGn5s73+xxf@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Fri, Aug 28, 2015 at 09:16:51PM +0200, Arnd Bergmann wrote:
> On Friday 28 August 2015 09:27:13 Christoph Hellwig wrote:
> > This fixes two trivial classes of asm-generic abuse.  First two headers
> > that are intended for drivers are moved to include/linux, and second
> > various drivers that incorrectly use asm-generic headers directly are
> > switched over to use the proper public headers.  There are a few more
> > asm-generic abuse, but they aren't quite as trivial so they will take
> > a little more effort to fix.
> 
> Thanks a lot, these all look really useful. My normal way of dealing
> with asm-generic patches is to have changes go through the tree of
> whichever maintainer needs the changes for their own work with my
> Ack, but I guess in this case you don't actually have other patches
> depending on them, right?

No, there's nothing depending on it.

> If driver maintainers want to pick individual patches from this series,
> please add my
> 
> Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> 
> otherwise let me know if I should put them into my asm-generic git
> tree (which is currently empty, but part of linux-next).

Note that the first two are something you should probably pick up either
way as they aren't really specific to a driver.
