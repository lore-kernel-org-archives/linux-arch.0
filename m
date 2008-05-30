From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 05/37] ata: use get/put_endian helpers
Date: Thu, 29 May 2008 22:04:50 -0700
Message-ID: <20080529220450.2f701d93.akpm@linux-foundation.org>
References: <1212092282.28403.107.camel@brick>
	<483F65CA.4050507@rtr.ca>
	<20080529195225.5665ae9c.akpm@linux-foundation.org>
	<18495.32327.521211.508818@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <18495.32327.521211.508818@cargo.ozlabs.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: Mark Lord <liml@rtr.ca>, Harvey Harrison <harvey.harrison@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, 30 May 2008 14:10:47 +1000 Paul Mackerras <paulus@samba.org> wrote:

> > > What's the point here?
> > 
> > Readability and maintainability.  Once one becomes familar with a
> > particular idion like this you can read it and say "ah, I know what
> > that's doing" rather than having to peer at every character and work it
> > out at each site where it happens.
> > 
> > As usual: a PITA now, but better long-term.
> > 
> > otoh,
> > 
> > - I think the args are backwards
> 
> I think you just admitted that the new version is less readable.  At
> least with an '=' operator you know which side is the thing that's
> being modified.  With a put_XXX function, I would have to go look up
> the definition (particularly since outb et al. are also the wrong way
> around, i.e. have the destination as the second argument).

Well yes, but you don't have to worry about that when reviewing because
you know the compiler will catch reversals.

Still not terribly keen about it all, but geeze the code which it is
trying to clarify is godawful:

	*(__le32 *)(buf + i) = cpu_to_le32(addr);

wtf?

Then again the replacement

	put_le32(addr, (__le32 *)(buf + i));

is still wtf.

