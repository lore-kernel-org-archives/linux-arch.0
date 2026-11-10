Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347414;
	b=3pF9UyGqlc4b0FU3jxmTZ6SrUADUEt4yM6EqBAtb9wD/WPC/gEoqxIRH6AKA6AR6g324
	 yai21O88ip43JpEVcK54+0g6MvePrBzL1fWgxX+1QpDoO6BlRc+n5PQbkqpnNehAYRsDB
	 EAiJHsNQlIITnbDLyt1iYfAdsw+GJwvsjTPzGHVMXQGip/3DbNLdq6q2d7hF1bpFMhITM
	 3/pOvngbgVdY6Iw2LliiQx2xp2QXlxl0kQ1BdHQi2qcUqLTiRw65F03uM7ZWkzVilfugI
	 qqTxIti8L7/VFT/GNG/sP5UT4VWB6MpEq2VXYQYeuPDDC0Ly7A6dWzeqGglLJT6/ivw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347414;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=EEipYbYao+VSwUghBQNnqmUX8onBkKmnbt5LzSPHXQs=;
	b=u5MqzOoL0iyf7AihWsd0yNqwQQy0B01Z2ebr5thEZvyrSXmkJEM/+6tbav4uv5p8mvUq
	 YF3Jn16BB64CiUJmJLpjd33C+PXX/yiB8fy16vhZP/716iThgkoVB+v2U2yRRb+2ep/Bw
	 NhF1H7Aq6i3UT275K+xmD7suy7jq8VVx3nzNoLpHFz9MqCCqgsn1K13H9XhCcQdiYeR+s
	 Z8YJbMERRnSo2bIyvkD+rfOIj62m9w57WMSyP8S2Hb4KGGBeOblnL5KaUuqljI2Y38oq9
	 WszW6wt8+ziK+q5REyjQi9QfIkJR60+90onK6xMLsPCzSUWEgShTTYab8J1inFmHEuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TmqRD+7/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF6D606A334;
	Tue, 10 Nov 2026 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TmqRD+7/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFC91F0089F;
	Tue, 10 Nov 2026 21:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794347413;
	bh=EEipYbYao+VSwUghBQNnqmUX8onBkKmnbt5LzSPHXQs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=TmqRD+7/LxdWe7qLcuyVSDaTRvz5U25cgA2QveBWcCUDKFYwF44WVi+CQPWvw46xl
	 1fSx6fVOshFC0giI1tZUtdGIIfwfSz48ZTrvXAmucteuXS3AQVAofsRjqvpO6UX7OW
	 4wI30PrleDLJQNBBUDhlTsew/TTSfg5nYrwS1b8doDaRFx0qbjEVf+aZ/hHE2xlDrP
	 gm4Y3O43++xuqi4/wsFY2efQMThrmyrpI1qqQMFRmKc7G9uulEg6Ct5f2rAHbYBu+Q
	 kwgs0OcT6gvxQZvm1ARVnWBtZJ9piuDcJ5sjDEcWnCvJs7sHGwQCBstq/LES/ca/Tt
	 ML0FESBjlBu4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3A241CE0AD8; Tue, 10 Nov 2026 13:50:13 -0800 (PST)
Date: Tue, 10 Nov 2026 13:50:13 -0800
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
Subject: Re: [PATCH 25/28] hazptr: Select TRACING for HAZPTR_TORTURE_TEST to
 enable tracepoint
Message-ID: <1c2eff9d-213b-4ea2-9905-a054c6d40d97@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
 <20261104165504.2430480-26-kunwu.chan@gmail.com>
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
In-Reply-To: <20261104165504.2430480-26-kunwu.chan@gmail.com>

On Thu, Nov 05, 2026 at 12:54:43AM +0800, Kunwu Chan wrote:
> The hazptr torture test registers the hazptr_waiter_enqueue
> tracepoint for its hot-address scenario; select TRACING so
> that the register_trace_*() API is available.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

It is useful to run the torture tests without CONFIG_TRACING=y in order
to quickly isolate RCU bugs that tracing related.  Is there a way to do
this so that people wanting to register tracing can do so, but so that
it is still easy to run the tests without tracing?

							Thanx, Paul

> ---
>  kernel/rcu/Kconfig.debug | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> index b500e96ea1c1..8fc6434a05d1 100644
> --- a/kernel/rcu/Kconfig.debug
> +++ b/kernel/rcu/Kconfig.debug
> @@ -27,6 +27,7 @@ config RCU_SCALE_TEST
>  	tristate "performance tests for RCU"
>  	depends on DEBUG_KERNEL
>  	select TORTURE_TEST
> +	select TRACING
>  	default n
>  	help
>  	  This option provides a kernel module that runs performance
> @@ -42,6 +43,7 @@ config RCU_TORTURE_TEST
>  	tristate "torture tests for RCU"
>  	depends on DEBUG_KERNEL
>  	select TORTURE_TEST
> +	select TRACING
>  	default n
>  	help
>  	  This option provides a kernel module that runs torture tests
> @@ -102,6 +104,7 @@ config RCU_REF_SCALE_TEST
>  	tristate "Scalability tests for read-side synchronization (RCU and others)"
>  	depends on DEBUG_KERNEL
>  	select TORTURE_TEST
> +	select TRACING
>  	default n
>  	help
>  	  This option provides a kernel module that runs performance tests
> @@ -117,6 +120,7 @@ config HAZPTR_TORTURE_TEST
>  	tristate "Torture tests for hazard pointers"
>  	depends on DEBUG_KERNEL
>  	select TORTURE_TEST
> +	select TRACING
>  	default n
>  	help
>  	  This option provides in-kernel hazard-pointer stress tests.
> -- 
> 2.43.0
> 
