From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 00/31] implement atomic_fetch_$op
Date: Fri, 22 Apr 2016 16:23:03 +0200
Message-ID: <20160422142303.GS3430@twins.programming.kicks-ass.net>
References: <20160422090413.393652501@infradead.org>
 <20160422094455.GO3430@twins.programming.kicks-ass.net>
 <20160422125656.GA15453@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:41209 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041AbcDVOXg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2016 10:23:36 -0400
Content-Disposition: inline
In-Reply-To: <20160422125656.GA15453@wfg-t540p.sh.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de

On Fri, Apr 22, 2016 at 08:56:56PM +0800, Fengguang Wu wrote:
> I'll add arm64-defconfig to P1 list to improve its coverage.

Thanks; any more architectures missing from P1?
