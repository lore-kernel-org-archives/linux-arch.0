Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34838 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752850AbcDVOXY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 22 Apr 2016 10:23:24 -0400
Date: Fri, 22 Apr 2016 15:23:16 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC][PATCH 05/31] locking,arm64: Implement
 atomic{,64}_fetch_{add,sub,and,andnot,or,xor}{,_relaxed,_acquire,_release}()
Message-ID: <20160422142316.GI10289@arm.com>
References: <20160422090413.393652501@infradead.org>
 <20160422093923.366551860@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160422093923.366551860@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com
Message-ID: <20160422142316.bHz1fHCvDk0fqn1NWKfrKxnfqYdyGPkmx36hMBz9oF8@z>

On Fri, Apr 22, 2016 at 11:04:18AM +0200, Peter Zijlstra wrote:
> Implement FETCH-OP atomic primitives, these are very similar to the
> existing OP-RETURN primitives we already have, except they return the
> value of the atomic variable _before_ modification.
> 
> This is especially useful for irreversible operations -- such as
> bitops (because it becomes impossible to reconstruct the state prior
> to modification).

The LSE bits will take me some time, but you're also missing some stuff
for the LL/SC variants. Fixup below.

Will

--->8
