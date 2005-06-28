Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 28 Jun 2005 18:14:14 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: RFC: is_compat_task (Was: Re: input compat stuff)
Message-ID: <20050628161414.GP8035@wotan.suse.de>
References: <20050628072710.GA29916@lst.de> <20050628181453.387e0fac.sfr@canb.auug.org.au> <20050628091704.GP4171@wotan.suse.de> <20050629020944.1af20657.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050629020944.1af20657.sfr@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andi Kleen <ak@suse.de>, hch@lst.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Jun 29, 2005 at 02:09:44AM +1000, Stephen Rothwell wrote:
> On Tue, 28 Jun 2005 11:17:04 +0200 Andi Kleen <ak@suse.de> wrote:
> >
> > On Tue, Jun 28, 2005 at 06:14:53PM +1000, Stephen Rothwell wrote:
> > > On Tue, 28 Jun 2005 09:27:10 +0200 Christoph Hellwig <hch@lst.de> wrote:
> > > >
> > > > besides this beeing butt ugly didn't we have a rule about never checking
> > > > task flags whether we're a compat process?  And if we're going to allow
> > > > it it should be done properly.
> > > 
> > > So, I have been thinking about this patch for a while (wondering how badly
> > > flamed I would get when I posted it :-)).  What do you all think?  Is this
> > > a reasonable thing to do?
> > 
> > No, it's not because it makes it impossible to have 64bit processes
> > that run with 32bit ABI (not implemented right now but we don't
> > want to break that).
> 
> Why does this make it impossible?  All I am defining is *arch specific*
> macros that tell us if the kernel was entered through a compat syscall. If

No, you're defining an arch specific macro to tell you that
the current process was loaded from a 32bit executable.
It does not tell you anything how the kernel was entered.

Subtle but important difference.

> 
> > Please don't do this. It is absolutely the wrong thing to do.
> 
> Then please tell us what the right thing to do is.

The right thing to do is what all the other non broken compat
functions do - figure out from the original system call entry
point if you're in compat context or not.

This typically requires a special path.

-Andi
