From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH -v2 22/33] locking,sparc: Implement
 atomic{,64}_fetch_{add,sub,and,or,xor}()
Date: Tue, 31 May 2016 10:50:57 -0700 (PDT)
Message-ID: <20160531.105057.1994007943543248986.davem@davemloft.net>
References: <20160531101925.702692792@infradead.org>
	<20160531102642.832054317@infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:35972 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbcEaRvA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2016 13:51:00 -0400
In-Reply-To: <20160531102642.832054317@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org
Cc: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com

From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 31 May 2016 12:19:47 +0200

> Implement FETCH-OP atomic primitives, these are very similar to the
> existing OP-RETURN primitives we already have, except they return the
> value of the atomic variable _before_ modification.
> 
> This is especially useful for irreversible operations -- such as
> bitops (because it becomes impossible to reconstruct the state prior
> to modification).
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: David S. Miller <davem@davemloft.net>
