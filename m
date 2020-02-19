From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v3 07/22] rcu: Mark rcu_dynticks_curr_cpu_in_eqs() inline
Date: Wed, 19 Feb 2020 08:39:34 -0800
Message-ID: <20200219163934.GA2935@paulmck-ThinkPad-P72>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.775936989@infradead.org>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgBSQjf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 11:39:35 -0500
Content-Disposition: inline
In-Reply-To: <20200219150744.775936989@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Wed, Feb 19, 2020 at 03:47:31PM +0100, Peter Zijlstra wrote:
> Since rcu_is_watching() is notrace (and needs to be, as it can be
> called from the tracers), make sure everything it in turn calls is
> notrace too.
> 
> To that effect, mark rcu_dynticks_curr_cpu_in_eqs() inline, which
> implies notrace, as the function is tiny.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

There was some controversy over inline vs. notrace, leading me to
ask whether we should use both inline and notrace here.  ;-)

Assuming that the usual tracing suspects are OK with it:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -294,7 +294,7 @@ static void rcu_dynticks_eqs_online(void
>   *
>   * No ordering, as we are sampling CPU-local information.
>   */
> -static bool rcu_dynticks_curr_cpu_in_eqs(void)
> +static inline bool rcu_dynticks_curr_cpu_in_eqs(void)
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  
> 
> 
