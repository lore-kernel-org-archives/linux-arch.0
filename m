From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH] objtool,x86_64: Replace recordmcount with objtool
Date: Fri, 17 Jul 2020 14:05:45 -0400
Message-ID: <20200717140545.6f008208@oasis.local.home>
References: <20200624203200.78870-1-samitolvanen@google.com>
        <20200624203200.78870-5-samitolvanen@google.com>
        <20200624212737.GV4817@hirez.programming.kicks-ass.net>
        <20200624214530.GA120457@google.com>
        <20200625074530.GW4817@hirez.programming.kicks-ass.net>
        <20200625161503.GB173089@google.com>
        <20200625200235.GQ4781@hirez.programming.kicks-ass.net>
        <20200625224042.GA169781@google.com>
        <20200626112931.GF4817@hirez.programming.kicks-ass.net>
        <CABCJKucSM7gqWmUtiBPbr208wB0pc25afJXc6yBQzJDZf4LSWA@mail.gmail.com>
        <20200717133645.7816c0b6@oasis.local.home>
        <CABCJKuda0AFCZ-1J2NTLc-M0xax007a9u-fzOoxmU2z60jvzbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABCJKuda0AFCZ-1J2NTLc-M0xax007a9u-fzOoxmU2z60jvzbA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Matt Helsley <mhelsley@vmware.com>
List-Id: linux-arch.vger.kernel.org

On Fri, 17 Jul 2020 10:47:51 -0700
Sami Tolvanen <samitolvanen@google.com> wrote:

> > Someone just submitted a patch for arm64 for this:
> >
> > https://lore.kernel.org/r/20200717143338.19302-1-gregory.herrero@oracle.com
> >
> > Is that what you want?  
> 
> That looks like the same issue, but we need to fix this on x86 instead.

Does x86 have a way to differentiate between the two that record mcount
can check?

-- Steve
