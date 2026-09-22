Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C0D3A3826;
	Tue, 22 Sep 2026 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790063738; cv=none; b=T7zZmQIVK+mci6hHvyXTz5OxA4BBeHp+J0OYD8XMVQy7/WotPlMgWjVfULE+3MNnQvXl88VaPDq79Z272QiuY3rO12f0fZJtmYSqcdoOBtsbTr9ObLarmtgXg5CoXM3tF4/Kyd5SIH0Ruj8dhDVu0XMfrb7hZZMYiMyQKW46O7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790063738; c=relaxed/simple;
	bh=glu3CtPUfgdcxJVwv+KjrwnICo0e/r37vbhh51FUZMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhVFIgBLISKj7L4VJYK2bSOp7pEuoabnFvxqeN3Zi6r2Cse3APSYAW5xIj0Sq998bZg9nP3VoYmek6CKkvCorCQGngdNju9Y97TPNIZYx4XOEFBMWPaE11HZ8TKBKMCUyxFn73/fZ9F5LwJNbFUwy07M0wSWXH+xb5Jf8i+bWWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KY4bn2Pj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KY4bn2Pj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2431F00898;
	Tue, 22 Sep 2026 07:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790063729;
	bh=TynZhFcM9RKoqxCO+eqj4+CP6Cl8Bpb0BRtyvsupsBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KY4bn2PjV6/YL2DcVQqkj1AL98d5AC8RnUnLsaRP3PzzAoCirX21IR+pPTvpnMUNJ
	 LYZeAzcdfrgCWsjLCval/AkpHs5+ABbSjb7xqsCwAVOZBz8lCbbkx5+bk6ASDny7xN
	 mK/DGukFNCvWIViu7lI8PqcYzvZP6wFzOPyqQdCn89SBFN5rYu/bcjJ26YtHFVU6NZ
	 XDXtVSFy9DtVNCeqBfE/z34baFmAsIpiZy3ZJNlAbJu+PsldvYk6Gl93fp8PkpR8RQ
	 iZS96lhTTpajNRHEATSmCH844ELEAkvBROxET2+u2KUtiFvB+8phqsWXz6g36msmjw
	 KO7mPXL5qsBRA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7F5C7F40068;
	Tue, 22 Sep 2026 03:55:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 22 Sep 2026 03:55:27 -0400
X-ME-Sender: <xms:bzSyakUc3w5_wtzR23b9GdqcyXCHwbMg9qF0xJZfXDqgnwkL2F31Ng>
    <xme:bzSyavZsIVK8-DuVzSGGAkuMMIU3-vR3cf65YUw60fmjIMcX5_6xvqeIpO4GnDxzQ
    y1ngoU4nY5Ngj4z6QLNXuXQZIJ5mov28hu4ojxm9L5imXRDQBkuxQc>
X-ME-Received: <xmr:bzSyahX_daTlkySMUlAid_VGlzrLXB8mGo9LGGTXIwBsBQXsMEtwFQhKMkIAZ59n-kqM7KYoG2CA4UcEb3Gnr4Zsa2QffevFI6QJm2qnnJduigDIDG-eLWz3>
X-ME-Proxy-Cause: dmFkZTGYk3vL6Q6DGBgp+octrQvQmmXRVqxJg3GCtOc72coXKnnFenXDymi5AO190qowui
    oc/JfDrhxSF7HgKwiOZGqaWLYPw5DSczg0uggpSx56wDTcqSiaW8nBwW/FhdqM/XYXCp+q
    VR8znUFoeRq5FgLyVzQF0WO5PbY9v+VU6nRd+Pnj3lv/y7LF/+LWmcgrginqIdZJ44ZGPj
    P5a8UKkjdXA1VqwlUd65dghtNdyNM+E8E9ouhjQFzlsCbwbX9HPa3bbgHoPKgEw7VKuURn
    pX7PEDxRmvX8uosr1SUh1iXeAZ16LZwHiDZgenDaB3B3zviKSRJQQj6m/8ACgbzF2hBFNU
    1Z28BwRzXuDhGBMpcfUTYCEGDjvreeH118SOAzJT1ppHORRCIDh2+lCRrsQg8YhTFPLxXt
    COp9XoTBmg3yGpF1OUKS0Md0F1vfA93isquIVbStTin8PnaxEjfMl/c7+u/t2z25puFs02
    s+YkX8l9otv1ynTgbZjM2XgMuef0i6W4kNw2kEH5OCoUiGoNTtg9S9G95lfBDJMwf+QpUB
    AmO9d9rBREiduo3Y4heHIWVyh1LcFfNr5gqtFVj+LxvwRcgfMwaZVSxWzZ2wB/4D9GGvyw
    ZBEWnijii9uhjM5zdSkOWX/5S5fzkz/mwokQ4sqwNQuupRfR13nChGjtsB+A
