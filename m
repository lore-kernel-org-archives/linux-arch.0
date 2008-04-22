From: Kyle McMartin <kyle-pfcGkIkfWfAsA/PxXw9srA@public.gmane.org>
Subject: Re: [RFC] Introduce __ARCH_WANT_SYS_SYSFS
Date: Tue, 22 Apr 2008 11:24:26 -0400
Message-ID: <20080422152426.GG19802@phobos.i.cabal.ca>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <20080422081211.e85989ec.randy.dunlap@oracle.com> <87a5b0800804220816y72a7f4f9gec2111df08a1a57f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87a5b0800804220816y72a7f4f9gec2111df08a1a57f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Newton <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, Apr 22, 2008 at 04:16:17PM +0100, Will Newton wrote:
> It can be done with Kconfig. Whether it should be or not depends on
> your point of view, hence RFC. Currently __ARCH_WANT macros is the way
> syscalls are enabled and disabled across architectures. If there's
> consensus that it should be done via Kconfig that could certainly be
> implmented, but that's a different patch.
>

It's currently done in unistd.h for hysterical raisins. All new
conditional syscalls have been done in Kconfig.
