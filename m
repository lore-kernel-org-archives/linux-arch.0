From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 13/36] vmlinux.lds.h: add PGO and AutoFDO input
 sections
Date: Mon, 3 Aug 2020 21:45:32 -0700
Message-ID: <20200804044532.GC1321588@tassilo.jf.intel.com>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-14-keescook@chromium.org>
 <20200801035128.GB2800311@rani.riverdale.lan>
 <20200803190506.GE1299820@tassilo.jf.intel.com>
 <20200803201525.GA1351390@rani.riverdale.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200803201525.GA1351390@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Jian Cai <jiancai@google.com>, =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>, Luis Lozano <llozano@google.com>, Manoj Gupta <manojgupta@google.com>, stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

> Why is that? Both .text and .text.hot have alignment of 2^4 (default
> function alignment on x86) by default, so it doesn't seem like it should
> matter for packing density.  Avoiding interspersing cold text among

You may lose part of a cache line on each unit boundary. Linux has 
a lot of units, some of them small. All these bytes add up.

It's bad for TLB locality too. Sadly with all the fine grained protection
changes the 2MB coverage is eroding anyways, but this makes it even worse.

> regular/hot text seems like it should be a net win.

> 
> That old commit doesn't reference efficiency -- it says there was some
> problem with matching when they were separated out, but there were no
> wildcard section names back then.

It was about efficiency.

-Andi
