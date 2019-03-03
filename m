From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 03/20] mmiowb: Hook up mmiowb helpers to spinlocks and
 generic I/O accessors
Date: Sun, 03 Mar 2019 11:47:22 +1000
Message-ID: <1551577391.707a6tsmt3.astroid@bobo.none>
References: <20190301140348.25175-1-will.deacon@arm.com>
        <20190301140348.25175-4-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190301140348.25175-4-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, Daniel Lustig <dlustig@nvidia.com>, linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Tony Luck <tony.luck@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
List-Id: linux-arch.vger.kernel.org

Will Deacon's on March 2, 2019 12:03 am:
> @@ -177,6 +178,7 @@ do {								\
>  static inline void do_raw_spin_lock(raw_spinlock_t *lock) __acquires(loc=
k)
>  {
>  	__acquire(lock);
> +	mmiowb_spin_lock();
>  	arch_spin_lock(&lock->raw_lock);
>  }
> =20
> @@ -188,16 +190,23 @@ static inline void
>  do_raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long *flags) __acq=
uires(lock)
>  {
>  	__acquire(lock);
> +	mmiowb_spin_lock();
>  	arch_spin_lock_flags(&lock->raw_lock, *flags);
>  }

You'd be better to put these inside the spin lock, to match your=20
trylock.

Also it means the mmiowb state can be used inside a lock/unlock pair
without a compiler barrer forcing it to be reloaded, should be better
code generation for very small critical sections on archs which inline
lock and unlock.

> =20
>  static inline int do_raw_spin_trylock(raw_spinlock_t *lock)
>  {
> -	return arch_spin_trylock(&(lock)->raw_lock);
> +	int ret =3D arch_spin_trylock(&(lock)->raw_lock);
> +
> +	if (ret)
> +		mmiowb_spin_lock();
> +
> +	return ret;
>  }
> =20
>  static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(l=
ock)
>  {
> +	mmiowb_spin_unlock();
>  	arch_spin_unlock(&lock->raw_lock);
>  	__release(lock);
>  }

Thanks,
Nick

=
