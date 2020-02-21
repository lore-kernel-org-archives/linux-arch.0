From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 01/27] lockdep: Teach lockdep about "USED" <-
 "IN-NMI" inversions
Date: Fri, 21 Feb 2020 10:08:55 -0500
Message-ID: <20200221100855.2f9bec3a@gandalf.local.home>
References: <20200221133416.777099322@infradead.org>
        <20200221134215.090538203@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200221134215.090538203@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, 21 Feb 2020 14:34:17 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -379,13 +379,13 @@ void lockdep_init_task(struct task_struc
>  
>  void lockdep_off(void)
>  {
> -	current->lockdep_recursion++;
> +	current->lockdep_recursion += BIT(16);
>  }
>  EXPORT_SYMBOL(lockdep_off);
>  
>  void lockdep_on(void)
>  {
> -	current->lockdep_recursion--;
> +	current->lockdep_recursion -= BIT(16);
>  }
>  EXPORT_SYMBOL(lockdep_on);
>  

> +
> +static bool lockdep_nmi(void)
> +{
> +	if (current->lockdep_recursion & 0xFFFF)

Nitpick, but the association with bit 16 and this mask really should be
defined as a macro somewhere and not have hard coded numbers.

-- Steve

> +		return false;
> +
> +	if (!in_nmi())
> +		return false;
> +
> +	return true;
> +}
> +
