From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 05/37] ata: use get/put_endian helpers
Date: Thu, 29 May 2008 19:52:25 -0700
Message-ID: <20080529195225.5665ae9c.akpm@linux-foundation.org>
References: <1212092282.28403.107.camel@brick>
	<483F65CA.4050507@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60646 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750934AbYE3Cwi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 29 May 2008 22:52:38 -0400
In-Reply-To: <483F65CA.4050507@rtr.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Lord <liml@rtr.ca>
Cc: Harvey Harrison <harvey.harrison@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>

On Thu, 29 May 2008 22:26:18 -0400 Mark Lord <liml@rtr.ca> wrote:

> Harvey Harrison wrote:
> > Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> > ---
> >  drivers/ata/pdc_adma.c   |   12 ++++++------
> >  drivers/ata/sata_qstor.c |   12 +++++-------
> >  2 files changed, 11 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
> > index be53545..162eecb 100644
> > --- a/drivers/ata/pdc_adma.c
> > +++ b/drivers/ata/pdc_adma.c
> > @@ -284,11 +284,11 @@ static int adma_fill_sg(struct ata_queued_cmd *qc)
> >  		u32 len;
> >  
> >  		addr = (u32)sg_dma_address(sg);
> > -		*(__le32 *)(buf + i) = cpu_to_le32(addr);
> > +		put_le32(addr, (__le32 *)(buf + i));
> ..
> 
> I don't get it.
> 
> What's the point here?

Readability and maintainability.  Once one becomes familar with a
particular idion like this you can read it and say "ah, I know what
that's doing" rather than having to peer at every character and work it
out at each site where it happens.

As usual: a PITA now, but better long-term.

otoh,

- I think the args are backwards

- I don't like the use of the put_*() namespace.  It makes it look
  like a uaccess operation.
