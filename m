Return-Path: <SRS0=LzcT=4H=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45920 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgBSSQV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 13:16:21 -0500
Received: by mail-qt1-f195.google.com with SMTP id d9so882022qte.12
        for <linux-arch@vger.kernel.org>; Wed, 19 Feb 2020 10:16:20 -0800 (PST)
Date: Wed, 19 Feb 2020 14:16:19 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 3/6] tracing: Wrap section comparison in
 tracer_alloc_buffers with COMPARE_SECTIONS
Message-ID: <20200219181619.GV31668@ziepe.ca>
References: <20200219045423.54190-1-natechancellor@gmail.com>
 <20200219045423.54190-4-natechancellor@gmail.com>
 <20200219093445.386f1c09@gandalf.local.home>
 <CAKwvOdm-N1iX0SMxGDV5Vf=qS5uHPdH3S-TRs-065BuSOdKt1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm-N1iX0SMxGDV5Vf=qS5uHPdH3S-TRs-065BuSOdKt1w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nathan Chancellor <natechancellor@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Jason Baron <jbaron@akamai.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, clang-built-linux <clang-built-linux@googlegroups.com>
Message-ID: <20200219181619.2R9SH7u4VYxa1gDcBgeCz6RB9n-Ni1HAA9AU-WfCUtc@z>

On Wed, Feb 19, 2020 at 09:44:31AM -0800, Nick Desaulniers wrote:
> On Wed, Feb 19, 2020 at 6:34 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Tue, 18 Feb 2020 21:54:20 -0700
> > Nathan Chancellor <natechancellor@gmail.com> wrote:
> >
> > > Clang warns:
> > >
> > > ../kernel/trace/trace.c:9335:33: warning: array comparison always
> > > evaluates to true [-Wtautological-compare]
> > >         if (__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt)
> > >                                        ^
> > > 1 warning generated.
> > >
> > > These are not true arrays, they are linker defined symbols, which are
> > > just addresses so there is not a real issue here. Use the
> > > COMPARE_SECTIONS macro to silence this warning by casting the linker
> > > defined symbols to unsigned long, which keeps the logic the same.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/765
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > >  kernel/trace/trace.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > > index c797a15a1fc7..e1f3b16e457b 100644
> > > +++ b/kernel/trace/trace.c
> > > @@ -9332,7 +9332,7 @@ __init static int tracer_alloc_buffers(void)
> > >               goto out_free_buffer_mask;
> > >
> > >       /* Only allocate trace_printk buffers if a trace_printk exists */
> > > -     if (__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt)
> > > +     if (COMPARE_SECTIONS(__stop___trace_bprintk_fmt, !=, __start___trace_bprintk_fmt))
> >
> > Sorry, but this is really ugly and unreadable. Please find some other
> > solution to fix this.
> >
> > NAK-by: Steven Rostedt
> >
> 
> Hey Nathan,
> Thanks for the series; enabling the warning will help us find more
> bugs.  Revisiting what the warning is about, I checked on this
> "referring to symbols defined in linker scripts from C" pattern.  This
> document [0] (by no means definitive, but I think it has a good idea)
> says:
> 
> Linker symbols that represent a data address: In C code, declare the
> variable as an extern variable. Then, refer to the value of the linker
> symbol using the & operator. Because the variable is at a valid data
> address, we know that a data pointer can represent the value.
> Linker symbols for an arbitrary address: In C code, declare this as an
> extern symbol. The type does not matter. If you are using GCC
> extensions, declare it as "extern void".
> 
> Indeed, it seems that Clang is happier with that pattern:
> https://godbolt.org/z/sW3t5W
> 
> Looking at __stop___trace_bprintk_fmt in particular:
> 
> kernel/trace/trace.h
> 1923:extern const char *__stop___trace_bprintk_fmt[];

Godbolt says clang is happy if it is written as:

  if (&__stop___trace_bprintk_fmt[0] != &__start___trace_bprintk_fmt[0])

Which is probably the best compromise. The type here is const char
*[], so it would be a shame to see it go.

I think this warning is specific to arrays and is designed to detect
programmer errors like:
  int a[1];
  int b[1];
  return a < b;

Where the author intended to use memcmp()

Jason
