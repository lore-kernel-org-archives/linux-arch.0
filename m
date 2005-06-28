Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 28 Jun 2005 11:17:04 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: RFC: is_compat_task (Was: Re: input compat stuff)
Message-ID: <20050628091704.GP4171@wotan.suse.de>
References: <20050628072710.GA29916@lst.de> <20050628181453.387e0fac.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628181453.387e0fac.sfr@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org, linux-kernel@vger.kernel.rg, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jun 28, 2005 at 06:14:53PM +1000, Stephen Rothwell wrote:
> On Tue, 28 Jun 2005 09:27:10 +0200 Christoph Hellwig <hch@lst.de> wrote:
> >
> > besides this beeing butt ugly didn't we have a rule about never checking
> > task flags whether we're a compat process?  And if we're going to allow
> > it it should be done properly.
> 
> So, I have been thinking about this patch for a while (wondering how badly
> flamed I would get when I posted it :-)).  What do you all think?  Is this
> a reasonable thing to do?

No, it's not because it makes it impossible to have 64bit processes
that run with 32bit ABI (not implemented right now but we don't
want to break that).

Please don't do this. It is absolutely the wrong thing to do.

-Andi
