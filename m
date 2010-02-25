From: Steven Rostedt <rostedt@goodmis.org>
Subject: Add this to tip (was: Re: [RFC patch] introduce sys_membarrier():
 process-wide memory barrier (v9))
Date: Thu, 25 Feb 2010 13:20:37 -0500
Message-ID: <1267122037.6328.40.camel@gandalf.stny.rr.com>
References: <20100212224606.GA30280@Krystal> <4B82CF1A.3010501@nortel.com>
	 <20100222212321.GA2573@Krystal> <20100224091052.GY9738@laptop>
	 <20100224152251.GA16295@Krystal> <20100225053310.GA9738@laptop>
	 <20100225165301.GF24052@Krystal>
	 <1267118726.6328.20.camel@gandalf.stny.rr.com>
	 <20100225175121.GA6658@Krystal>  <20100225180014.GB6658@Krystal>
Reply-To: rostedt@goodmis.org
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:34702 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933253Ab0BYSUr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Feb 2010 13:20:47 -0500
In-Reply-To: <20100225180014.GB6658@Krystal>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: mingo@elte.hu, Nick Piggin <npiggin@suse.de>, Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Nicholas Miell <nmiell@comcast.net>, Linus Torvalds <torvalds@linux-foundation.org>, laijs@cn.fujitsu.com, dipankar@in.ibm.com, akpm@linux-foundation.org, josh@joshtriplett.org, dvhltc@us.ibm.com, niv@us.ibm.com, tglx@linutronix.de, peterz@infradead.org, Valdis.Kletnieks@vt.edu, dhowells@redhat.com

On Thu, 2010-02-25 at 13:00 -0500, Mathieu Desnoyers wrote:

> So... considering all this discussion is about future enhancements that are not
> required by anyone at this stage, and that it will be possible to add these
> later on thanks to the extensible sys_membarrier() flags, I propose to merge v9
> of this patch for 2.6.34. I think the logical path for this patch is to go
> through Ingo's tree, as it sits mostly along with the scheduler, but I have not
> heard anything from him yet. Am I taking the correct path ?

I agree this should probably go through tip. I'm sure Ingo is busy
working through the merge window now too, and is not focusing on this
thread.

Anyway, this thread still has RFC in it. Send out a new patch (new
thread) with the Subject:

[PATCH -tip] introduce sys_membarrier(): process-wide memory barrier (v9))


With all Acked-by's given and state that it is ready for inclusion in
v2.6.34. (make this statement at the top of the email) It may still not
make 2.6.34, but at least it will be on its way to 2.6.25 (or 3.0
*wish*)


-- Steve
