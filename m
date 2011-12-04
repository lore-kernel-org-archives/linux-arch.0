From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Re: [PATCHv5] atomic: add *_dec_not_zero
Date: Sun, 4 Dec 2011 22:18:50 +0000
Message-ID: <20111204221850.GC14542@n2100.arm.linux.org.uk>
References: <1323013369-29691-1-git-send-email-sven@narfation.org> <20111204213316.GB14542@n2100.arm.linux.org.uk> <1699880.NTdz2k3W9O@sven-laptop.home.narfation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <1699880.NTdz2k3W9O@sven-laptop.home.narfation.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Sven Eckelmann <sven@narfation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Randy Dunlap <rdunlap@xenotime.net>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Hirokazu Takata <takata@linux-m32r.org>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>, Chris
List-Id: linux-arch.vger.kernel.org

On Sun, Dec 04, 2011 at 10:49:10PM +0100, Sven Eckelmann wrote:
> On Sunday 04 December 2011 21:33:16 Russell King - ARM Linux wrote:
> [...]
> > > +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)
> > 
> > I think this is rather silly - all these definitions are very similar to
> > each other.  Is there really no way to put this into include/linux/atomic.h,
> > maybe as something like:
> > 
> > #ifndef atomic64_dec_not_zero
> > #define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
> > #endif
> > 
> > and avoid having to add essentially the same definition to 12 individual
> > files?
> > 
> > Architectures which want to override it can do by the following:
> > 
> > #define atomic64_dec_not_zero		atomic64_dec_not_zero
> > 
> > which won't have any effect on C nor asm code.
> 
>  * https://lkml.org/lkml/2011/5/8/15
>  * https://lkml.org/lkml/2011/5/8/16
>  * https://lkml.org/lkml/2011/5/8/321

I don't see any reason in that set of messages _not_ to do what I suggest.
Even on SMP architectures, your:

#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)

makes total sense - and with the adjustments I've suggested it means
that architectures (like x86) can still override it if have a more
optimal way to perform this operation.

Not only that, but we already do this kind of thing in
include/linux/atomic.h for the non-64 bit ops, for example:

#ifndef atomic_inc_unless_negative
static inline int atomic_inc_unless_negative(atomic_t *p)
{
        int v, v1;
        for (v = 0; v >= 0; v = v1) {
                v1 = atomic_cmpxchg(p, v, v + 1);
                if (likely(v1 == v))
                        return 1;
        }
        return 0;
}
#endif

And really, I believe it would be a good cleanup if all the standard
definitions for atomic64 ops (like atomic64_add_negative) were also
defined in include/linux/atomic.h rather than individually in every
atomic*.h header throughout the kernel source, except where an arch
wants to explicitly override it.  Yet again, virtually all architectures
define these in exactly the same way.

We have more than enough code in arch/ for any architecture to worry
about, we don't need schemes to add more when there's simple and
practical solutions to avoiding doing so if the right design were
chosen (preferably from the outset.)

So, I'm not going to offer my ack for a change which I don't believe
is the correct approach.
