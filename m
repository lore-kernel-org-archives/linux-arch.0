Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate3.de.ibm.com ([195.212.29.152]:9568 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751323AbWIOMGL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Sep 2006 08:06:11 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id k8FC69wT148814
	for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2006 12:06:09 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com [9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8FCAmDT3141794
	for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2006 14:10:48 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8FC68Kj023460
	for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2006 14:06:08 +0200
Subject: Re: [patch 1/2] Directed yield: cpu_relax variants for spinlocks
	and rw-locks.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <17674.38270.541900.580212@cargo.ozlabs.ibm.com>
References: <20060915113039.GE23134@skybase>
	 <17674.38270.541900.580212@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 14:06:07 +0200
Message-Id: <1158321967.23993.15.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: linux-arch@vger.kernel.org, mingo@elte.hu
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2006-09-15 at 21:58 +1000, Paul Mackerras wrote:
> > In order to implement a spinlock that yields the cpu in favour of
> > the current lock holder cpu_relax variants for spinlocks and
> > read/write locks are needed. The new _raw_spin_relax, _raw_read_relax
> > and _raw_write_relax primitives have an additional argument: the
> > pointer to the lock structure.
> 
> This will be useful on powerpc as well.  We need:
> 
> #define _raw_spin_relax(lock)	__spin_yield(lock)
> #define _raw_read_relax(lock)	__rw_yield(lock)
> #define _raw_write_relax(lock)	__rw_yield(lock)
> 
> in order to define your new primitives in terms of what we already
> have defined in asm-powerpc/spinlock.h.

Ahh, I haven't seen that powerpc already has a __spin_yield. I'll change
the patch accordingly.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


