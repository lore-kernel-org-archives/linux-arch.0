From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 05/37] ata: use get/put_endian helpers
Date: Fri, 30 May 2008 14:10:47 +1000
Message-ID: <18495.32327.521211.508818@cargo.ozlabs.ibm.com>
References: <1212092282.28403.107.camel@brick>
	<483F65CA.4050507@rtr.ca>
	<20080529195225.5665ae9c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20080529195225.5665ae9c.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Lord <liml@rtr.ca>, Harvey Harrison <harvey.harrison@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Andrew Morton writes:

> On Thu, 29 May 2008 22:26:18 -0400 Mark Lord <liml@rtr.ca> wrote:
> 
> > Harvey Harrison wrote:
> > > Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> > > ---
> > >  drivers/ata/pdc_adma.c   |   12 ++++++------
> > >  drivers/ata/sata_qstor.c |   12 +++++-------
> > >  2 files changed, 11 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
> > > index be53545..162eecb 100644
> > > --- a/drivers/ata/pdc_adma.c
> > > +++ b/drivers/ata/pdc_adma.c
> > > @@ -284,11 +284,11 @@ static int adma_fill_sg(struct ata_queued_cmd *qc)
> > >  		u32 len;
> > >  
> > >  		addr = (u32)sg_dma_address(sg);
> > > -		*(__le32 *)(buf + i) = cpu_to_le32(addr);
> > > +		put_le32(addr, (__le32 *)(buf + i));
> > ..
> > 
> > I don't get it.
> > 
> > What's the point here?
> 
> Readability and maintainability.  Once one becomes familar with a
> particular idion like this you can read it and say "ah, I know what
> that's doing" rather than having to peer at every character and work it
> out at each site where it happens.
> 
> As usual: a PITA now, but better long-term.
> 
> otoh,
> 
> - I think the args are backwards

I think you just admitted that the new version is less readable.  At
least with an '=' operator you know which side is the thing that's
being modified.  With a put_XXX function, I would have to go look up
the definition (particularly since outb et al. are also the wrong way
around, i.e. have the destination as the second argument).

> - I don't like the use of the put_*() namespace.  It makes it look
>   like a uaccess operation.

Plus we have a common idiom that get_*() functions increment some sort
of reference count, and put_*() functions decrease a reference count
and may free something...

Paul.
