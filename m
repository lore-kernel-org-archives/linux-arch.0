From: Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 04/22] kbuild: lto: fix recordmcount
Date: Thu, 25 Jun 2020 09:15:03 -0700
Message-ID: <20200625161503.GB173089@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-5-samitolvanen@google.com>
 <20200624212737.GV4817@hirez.programming.kicks-ass.net>
 <20200624214530.GA120457@google.com>
 <20200625074530.GW4817@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200625074530.GW4817@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 25, 2020 at 09:45:30AM +0200, Peter Zijlstra wrote:
> On Wed, Jun 24, 2020 at 02:45:30PM -0700, Sami Tolvanen wrote:
> > On Wed, Jun 24, 2020 at 11:27:37PM +0200, Peter Zijlstra wrote:
> > > On Wed, Jun 24, 2020 at 01:31:42PM -0700, Sami Tolvanen wrote:
> > > > With LTO, LLVM bitcode won't be compiled into native code until
> > > > modpost_link. This change postpones calls to recordmcount until after
> > > > this step.
> > > > 
> > > > In order to exclude specific functions from inspection, we add a new
> > > > code section .text..nomcount, which we tell recordmcount to ignore, and
> > > > a __nomcount attribute for moving functions to this section.
> > > 
> > > I'm confused, you only add this to functions in ftrace itself, which is
> > > compiled with:
> > > 
> > >  KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
> > > 
> > > and so should not have mcount/fentry sites anyway. So what's the point
> > > of ignoring them further?
> > > 
> > > This Changelog does not explain.
> > 
> > Normally, recordmcount ignores each ftrace.o file, but since we are
> > running it on vmlinux.o, we need another way to stop it from looking
> > at references to mcount/fentry that are not calls. Here's a comment
> > from recordmcount.c:
> > 
> >   /*
> >    * The file kernel/trace/ftrace.o references the mcount
> >    * function but does not call it. Since ftrace.o should
> >    * not be traced anyway, we just skip it.
> >    */
> > 
> > But I agree, the commit message could use more defails. Also +Steven
> > for thoughts about this approach.
> 
> Ah, is thi because recordmcount isn't smart enough to know the
> difference between "CALL $mcount" and any other RELA that has mcount?

Yes.

> At least for x86_64 I can do a really quick take for a recordmcount pass
> in objtool, but I suppose you also need this for ARM64 ?

Sure, sounds good. arm64 uses -fpatchable-function-entry with clang, so we
don't need recordmcount there.

Sami
