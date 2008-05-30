From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 05/37] ata: use get/put_endian helpers
Date: Thu, 29 May 2008 21:08:59 -0700
Message-ID: <20080529210859.0feee69d.akpm@linux-foundation.org>
References: <1212092282.28403.107.camel@brick>
	<483F65CA.4050507@rtr.ca>
	<20080529195225.5665ae9c.akpm@linux-foundation.org>
	<1212118661.28403.175.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <1212118661.28403.175.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, linux-arch <linux-arch@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, 29 May 2008 20:37:40 -0700 Harvey Harrison <harvey.harrison@gmail.com> wrote:

> On Thu, 2008-05-29 at 19:52 -0700, Andrew Morton wrote:
> > On Thu, 29 May 2008 22:26:18 -0400 Mark Lord <liml@rtr.ca> wrote:
> > 
> 
> > otoh,
> > 
> > - I think the args are backwards
> > 
> 
> It was made to look like put_unaligned_* and put_unaligned()
> 
> I think of it as put_le16(source, dest)

	fn(dest, src)

is a well-known C idiom which the kernel went and broke in lots of places :(

It maps nicely onto

	dest = src

as a mnemonic.

But given that the compiler will reliably barf if they are backwards
it's a minor thing.

> > - I don't like the use of the put_*() namespace.  It makes it look
> >   like a uaccess operation.
> 
> I'm flexible...although I'd probably get nailed to a cross for changing
> it again so soon. (the unaligned versions, that is)

We'll live.

(I'm not a big fan of the patches, btw.  It's more of an "oh groan,
because it's there I suppose we really ought to do this" sort of thing.
(strong objections would save me a lot of work (looks hopefully at
inbox))).
