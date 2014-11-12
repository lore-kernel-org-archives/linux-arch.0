From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] arch: Introduce read_acquire()
Date: Wed, 12 Nov 2014 15:43:41 -0500 (EST)
Message-ID: <20141112.154341.1705628294274955796.davem@davemloft.net>
References: <20141111185510.2181.75347.stgit@ahduyck-workstation.home>
	<20141111194734.GL16265@arm.com>
	<54627BC0.4020705@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:46451 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbaKLUnu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 12 Nov 2014 15:43:50 -0500
In-Reply-To: <54627BC0.4020705@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: alexander.h.duyck@redhat.com
Cc: will.deacon@arm.com, alexander.duyck@gmail.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mikey@neuling.org, tony.luck@intel.com, mathieu.desnoyers@polymtl.ca, peterz@infradead.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, oleg@redhat.com, michael@ellerman.id.au, geert@linux-m68k.org, fweisbec@gmail.com, schwidefsky@de.ibm.com, linux@arm.linux.org.uk, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, mingo@kernel.org

From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Tue, 11 Nov 2014 13:12:32 -0800

> The architectures I need to sort out are arm, x86, sparc, ia64, and
> s390 as they are the only ones that tried to make use of the
> smp_load_acquire logic.

On sparc64, you don't have to worry about anything really.

Only mb() does anything.  The cpus execute in a reasonably strict
memory ordering mode, and that's why rmb/wmb and friends are simply
nops with a compiler barrier.
