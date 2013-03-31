From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] sparc: Use generic idle loop
Date: Sun, 31 Mar 2013 19:46:16 -0400 (EDT)
Message-ID: <20130331.194616.1802921705658512929.davem@davemloft.net>
References: <20130321214930.752934102@linutronix.de>
	<20130329161905.GC6201@merkur.ravnborg.org>
	<20130329202926.GA9484@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:49936 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756214Ab3CaXqS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 31 Mar 2013 19:46:18 -0400
In-Reply-To: <20130329202926.GA9484@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: sam@ravnborg.org
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, rusty@rustcorp.com.au, paulmck@linux.vnet.ibm.com, mingo@elte.hu, peterz@infradead.org, srivatsa.bhat@linux.vnet.ibm.com, magnus.damm@gmail.com

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 29 Mar 2013 21:29:26 +0100

> Add generic cpu_idle support
> 
> sparc32:
> - replace call to cpu_idle() with cpu_startup_entry()
> - add arch_cpu_idle()
> 
> sparc64:
> - smp_callin() includes cpu_startup_entry() call so we can
>   skip calling cpu_idle from assembler
> - add arch_cpu_idle_enter() and arch_cpu_idle_dead()
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Acked-by: David S. Miller <davem@davemloft.net>
