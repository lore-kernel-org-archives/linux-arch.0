From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [RFC PATCH 01/11] prctl: Support movement of arch prctls out of
 common code
Date: Wed, 23 May 2018 11:14:52 +0100
Message-ID: <20180523101451.GH13470@e103592.cambridge.arm.com>
References: <5252accbd67022cea25e5aa80e48d95c.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Fenghua Yu <fenghua.yu@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, James Hogan <jhogan@kernel.org>, Kees Cook <keescook@chromium.org>, Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Henderson <rth@twiddle.net>, Rich Felker <dalias@libc.org>, Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>
List-Id: linux-arch.vger.kernel.org

On Mon, May 21, 2018 at 07:28:26PM +0100, Will Deacon wrote:
> Hi Dave,
> 
> On Mon, May 14, 2018 at 06:14:17PM +0100, Dave Martin wrote:
> > The core framework for the prctl() syscall is unloved and looking
> > rather crusty these days.  It also relies on defining ancillary
> > boilerplate macros for each prctl() in order to control conditional
> > compilation of the different prctl calls.  We have better ways to
> > do this now, using Kconfig.
> > 
> > This patch defines a new arch hook arch_syscall().  Architectures
> > that implemement arch-specific syscalls can now select
> > HAVE_ARCH_SYSCALL in their Kconfig and define this function
> > appropriately.
> > 
> > The core prctl() implementation now matches option against the list
> > of common or legacy prctls, deferring to prctl_arch() if an
> > unrecognised option is encountered.
> > 
> > (arch_prctl() would have been a nicer name, but it conflicts with the
> > pre-existing syscall of the same name on x86, particularly in the um
> > code.)
> > 
> > No functional change.
> 
> [...]
> 
> > diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> > index af5f8c2..c911ff0 100644
> > --- a/include/uapi/linux/prctl.h
> > +++ b/include/uapi/linux/prctl.h
> > @@ -1,6 +1,6 @@
> >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > -#ifndef _LINUX_PRCTL_H
> > -#define _LINUX_PRCTL_H
> > +#ifndef _UAPI_LINUX_PRCTL_H
> > +#define _UAPI_LINUX_PRCTL_H
> 
> Is it safe to rename this #define, or is there a possibility that userspace
> could be using it for something and relying on it not changing?
> 
> Other than that:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

I think that header guards are generally viewed as being private to a
project and not API.  codesearch.debian.net yields few hits, where there
are actual #ifdefs on this symbol, they seem to be pastes of the kernel
headers:

https://codesearch.debian.net/search?q=_LINUX_PRCTL_H&perpkg=1

 -> android, linux, dietlibc ... gnome-chess (?)


There is plenty of precedent in the Howells special:

607ca46e97a1 ("UAPI: (Scripted) Disintegrate include/linux")

See for example <{,uapi/}linux/loop.h>.

Cheers
---Dave
