Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347158;
	b=v+hStehKr5q7ajv9+n5iOQFZWwyDZE/YXwt2Tvn3KjNHKBwvvOu4hAwzdy+Iw938FLo1
	 tPwrJZC96iR84dDhbInWq/xopR50/0Kad2UOpasYm0grRcr3F+u3+f4HENn+2tiJDx0WS
	 ixQ05uxz8TChkWGvn/rKlLPkuWzCv8+Zc1VWbHh/CeVGjnXW/PTi5LCf8JWA2zI0jrddL
	 xd6GDoOsMQWdoWRfJk0LHNEzgMNAipgSi8zrMZQUXCpW9nVsweZ+LiTRD1TxgnxNC8COl
	 CiUojmyIVsTqjMp+oT4w73W8HQrH2z6FDcxzEoz4u43l0FrNzIBEI7WzT7wR71SH06w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347158;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=M7sF+0lKlZFH44EHViGdUB0omP3CtyYvzMtcq6TGobs=;
	b=eWbvzDJS9poxUb7IT84qHwnRktah++VUNi6Bl6UxtBsifculLW95X0o30QiN1Or3ik4s
	 wnBAKB3OXCJu3yoUwSyl5JWu6Ws9sQBwm6BBsMWNUzZEkipvk5ksUxZxDAjAR4FZd1j7w
	 eu0tBpNFxLx+R6o4a1aVSxk9BRfg4sRITyQ14byFdFri1itgBRZbM4aP5VuzIdk540XDg
	 7urdx8oh+/+X3fZZEYwF761g7GnT5CWHJ1yhpmDug5KmRKGc8lh5++RaTjS3umNlJjhT2
	 jlDBSK4m+E1UNEupIUiXb9RzK+kB2KGqQIQpuBXQZAmHvNwJdBfVeZBEDm6vBGydzBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jSzjzpFC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A46B606A31C;
	Tue, 10 Nov 2026 21:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jSzjzpFC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F3F1F0089F;
	Tue, 10 Nov 2026 21:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794347157;
	bh=M7sF+0lKlZFH44EHViGdUB0omP3CtyYvzMtcq6TGobs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=jSzjzpFC1lJq45DadIevqR8IeWuHrceuuyjJmbb3DW3ua0ZtVYxMqJN9PBqMZnkZY
	 DDBAaYHJY7PFLY0yJ2XCEKqA5hJeXyPXeeWtmsv/XokjdZc/IKP/s4oVwzFk5XJ/tc
	 5IS74XL6vV5moDkNopRSX0mmUC14Eyx5V/AM1gHUK+YZKuobuf948fzormXlenhEXu
	 1nDeid3UkvsfM7NijlAG9oYFkJlmU97J+T94A6NvLEZa9izsp3DnhIgRK+dSAGoZEC
	 A5MuPweukTvUhR/yF1aJX4PDZEY6UbsC29dW9gv0/CpaD4UceosfEbd3tPgjUaIOsL
	 6a+3L4Hm6Epsg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 96F99CE0AD8; Tue, 10 Nov 2026 13:45:57 -0800 (PST)
Date: Tue, 10 Nov 2026 13:45:57 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: boqun@kernel.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, corbet@lwn.net, mingo@redhat.com,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org, urezki@gmail.com, dave@stgolabs.net,
	stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joelagnelf@nvidia.com,
	skhan@linuxfoundation.org, rdunlap@infradead.org,
	longman@redhat.com, rostedt@goodmis.org, qiang.zhang@linux.dev,
	brads@mainlining.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org, rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 23/28] rcuscale: Add hazptr scale type
Message-ID: <c4f84631-5805-4750-a7bb-3fd5a24bbb62@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
 <20261104165504.2430480-24-kunwu.chan@gmail.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104165504.2430480-24-kunwu.chan@gmail.com>

