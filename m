From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v1 7/7] tools: add userspace linker table sandbox
Date: Wed, 24 Aug 2016 09:39:03 -0300
Message-ID: <20160824123903.GA10063@kernel.org>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <1471642875-5957-1-git-send-email-mcgrof@kernel.org>
 <1471642875-5957-8-git-send-email-mcgrof@kernel.org>
 <CAGXu5jKX-VZR_r9wMsnLAU+Z10vB4yDiRPpvwXbRZj0=wU208A@mail.gmail.com>
 <20160823000739.GX3296@wotan.suse.de>
 <201608230028.u7N0SneR020502@mail.zytor.com>
 <20160823143028.GA2834@redhat.com>
 <CAGXu5j+JsFAUJ4AfCvK2FVE3TOOeLjyiOD1Buy-X4oRHu=Cz=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754250AbcHXMqQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Aug 2016 08:46:16 -0400
Content-Disposition: inline
In-Reply-To: <CAGXu5j+JsFAUJ4AfCvK2FVE3TOOeLjyiOD1Buy-X4oRHu=Cz=A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Masami Hiramatsu <mhiramat@kernel.org>, jbaron@akamai.com, Heiko Carstens <heiko.carstens@de.ibm.com>, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, "David S. Miller" <davem@davemloft.net>, Miao Steven <realmz6@gmail.com>, "x86@kernel.org" <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, Rusty Russell <rusty@rustcorp.com.au>, gnomes@lxorguk

Em Tue, Aug 23, 2016 at 10:28:39PM -0400, Kees Cook escreveu:
> On Tue, Aug 23, 2016 at 10:30 AM, Arnaldo Carvalho de Melo
> <acme@redhat.com> wrote:
> > Em Mon, Aug 22, 2016 at 05:28:42PM -0700, H. Peter Anvin escreveu:
> >> On August 22, 2016 5:07:39 PM PDT, "Luis R. Rodriguez" <mcgrof@kernel.org> wrote:
> >> >On Fri, Aug 19, 2016 at 03:31:47PM -0700, Kees Cook wrote:

> >> >> Aren't a bunch of these files exact duplicates of the headers in
> >> >include/linux?

> >> >Indeed... This a userspace tools/ architecture decision that was made
> >> >long ago, so its not up to me, I am just following the strategy
> >> >devised and picked up.  Refer to
> >> >7d7d1bf1d1dabe435ef50efb051724b8664749cb ("perf bench: Copy kernel
> >> >files needed to build mem{cpy,set} x86_64 benchmarks") for an example
> >> >of previous similar work. By sharing header files this enable more
> >> >tools/ to be hacked on.

> >> I think this is a legacy from before the uapi change that should
> >> really be fixed.  If we need to export additional kernel structures
> >> for the tools, we could define a third level of we really need it.

> > No, it is something recent, its just that from time to time files that
> > tools/ included from outside, i.e. from the kernel sources, made tools/
> > break, so after discussion with Linus and Ingo[1], it was decided we would

> This [1] reference seems missing. I'm curious to see the thread. I

I added the '[1]', went to look for the discussion yesterday, but it was
a private conversation with ~15 people, bummer, but the one below has
Ingo describing it in another occasion where a new utility got added to
tools/, objtool:

  https://lkml.kernel.org/r/20160309183945.GA17956@gmail.com

And yeah, I started using stuff directly from the kernel, breakage took
place, we changed course.

> wonder if something could be done to just generate the needed headers
> from the canonical locations into the tools/ locations?

Then that would bring possible problems, better to do it manually when
auto-detected.
 
> > grab copies and never more access anything outside tools/ directly.
> >
> > Instead we would check for changes and warn the tools/ developers about
> > it, so that they could check what has changed, that could mean changes
> > should/could be done to tools/ using those headers.
> 
> Is there anything automated in place to notice when these changes happen?

See 791cceb89f7987c0375ff2e8971928a47f62ccae, among others, but it will
amount to something like:

    Changes detected by the tools build system:
    
      $ make -C tools/perf O=/tmp/build/perf install-bin
      make: Entering directory '/home/acme/git/linux/tools/perf'
        BUILD:   Doing 'make -j4' parallel build
--->  Warning: tools/include/uapi/linux/bpf.h differs from kernel <-------
        INSTALL  GTK UI
        CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
      <SNIP>
      $

- Arnaldo
