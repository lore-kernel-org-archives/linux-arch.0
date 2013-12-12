From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 tip/core/locking 3/8]
 Documentation/memory-barriers.txt: Prohibit speculative writes
Date: Thu, 12 Dec 2013 07:08:44 -0800
Message-ID: <20131212150844.GZ4208@linux.vnet.ibm.com>
References: <20131211215850.GA810@linux.vnet.ibm.com>
 <1386799151-2219-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <1386799151-2219-3-git-send-email-paulmck@linux.vnet.ibm.com>
 <20131212131710.GE5806@gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:36873 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab3LLPIw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Dec 2013 10:08:52 -0500
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 12 Dec 2013 08:08:52 -0700
Content-Disposition: inline
In-Reply-To: <20131212131710.GE5806@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, laijs@cn.fujitsu.com, dipankar@in.ibm.com, akpm@linux-foundation.org, mathieu.desnoyers@efficios.com, josh@joshtriplett.org, niv@us.ibm.com, tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com, darren@dvhart.com, fweisbec@gmail.com, oleg@redhat.com, sbw@mit.edu, Linux-Arch <linux-arch@vger.kernel.org>

On Thu, Dec 12, 2013 at 02:17:10PM +0100, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > 
> > No SMP architecture currently supporting Linux allows speculative writes,
> > so this commit updates Documentation/memory-barriers.txt to prohibit
> > them in Linux core code.  It also records restrictions on their use.
> > 
> > Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> The signoff sequence looks weird here. If this came from Peter 
> originally, did you mean:
> 
>   From: Peter Zijlstra <peterz@infradead.org>
> 
> instead of "From: Paul ..." ?

Indeed I did!  I will fix.

							Thanx, Paul
