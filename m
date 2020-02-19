From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/6] tracing: Wrap section comparison in
 tracer_alloc_buffers with COMPARE_SECTIONS
Date: Wed, 19 Feb 2020 14:09:27 -0500
Message-ID: <20200219140927.396ca577@gandalf.local.home>
References: <20200219045423.54190-1-natechancellor@gmail.com>
        <20200219045423.54190-4-natechancellor@gmail.com>
        <20200219093445.386f1c09@gandalf.local.home>
        <CAKwvOdm-N1iX0SMxGDV5Vf=qS5uHPdH3S-TRs-065BuSOdKt1w@mail.gmail.com>
        <20200219181619.GV31668@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbgBSTJa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 14:09:30 -0500
In-Reply-To: <20200219181619.GV31668@ziepe.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Jason Baron <jbaron@akamai.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, clang-built-linux <clang-built-linux@googlegroups.com>

On Wed, 19 Feb 2020 14:16:19 -0400
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> > kernel/trace/trace.h
> > 1923:extern const char *__stop___trace_bprintk_fmt[];  
> 
> Godbolt says clang is happy if it is written as:
> 
>   if (&__stop___trace_bprintk_fmt[0] != &__start___trace_bprintk_fmt[0])
> 
> Which is probably the best compromise. The type here is const char
> *[], so it would be a shame to see it go.

If the above works, I'd be happy with that. As it is still readable.

-- Steve
