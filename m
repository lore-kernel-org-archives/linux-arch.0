Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268848AbUIQPcc@vger.kernel.org>
Received: from zeus.kernel.org ([204.152.189.113]:9099 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S268900AbUIQPbr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Sep 2004 11:31:47 -0400
Received: from omx3.sgi.com (omx3-ext.sgi.com [192.48.171.20])
	by zeus.kernel.org (8.12.11/8.11.6) with ESMTP id i8HFViO4028106
	for <linux-arch@vger.kernel.org>; Fri, 17 Sep 2004 08:31:44 -0700
From: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: RFC: being more anal about iospace accesses..
Date: Fri, 17 Sep 2004 08:30:19 -0700
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <200409161152.54691.jbarnes@engr.sgi.com> <1095398253.5108.38.camel@gaston>
In-Reply-To: <1095398253.5108.38.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409170830.19090.jbarnes@engr.sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Matthew Wilcox <willy@debian.org>, James Bottomley <James.Bottomley@steeleye.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Arch list <linux-arch@vger.kernel.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>

On Thursday, September 16, 2004 10:17 pm, Benjamin Herrenschmidt wrote:
> Hrm... that's weird... on sane DMA hardward, most PIO/MMIO reads are
> actually here just to guarantee that completion, interrupts isn't enough
> especially if we do things like polling (NAPI) etc... besides,
> interrupts are usually totally asynchronous to anything else, so I
> wouldn't say it's sane.

Well, it can definitely be problematic.  Devices that want to complete more 
than one transaction per interrupt have always been troublesome on sn 
platforms.

>
> > Sure, that's the way I'd like to go, but that's a dangerous route. 
> > Devices that want to do a PIO read to see if their DMA is complete will
> > work most of the time, but you'll get occasional data corruption.  IOW,
> > specifying reads that you know *aren't* dependent is much easier to do,
> > and safer.  It also allows SGI hardware to run all current drivers w/o
> > modification, which is nice.
>
> Agreed. Reads must NOT be relaxed by default

At least not for the current interface, but maybe for the new one.  The 
proposed dma_sync interface could take both an iomem address *and* a device 
if that would make it easier (it would for us).

Jesse
