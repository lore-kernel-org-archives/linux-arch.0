From: Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: RFC: Adding arch-specific user ABI documentation in linux-man
Date: Tue, 5 May 2020 13:14:28 +0100
Message-ID: <20200505121428.GJ19710@willie-the-truck>
References: <20200504153214.GH30377@arm.com>
 <20200505104454.GC19710@willie-the-truck>
 <20200505110519.GM30377@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200505110519.GM30377-5wv7dgnIgG8@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Cc: Michael Kerrisk <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-5wv7dgnIgG8@public.gmane.org>, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Tue, May 05, 2020 at 12:05:19PM +0100, Dave Martin wrote:
> On Tue, May 05, 2020 at 11:44:55AM +0100, Will Deacon wrote:
> > Hi Dave,
> > 
> > On Mon, May 04, 2020 at 04:32:35PM +0100, Dave Martin wrote:
> > > I considering trying to plug some gaps in the arch-specific ABI
> > > documentation in the linux man-pages, specifically for arm64 (and
> > > possibly arm, where compat means we have some overlap).
> > > 
> > > For arm64, there are now significant new extensions (Pointer
> > > authentication, SVE, MTE etc.)  Currently there is some user-facing
> > > documentation mixed in with the kernel-facing documentation in the
> > > kernel tree, but this situation isn't ideal.
> > > 
> > > Do you have an opinion on where in the man-pages documentation should be
> > > added, and how to structure it?
> > > 
> > > 
> > > Affected areas include:
> > > 
> > >  * exec interface
> > >  * aux vector, hwcaps
> > >  * arch-specific signals
> > >  * signal frame
> > >  * mmap/mprotect extensions
> > >  * prctl calls
> > >  * ptrace quirks and extensions
> > >  * coredump contents
> > > 
> > > 
> > > Not everything has an obvious home in an existing page, and adding
> > > specifics for every architecture could make some existing manpages very
> > > unwieldy.
> > > 
> > > I think for some arch features, we really need some "overview" pages
> > > too: just documenting the low-level details is of limited value
> > > without some guide as to how to use them together.
> > > 
> > > 
> > > Does the following sketch look reasonable?
> > > 
> > >  * man7/arm64.7: new page: overview of arm64-specific ABI extensions
> > > 
> > >  * man7/sve.7 (or man7/arm64-sve.7 or man7/sve.7arm64): new page:
> > >    overview of arm64 SVE ABI
> > > 
> > >  * man2/arm64-ptrace.2 (or man2/ptrace.2arm64): new page:
> > >    arm64 ptrace extensions
> > 
> > Michael has been nagging me on and off about that for, what, 10 years now?
> > I would therefore be very much in favour of having our ptrace extensions
> > documented!
> > 
> > We could even put this stuff under Documentation/arm64/man/ if it's deemed
> > too CPU-specific for the man-pages project, but my preference would still
> > be for it to be hosted there alongside all the other man pages.
> 
> Heh, perhaps we could build that into the kernel and mount it somewhere.

Argh, don't joke too loudly about things like that!

> Seriously though,
> 
> I guess I can start off with straightforward small things for which the
> documentation has an obvious home (like prctls[*]) and then move on to
> the bigger stuff like ptrace.
> 
> If people start shouting about a page getting too big or messy I can try
> to split it up.
> 
> Make sense?

Sure, works for me.

Will
