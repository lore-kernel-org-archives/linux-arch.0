Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268334AbUIWTlu@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:53716 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268306AbUIWTlu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Sep 2004 15:41:50 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: [PATCH] I/O space write barrier
Date: Thu, 23 Sep 2004 15:41:34 -0400
References: <200409231448.21887.jbarnes@engr.sgi.com> <200409231507.26672.jbarnes@engr.sgi.com> <1095967651.2157.42.camel@mulgrave>
In-Reply-To: <1095967651.2157.42.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409231541.34272.jbarnes@engr.sgi.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-arch@vger.kernel.org, jeremy@sgi.com
List-ID: <linux-arch.vger.kernel.org>

On Thursday, September 23, 2004 3:27 pm, James Bottomley wrote:
> On Thu, 2004-09-23 at 15:07, Jesse Barnes wrote:
> > If we're waiting for an interrupt here, I don't think it matters if we
> > flush or order, we'll wait the same amount of time regardless.
>
> I don't think so.  Your ordering barrier doesn't cause a posted write
> flush.  Posted writes have theoretically no upper limit defined in the
> spec for the time they may remain posted, so in the former case, you are
> guaranteed that by the time you set the flag and exit the function that
> interrupts are enabled in the qla1280.

Ok, you're right we don't want to break that.  I just didn't think it was that 
important for the driver to think that interrupts were enabled even when they 
weren't since it would probably do another read sometime soon anyway, but 
that's sloppy, so I'll just drop this bit.

Thanks,
Jesse
