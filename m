From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH] objtool,x86_64: Replace recordmcount with objtool
Date: Fri, 26 Jun 2020 13:29:31 +0200
Message-ID: <20200626112931.GF4817@hirez.programming.kicks-ass.net>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-5-samitolvanen@google.com>
 <20200624212737.GV4817@hirez.programming.kicks-ass.net>
 <20200624214530.GA120457@google.com>
 <20200625074530.GW4817@hirez.programming.kicks-ass.net>
 <20200625161503.GB173089@google.com>
 <20200625200235.GQ4781@hirez.programming.kicks-ass.net>
 <20200625224042.GA169781@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-hardening-return-19174-glkh-kernel-hardening=m.gmane-mx.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Content-Disposition: inline
In-Reply-To: <20200625224042.GA169781@google.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>, mhelsley@vmware.com
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 25, 2020 at 03:40:42PM -0700, Sami Tolvanen wrote:

> > Not boot tested, but it generates the required sections and they look
> > more or less as expected, ymmv.

> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index a291823f3f26..189575c12434 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -174,7 +174,6 @@ config X86
> >  	select HAVE_EXIT_THREAD
> >  	select HAVE_FAST_GUP
> >  	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
> > -	select HAVE_FTRACE_MCOUNT_RECORD
> >  	select HAVE_FUNCTION_GRAPH_TRACER
> >  	select HAVE_FUNCTION_TRACER
> >  	select HAVE_GCC_PLUGINS
> 
> This breaks DYNAMIC_FTRACE according to kernel/trace/ftrace.c:
> 
>   #ifndef CONFIG_FTRACE_MCOUNT_RECORD
>   # error Dynamic ftrace depends on MCOUNT_RECORD
>   #endif
> 
> And the build errors after that seem to confirm this. It looks like we might
> need another flag to skip recordmcount.

Hurm, Steve, how you want to do that?

> Anyway, since objtool is run before recordmcount, I just left this unchanged
> for testing and ignored the recordmcount warnings about __mcount_loc already
> existing. Something is a bit off still though, I see this at boot:
> 
>   ------------[ ftrace bug ]------------
>   ftrace failed to modify
>   [<ffffffff81000660>] __tracepoint_iter_initcall_level+0x0/0x40
>    actual:   0f:1f:44:00:00
>   Initializing ftrace call sites
>   ftrace record flags: 0
>    (0)
>    expected tramp: ffffffff81056500
>   ------------[ cut here ]------------
> 
> Otherwise, this looks pretty good.

Ha! it is trying to convert the "CALL __fentry__" into a NOP and not
finding the CALL -- because objtool already made it a NOP...

Weird, I thought recordmcount would also write NOPs, it certainly has
code for that. I suppose we can use CC_USING_NOP_MCOUNT to avoid those,
but I'd rather Steve explain this before I wreck things further.
