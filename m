From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v1 7/7] tools: add userspace linker table sandbox
Date: Wed, 24 Aug 2016 16:17:20 -0300
Message-ID: <20160824191720.GE10063@kernel.org>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <1471642875-5957-1-git-send-email-mcgrof@kernel.org>
 <1471642875-5957-8-git-send-email-mcgrof@kernel.org>
 <CAGXu5jKX-VZR_r9wMsnLAU+Z10vB4yDiRPpvwXbRZj0=wU208A@mail.gmail.com>
 <20160823000739.GX3296@wotan.suse.de>
 <201608230028.u7N0SneR020502@mail.zytor.com>
 <20160823143028.GA2834@redhat.com>
 <CAGXu5j+JsFAUJ4AfCvK2FVE3TOOeLjyiOD1Buy-X4oRHu=Cz=A@mail.gmail.com>
 <20160824123903.GA10063@kernel.org>
 <CAB=NE6W24OTy+6P6=AM=JDngGJvEa9B_afbQxkx7Epx+_CfAWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932825AbcHXTR2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Aug 2016 15:17:28 -0400
Content-Disposition: inline
In-Reply-To: <CAB=NE6W24OTy+6P6=AM=JDngGJvEa9B_afbQxkx7Epx+_CfAWg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Masami Hiramatsu <mhiramat@kernel.org>, jbaron@akamai.com, Heiko Carstens <heiko.carstens@de.ibm.com>, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, "David S. Miller" <davem@davemloft.net>, Miao Steven <realmz6@gmail.com>, "x86@kernel.org" <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, Rusty Russell <rusty@rustcorp.com.au>, gnomes@lxorguk.ukuu.

Em Wed, Aug 24, 2016 at 09:20:12AM -0700, Luis R. Rodriguez escreveu:
> On Wed, Aug 24, 2016 at 5:39 AM, Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> > Changes detected by the tools build system:
> >
> >       $ make -C tools/perf O=/tmp/build/perf install-bin
> >       make: Entering directory '/home/acme/git/linux/tools/perf'
> >         BUILD:   Doing 'make -j4' parallel build
> > --->  Warning: tools/include/uapi/linux/bpf.h differs from kernel <-------
> >         INSTALL  GTK UI
> >         CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
> >       <SNIP>
> >       $
 
> I borrowed the same strategy from perf tools and generalized this
> through helpers a bit as Makefile helpers in the linker-tables
> sandbox:
 
> HEADERS = \
>           ../../include/asm-generic/section-core.h \
>           ../../include/asm-generic/ranges.h \
>           ../../include/asm-generic/tables.h \
>           ../../include/linux/sections.h \
>           ../../include/linux/ranges.h \
>           ../../include/linux/tables.h
> 
> __check_headers: $(HEADERS)
>         @$(foreach h, $(HEADERS), \
>                 (test -f $(h) && ( \
>                         (diff -B $(subst ../,../,$(h)) $(h) >/dev/null) \
>                         || echo "Warning: $(subst ../../,tools/,$(h))
> differs from kernel" >&2 ) || true);)
 
> Instead of doing the check / complaint at install it complains at
> build time. Its up to the tools to decide when they want this check,
> but perhaps later a generic check can be set up. My thought was later
> to move some of this as helpers in a generic tools Makefile to more
> easily enable other tools/ to do similar checks more easily. I suspect
> we may later want to keep a tighter tab on what tools need what
> headers and instead have a generic place to keep tabs on this, but we
> can do that slowly later after generalizing a checker.

Right
 
> In doing the linker table sandbox one of the needs I found in needing
> separate headers was that often you don't want the same copy as the
> kernel provides, as you want to port things over to work in userspace

Right, the ones that are direct copies are the ones being checked with
diff, there are others, as you say, that are not copies and are not
being checked at all :-\

Example:

tools/include/linux/rbtree.h

The kernel one has RCU stuff, in it and tools still doesn't have some
userspace RCU implementation that could provide what it expects.

Without collaboration from the kernel people working on
include/linux/rbtree.h, that is what we can do.

> and often ported to libc. So other than the direct copies -- we also
> have another category of headers -- ported headers. Its possible not

yeah

> all tools may end up wanting the same port, this can be addressed
> through two means. One is having a generic port which should suffice
> for most tools that need libc, and for those that don't want the
> generic port they can just carry their own port in their own tree. The
> linker tables tools sandbox enables this by allowing first headers to
> be search in its own directory, that way it can override what is
> provided as generic in tools. However it may still be useful later to
> have two separate directories to be able to easily distinguish between
> "copies" and "ports". But this can be done later.
> 
> Thoughts?

I don't see problems with your reasoning, do what is faster for having
your tool in place and we can go on improving the way tools/ gets stuff
from the kernel, how we detect changes that could be interesting to get
and eventually how kernel developers can help in this process.

What we don't want is to burden the kernel developers with things for
tools/.

- Arnaldo
