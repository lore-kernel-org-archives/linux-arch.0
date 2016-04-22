From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC][PATCH 00/31] implement atomic_fetch_$op
Date: Fri, 22 Apr 2016 14:03:57 +0100
Message-ID: <20160422130357.GH10289@arm.com>
References: <20160422090413.393652501@infradead.org>
 <20160422094455.GO3430@twins.programming.kicks-ass.net>
 <20160422125656.GA15453@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160422125656.GA15453@wfg-t540p.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 22, 2016 at 08:56:56PM +0800, Fengguang Wu wrote:
> On Fri, Apr 22, 2016 at 11:44:55AM +0200, Peter Zijlstra wrote:
> > On Fri, Apr 22, 2016 at 11:04:13AM +0200, Peter Zijlstra wrote:
> > > The one that I did not do was ARMv8.1-LSE and I was hoping Will would help out
> > > with that. Also, it looks like the 0-day built bot does not do arm64 builds,
> > > people might want to look into that.
> > 
> > OK, weirdness. I received the "BUILD SUCCESS" email without any arm64
> > builds listed, but I just received a build bot email telling me the
> > arm64 build was borked (which I know it is).
> 
> Sorry, that may happen because even though most errors will be
> detected in the first hour or before the BUILD SUCCESS/DONE
> notification, the build/boot/performance tests for a particular branch
> may continue for days, during the time test coverage keeps growing.
> Which means it's possible to receive a build failure after receiving
> BUILD SUCCESS notification.
> 
> In particular, 0-day bot classify 500+ kconfigs into 2 priority lists:
> 
> P1: 100+ realtime priority kconfigs which should be finished before sending
>     out BUILD SUCCESS notification
> 
> P2: 400+ background priority kconfigs which may take hours to days to finish
> 
> That split is a tradeoff between timeliness and completeness. It turns
> out to work well as long as we choose the suitable P1 list.
> 
> So the more accurate interpretation of "BUILD SUCCESS/DONE" would be:
> 0day bot is working on your tree (no worry about out-of-service) and
> reached a major milestone.
> 
> I'll add arm64-defconfig to P1 list to improve its coverage.

That's good to hear, thanks Fengguang!

Will
