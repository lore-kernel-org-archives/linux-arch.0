From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/3] generic sys_ipc wrapper
Date: Wed, 6 Jan 2010 19:59:05 +0000
Message-ID: <20100106195905.GE1728@n2100.arm.linux.org.uk>
References: <20100106172152.GC17163@lst.de> <201001062052.11641.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756220Ab0AFT7l@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201001062052.11641.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, ysato@users.sourceforge.jp, takata@linux-m32r.org, geert@linux-m68k.org, zippel@linux-m68k.org, gerg@uclinux.org, ralf@linux-mips.org, benh@kernel.crashing.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, lethal@linux-sh.org, davem@davemloft.net, jdike@addtoit.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, viro@zeniv.linux.org.uk
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 06, 2010 at 08:52:11PM +0100, Arnd Bergmann wrote:
> > +		switch (version) {

Open of first

> > +		default: {

Open of second

> > +			ulong raddr;
> > +			ret = do_shmat(first, (char __user *)ptr,
> > +				       second, &raddr);
> > +			if (ret)
> > +				return ret;
> > +			return put_user(raddr, (ulong __user *) third);
> > +		}

close of second

> > +
> > +#if defined(__i386__) || defined(__frv__) || defined(__mips__) ||\
> > +    defined(__mn10300__)
> > +		case 1:
> > +			/* iBCS2 emulator entry point */
> > +			if (!segment_eq(get_fs(), get_ds()))
> > +				return -EINVAL;
> > +			/*
> > +			 * The "(ulong *) third" is valid _only_ because of
> > +			 * the kernel segment thing.
> > +			 */
> > +			return do_shmat(first, (char __user *) ptr, second,
> > +					(unsigned long *)third);
> > +#endif
> > +#if defined(__arm__) || defined(__sparc__)
> > +		case 1:
> > +			/* Of course, we don't support iBCS2! */
> > +			return -EINVAL;
> > +#endif
> > +		}

close of first.

> This would not build on any of the architecture mentioned, because of
> incorrect placement of curly braces, but as Al mentioned it should just
> go away entirely.

They look fine to me.

In any case, all three patches get my ack.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.
