Return-Path: <SRS0=PuGS=4H=kvack.org=owner-linux-mm@kernel.org>
Date: Wed, 19 Feb 2020 15:54:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 3/6] tracing: Wrap section comparison in
 tracer_alloc_buffers with COMPARE_SECTIONS
Message-ID: <20200219195424.GW31668@ziepe.ca>
References: <20200219045423.54190-1-natechancellor@gmail.com>
 <20200219045423.54190-4-natechancellor@gmail.com>
 <20200219093445.386f1c09@gandalf.local.home>
 <CAKwvOdm-N1iX0SMxGDV5Vf=qS5uHPdH3S-TRs-065BuSOdKt1w@mail.gmail.com>
 <20200219181619.GV31668@ziepe.ca>
 <CAKwvOd=8vb5eOjiLg96zr25Xsq_Xge_Ym7RsNqKK8g+ZR9KWzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=8vb5eOjiLg96zr25Xsq_Xge_Ym7RsNqKK8g+ZR9KWzA@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Jason Baron <jbaron@akamai.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, clang-built-linux <clang-built-linux@googlegroups.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200219195424.oljxqPeeSmOIZxyG1YbOBBhmiv7PygWK1CWd0hdaL2k@z>

On Wed, Feb 19, 2020 at 11:11:19AM -0800, Nick Desaulniers wrote:
> > Godbolt says clang is happy if it is written as:
> >
> >   if (&__stop___trace_bprintk_fmt[0] != &__start___trace_bprintk_fmt[0])
> >
> > Which is probably the best compromise. The type here is const char
> > *[], so it would be a shame to see it go.
> 
> If the "address" is never dereferenced, but only used for arithmetic
> (in a way that the the pointed to type is irrelevant), does the
> pointed to type matter? 

The type is used here:

        if (*pos < start_index)
                return __start___trace_bprintk_fmt + *pos;

The return expression should be a const char **

Presumably the caller of find_next derferences it.

Jason