X-ME-Proxy: <xmx:bzSyamJFyH5Ju-YzIHs54F4KOubGEfxClSdH6fKU7t-qq86msYfWDQ>
    <xmx:bzSyai0apPuH0T2X5JGi9g4x7khBl5IiFwxzp_Ig12aGrr8El6yLDw>
    <xmx:bzSyam_7zR4rMuM5s0vrVPNbgNhfUsaeOJmYkfw14ghr__3ViemkOA>
    <xmx:bzSyavgErkQyD72d7FA9Iy3ESGrWnvGOK59duzz84f70y5vN0XqYZA>
    <xmx:bzSyaiU2mM51d-kfsCGEZT26fLZlhuWa6KrNLgZVv05OUsmtKxeaLL8u>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 03:55:26 -0400 (EDT)
Date: Tue, 22 Sep 2026 09:55:25 +0200
From: Boqun Feng <boqun@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org,
	corbet@lwn.net, mingo@redhat.com, dave@stgolabs.net,
	josh@joshtriplett.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, urezki@gmail.com, akiyks@gmail.com,
	dlustig@nvidia.com, joelagnelf@nvidia.com,
	skhan@linuxfoundation.org, rdunlap@infradead.org,
	longman@redhat.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, include@grrlz.net,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, linux-doc@vger.kernel.org,
	rcu@vger.kernel.org, lianux.mm@gmail.com
Subject: Re: [RFC/WIP PATCH 3/4] rcuscale: add hazptr scale type
Message-ID: <arI0bexTH7CL66Dc@MacBook-0RXW5>
References: <20260922070950.4173245-1-kunwu.chan@gmail.com>
 <20260922070950.4173245-4-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922070950.4173245-4-kunwu.chan@gmail.com>

On Tue, Sep 22, 2026 at 03:09:49PM +0800, Kunwu Chan wrote:
> Add hazptr reader and synchronize operations so that synchronize
> latency can be measured alongside RCU and SRCU.
> 
> The read side acquires the hazard pointer in readlock() and holds
> it until readunlock(), matching the RCU/SRCU reader model.  The
> address of a static object serves as the synchronize target, which
> is stable and never reclaimed.  Both normal and expedited sync map
> to hazptr_synchronize(), since hazptr has no expedited concept.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> ---
>  kernel/rcu/rcuscale.c | 65 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 1097ec15879c..072ddf9526c3 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -39,6 +39,7 @@
>  #include <linux/torture.h>
>  #include <linux/vmalloc.h>
>  #include <linux/rcupdate_trace.h>
> +#include <linux/hazptr.h>
>  #include <linux/sched/debug.h>
>  
>  #include "rcu.h"
> @@ -418,6 +419,66 @@ static struct rcu_scale_ops tasks_tracing_ops = {
>  
>  #endif // #else // #ifdef CONFIG_TASKS_TRACE_RCU
>  
> +#if IS_ENABLED(CONFIG_HAZPTR_TORTURE_TEST)
> +
> +static int hazptr_scale_obj;	/* Stable, non-NULL, never reclaimed. */

You can probaly make hazptr_scale_obj an arrary, and let an updater
either randomly or round-robin select an object to wait, it'll reflect
better to a real world workload.

> +static void *hazptr_scale_ptr = &hazptr_scale_obj;
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
> +
> +	preempt_disable();

I think you can drop the preempt_disable() and preempt_enable() below,
since the new hazptr_acquire()/hazptr_release() work without them (i.e.
the hazptr acquisition no longer requires preemption disable).

Regards,
Boqun

> +	state->addr = hazptr_acquire(&state->ctx, &hazptr_scale_ptr);
> +	return 0;
> +}
> +
> +static void hazptr_scale_read_unlock(int idx)
> +{
> +	struct hazptr_scale_state *state = this_cpu_ptr(&hazptr_scale_state);
> +
> +	udelay(10);
> +	hazptr_release(&state->ctx, state->addr);
> +	preempt_enable();
> +}
> +
> +static unsigned long hazptr_scale_completed(void)
> +{
> +	return 0;
> +}
> +
> +static void hazptr_scale_sync(void)
> +{
> +	hazptr_synchronize(hazptr_scale_ptr);
> +}
> +
> +static void hazptr_scale_sync_exp(void)
> +{
> +	hazptr_synchronize(hazptr_scale_ptr);
> +}
> +
> +static struct rcu_scale_ops hazptr_scale_ops = {
> +	.ptype		= 0,
> +	.readlock	= hazptr_scale_read_lock,
> +	.readunlock	= hazptr_scale_read_unlock,
> +	.get_gp_seq	= hazptr_scale_completed,
> +	.gp_diff	= NULL,
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
> @@ -1110,7 +1171,9 @@ rcu_scale_init(void)
>  	long i;
>  	long j;
>  	static struct rcu_scale_ops *scale_ops[] = {
> -		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
> +		&rcu_ops, &srcu_ops, &srcud_ops,
> +		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
> +		HAZPTR_SCALE_OPS
>  	};
>  
>  	if (!torture_init_begin(scale_type, verbose))
> -- 
> 2.43.0
> 
