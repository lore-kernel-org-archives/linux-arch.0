Return-Path: <paulmck@linux.vnet.ibm.com>
Date: Fri, 22 Nov 2013 17:32:41 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] arch: Introduce smp_load_acquire(),
 smp_store_release()
Message-ID: <20131123013241.GA29847@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20131107162341.305859004@infradead.org>
 <20131107164503.325138873@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131107164503.325138873@infradead.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chen Liqin <liqin.linux@gmail.com>, Chris Metcalf <cmetcalf@tilera.com>, Chris Zankel <chris@zankel.net>, David Howells <dhowells@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hirokazu Takata <takata@linux-m32r.org>, James Hogan <james.hogan@imgtec.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Linus Torvalds <torvalds@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Michael Ellerman <michael@ellerman.id.au>, Michael Neuling <mikey@neuling.org>, Michal Simek <monstr@monstr.eu>, Mike Frysinger <vapier@gentoo.org>, Oleg Nesterov <oleg@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>, Victor Kaplansky <VICTORK@il.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Will Deacon <will.deacon@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, jejb@parisc-linux.org, linux-alpha@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Nov 07, 2013 at 05:23:44PM +0100, Peter Zijlstra wrote:
> A number of situations currently require the heavyweight smp_mb(),
> even though there is no need to order prior stores against later
> loads.  Many architectures have much cheaper ways to handle these
> situations, but the Linux kernel currently has no portable way
> to make use of them.
> 
> This commit therefore supplies smp_load_acquire() and
> smp_store_release() to remedy this situation.  The new
> smp_load_acquire() primitive orders the specified load against
> any subsequent reads or writes, while the new smp_store_release()
> primitive orders the specifed store against any prior reads or
> writes.  These primitives allow array-based circular FIFOs to be
> implemented without an smp_mb(), and also allow a theoretical
> hole in rcu_assign_pointer() to be closed at no additional
> expense on most architectures.
> 
> In addition, the RCU experience transitioning from explicit
> smp_read_barrier_depends() and smp_wmb() to rcu_dereference()
> and rcu_assign_pointer(), respectively resulted in substantial
> improvements in readability.  It therefore seems likely that
> replacing other explicit barriers with smp_load_acquire() and
> smp_store_release() will provide similar benefits.  It appears
> that roughly half of the explicit barriers in core kernel code
> might be so replaced.
> 
> [Changelog by PaulMck]

As noted a few times in another thread, powerpc's smp_store_release()
needs to use smp_mb() rather than __lwsync(), like this:

#define smp_store_release(p, v)						\
do {									\
	compiletime_assert_atomic_type(*p);				\
	smp_mb();							\
	ACCESS_ONCE(*p) = (v);						\
} while (0)

Would you like to make this change, or should I send another patch?

							Thanx, Paul
