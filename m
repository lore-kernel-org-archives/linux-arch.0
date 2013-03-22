From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [patch 06/34] arc: Use generic idle loop
Date: Fri, 22 Mar 2013 14:32:34 +0530
Message-ID: <514C1E2A.8070308@synopsys.com>
References: <20130321214930.752934102@linutronix.de> <20130321215233.711253792@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from kiruna.synopsys.com ([198.182.44.80]:57505 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238Ab3CVJDt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Mar 2013 05:03:49 -0400
In-Reply-To: <20130321215233.711253792@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Magnus Damm <magnus.damm@gmail.com>

Hi Thomas,

> On 03/22/2013 03:23 AM, Thomas Gleixner wrote:

While the ARC specific changes look simple enough, do you have the series put up
somewhere which I can merge to give a quick build/run test.

Are you planning to add this to linux-next at some point as that will make it
really trivial to test out.

Thx,
-Vineet