On Thu, Nov 05, 2026 at 12:54:41AM +0800, Kunwu Chan wrote:
> Add a hazptr scale type for per-writer hazptr_synchronize()
> cost and per-reader hazptr_acquire()/hazptr_release() overhead.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> ---
>  kernel/rcu/rcuscale.c | 67 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 5659eaebc5c0..6e3e3f296f85 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -40,6 +40,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/rcupdate_trace.h>
>  #include <linux/sched/debug.h>
> +#include <linux/hazptr.h>
>  
>  #include "rcu.h"
>  
> @@ -460,6 +461,71 @@ static struct rcu_scale_ops tasks_tracing_ops = {
>  
>  #endif // #else // #ifdef CONFIG_TASKS_TRACE_RCU
>  
> +#if IS_ENABLED(CONFIG_HAZPTR_TORTURE_TEST)

Ah, maybe this is why you want hazptrtorture and rcuscale to be built
into the same kernel.

But what you really want is hazard pointers to be built in, right?
As opposed to the torture test?  But this patch will be on top of the
patches providing unconditional hazard-pointer support in the kernel,
so you can just omit the above #ifdef.

The reason for the CONFIG_HAZPTR_TORTURE_TEST #ifdef is that it is
possible to build kernels that do not support Tasks Trace RCU.

							Thanx, Paul

> +#define HAZPTR_SCALE_NR_OBJS 8
> +static int hazptr_scale_obj[HAZPTR_SCALE_NR_OBJS];
> +static atomic_t hazptr_scale_sync_idx = ATOMIC_INIT(0);
> +
> +struct hazptr_scale_state {
> +	struct hazptr_ctx ctx;
> +	void *addr;
> +};
> +static DEFINE_PER_CPU(struct hazptr_scale_state, hazptr_scale_state);
> +
> +static int hazptr_scale_read_lock(void)
> +{
> +	struct hazptr_scale_state *state = this_cpu_ptr(&hazptr_scale_state);
> +	int idx = smp_processor_id() % HAZPTR_SCALE_NR_OBJS;
> +	void *ptr = &hazptr_scale_obj[idx];
> +
> +	state->addr = hazptr_acquire(&state->ctx, &ptr);
> +	return 0;
> +}
> +
> +static void hazptr_scale_read_unlock(int idx)
> +{
> +	struct hazptr_scale_state *state = this_cpu_ptr(&hazptr_scale_state);
> +
> +	hazptr_release(&state->ctx, state->addr);
> +}
> +
> +static unsigned long hazptr_scale_completed(void)
> +{
> +	return 0;
> +}
> +
> +static void hazptr_scale_sync(void)
> +{
> +	int idx = atomic_fetch_inc(&hazptr_scale_sync_idx) % HAZPTR_SCALE_NR_OBJS;
> +
> +	hazptr_synchronize(&hazptr_scale_obj[idx]);
> +}
> +
> +static void hazptr_scale_sync_exp(void)
> +{
> +	int idx = atomic_fetch_inc(&hazptr_scale_sync_idx) % HAZPTR_SCALE_NR_OBJS;
> +
> +	hazptr_synchronize(&hazptr_scale_obj[idx]);
> +}
> +
> +static struct rcu_scale_ops hazptr_scale_ops = {
> +	.ptype		= 0,
> +	.readlock	= hazptr_scale_read_lock,
> +	.readunlock	= hazptr_scale_read_unlock,
> +	.get_gp_seq	= hazptr_scale_completed,
> +	.gp_diff	= NULL,
> +	.exp_completed	= hazptr_scale_completed,
> +	.sync		= hazptr_scale_sync,
> +	.exp_sync	= hazptr_scale_sync_exp,
> +	.name		= "hazptr",
> +};
> +
> +#define HAZPTR_SCALE_OPS &hazptr_scale_ops,
> +#else
> +#define HAZPTR_SCALE_OPS
> +#endif
> +
>  static unsigned long rcuscale_seq_diff(unsigned long new, unsigned long old)
>  {
>  	if (!cur_ops->gp_diff)
> @@ -1140,6 +1206,7 @@ rcu_scale_init(void)
>  	static struct rcu_scale_ops *scale_ops[] = {
>  		&rcu_ops, &srcu_ops, &srcua_ops, &srcud_ops,
>  		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
> +		HAZPTR_SCALE_OPS
>  	};
>  
>  	if (!torture_init_begin(scale_type, verbose))
> -- 
> 2.43.0
> 
