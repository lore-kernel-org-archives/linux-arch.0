Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268225AbUIWTHs@vger.kernel.org>
Received: from omx3-ext.sgi.com ([192.48.171.20]:4522 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268218AbUIWTHs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Sep 2004 15:07:48 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: [PATCH] I/O space write barrier
Date: Thu, 23 Sep 2004 15:07:26 -0400
References: <200409231448.21887.jbarnes@engr.sgi.com> <1095966238.3043.26.camel@mulgrave>
In-Reply-To: <1095966238.3043.26.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409231507.26672.jbarnes@engr.sgi.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-arch@vger.kernel.org, jeremy@sgi.com
List-ID: <linux-arch.vger.kernel.org>

On Thursday, September 23, 2004 3:03 pm, James Bottomley wrote:
> On Thu, 2004-09-23 at 14:48, Jesse Barnes wrote:
> > - RD_REG_WORD(&reg->ictrl); /* PCI Posted Write flush */
> > + mmiowb(); /* make sure this write arrives before any others */
>
> What's going on here?  In your docs you say this mmiowb() is explicitly
> to prevent write ordering problems and doesn't affect posting.  However
> in this patch you're using it to replace a posting flush read.

Jeremy was the one that added these, I think the comment is misleading and 
only ordering was intended.  If that's not the case I'll drop this bit.

>
> >   ha->flags.ints_enabled = 1;
>
> The result will be that we can get to here, but the write that enables
> the interrupt may still be posted in a bridge somewhere.

If we're waiting for an interrupt here, I don't think it matters if we flush 
or order, we'll wait the same amount of time regardless.

Thanks,
Jesse
