From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH] objtool,x86_64: Replace recordmcount with objtool
Date: Wed, 22 Jul 2020 20:06:08 -0400
Message-ID: <20200722200608.40ca9994@oasis.local.home>
References: <20200624212737.GV4817@hirez.programming.kicks-ass.net>
        <20200624214530.GA120457@google.com>
        <20200625074530.GW4817@hirez.programming.kicks-ass.net>
        <20200625161503.GB173089@google.com>
        <20200625200235.GQ4781@hirez.programming.kicks-ass.net>
        <20200625224042.GA169781@google.com>
        <20200626112931.GF4817@hirez.programming.kicks-ass.net>
        <20200722135542.41127cc4@oasis.local.home>
        <20200722184137.GP10769@hirez.programming.kicks-ass.net>
        <20200722150943.53046592@oasis.local.home>
        <20200722235620.GR10769@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20200722235620.GR10769@hirez.programming.kicks-ass.net>
Sender: linux-kbuild-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Thu, 23 Jul 2020 01:56:20 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Anyway, what do you prefer, I suppose I can make objtool whatever we
> need, that patch is trivial. Simply recording the sites and not
> rewriting them should be simple enough.

Either way. If objtool turns it into nops, just make it where we can
enable -DCC_USING_NOP_MCOUNT set, and the kernel will be unaware.

Or if you just add the locations, then that would work too.

-- Steve
