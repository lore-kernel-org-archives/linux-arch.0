From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/3] syscalls: clean up stub naming convention
Date: Sun, 8 Apr 2018 10:35:50 +0200
Message-ID: <20180408083550.32d65b6ra6yca5p7@gmail.com>
References: <20180407074651.29014-1-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180407074651.29014-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Maninder Singh <maninder1.s@samsung.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


* Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> In short (0xffffffff prefix removed, re-ordered):
> 
> 810f0af0 t            kernel_waitid	# common (32/64) kernel helper
> 
> <inline>            __in_sys_waitid	# inlined helper doing actual work
> 810f0be0 t          __do_sys_waitid	# C func calling inlined helper
> 
> <inline>     __in_compat_sys_waitid	# inlined helper doing actual work
> 810f0d80 t   __do_compat_sys_waitid	# compat C func calling inlined helper
> 
> 810f2080 T         __x64_sys_waitid	# x64 64-bit-ptregs -> C stub
> 810f20b0 T        __ia32_sys_waitid	# ia32 32-bit-ptregs -> C stub [unused]
> 810f2470 T __ia32_compat_sys_waitid	# ia32 32-bit-ptregs -> compat C stub
> 810f2490 T  __x32_compat_sys_waitid	# x32 64-bit-ptregs -> compat C stub

Ok, looks pretty clean and nice to me all around, and looking at the highest level 
syscall tables the actual calling convention and address encoding is now a _lot_ 
more obvious at first sight as well.

The "in" part is a tiny bit confusing because it reads like a preposition:
"are we in sys_waitid?".

But I have no better idea, other than we could perhaps use more underscores to 
signal the inline helper, instead of the 'in_' prefix:

> 810f0af0 t            kernel_waitid	# common (32/64) kernel helper
> 
> <inline>            _____sys_waitid	# inlined helper doing actual work
> 810f0be0 t          __do_sys_waitid	# C func calling inlined helper
> 
> <inline>     _____compat_sys_waitid	# inlined helper doing actual work
> 810f0d80 t   __do_compat_sys_waitid	# compat C func calling inlined helper
> 
> 810f2080 T         __x64_sys_waitid	# x64 64-bit-ptregs -> C stub
> 810f20b0 T        __ia32_sys_waitid	# ia32 32-bit-ptregs -> C stub [unused]
> 810f2470 T __ia32_compat_sys_waitid	# ia32 32-bit-ptregs -> compat C stub
> 810f2490 T  __x32_compat_sys_waitid	# x32 64-bit-ptregs -> compat C stub

?

There are some other variants as well, here's the list of all the options I could 
think of:

  - _____sys_waitid()      # ridiculous number of underscores?
  - __sys_waitid()         # too generic sounding?
  - __inline_sys_waitid()  # too long?
  - __il_sys_waitid()      # reminds me of the IL country code ;-)
  - __in_sys_waitid()      # easy to read as 'are we in syscall?'

None is super convinging - but maybe __inline_sys_waitid is the most natural one.

[ Note, whichever we pick (if we pick a new one), there no need to resend, I can 
  edit the patches in place if you agree. ]

One more fundamental question: why do we have the __do_sys_waitid() and 
__inline_sys_waitid() distinction - aren't the function call signatures the same 
with no conversion done?

I.e. couldn't we just do a single, static __do_sys_waitid(), where the compiler 
would decide to what extent inlining is justified? This would allow the compiler 
to inline all the intermediate code into the stubs themselves.

Or is this a side effect of the error injection feature, which needs to add extra 
logic at this intermediate level? That too should be able to use the 
__do_sys_waitid() variant though.

> The kbuild test robot barked at an alleged +20038 bytes kernel size regression
> for i386-tinyconfig due to the first patch of this series. That seems to be a
> false positive, as it likely doesn't take into account the change to
> scripts/bloat-o-meter. Moreover, I could not reproduce such a size regression
> on local i386 builds.

Ok, I'll ignore that.

Is UML unaffected by these renames?

Thanks,

	Ingo
