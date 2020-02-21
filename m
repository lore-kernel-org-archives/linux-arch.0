From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 01/27] lockdep: Teach lockdep about "USED" <-
 "IN-NMI" inversions
Date: Fri, 21 Feb 2020 15:28:28 -0500
Message-ID: <20200221152828.7fe59d51@gandalf.local.home>
References: <20200221133416.777099322@infradead.org>
        <20200221134215.090538203@infradead.org>
        <20200221100855.2f9bec3a@gandalf.local.home>
        <20200221202511.GB14897@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgBUU2b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Feb 2020 15:28:31 -0500
In-Reply-To: <20200221202511.GB14897@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Fri, 21 Feb 2020 21:25:11 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > Nitpick, but the association with bit 16 and this mask really should be
> > defined as a macro somewhere and not have hard coded numbers.  
> 
> Right, I suppose I can do something like:
> 
> #define LOCKDEP_RECURSION_BITS	16
> #define LOCKDEP_OFF (1U << LOCKDEP_RECURSION_BITS)
> #define LOCKDEP_RECURSION_MASK (LOCKDEP_OFF - 1)

LGTM

-- Steve
