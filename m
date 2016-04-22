Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:41236 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336AbcDVO1P (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2016 10:27:15 -0400
Date: Fri, 22 Apr 2016 16:26:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 03/31] locking,arc: Implement
 atomic_fetch_{add,sub,and,andnot,or,xor}()
Message-ID: <20160422142645.GT3430@twins.programming.kicks-ass.net>
References: <20160422090413.393652501@infradead.org>
 <20160422093923.218866387@infradead.org>
 <C2D7FE5348E1B147BCA15975FBA23075F4E9EF11@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F4E9EF11@us01wembx1.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "will.deacon@arm.com" <will.deacon@arm.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, "waiman.long@hpe.com" <waiman.long@hpe.com>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "rth@twiddle.net" <rth@twiddle.net>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "egtvedt@samfundet.no" <egtvedt@samfundet.no>, "realmz6@gmail.com" <realmz6@gmail.com>, "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>, "rkuo@codeaurora.org" <rkuo@codeaurora.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "james.hogan@imgtec.com" <james.hogan@imgtec.com>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "dhowells@redhat.com" <dhowells@redhat.com>, "jejb@parisc-linux.org" <jejb@parisc-linux.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "dalias@libc.org" <dalias@libc.org>, "davem@davemloft.net" <davem@davemloft.net>, "cmetcalf@mellanox.com" <cmetcalf@mellanox.com>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "dbueso@suse.de" <dbueso@suse.de>, "fengguang.wu@intel.com" <fengguang.wu@intel.com>
Message-ID: <20160422142645.S8OhgbX-iSshZUjbMiaeg15rD5XILXswhg4jygDF9uo@z>

On Fri, Apr 22, 2016 at 10:50:41AM +0000, Vineet Gupta wrote:
> Also per your other comment/patches, converting ARC to _relaxed atomics sounds
> trivial, I can provide a fixup patch once your series is stable'ish and u point me
> to ur git tree or some such .

Yeah, that change is pretty simple; I ran out of steam and only did
alpha and mips in this series.


