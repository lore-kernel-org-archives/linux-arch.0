Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:57809 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbcFHNdd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jun 2016 09:33:33 -0400
Date: Wed, 8 Jun 2016 15:32:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH -v2 00/33] implement atomic_fetch_$op
Message-ID: <20160608133242.GS30154@twins.programming.kicks-ass.net>
References: <20160531101925.702692792@infradead.org>
 <C2D7FE5348E1B147BCA15975FBA23075F4EAF393@us01wembx1.internal.synopsys.com>
 <20160602093304.GX3190@twins.programming.kicks-ass.net>
 <20160608124312.GA30927@twins.programming.kicks-ass.net>
 <20160608125530.GB11563@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160608125530.GB11563@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "will.deacon@arm.com" <will.deacon@arm.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, "waiman.long@hpe.com" <waiman.long@hpe.com>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "rth@twiddle.net" <rth@twiddle.net>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "egtvedt@samfundet.no" <egtvedt@samfundet.no>, "realmz6@gmail.com" <realmz6@gmail.com>, "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>, "rkuo@codeaurora.org" <rkuo@codeaurora.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "james.hogan@imgtec.com" <james.hogan@imgtec.com>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "dhowells@redhat.com" <dhowells@redhat.com>, "jejb@parisc-linux.org" <jejb@parisc-linux.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "dalias@libc.org" <dalias@libc.org>, "davem@davemloft.net" <davem@davemloft.net>, "cmetcalf@mellanox.com" <cmetcalf@mellanox.com>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "dbueso@suse.de" <dbueso@suse.de>, "fengguang.wu@intel.com" <fengguang.wu@intel.com>
Message-ID: <20160608133242.rdX1PotVv4mf2A9zcXgwESKA0fsal0JwunjQxD-oTrg@z>

On Wed, Jun 08, 2016 at 02:55:30PM +0200, Ingo Molnar wrote:

> I'd much prefer to have all of these in the locking tree (i.e. tip:locking/core), 
> to make it less painful all around.

All the fetch_op stuff, yes certainly. But Vineet wanted to munge
arch/arc/include/asm/atomic.h a bit in 4.7, which would make applying
the arc fetch_op patch tricky.

