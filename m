From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH] mm: Pass virtual address to
 [__]p{te,ud,md}_free_tlb()
Date: Wed, 22 Jul 2009 09:31:54 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907220930320.19335@localhost.localdomain>
References: <20090715074952.A36C7DDDB2@ozlabs.org>  <20090715135620.GD7298@wotan.suse.de> <1248073873.13067.31.camel@pasglop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1248073873.13067.31.camel@pasglop>
Sender: owner-linux-mm@kvack.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nick Piggin <npiggin@suse.de>, Linux Memory Management <linux-mm@kvack.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Hugh Dickins <hugh@tiscali.co.uk>
List-Id: linux-arch.vger.kernel.org



On Mon, 20 Jul 2009, Benjamin Herrenschmidt wrote:

> On Wed, 2009-07-15 at 15:56 +0200, Nick Piggin wrote:
> > > I would like to merge the new support that depends on this in 2.6.32,
> > > so unless there's major objections, I'd like this to go in early during
> > > the merge window. We can sort out separately how to carry the patch
> > > around in -next until then since the powerpc tree will have a dependency
> > > on it.
> > 
> > Can't see any problem with that.
> 
> CC'ing Linus here. How do you want to proceed with that merge ? (IE. so
> far nobody objected to the patch itself)

Maybe you can put it as a separate branch in -next, and have it merged 
before the stuff that depends on it, and then just sending it to me (as a 
git branch or patch or whatever) in the first day of the merge window?

		Linus

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
