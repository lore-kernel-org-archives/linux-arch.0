Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S264443AbUIWT6G@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:58851 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264396AbUIWT6F (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Sep 2004 15:58:05 -0400
Date: Thu, 23 Sep 2004 12:57:59 -0700
From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH] I/O space write barrier
Message-ID: <20040923195759.GB156548@sgi.com>
References: <200409231448.21887.jbarnes@engr.sgi.com> <1095966238.3043.26.camel@mulgrave> <200409231507.26672.jbarnes@engr.sgi.com> <1095967651.2157.42.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095967651.2157.42.camel@mulgrave>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Sep 23, 2004 at 03:27:24PM -0400, James Bottomley wrote:
> On Thu, 2004-09-23 at 15:07, Jesse Barnes wrote:
> > If we're waiting for an interrupt here, I don't think it matters if we flush 
> > or order, we'll wait the same amount of time regardless.
> 
> I don't think so.  Your ordering barrier doesn't cause a posted write
> flush.  Posted writes have theoretically no upper limit defined in the
> spec for the time they may remain posted, so in the former case, you are
> guaranteed that by the time you set the flag and exit the function that
> interrupts are enabled in the qla1280.  If you apply the patch you sent
> in, this guarantee is broken and you don't really know how much longer
> after exiting the function it will be before interrupts become enabled
> (although in practice it's probably only of the order of ms).
> 
> James

I would say microseconds.  I think that knowing that the hardware has
interrupts enabled by the end of the function is unnecessary, because
they will be enabled before you can do anything else to the chip.
But it shouldn't hurt anything either, and defensive programming in
old SCSI drivers is often a good idea  :-)
