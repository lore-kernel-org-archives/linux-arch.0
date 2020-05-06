From: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Subject: Re: RFC: Adding arch-specific user ABI documentation in linux-man
Date: Wed, 6 May 2020 15:29:42 +0100
Message-ID: <20200506142942.GV30377@arm.com>
References: <20200504153214.GH30377@arm.com>
 <07855941-d0f7-2ec6-819e-e43a8935e29e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <07855941-d0f7-2ec6-819e-e43a8935e29e-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Michael Kerrisk (man-pages)" <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-5wv7dgnIgG8@public.gmane.org>, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Wed, May 06, 2020 at 12:47:17PM +0200, Michael Kerrisk (man-pages) wrote:
> Hello Dave, et al.
> 
> On 5/4/20 5:32 PM, Dave Martin wrote:
> > Hi all,
> > 
> > I considering trying to plug some gaps in the arch-specific ABI
> > documentation in the linux man-pages, specifically for arm64 (and
> > possibly arm, where compat means we have some overlap).
> 
> Sounds good to me.
> 
> > For arm64, there are now significant new extensions (Pointer
> > authentication, SVE, MTE etc.)  Currently there is some user-facing
> > documentation mixed in with the kernel-facing documentation in the
> > kernel tree, but this situation isn't ideal.
> > 
> > Do you have an opinion on where in the man-pages documentation should be
> > added, and how to structure it?
> > 
> > 
> > Affected areas include:
> > 
> >  * exec interface
> 
> Not sure what the details are here, so I have no opinion yet.
> But probably, as additions to execve(2).

Having looked at that page again, probably yes.

This would include things like how arch-specific registers get reset,
and how various thread properties are reset/inherited.

Possibly, much of this would be documented by cross-referencing other
pages.

> 
> >  * aux vector, hwcaps
> 
> ==> getauxval(3)

Ah, yes.  I keep forgetting that because it's provided by libc.

There are a few things missing, but we can add them in there.

> >  * arch-specific signals
> >  * signal frame
> 
> Not sure what the details are here, so I have no opinion yet.

Stuff like architecture-specific si_codes and how they are used.

Signal handlers that poke about in the signal frame need to know how it
is structured, and for arm64 this is now quite complex.  I want to
document some example code for parsing it somewhere, and I feel that
will be too much noise for signal(7).

I guess I can try to write something and than we can figure out where to
put it.

> 
> >  * mmap/mprotect extensions
> 
> See below.
> 
> >  * prctl calls
> 
> As additions in prctl(2) would be fine, I think.
> 
> >  * ptrace quirks and extensions
> 
> See below.
> 
> >  * coredump contents
> 
> Not sure what the details are here, so I have no opinion yet.
> Possibly as additions to core(5).

Things like arch-specific regsets.  Some of that can probabably live
in the ptrace page, with cross-references from core(5).

> > Not everything has an obvious home in an existing page, 
> 
> Yes.
> 
> > and adding
> > specifics for every architecture could make some existing manpages very
> > unwieldy.
> 
> Still, I think it's worth adding details, especially for widely
> used architectures.

Agreed.  If there's a lot of explanation required for somethings which
feels out of scope for the core page, then I might still be tempted to
push some of that out into a more arch-specific page and cross-reference
it.  We can play that by ear, though.

> > I think for some arch features, we really need some "overview" pages
> > too: just documenting the low-level details is of limited value
> > without some guide as to how to use them together.
> > 
> > 
> > Does the following sketch look reasonable?
> > 
> >  * man7/arm64.7: new page: overview of arm64-specific ABI extensions
> 
> I'm a little unclear on what would land in here, but sounds 
> reasonable in principle.

I probably won't attempt to add such a page until I find a use for it.

I mainly intended this as an overview of what areas are impacted by the
architecture and which other pages to go look at.

> >  * man7/sve.7 (or man7/arm64-sve.7 or man7/sve.7arm64): new page:
> >    overview of arm64 SVE ABI
> 
> Sounds reasonable to me.
> 
> >  * man2/arm64-ptrace.2 (or man2/ptrace.2arm64): new page:
> >    arm64 ptrace extensions
> 
> I think maybe better is: ptrace-arm64.2

Agreed.  That's probably easier to for people to place in their mental
map.

> 
> I'm agnostic about whether there should be a new page, or whether 
> these should be added to ptrace(2). But, we could start with the
> idea of a new page.
> 
> >  * man2/mmap.2: extend with arm64-specific flags (only two flags, so we
> >    add them to the existing man page rather than creating a new one).
> 
> Sounds good to me
> 
> > etc.
> > 
> > 
> > Ideally, I'd like to adopt a pattern that other arches can follow.
> 
> Well, if they do follow. Arch-specific documentation is woefully
> thin at the moment. I'm not going to worry too much about the right
> pattern (don't let perfect get in the way of good, yadda, yadda),
> until I get so much arch-specific documentation that some refactoring
> may be required. (I'm not going to hold my breath waiting for that
> to happen ;-).)

Sure.  I don't want to do something obviously broken, but it sounds like
you're reasonably happy with my approach.  In any case I'll start with the
simple stuff.

Where it's easy to do so, I may try to trawl up some undocumented non-
ARM stuff, but I'm not the expert there...

Cheers
---Dave
