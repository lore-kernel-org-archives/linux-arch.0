From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [patch 30/34] tile: Enter idle with preemption disabled
Date: Fri, 22 Mar 2013 16:34:46 -0400
Message-ID: <514CC066.8080307@tilera.com>
References: <20130321214930.752934102@linutronix.de> <20130321215235.280451779@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:41269 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422920Ab3CVUet (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Mar 2013 16:34:49 -0400
In-Reply-To: <20130321215235.280451779@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Magnus Damm <magnus.damm@gmail.com>

On 3/21/2013 5:53 PM, Thomas Gleixner wrote:
> cpu_idle() needs to be called with preemption disabled.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> ---
>  arch/tile/kernel/smpboot.c |    2 --
>  1 file changed, 2 deletions(-)

Thanks.  I had fixed this in our internal tree, but hadn't pushed it up yet.  I'll take your version into the public tile tree.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
