Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S264396AbUIWUJu@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:10112 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263117AbUIWUJu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Sep 2004 16:09:50 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: [PATCH] I/O space write barrier
Date: Thu, 23 Sep 2004 16:09:33 -0400
References: <200409231448.21887.jbarnes@engr.sgi.com> <200409231507.26672.jbarnes@engr.sgi.com> <20040923195500.GA156548@sgi.com>
In-Reply-To: <20040923195500.GA156548@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409231609.33677.jbarnes@engr.sgi.com>
To: Jeremy Higdon <jeremy@sgi.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thursday, September 23, 2004 3:55 pm, Jeremy Higdon wrote:
> On Thu, Sep 23, 2004 at 03:07:26PM -0400, Jesse Barnes wrote:
> > On Thursday, September 23, 2004 3:03 pm, James Bottomley wrote:
> > > On Thu, 2004-09-23 at 14:48, Jesse Barnes wrote:
> > > > - RD_REG_WORD(&reg->ictrl); /* PCI Posted Write flush */
> > > > + mmiowb(); /* make sure this write arrives before any others */
> > >
> > > What's going on here?  In your docs you say this mmiowb() is explicitly
> > > to prevent write ordering problems and doesn't affect posting.  However
> > > in this patch you're using it to replace a posting flush read.
> >
> > Jeremy was the one that added these, I think the comment is misleading
> > and only ordering was intended.  If that's not the case I'll drop this
> > bit.
>
> No, I didn't add those.  In fact, I thought them to be unnecessary.  Jes
> added them, I believe.  I added the reads after the writes of
> req_ring_index to mailbox4.  Since at the time we did not have a write
> ordering function, I had to use the heavy weight flush.

Ok, sorry for the misattribution :).  At any rate, I've already dropped that 
bit.

Jesse
