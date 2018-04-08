From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 0/3] syscalls: clean up stub naming convention
Date: Sun, 8 Apr 2018 11:15:36 +0200
Message-ID: <20180408091536.GA10120@light.dominikbrodowski.net>
References: <20180407074651.29014-1-linux@dominikbrodowski.net>
 <20180408083550.32d65b6ra6yca5p7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180408083550.32d65b6ra6yca5p7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Maninder Singh <maninder1.s@samsung.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Sun, Apr 08, 2018 at 10:35:50AM +0200, Ingo Molnar wrote:
>   - _____sys_waitid()      # ridiculous number of underscores?
>   - __sys_waitid()         # too generic sounding?

... and we'd need to rename internal helpers in net/

>   - __inline_sys_waitid()  # too long?

sounds acceptable, though a bit long (especially for the compat case, though
it doesn't really matter in the case of 
__inline_compat_sys_sched_rr_get_interval)

> One more fundamental question: why do we have the __do_sys_waitid() and 
> __inline_sys_waitid() distinction - aren't the function call signatures the same 
> with no conversion done?
> 
> I.e. couldn't we just do a single, static __do_sys_waitid(), where the compiler 
> would decide to what extent inlining is justified? This would allow the compiler 
> to inline all the intermediate code into the stubs themselves.
> 
> Or is this a side effect of the error injection feature, which needs to add extra 
> logic at this intermediate level? That too should be able to use the 
> __do_sys_waitid() variant though.

Error injection is unrelated. It seems to be for three reasons, if I read
the code (include/linux/syscalls.h) correctly:

	asmlinkage long __do_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))

1)  This takes arguments of type long (to protect against CVE-2009-0029);
    see https://lwn.net/Articles/604287/ : "Digging into the history of
    this, it turns out that the long version ensures that 32-bit values
    are correctly sign-extended for some 64-bit kernel platforms,
    preventing a historical vulnerability."

	{
		long ret = __in_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));
		__MAP(x,__SC_TEST,__VA_ARGS__);

2) We can add testing whether one of the arguments is longer than long.

		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));

3) This adds asmlinkage_protect() on m68k, but seems to be a no-op on other
architectures.


While reasons 1 and 3 seem irrelevant on x86, I'd like to keep the code
close to the generic one -- and reason 2 is valid in and by itself. So I'd
recommend keeping the __inline_sys / __do_sys indirection.


> Is UML unaffected by these renames?

UML is only affected by patch 3/3, but kept happy by the patch to
entry/syscalls/syscalltbl.sh.


On a somewhat related note: I'll try to prepare a patch this evening which
lets us build just the __ia32_sys and __x32_compat_sys stubs we actually
need. We have that information already in entry/syscalls/syscall_{32,64}.tbl,
it just needs to be extracted into another header file (in the form of
	#define NEED_IA32_sys_xyzzz 1
) and then tested within the stubs. After some randconfig testing, this
might be worthwile to add on top of the patches already in tip-asm and the
three renaming patches currently under discussion.


Thanks,
	Dominik
