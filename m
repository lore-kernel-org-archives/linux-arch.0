From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 2/9] rcu: Mark rcu_dynticks_curr_cpu_in_eqs() inline
Date: Wed, 12 Feb 2020 17:38:18 -0500
Message-ID: <20200212223818.GA115917@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.915180520@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35204 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgBLWiU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 17:38:20 -0500
Received: by mail-qk1-f195.google.com with SMTP id v2so3811186qkj.2
        for <linux-arch@vger.kernel.org>; Wed, 12 Feb 2020 14:38:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200212210749.915180520@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On Wed, Feb 12, 2020 at 10:01:41PM +0100, Peter Zijlstra wrote:
> Since rcu_is_watching() is notrace (and needs to be, as it can be
> called from the tracers), make sure everything it in turn calls is
> notrace too.
> 
> To that effect, mark rcu_dynticks_curr_cpu_in_eqs() inline, which
> implies notrace, as the function is tiny.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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

I think there are ways to turn off function inlining, such as gcc's:
-fkeep-inline-functions

And just to be sure weird compilers (clang *cough*) don't screw this up,
could we make it static inline notrace?

Build tested it on the tip tree on top of your patch:

---8<-----------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f3cb824fe5bbf..078d56951c8e7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -294,7 +294,7 @@ static void rcu_dynticks_eqs_online(void)
  *
  * No ordering, as we are sampling CPU-local information.
  */
-static inline bool rcu_dynticks_curr_cpu_in_eqs(void)
+static inline notrace bool rcu_dynticks_curr_cpu_in_eqs(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
