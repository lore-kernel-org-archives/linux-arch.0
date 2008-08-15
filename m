From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: drivers/usb/musb/musb_io.h
Date: Fri, 15 Aug 2008 12:23:50 +0300
Message-ID: <20080815092350.GL16231@frodo>
References: <20080814215200.27f79a59.akpm@linux-foundation.org> <20080815073750.GG16231@frodo> <20080815074318.GH16231@frodo> <20080815010227.121e5e4b.akpm@linux-foundation.org> <20080815081154.GJ16231@frodo> <20080815013148.b9dfc7ad.akpm@linux-foundation.org> <20080815085247.GK16231@frodo> <20080815021131.dfab416a.akpm@linux-foundation.org>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:54451 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbYHOJYA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Aug 2008 05:24:00 -0400
Content-Disposition: inline
In-Reply-To: <20080815021131.dfab416a.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: me@felipebalbi.com, Felipe Balbi <felipe.balbi@nokia.com>, linux-usb@vger.kernel.org, linux-arch@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>

On Fri, Aug 15, 2008 at 02:11:31AM -0700, Andrew Morton wrote:
> On Fri, 15 Aug 2008 11:52:48 +0300 Felipe Balbi <me@felipebalbi.com> wrote:
> 
> > Wonder if it's possible to have the above patch applied so I can get rid
> > of those stubs in musb_io.h
> 
> Someone would need to take care of it and document it and repair all
> those driver which broke because they went and created private copies.
> 
> I could do some of that but I'm stuck at step #1.  What the heck _are_
> these things?  Why do they exist?  What are their semantics?
> 
> The arm implementation says
> 
>  * Generic IO read/write.  These perform native-endian accesses.  Note
>  * that some architectures will want to re-define __raw_{read,write}w.
> 
> which is somewhat clear as mud.  I'd guess that these are the MMIO
> partners to insl and friends?
> 
> And then it has
> 
> extern void __raw_writesb(void __iomem *addr, const void *data, int bytelen);
> extern void __raw_writesw(void __iomem *addr, const void *data, int wordlen);
> extern void __raw_writesl(void __iomem *addr, const void *data, int longlen);
> 
> which is a bit odd.  I assume that "bytelen" should have been
> "bytecount" or similar.

Clearing that out is as easy as asking Russel King for more details.

Russel, do you have any comments to the above ?

-- 
balbi
