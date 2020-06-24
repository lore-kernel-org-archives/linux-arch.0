From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 04/22] kbuild: lto: fix recordmcount
Date: Wed, 24 Jun 2020 23:27:37 +0200
Message-ID: <20200624212737.GV4817@hirez.programming.kicks-ass.net>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-5-samitolvanen@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-hardening-return-19140-glkh-kernel-hardening=m.gmane-mx.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Content-Disposition: inline
In-Reply-To: <20200624203200.78870-5-samitolvanen@google.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 24, 2020 at 01:31:42PM -0700, Sami Tolvanen wrote:
> With LTO, LLVM bitcode won't be compiled into native code until
> modpost_link. This change postpones calls to recordmcount until after
> this step.
> 
> In order to exclude specific functions from inspection, we add a new
> code section .text..nomcount, which we tell recordmcount to ignore, and
> a __nomcount attribute for moving functions to this section.

I'm confused, you only add this to functions in ftrace itself, which is
compiled with:

 KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))

and so should not have mcount/fentry sites anyway. So what's the point
of ignoring them further?

This Changelog does not explain.
