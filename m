From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/3] syscalls: clean up stub naming convention
Date: Mon, 9 Apr 2018 09:34:31 +0200
Message-ID: <20180409073431.3acda3qpyhb35wnt@gmail.com>
References: <20180407074651.29014-1-linux@dominikbrodowski.net>
 <20180408083550.32d65b6ra6yca5p7@gmail.com>
 <20180408091536.GA10120@light.dominikbrodowski.net>
 <20180409064511.ejhfqcurtlq2srq5@gmail.com>
 <20180409070611.43iq66eay2ctwv2m@gmail.com>
 <20180409070800.GA14257@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180409070800.GA14257@light.dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Maninder Singh <maninder1.s@samsung.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


* Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> > New suggested naming:
> > 
> > 810f08d0 t     kernel_waitid	# common C function (see kernel/exit.c)
> > 
> > <inline>     __do_sys_waitid	# inlined helper doing the actual work
> > 				# (takes original parameters as declared)
> > 
> > 810f1aa0 T   __se_sys_waitid	# sign-extending C function calling inlined
> > 				# helper (takes parameters of type long;
> > 				# casts them to the declared type)
> > 
> > 810f1aa0 T        sys_waitid	# alias to __se_sys_waitid() (but taking
> > 				# original parameters as declared), to be
> > 				# included in syscall table
> > 
> > Agreed?
> 
> Yes.

Ok, great. Since these re-renames look complex enough, mind re-sending the series 
with these changes incorporated and the 4/3 patch incorporated as well (and the 
image shrinking script left out)?

The base patches are looking good here so I plan sending these to Linus 
tomorrow-ish. (The renames don't affect functionality so they don't need
as much testing.)

Thanks,

	Ingo
