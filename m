Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:49126 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751293AbWIOL7O (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Sep 2006 07:59:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17674.38270.541900.580212@cargo.ozlabs.ibm.com>
Date: Fri, 15 Sep 2006 21:58:54 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 1/2] Directed yield: cpu_relax variants for spinlocks and rw-locks.
In-Reply-To: <20060915113039.GE23134@skybase>
References: <20060915113039.GE23134@skybase>
Sender: linux-arch-owner@vger.kernel.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org, mingo@elte.hu
List-ID: <linux-arch.vger.kernel.org>

Martin Schwidefsky writes:

> In order to implement a spinlock that yields the cpu in favour of
> the current lock holder cpu_relax variants for spinlocks and
> read/write locks are needed. The new _raw_spin_relax, _raw_read_relax
> and _raw_write_relax primitives have an additional argument: the
> pointer to the lock structure.

This will be useful on powerpc as well.  We need:

#define _raw_spin_relax(lock)	__spin_yield(lock)
#define _raw_read_relax(lock)	__rw_yield(lock)
#define _raw_write_relax(lock)	__rw_yield(lock)

in order to define your new primitives in terms of what we already
have defined in asm-powerpc/spinlock.h.

Thanks,
Paul.
