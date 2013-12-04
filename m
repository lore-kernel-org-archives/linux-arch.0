From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v3 10/19] smp, metag: kill SMP single function call
 interrupt
Date: Wed, 4 Dec 2013 16:38:45 +0000
Message-ID: <529F5A95.9050307@imgtec.com>
References: <1386173591-28514-1-git-send-email-liuj97@gmail.com> <1386173591-28514-11-git-send-email-liuj97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:9590 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755782Ab3LDQiu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 4 Dec 2013 11:38:50 -0500
In-Reply-To: <1386173591-28514-11-git-send-email-liuj97@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shaohua Li <shli@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-metag@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <trivial@kernel.org>, Wang YanQing <udknight@gmail.com>, linux-arch@vger.kernel.org

On 04/12/13 16:13, Jiang Liu wrote:
> Commit 9a46ad6d6df3b54 "smp: make smp_call_function_many() use logic
> similar to smp_call_function_single()" has unified the way to handle
> single and multiple cross-CPU function calls. Now only one intterupt

s/intterupt/interrupt/

> is needed for architecture specific code to support generic SMP function
> call interfaces, so kill the redundant single function call interrupt.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shaohua Li <shli@kernel.org>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Jiri Kosina <trivial@kernel.org>
> Cc: James Hogan <james.hogan@imgtec.com>
> Signed-off-by: Jiang Liu <liuj97@gmail.com>

Acked-by: James Hogan <james.hogan@imgtec.com>

Do you want me to take this patch through the metag tree for v3.14 or
let it go via another tree with the other patches?

Thanks
James
