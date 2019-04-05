From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 07/21] x86/io: Remove useless definition of mmiowb()
Date: Fri, 5 Apr 2019 16:14:23 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1904051613500.1802@nanos.tec.linutronix.de>
References: <20190405135936.7266-1-will.deacon@arm.com> <20190405135936.7266-8-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405135936.7266-8-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redh>
List-Id: linux-arch.vger.kernel.org

On Fri, 5 Apr 2019, Will Deacon wrote:

> x86 maps mmiowb() to barrier(), but this is superfluous because a
> compiler barrier is already implied by spin_unlock(). Since x86 also
> includes asm-generic/io.h in its asm/io.h file, we can remove the

s/we can//

> definition entirely and pick up the dummy definition from core code.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
