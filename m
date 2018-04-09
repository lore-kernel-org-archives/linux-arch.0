From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 0/3] syscalls: clean up stub naming convention
Date: Mon, 9 Apr 2018 09:08:00 +0200
Message-ID: <20180409070800.GA14257@light.dominikbrodowski.net>
References: <20180407074651.29014-1-linux@dominikbrodowski.net>
 <20180408083550.32d65b6ra6yca5p7@gmail.com>
 <20180408091536.GA10120@light.dominikbrodowski.net>
 <20180409064511.ejhfqcurtlq2srq5@gmail.com>
 <20180409070611.43iq66eay2ctwv2m@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180409070611.43iq66eay2ctwv2m@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Maninder Singh <maninder1.s@samsung.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 09, 2018 at 09:06:11AM +0200, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > 
> > * Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> > 
> > > On Sun, Apr 08, 2018 at 10:35:50AM +0200, Ingo Molnar wrote:
> > > >   - _____sys_waitid()      # ridiculous number of underscores?
> > > >   - __sys_waitid()         # too generic sounding?
> > > 
> > > ... and we'd need to rename internal helpers in net/
> > > 
> > > >   - __inline_sys_waitid()  # too long?
> > > 
> > > sounds acceptable, though a bit long (especially for the compat case, though
> > > it doesn't really matter in the case of 
> > > __inline_compat_sys_sched_rr_get_interval)
> > 
> > So as per the previous mail this is not just an inline function, but an active 
> > type conversion wrapper that sign-extends 32-bit ints to longs, which is important 
> > on some 64-bit architectures.
> > 
> > And that's a really non-obvious property IMO, and the name should probably reflect 
> > _that_ non-obvious property, not the inlining property which is really just a 
> > small detail.
> > 
> > I.e. how about:
> > 
> > 	__se_sys_waitid()
> > 
> > ... where 'se' stands for sign-extended, with a comment in the macro that explains 
> > the prefix? (The historical abbreviation for sign extension is 'sext', which I 
> > think wouldn't really be suitable these days.)
> 
> Ok, so I got confused there: I think it's the do_sys_waitid() intermediate that
> is actually doing the sign-extension - and the inlined helper is what is in the 
> syscall definition body.
> 
> So it's all still somewhat of a confusing misnomer: the 'do' named function is 
> actually the sign-extension function variant - and the '_il' variant actually 
> 'does' the real work ...
> 
> I.e., old naming:
> 
> 810f08d0 t     kernel_waitid	# common C function (see kernel/exit.c)
> 
> <inline>     __il_sys_waitid	# inlined helper doing the actual work
> 				# (takes parameters as declared)
> 
> 810f1aa0 T   __do_sys_waitid	# C function calling inlined helper
> 				# (takes parameters of type long; casts
> 				#  them to the declared type)
> 
> 810f1aa0 T        sys_waitid	# alias to __do_sys_waitid() (taking
> 				# parameters as declared), to be included
> 				# in syscall table
> 
> 
> New suggested naming:
> 
> 810f08d0 t     kernel_waitid	# common C function (see kernel/exit.c)
> 
> <inline>     __do_sys_waitid	# inlined helper doing the actual work
> 				# (takes original parameters as declared)
> 
> 810f1aa0 T   __se_sys_waitid	# sign-extending C function calling inlined
> 				# helper (takes parameters of type long;
> 				# casts them to the declared type)
> 
> 810f1aa0 T        sys_waitid	# alias to __se_sys_waitid() (but taking
> 				# original parameters as declared), to be
> 				# included in syscall table
> 
> Agreed?

Yes.

Thanks,
	Dominik
