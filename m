From: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH v4 00/13] "Task_isolation" mode
Date: Thu, 23 Jul 2020 17:49:33 +0200
Message-ID: <20200723154933.GB709@worktop.programming.kicks-ass.net>
References: <04be044c1bcd76b7438b7563edc35383417f12c8.camel@marvell.com>
 <87imeextf3.fsf@nanos.tec.linutronix.de>
 <831e023422aa0e4cb3da37ceef6fdcd5bc854682.camel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <831e023422aa0e4cb3da37ceef6fdcd5bc854682.camel-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alex Belits <abelits-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "frederic-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <frederic-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org" <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, "mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Prasun Kapoor <pkapoor-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 23, 2020 at 03:18:42PM +0000, Alex Belits wrote:
> On Thu, 2020-07-23 at 15:17 +0200, Thomas Gleixner wrote:
> > 
> > Without going into details of the individual patches, let me give you a
> > high level view of this series:
> > 
> >   1) Entry code handling:
> > 
> >      That's completely broken vs. the careful ordering and instrumentation
> >      protection of the entry code. You can't just slap stuff randomly
> >      into places which you think are safe w/o actually trying to understand
> >      why this code is ordered in the way it is.
> > 
> >      This clearly was never built and tested with any of the relevant
> >      debug options enabled. Both build and boot would have told you.
> 
> This is intended to avoid a race condition when entry or exit from isolation
> happens at the same time as an event that requires synchronization. The idea
> is, it is possible to insulate the core from all events while it is running
> isolated task in userspace, it will receive those calls normally after
> breaking isolation and entering kernel, and it will synchronize itself on
> kernel entry.

'What does noinstr mean? and why do we have it" -- don't dare touch the
entry code until you can answer that.
