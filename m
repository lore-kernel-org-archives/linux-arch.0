Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:45234 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965895Ab2FAWwM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jun 2012 18:52:12 -0400
Date: Fri, 01 Jun 2012 18:52:09 -0400 (EDT)
Message-ID: <20120601.185209.1098912234856410037.davem@davemloft.net>
Subject: Re: [UPDATED PATCH 20/27] sparc64, smpboot: Use generic SMP
 booting infrastructure
From: David Miller <davem@davemloft.net>
In-Reply-To: <4FC945C1.2000004@linux.vnet.ibm.com>
References: <20120601091449.31979.67743.stgit@srivatsabhat.in.ibm.com>
	<20120601.135522.2065505829159749961.davem@davemloft.net>
	<4FC945C1.2000004@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: srivatsa.bhat@linux.vnet.ibm.com
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com, paul.gortmaker@windriver.com, vapier@gentoo.org, jkosina@suse.cz, sparclinux@vger.kernel.org
Message-ID: <20120601225209.A_YHZ2-vjVYPsHNsT63M8sA2DT0wTmroK_OksnQXrOk@z>

From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Sat, 02 Jun 2012 04:14:17 +0530

> From: Nikunj A. Dadhania <nikunj@linux.vnet.ibm.com>
> 
> Convert sparc64 to use the generic framework to boot secondary CPUs.
> 
> Notes:
> Remove the calls to cpu_idle() from assembly files because we will invoke
> cpu_idle() in generic code.
> 
> Signed-off-by: Nikunj A. Dadhania <nikunj@linux.vnet.ibm.com>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Acked-by: David S. Miller <davem@davemloft.net>
