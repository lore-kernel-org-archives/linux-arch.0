From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4 04/27] x86/mce: Delete ist_begin_non_atomic()
Date: Sat, 22 Feb 2020 00:40:02 +0100
Message-ID: <20200221234001.GC28251@lenoir>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.264229755@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbgBUXkF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Feb 2020 18:40:05 -0500
Content-Disposition: inline
In-Reply-To: <20200221134215.264229755@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com, mhiramat@kernel.org

On Fri, Feb 21, 2020 at 02:34:20PM +0100, Peter Zijlstra wrote:
> It is an abomination; and in prepration of removing the whole
> ist_enter() thing, it needs to go.
> 
> Convert #MC over to using task_work_add() instead; it will run the
> same code slightly later, on the return to user path of the same
> exception.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
