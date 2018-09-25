From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH V5 17/30] csky: Misc headers
Date: Tue, 25 Sep 2018 12:08:03 +0200
Message-ID: <20180925100803.GA6891@andrea>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <5ae1990e1863fe2293bba1e5ec0408892a9a7f0c.1537789737.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5ae1990e1863fe2293bba1e5ec0408892a9a7f0c.1537789737.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com, palmer@sifive.com
List-Id: linux-arch.vger.kernel.org

Hi Guo,

> +/*
> + * set_bit - Atomically set a bit in memory
> + * @nr: the bit to set
> + * @addr: the address to start counting from
> + *
> + * This function is atomic and may not be reordered.  See __set_bit()
> + * if you do not require the atomic guarantees.
> + *
> + * Note: there are no guarantees that this function will not be reordered
> + * on non x86 architectures, so if you are writing portable code,
> + * make sure not to rely on its reordering guarantees.
> + *
> + * Note that @nr may be almost arbitrarily large; this function is not
> + * restricted to acting on a single-word quantity.
> + */
> +static inline void set_bit(int nr, volatile unsigned long *addr)
> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +	unsigned long tmp;
> +
> +	/* *p  |= mask; */
> +	smp_mb();
> +	asm volatile (
> +		"1:	ldex.w		%0, (%2)	\n"
> +		"	or32		%0, %0, %1	\n"
> +		"	stex.w		%0, (%2)	\n"
> +		"	bez		%0, 1b		\n"
> +		: "=&r"(tmp)
> +		: "r"(mask), "r"(p)
> +		: "memory");
> +	smp_mb();
> +}
> +
> +/**
> + * clear_bit - Clears a bit in memory
> + * @nr: Bit to clear
> + * @addr: Address to start counting from
> + *
> + * clear_bit() is atomic and may not be reordered.  However, it does
> + * not contain a memory barrier, so if it is used for locking purposes,
> + * you should call smp_mb__before_atomic() and/or smp_mb__after_atomic()
> + * in order to ensure changes are visible on other processors.
> + */
> +static inline void clear_bit(int nr, volatile unsigned long *addr)
> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +	unsigned long tmp;
> +
> +	/* *p &= ~mask; */
> +	mask = ~mask;
> +	smp_mb();
> +	asm volatile (
> +		"1:	ldex.w		%0, (%2)	\n"
> +		"	and32		%0, %0, %1	\n"
> +		"	stex.w		%0, (%2)	\n"
> +		"	bez		%0, 1b		\n"
> +		: "=&r"(tmp)
> +		: "r"(mask), "r"(p)
> +		: "memory");
> +	smp_mb();
> +}
> +
> +/**
> + * change_bit - Toggle a bit in memory
> + * @nr: Bit to change
> + * @addr: Address to start counting from
> + *
> + * change_bit() is atomic and may not be reordered. It may be
> + * reordered on other architectures than x86.
> + * Note that @nr may be almost arbitrarily large; this function is not
> + * restricted to acting on a single-word quantity.
> + */
> +static inline void change_bit(int nr, volatile unsigned long *addr)
> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +	unsigned long tmp;
> +
> +	/* *p ^= mask; */
> +	smp_mb();
> +	asm volatile (
> +		"1:	ldex.w		%0, (%2)	\n"
> +		"	xor32		%0, %0, %1	\n"
> +		"	stex.w		%0, (%2)	\n"
> +		"	bez		%0, 1b		\n"
> +		: "=&r"(tmp)
> +		: "r"(mask), "r"(p)
> +		: "memory");
> +	smp_mb();
> +}

The {set,clear,change}_bit() operations don't have to be ordered: you
might want to remove the above smp_mb()s (and adjust the comments).

  Andrea
