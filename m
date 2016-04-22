From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 00/31] implement atomic_fetch_$op
Date: Fri, 22 Apr 2016 11:44:55 +0200
Message-ID: <20160422094455.GO3430@twins.programming.kicks-ass.net>
References: <20160422090413.393652501@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160422090413.393652501@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 22, 2016 at 11:04:13AM +0200, Peter Zijlstra wrote:
> The one that I did not do was ARMv8.1-LSE and I was hoping Will would help out
> with that. Also, it looks like the 0-day built bot does not do arm64 builds,
> people might want to look into that.

OK, weirdness. I received the "BUILD SUCCESS" email without any arm64
builds listed, but I just received a build bot email telling me the
arm64 build was borked (which I know it is).
