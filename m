Return-Path: <SRS0=LzcT=4H=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42867 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgBSVcu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 16:32:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so720662pfz.9
        for <linux-arch@vger.kernel.org>; Wed, 19 Feb 2020 13:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20200219045423.54190-1-natechancellor@gmail.com>
 <20200219045423.54190-4-natechancellor@gmail.com> <20200219093445.386f1c09@gandalf.local.home>
 <CAKwvOdm-N1iX0SMxGDV5Vf=qS5uHPdH3S-TRs-065BuSOdKt1w@mail.gmail.com>
 <20200219181619.GV31668@ziepe.ca> <CAKwvOd=8vb5eOjiLg96zr25Xsq_Xge_Ym7RsNqKK8g+ZR9KWzA@mail.gmail.com>
 <20200219195424.GW31668@ziepe.ca>
In-Reply-To: <20200219195424.GW31668@ziepe.ca>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 19 Feb 2020 13:32:38 -0800
Message-ID: <CAKwvOdktG0vZOZVtNJBk1COhOnLYv3MU5KNQ8Z40L4ph5QcnRg@mail.gmail.com>
Subject: Re: [PATCH 3/6] tracing: Wrap section comparison in
 tracer_alloc_buffers with COMPARE_SECTIONS
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nathan Chancellor <natechancellor@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Jason Baron <jbaron@akamai.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, clang-built-linux <clang-built-linux@googlegroups.com>
Message-ID: <20200219213238.M5ghFy4o7i5sM5Syx_qMSFKqDT990yIORmKVGqU7S8U@z>

On Wed, Feb 19, 2020 at 11:54 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Feb 19, 2020 at 11:11:19AM -0800, Nick Desaulniers wrote:
> > > Godbolt says clang is happy if it is written as:
> > >
> > >   if (&__stop___trace_bprintk_fmt[0] != &__start___trace_bprintk_fmt[0])
> > >
> > > Which is probably the best compromise. The type here is const char
> > > *[], so it would be a shame to see it go.
> >
> > If the "address" is never dereferenced, but only used for arithmetic
> > (in a way that the the pointed to type is irrelevant), does the
> > pointed to type matter?
>
> The type is used here:
>
>         if (*pos < start_index)
>                 return __start___trace_bprintk_fmt + *pos;
>
> The return expression should be a const char **
>
> Presumably the caller of find_next derferences it.
>
> Jason

And the callers of find_next just return the return value from
find_next, but suddenly as `void*` (find_next()'s return type is
`char**`).  So it doesn't seem like the pointed to type matters, hence
the recommendation of `void` and then address-of (&) used in
comparison+arithmetic.

-- 
Thanks,
~Nick Desaulniers
