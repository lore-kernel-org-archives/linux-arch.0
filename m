From: Kyle McMartin <kyle-pfcGkIkfWfAsA/PxXw9srA@public.gmane.org>
Subject: Re: [RFC] Introduce __ARCH_WANT_SYS_SYSFS
Date: Tue, 22 Apr 2008 11:38:49 -0400
Message-ID: <20080422153849.GH19802@phobos.i.cabal.ca>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <20080422081211.e85989ec.randy.dunlap@oracle.com> <87a5b0800804220816y72a7f4f9gec2111df08a1a57f@mail.gmail.com> <20080422152426.GG19802@phobos.i.cabal.ca> <87a5b0800804220834q4d6daec1x4146d211115ab5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87a5b0800804220834q4d6daec1x4146d211115ab5c-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Newton <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kyle McMartin <kyle-pfcGkIkfWfAsA/PxXw9srA@public.gmane.org>, Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, Apr 22, 2008 at 04:34:03PM +0100, Will Newton wrote:
> On Tue, Apr 22, 2008 at 4:24 PM, Kyle McMartin <kyle-pfcGkIkfWfAsA/PxXw9srA@public.gmane.org> wrote:
> > On Tue, Apr 22, 2008 at 04:16:17PM +0100, Will Newton wrote:
> >  > It can be done with Kconfig. Whether it should be or not depends on
> >  > your point of view, hence RFC. Currently __ARCH_WANT macros is the way
> >  > syscalls are enabled and disabled across architectures. If there's
> >  > consensus that it should be done via Kconfig that could certainly be
> >  > implmented, but that's a different patch.
> >  >
> >
> >  It's currently done in unistd.h for hysterical raisins. All new
> >  conditional syscalls have been done in Kconfig.
> 
> Do you have a syscall in mind that does this in the correct way?
> 

epoll is the most immediate example at hand, since it touches
fs/compat.c similarly to how you would be touching fs/filesystem.c, and
touches kernel/sys_ni.c and init/Kconfig in much the same way.

> BTW, don't blame the blackfin guys for this, I'm thinking about future
> architectures that may be added rather than any existing ones. ;-)
> 

Meh. :)

cheers, Kyle
