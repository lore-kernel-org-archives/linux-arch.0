From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH 1/2] HAVE_SET_RESTORE_SIGMASK
Date: Fri, 11 Apr 2008 14:40:34 +0100
Message-ID: <1207921234.22291.4.camel@pmac.infradead.org>
References: <20080329001230.D013726FA1D@magilla.localdomain>
	 <20080329001341.7F93826FA1D@magilla.localdomain>
	 <alpine.LFD.1.00.0803281746480.14670@woody.linux-foundation.org>
	 <20080329022408.0DD4726FA1D@magilla.localdomain>
	 <20080329031146.6FF7126FA1D@magilla.localdomain>
	 <1207741532.27048.64.camel@shinybook.infradead.org>
	 <20080410203250.GA21589@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080410203250.GA21589-f404yB8NqCZvn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk+lkml-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Roland McGrath <roland-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>Andrew Morton" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, miles-mXXj517/zsQ@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, zippel-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

On Thu, 2008-04-10 at 21:32 +0100, Russell King wrote: 
> On Wed, Apr 09, 2008 at 12:45:32PM +0100, David Woodhouse wrote:
> > On Fri, 2008-03-28 at 20:11 -0700, Roland McGrath wrote:
> > > Change all the #ifdef TIF_RESTORE_SIGMASK conditionals in non-arch
> > > code to #ifdef HAVE_SET_RESTORE_SIGMASK.
> > 
> > That ifdef was only supposed to be a temporary thing until all
> > architectures had implemented TIF_RESTORE_SIGMASK anyway.
> > 
> > It looks like only ARM, v850 and m68k which are still missing it; if
> > those three architectures can catch up, then hopefully it can die off
> > completely quite soon.
> 
> Well, we don't have the pselect/ppoll/epoll_wait syscalls and there's
> been no demand for them, so I don't particularly see the point of
> going to the trouble of adding support for something no one's
> interested in using.

You're not likely to see demand for it from users. I believe glibc will
emulate it as best it can (which is not very well), and things will
appear to work.... most of the time.

-- 
dwmw2
