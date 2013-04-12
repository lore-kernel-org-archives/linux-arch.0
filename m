From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] sparc: Use generic idle loop
Date: Fri, 12 Apr 2013 14:58:23 -0400 (EDT)
Message-ID: <20130412.145823.1608861418189836214.davem@davemloft.net>
References: <20130408.152449.169732563685022388.davem@davemloft.net>
	<20130411193850.GA2330@merkur.ravnborg.org>
	<alpine.LFD.2.02.1304122055210.21884@ionos>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:52409 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547Ab3DLS60 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Apr 2013 14:58:26 -0400
In-Reply-To: <alpine.LFD.2.02.1304122055210.21884@ionos>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de
Cc: sam@ravnborg.org, srivatsa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, rusty@rustcorp.com.au, paulmck@linux.vnet.ibm.com, mingo@elte.hu, peterz@infradead.org, magnus.damm@gmail.com

From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 12 Apr 2013 20:56:10 +0200 (CEST)

> On Thu, 11 Apr 2013, Sam Ravnborg wrote:
> 
>> Add generic cpu_idle support
>> 
>> sparc32:
>> - replace call to cpu_idle() with cpu_startup_entry()
>> - add arch_cpu_idle()
>> 
>> sparc64:
>> - smp_callin() now include cpu_startup_entry() call so we can
>>   skip calling cpu_idle from assembler
>> - add arch_cpu_idle() and arch_cpu_idle_dead()
> 
> Nice !
> 
> If Dave acks it, I'll pick it up 

Acked-by: David S. Miller <davem@davemloft.net>
