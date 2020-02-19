From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 3/6] tracing: Wrap section comparison in
 tracer_alloc_buffers with COMPARE_SECTIONS
Date: Wed, 19 Feb 2020 12:22:49 -0700
Message-ID: <20200219192249.GA8840@ubuntu-m2-xlarge-x86>
References: <20200219045423.54190-1-natechancellor@gmail.com>
 <20200219045423.54190-4-natechancellor@gmail.com>
 <20200219093445.386f1c09@gandalf.local.home>
 <CAKwvOdm-N1iX0SMxGDV5Vf=qS5uHPdH3S-TRs-065BuSOdKt1w@mail.gmail.com>
 <20200219181619.GV31668@ziepe.ca>
 <CAKwvOd=8vb5eOjiLg96zr25Xsq_Xge_Ym7RsNqKK8g+ZR9KWzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36701 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgBSTWw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 14:22:52 -0500
Content-Disposition: inline
In-Reply-To: <CAKwvOd=8vb5eOjiLg96zr25Xsq_Xge_Ym7RsNqKK8g+ZR9KWzA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Steven Rostedt <rostedt@goodmis.org>, Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Jason Baron <jbaron@akamai.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, clang-built-linux <clang-built-linux@googlegroups.com>

On Wed, Feb 19, 2020 at 11:11:19AM -0800, Nick Desaulniers wrote:
> On Wed, Feb 19, 2020 at 10:16 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Feb 19, 2020 at 09:44:31AM -0800, Nick Desaulniers wrote:
> > > Hey Nathan,
> > > Thanks for the series; enabling the warning will help us find more
> > > bugs.  Revisiting what the warning is about, I checked on this
> > > "referring to symbols defined in linker scripts from C" pattern.  This
> > > document [0] (by no means definitive, but I think it has a good idea)
> > > says:
> > >
> > > Linker symbols that represent a data address: In C code, declare the
> > > variable as an extern variable. Then, refer to the value of the linker
> > > symbol using the & operator. Because the variable is at a valid data
> > > address, we know that a data pointer can represent the value.
> > > Linker symbols for an arbitrary address: In C code, declare this as an
> > > extern symbol. The type does not matter. If you are using GCC
> > > extensions, declare it as "extern void".
> > >
> > > Indeed, it seems that Clang is happier with that pattern:
> > > https://godbolt.org/z/sW3t5W
> > >
> > > Looking at __stop___trace_bprintk_fmt in particular:
> > >
> > > kernel/trace/trace.h
> > > 1923:extern const char *__stop___trace_bprintk_fmt[];
> >
> > Godbolt says clang is happy if it is written as:
> >
> >   if (&__stop___trace_bprintk_fmt[0] != &__start___trace_bprintk_fmt[0])
> >
> > Which is probably the best compromise. The type here is const char
> > *[], so it would be a shame to see it go.
> 
> If the "address" is never dereferenced, but only used for arithmetic
> (in a way that the the pointed to type is irrelevant), does the
> pointed to type matter?  I don't feel strongly either way, but we seem
> to have found two additional possible solutions for these warnings,
> which is my ultimate goal. Nathan, hopefully those are some ideas you
> can work with to address the additional cases throughout the kernel?
> 
> -- 
> Thanks,
> ~Nick Desaulniers

Yes, thank you for the analysis and further discussion! I have done some
rudimentary printk debugging in QEMU and it looks like these are produce
the same value:

__stop___trace_bprintk_fmt
&__stop___trace_bprintk_fmt
&__start___trace_bprintk_fmt[0]

as well as

__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt
&__stop___trace_bprintk_fmt != &__start___trace_bprintk_fmt
&__stop___trace_bprintk_fmt[0] != &__start___trace_bprintk_fmt[0]

I'll use the second one once I confirm this is true in all callspots
with both Clang and GCC, since it looks cleaner. Let me know if there
are any objections to that.

Cheers,
Nathan
