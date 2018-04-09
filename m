From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/3] syscalls: clean up stub naming convention
Date: Mon, 9 Apr 2018 08:39:21 +0200
Message-ID: <20180409063921.wkrqbnv4lzxb3isg@gmail.com>
References: <20180407074651.29014-1-linux@dominikbrodowski.net>
 <20180408083550.32d65b6ra6yca5p7@gmail.com>
 <20180408091536.GA10120@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180408091536.GA10120@light.dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Maninder Singh <maninder1.s@samsung.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

* Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> > One more fundamental question: why do we have the __do_sys_waitid() and 
> > __inline_sys_waitid() distinction - aren't the function call signatures the same 
> > with no conversion done?
> > 
> > I.e. couldn't we just do a single, static __do_sys_waitid(), where the compiler 
> > would decide to what extent inlining is justified? This would allow the compiler 
> > to inline all the intermediate code into the stubs themselves.
> > 
> > Or is this a side effect of the error injection feature, which needs to add extra 
> > logic at this intermediate level? That too should be able to use the 
> > __do_sys_waitid() variant though.
> 
> Error injection is unrelated. It seems to be for three reasons, if I read
> the code (include/linux/syscalls.h) correctly:
> 
> 	asmlinkage long __do_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))
> 
> 1)  This takes arguments of type long (to protect against CVE-2009-0029);
>     see https://lwn.net/Articles/604287/ : "Digging into the history of
>     this, it turns out that the long version ensures that 32-bit values
>     are correctly sign-extended for some 64-bit kernel platforms,
>     preventing a historical vulnerability."
> 
> 	{
> 		long ret = __in_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));
> 		__MAP(x,__SC_TEST,__VA_ARGS__);

I see - so it's _not_ the same function call signature, but a wrapper with a 
sign-extended version, which is fair and useful. So on architectures where this 
matters there's type conversion and active code generated.

Thanks,

	Ingo
