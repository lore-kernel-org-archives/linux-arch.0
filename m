From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v6 tip/core/locking 3/8]
 Documentation/memory-barriers.txt: Prohibit speculative writes
Date: Thu, 12 Dec 2013 14:17:10 +0100
Message-ID: <20131212131710.GE5806@gmail.com>
References: <20131211215850.GA810@linux.vnet.ibm.com>
 <1386799151-2219-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <1386799151-2219-3-git-send-email-paulmck@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:58883 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab3LLNRP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Dec 2013 08:17:15 -0500
Content-Disposition: inline
In-Reply-To: <1386799151-2219-3-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, laijs@cn.fujitsu.com, dipankar@in.ibm.com, akpm@linux-foundation.org, mathieu.desnoyers@efficios.com, josh@joshtriplett.org, niv@us.ibm.com, tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com, darren@dvhart.com, fweisbec@gmail.com, oleg@redhat.com, sbw@mit.edu, Linux-Arch <linux-arch@vger.kernel.org>


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> 
> No SMP architecture currently supporting Linux allows speculative writes,
> so this commit updates Documentation/memory-barriers.txt to prohibit
> them in Linux core code.  It also records restrictions on their use.
> 
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

The signoff sequence looks weird here. If this came from Peter 
originally, did you mean:

  From: Peter Zijlstra <peterz@infradead.org>

instead of "From: Paul ..." ?

Thanks,

	Ingo
