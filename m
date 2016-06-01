From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH -v2 19/33] locking,powerpc: Implement
 atomic{,64}_fetch_{add,sub,and,or,xor}{,_relaxed,_acquire,_release}()
Date: Wed, 1 Jun 2016 10:46:23 +0200
Message-ID: <20160601084623.GM3190@twins.programming.kicks-ass.net>
References: <20160531101925.702692792@infradead.org>
 <20160531102642.648971209@infradead.org>
 <20160601031138.GA30064@insomnia>
 <20160601061045.GB30064@insomnia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160601061045.GB30064@insomnia>
Sender: linux-kernel-owner@vger.kernel.org
To: Boqun Feng <boqun.feng@gmail.com>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 01, 2016 at 02:10:45PM +0800, Boqun Feng wrote:
> On Wed, Jun 01, 2016 at 11:11:38AM +0800, Boqun Feng wrote:

> > Looks like I missed this one in v1, it should be
> > 	
> > 	return res;

Indeed.

> > because the primitives will return the values before modified by the
> > operations.
> > 
> 
> FWIW, I tested on ppc with ATOMIC64_SELFTEST=y for the following branch:

Thanks, I'll add a tested-by tag with your name on ;-)
