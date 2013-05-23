From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH] arch: configuration,
	deleting 'CONFIG_BUG' since	always need it.
Date: Thu, 23 May 2013 11:29:34 +0100
Message-ID: <20130523102934.GN18614@n2100.arm.linux.org.uk>
References: <519DCBEF.3090208@asianux.com>
	<20130523090534.GJ18614@n2100.arm.linux.org.uk>
	<CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com>
	<201305231139.38233.arnd@arndb.de> <878v369fdd.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <878v369fdd.fsf-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
Cc: Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Chen Gang <gang.chen-bOixZGp5f+dBDgjK7y7TUQ@public.gmane.org>, Heiko Carstens <heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, "paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org" <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Michel Lespinasse <walken-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Hans-Christian Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, Linux-Arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, uml-devel <user-mode-linux-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, Helge Deller <deller-Mmb7MZpHnFY@public.gmane.org>, the arch/x86 maintainers <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "James E.J. Bottomley" <jejb-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>, "mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Geert Uytterhoeven <geert@>
List-Id: linux-arch.vger.kernel.org

On Thu, May 23, 2013 at 03:09:50AM -0700, Eric W. Biederman wrote:
> Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> writes:
> 
> > On Thursday 23 May 2013, Geert Uytterhoeven wrote:
> >> > The problem is: trying to fix that will mean the result is a larger
> >> > kernel than if you just do the usual arch-implemented thing of placing
> >> > an defined faulting instruction at the BUG() site - which defeats the
> >> > purpose of turning off CONFIG_BUG.
> >> 
> >> Is __builtin_unreachable() working well these days?
> >> 
> >
> > Hmm, I just tried the trivial patch below, which seemed to do the right thing.
> > Needs a little more investigation, but that might actually be the correct
> > solution. I thought that at some point __builtin_unreachable() was the same
> > as "do {} while (1)", but this is not the case with the gcc I was using --
> > it just tells gcc that we don't expect to ever get here.
> 
> Yes.
> 
> We already have this abstracted in compiler.h as the macro unreachable,
> so the slight modification of your patch below should handle this case.
> 
> For compilers without __builtin_unreachable() unreachable() expands to
> do {} while(1) but an infinite loop seems reasonable and preserves the
> semantics of the code, unlike the current noop that is do {} while(0).

Semantics of the code really don't come in to it if you use unreachable().
unreachable() is an effective do { } while (0) to the compiler.  It just
doesn't warn about it anymore.  It's actually worse than that - it's
permission to the compiler to just stop considering flow control at that
point and do anything it likes with the following instruction slot.

What __builtin_unreachable() means to the compiler is "we will *never*
get here".  That isn't the case for BUG() - BUG() means "we hope that
we will never get here, but we might, and if we do your data is in
grave danger."

We should either have something at that point (like a call to a function
which panics) or remove the ability to turn off CONFIG_BUG and anyone who
cares about kernel size needs to come up with a single trapping
instruction BUG() implementation.
