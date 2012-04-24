Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:11678 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756746Ab2DXQsC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Apr 2012 12:48:02 -0400
Date: Tue, 24 Apr 2012 11:47:59 -0500
From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [patch 11/18] hexagon: Use generic idle thread allocation
Message-ID: <20120424164759.GD3221@codeaurora.org>
References: <20120420122120.097464672@linutronix.de>
 <20120420124557.581762105@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120420124557.581762105@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, linux-hexagon@vger.kernel.org
Message-ID: <20120424164759.F-UgxB__jzgLfv75e7PgpWka1wGQTUjICO05QyYRnTs@z>

On Fri, Apr 20, 2012 at 01:05:51PM -0000, Thomas Gleixner wrote:
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Richard Kuo <rkuo@codeaurora.org>
> ---
>  arch/hexagon/Kconfig      |    1 +
>  arch/hexagon/kernel/smp.c |   11 ++---------
>  2 files changed, 3 insertions(+), 9 deletions(-)

Tested; works for me.

Acked-by: Richard Kuo <rkuo@codeaurora.org>


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
