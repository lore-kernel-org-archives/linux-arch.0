From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [patch 30/34] tile: Enter idle with preemption disabled
Date: Fri, 22 Mar 2013 16:40:12 -0400
Message-ID: <514CC1AC.4060006@tilera.com>
References: <20130321214930.752934102@linutronix.de> <20130321215235.280451779@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:9503 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422900Ab3CVUkN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Mar 2013 16:40:13 -0400
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

Or, given this is part of a series you're presumably intending to push yourself, it probably makes more sense just to add my

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

to both this patch and patch 31/34.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
