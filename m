From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH] objtool,x86_64: Replace recordmcount with objtool
Date: Wed, 22 Jul 2020 20:41:37 +0200
Message-ID: <20200722184137.GP10769@hirez.programming.kicks-ass.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200722135542.41127cc4@oasis.local.home>
Sender: linux-pci-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>, mhelsley@vmware.com
List-Id: linux-arch.vger.kernel.org

On Wed, Jul 22, 2020 at 01:55:42PM -0400, Steven Rostedt wrote:

> > Ha! it is trying to convert the "CALL __fentry__" into a NOP and not
> > finding the CALL -- because objtool already made it a NOP...
> > 
> > Weird, I thought recordmcount would also write NOPs, it certainly has
> > code for that. I suppose we can use CC_USING_NOP_MCOUNT to avoid those,
> > but I'd rather Steve explain this before I wreck things further.
> 
> The reason for not having recordmcount insert all the nops, is because
> x86 has more than one optimal nop which is determined by the machine it
> runs on, and not at compile time. So we figured just updated it then.
> 
> We can change it to be a nop on boot, and just modify it if it's not
> the optimal nop already. 

Right, I throught that's what we'd be doing already, anyway:

> That said, Andi Kleen added an option to gcc called -mnop-mcount which
> will have gcc do both create the mcount section and convert the calls
> into nops. When doing so, it defines CC_USING_NOP_MCOUNT which will
> tell ftrace to expect the calls to already be converted.

That seems like the much easier solution, then we can forget about
recordmcount / objtool entirely for this.
