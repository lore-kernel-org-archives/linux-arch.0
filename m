From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH] objtool,x86_64: Replace recordmcount with objtool
Date: Wed, 22 Jul 2020 15:09:43 -0400
Message-ID: <20200722150943.53046592@oasis.local.home>
References: <20200624203200.78870-1-samitolvanen@google.com>
        <20200624203200.78870-5-samitolvanen@google.com>
        <20200624212737.GV4817@hirez.programming.kicks-ass.net>
        <20200624214530.GA120457@google.com>
        <20200625074530.GW4817@hirez.programming.kicks-ass.net>
        <20200625161503.GB173089@google.com>
        <20200625200235.GQ4781@hirez.programming.kicks-ass.net>
        <20200625224042.GA169781@google.com>
        <20200626112931.GF4817@hirez.programming.kicks-ass.net>
        <20200722135542.41127cc4@oasis.local.home>
        <20200722184137.GP10769@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20200722184137.GP10769@hirez.programming.kicks-ass.net>
Sender: linux-pci-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Wed, 22 Jul 2020 20:41:37 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > That said, Andi Kleen added an option to gcc called -mnop-mcount which
> > will have gcc do both create the mcount section and convert the calls
> > into nops. When doing so, it defines CC_USING_NOP_MCOUNT which will
> > tell ftrace to expect the calls to already be converted.  
> 
> That seems like the much easier solution, then we can forget about
> recordmcount / objtool entirely for this.

Of course that was only for some gcc compilers, and I'm not sure if
clang can do this.

Or do you just see all compilers doing this in the future, and not
worrying about record-mcount at all, and bothering with objtool?

-- Steve
