From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC patch] introduce sys_membarrier(): process-wide memory
	barrier (v9)
Date: Thu, 25 Feb 2010 13:00:15 -0500
Message-ID: <20100225180014.GB6658@Krystal>
References: <20100212224606.GA30280@Krystal> <4B82CF1A.3010501@nortel.com> <20100222212321.GA2573@Krystal> <20100224091052.GY9738@laptop> <20100224152251.GA16295@Krystal> <20100225053310.GA9738@laptop> <20100225165301.GF24052@Krystal> <1267118726.6328.20.camel@gandalf.stny.rr.com> <20100225175121.GA6658@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.openrapids.net ([64.15.138.104]:37126 "EHLO
	blackscsi.openrapids.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933017Ab0BYSAS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 25 Feb 2010 13:00:18 -0500
Content-Disposition: inline
In-Reply-To: <20100225175121.GA6658@Krystal>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, mingo@elte.hu
Cc: Nick Piggin <npiggin@suse.de>, Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Nicholas Miell <nmiell@comcast.net>, Linus Torvalds <torvalds@linux-foundation.org>, laijs@cn.fujitsu.com, dipankar@in.ibm.com, akpm@linux-foundation.org, josh@joshtriplett.org, dvhltc@us.ibm.com, niv@us.ibm.com, tglx@linutronix.de, peterz@infradead.org, Valdis.Kletnieks@vt.edu, dhowells@redhat.com

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
[...]
> But... either way we chose, we can extend the system call flags and parameters
> as needed, so I think it really should not be part of this initial
> implementation.

So... considering all this discussion is about future enhancements that are not
required by anyone at this stage, and that it will be possible to add these
later on thanks to the extensible sys_membarrier() flags, I propose to merge v9
of this patch for 2.6.34. I think the logical path for this patch is to go
through Ingo's tree, as it sits mostly along with the scheduler, but I have not
heard anything from him yet. Am I taking the correct path ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency Consultant
EfficiOS Inc.
http://www.efficios.com
