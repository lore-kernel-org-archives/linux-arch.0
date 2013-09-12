From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH 2/7] sched: Add NEED_RESCHED to the preempt_count
Date: Thu, 12 Sep 2013 08:01:41 +0200
Message-ID: <1378965701.10696.36.camel@marge.simpson.net>
References: <20130910130811.507933095@infradead.org>
	 <20130910132011.116593485@infradead.org> <522FCE9D.4010707@amacapital.net>
	 <20130911082530.GN31370@twins.programming.kicks-ass.net>
	 <20130911110635.GT26785@twins.programming.kicks-ass.net>
	 <1378906497.5476.97.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:64232 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab3ILGD5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Sep 2013 02:03:57 -0400
In-Reply-To: <1378906497.5476.97.camel@marge.simpson.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andi Kleen <ak@linux.intel.com>, Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Len Brown <lenb@kernel.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

On Wed, 2013-09-11 at 15:34 +0200, Mike Galbraith wrote: 
> On Wed, 2013-09-11 at 13:06 +0200, Peter Zijlstra wrote: 

> > Mike does it fix the funny you saw?
> 
> Yup, modulo test_need_resched() not existing in master.

...

> while I haven't yet booted Q6600 box, core2
> Toshiba Satellite lappy is using mwait_idle_with_hints() in master.

Heh.  Core2 lappy uses mwait_idle_with_hints().. unless you boot
processor.max_cstate=1 so it doesn't use piece of shite hpet.  Q6600
always has idle woes, seemingly because box doesn't do deep enough
cstate to make something (acpi?) happy, despite mwait_idle() having
worked fine for years.

Seems I need to find the cstate dependency spot, and rap it upside the
head if I want my core2 boxen to regain happy campers status.

-Mike
