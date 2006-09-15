Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate5.de.ibm.com ([195.212.29.154]:20032 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751272AbWIOLa1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Sep 2006 07:30:27 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id k8FBUQCO080612
	for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2006 11:30:26 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8FBZ5oL2891838
	for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2006 13:35:05 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8FBUPX2016752
	for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2006 13:30:25 +0200
Date: Fri, 15 Sep 2006 13:30:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/2] Directed yield.
Message-ID: <20060915113024.GD23134@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, mingo@elte.hu
List-ID: <linux-arch.vger.kernel.org>

Hi folks,
with CONFIG_PREEMPT=y the spin_lock/read_lock/write_lock functions are
defined in kernel/spinlock.c with a loop over _raw_##op##_trylock. If
the lock could not be taken cpu_relax is called. The architecture can't
choose to do something else instead of cpu_relax. To implement a
directed yield that gives up the timeslice of a virtual cpu in
favour of a specific cpu, the cpu_relax needs to be replaced with
something new: _raw_spin_relax, _raw_read_relax or _raw_write_relax.

Patch #01 introduces the new primitives and patch #02 has the s390
implementation for directed yield as example for the use of the
primitives.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.

