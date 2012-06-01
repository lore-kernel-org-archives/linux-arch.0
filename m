Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:45268 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965890Ab2FAWxo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jun 2012 18:53:44 -0400
Date: Fri, 01 Jun 2012 18:53:41 -0400 (EDT)
Message-ID: <20120601.185341.1462375672682064314.davem@davemloft.net>
Subject: Re: [UPDATED PATCH 21/27] sparc32, smpboot: Use generic SMP
 booting infrastructure
From: David Miller <davem@davemloft.net>
In-Reply-To: <4FC94693.5050707@linux.vnet.ibm.com>
References: <20120601.135612.699120609738854050.davem@davemloft.net>
	<20120601185448.GA19148@merkur.ravnborg.org>
	<4FC94693.5050707@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: srivatsa.bhat@linux.vnet.ibm.com
Cc: sam@ravnborg.org, tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com, vapier@gentoo.org, konrad@gaisler.com, tkhai@yandex.ru, sparclinux@vger.kernel.org
Message-ID: <20120601225341.WPFYC1h756n8uR5D1AdPqRKlIhkW3iOPCqwjvlGPEjc@z>

From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Sat, 02 Jun 2012 04:17:47 +0530

> 
> Convert sparc32 to use the generic framework to boot secondary CPUs.
> 
> Notes:
> While removing the call to cpu_idle(), we can also remove the call to
> cpu_panic() because we are calling BUG() in the generic code anyway.
> 
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Almost there, but not quite yet.

You can't get rid of the cpu_panic invocations, those have to be there
after the *_callin calls to catch if they accidently return.
