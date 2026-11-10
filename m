Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346314;
	b=bjJVm7xtRvVLW0JQYk86uDgZpgR/BT2HWuc/w3Q3xy+Th4HNYsPS0rmUigQbSlMZ/A3Z
	 RWE5L+My2AekEEoiBt6zFwmiVGvH/pVsNfMvDfT+hbRmkQMejG13X34UYqJL9ebsUSx2u
	 +ykb8m2pUKtQpvJDgAG2tDfyokqCgk0MBdvc/xOd0id59YdyNTkgLknFM2GqC/qvG2mh8
	 w9XAEhG38+S69rIcNnaGR+AXVSaky2jZy/JZlikMTvs4Ai6IjV9xa8kheB9RDviSJ8qCS
	 +TywkV5IE2l4VBbK5QvoJqyWWAR3CILBHyki26wrwMEjR/79eG4iGcIgVxFWgp8Ajog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346314;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Kh0ZeYdYoNYqCwSPGE+2Sg6clJviXZAk10ucqwqx6js=;
	b=KqGHyQ5ukH/rhJLOT+BMuhYTVw5fSMYEaFcPtcANGyH9Zh8c4glDbG3n6aka6DLLy6AP
	 kQXnT+PTDaNRmqM3a0uzkjdZOGhZbYNUfl7Q00FJlKyhPnJX30wYtZlT0O6UqOoqqLmo5
	 AZJMBs961r28lRzY9paGC9JcL+FqmyKee0mJCDa4del7vimquNaVvgrjdYjl6NIwbA5Pz
	 T9hx4wbf+9mnvPeHAwq1Z1ApMSjDGfbg1qen0U3ke+m5Y6Uf4dGVkzBjmI8qmdXnKgQhE
	 UnOMR4h4lpgQYKZ2+9qVeJYh2JiKhTBIBlT2BPacrLBQDnll7AJbCAKOX9yLLOBgjMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dd4VGTkO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9069C606A31C;
	Tue, 10 Nov 2026 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dd4VGTkO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E49E1F0089F;
	Tue, 10 Nov 2026 21:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794346313;
	bh=Kh0ZeYdYoNYqCwSPGE+2Sg6clJviXZAk10ucqwqx6js=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=dd4VGTkO8Alc2PCdu3gxUC1EpOTi24quLZGagayrE/IQoUuhcLtwa3IJCC1BW1VQt
	 AAYBOkYk+9O37qbi/PKBM90IqpSpS/cmHBVvgKoo6HBUFk1ZiJjLFSm5ORlCsQvqwI
	 dkdkkSxHYJV8eOaehA+52IoAKoNq/GavfybO0vI+fF/4LtUymJMhHtQZZ8VAHyxMi7
	 C6eOmDRbxoYLybevt5ygucmvBzBq0rp5p4Y9l7ftangmm30ca3/k3uLhTDj001aVDq
	 CG037/9q6ji+yYYcphQKxJTbSIYLcAP4XiT/jpU8mF7Q+xiqTcK64PGmu1n9S/DXth
	 RS59+gFPKwP7A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C1A09CE0AD8; Tue, 10 Nov 2026 13:31:52 -0800 (PST)
Date: Tue, 10 Nov 2026 13:31:52 -0800
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
Subject: Re: [PATCH 26/28] hazptrtorture: Add torture_type=none clean skip
 for rcuscale coexistence
Message-ID: <444c9bb1-fccc-44ff-8bcb-a04dd36eeecb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
 <20261104165504.2430480-27-kunwu.chan@gmail.com>
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
In-Reply-To: <20261104165504.2430480-27-kunwu.chan@gmail.com>

On Thu, Nov 05, 2026 at 12:54:44AM +0800, Kunwu Chan wrote:
> When both HAZPTR_TORTURE_TEST and RCU_SCALE_TEST are built into
> the same kernel, hazptrtorture calls torture_init_begin() first
> and rcuscale fails with -EBUSY.  torture_type=none makes
> hazptrtorture return early without registering, allowing the
> rcuscale hazptr scale type to run in the same boot.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

You are only supposed to build one of them into the kernel at a time,
so the intent of the torture_init_begin() failure paths is to enforce
this rule.  If you want to run both in the same kernel, the way to do
that is to build both as kernel modules, then do modprobe and then rmmod
of the first one, followed by modprobe and rmmod of the second one.

So please help me out here.  Why do we need to allow both rcuscale and
hazptrtorture to be built into the same kernel?

If your desire is simply better handling of an error condition, an
alternative is to force either a Kconfig or build failure when more than
one of the modules invoking torture_init_begin() is built into the same
kernel at the same time.

							Thanx, Paul

> ---
>  .../selftests/rcutorture/configs/rcuscale/HAZPTR    | 13 +++++++++++++
>  .../rcutorture/configs/rcuscale/HAZPTR.boot         |  1 +
>  2 files changed, 14 insertions(+)
>  create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR
>  create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR.boot
> 
> diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR b/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR
> new file mode 100644
> index 000000000000..c5e9cf0184ae
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR
> @@ -0,0 +1,13 @@
> +CONFIG_SMP=y
> +CONFIG_NR_CPUS=128
> +CONFIG_PREEMPT=y
> +CONFIG_HZ_PERIODIC=n
> +CONFIG_NO_HZ_IDLE=y
> +CONFIG_HOTPLUG_CPU=y
> +CONFIG_DEBUG_KERNEL=y
> +CONFIG_HAZPTR_TORTURE_TEST=y
> +CONFIG_HAZPTR_DEBUG=y
> +CONFIG_HAZPTR_STALL_DETECTOR=y
> +CONFIG_HAZPTR_STALL_TIMEOUT=1000
> +CONFIG_HAZPTR_DRAIN_ASSIST=y
> +CONFIG_RCU_SCALE_TEST=y
> diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR.boot b/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR.boot
> new file mode 100644
> index 000000000000..e9cca4cf453b
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR.boot
> @@ -0,0 +1 @@
> +hazptrtorture.torture_type=none
> -- 
> 2.43.0
> 
