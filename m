Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346521;
	b=B3UCF4wBsQrYyUSwwGCkx82mMhEzwMpIaRlK9XI8RqKBv7BK6qjkiNFY2bzb/WiuM25a
	 fl7y7IG+bkNYYDSOFfEGof0Cj6qqtYWlvXGpMGIypDWRno12vdnEQ5pBECo9ERTHcyK1L
	 XNqjs2K64NXDgY3z5BTPjPoGQkN3E96+M9WUe/1UWHQDsF2NEzZGUMTcZnly3IakNpwzy
	 zfQ2GeP2mWWdTfojuhPge867YsyveHJdERfHhLh1cVl4u3gBuArSET9gN4jwAifDpTjhk
	 XZnzvfejpt/803fQEKBvQOprbDPWerfCspGOkTCIcEW/i9u/PgTsnGNZvLvZNpk1ldQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346521;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Zey2HMt5klpTlY68NDHEVjd3B/NIYRgop9XZCkWkwSY=;
	b=gZGgdyZLvu8gW/fw3QpPYOLDbyIQcCVsHn1xFN3gh6e8dkvdEoDeS0dIft2Yq7eqdyTO
	 CdL6OzXDy8F8bvP4gCkynHrC3MOTdLvUR2M4mwUkkq725tdl1sJBABHSlAvG3sKx/U4gx
	 JnAxiqf0Ub506NFllON5SLg68Wuwap6OLmeEvRvNQsKT7CqAAsDUeKGsjEMXiRHWfCPmq
	 wXKGZTeQTv9nIXZ2hSnaH0HsdSh/ITgm9Ltwez8PgRawrLNhXTr5Jm50ck19/NoZ+y1W1
	 64ix0rC8VRaqkLF3xku/ZCarMBbEyJ3sT9jC289Yhi/58O0o7u2htb+hbqIu3oFLXKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WyWF2Tb9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14605606A321;
	Tue, 10 Nov 2026 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WyWF2Tb9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA631F0089F;
	Tue, 10 Nov 2026 21:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794346520;
	bh=Zey2HMt5klpTlY68NDHEVjd3B/NIYRgop9XZCkWkwSY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=WyWF2Tb9oGDsmfwAziG7o4QccoVPMQa7E1m8keS522AgIfVXCHjGiiEc47YpBly0O
	 y6v2AB3rtAkKxqrEZ/sGw1fSMdNY76jH9HsZb1xs6m+3e3Gs8BprQAa5INVKR/dOqX
	 JN4W5RtRua+gtzfSStbnvl3tlWXV4UNSNpIn5xOfdfJOEb6mQ7ffV6s1nZ9Acpae7v
	 NaiZEVvQ/qmZir6grlljcFn8JiNlyyJWqVurhyXx79nYPspANifo3/941JuYIrnHGF
	 yx9tNlMUozolXphzse6xKDoZLXJ6+o33/A4OyHLjn1tgrQeznWB23LZbFBiZAssLXS
	 OabHGzs8G31Kw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 621D7CE0AD8; Tue, 10 Nov 2026 13:35:20 -0800 (PST)
Date: Tue, 10 Nov 2026 13:35:20 -0800
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
Subject: Re: [PATCH 10/28] hazptrtorture: Add 128- and 256-CPU configs
Message-ID: <83463788-5e18-4932-99c9-4cbf4148a213@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
 <20261104165504.2430480-11-kunwu.chan@gmail.com>
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
In-Reply-To: <20261104165504.2430480-11-kunwu.chan@gmail.com>

On Thu, Nov 05, 2026 at 12:54:28AM +0800, Kunwu Chan wrote:
> Add CPU128 and CPU256 configs for hazptr-stack torture testing.
> These configs exercise the shared-scan path at larger CPU counts.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

For these, why not instead add '--kconfig "CONFIG_NR_CPUS=128"' to a
run in torture.sh?  Ditto for 256 CPUs.  These will override the values
given in the hazptr Kconfig files.

							Thanx, Paul

> Acked-by: Bradley Morgan <brads@mainlining.org>
> ---
>  .../selftests/rcutorture/configs/hazptr/CPU128   | 16 ++++++++++++++++
>  .../rcutorture/configs/hazptr/CPU128.boot        |  1 +
>  .../selftests/rcutorture/configs/hazptr/CPU256   | 16 ++++++++++++++++
>  .../rcutorture/configs/hazptr/CPU256.boot        |  1 +
>  4 files changed, 34 insertions(+)
>  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU128
>  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU128.boot
>  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU256
>  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU256.boot
> 
> diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CPU128 b/tools/testing/selftests/rcutorture/configs/hazptr/CPU128
> new file mode 100644
> index 000000000000..079b463607e8
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/hazptr/CPU128
> @@ -0,0 +1,16 @@
> +CONFIG_SMP=y
> +CONFIG_NR_CPUS=128
> +CONFIG_PREEMPT_NONE=n
> +CONFIG_PREEMPT_VOLUNTARY=n
> +CONFIG_PREEMPT=y
> +CONFIG_HZ_PERIODIC=n
> +CONFIG_NO_HZ_IDLE=y
> +CONFIG_NO_HZ_FULL=n
> +CONFIG_HOTPLUG_CPU=y
> +CONFIG_SUSPEND=n
> +CONFIG_HIBERNATION=n
> +CONFIG_DEBUG_LOCK_ALLOC=n
> +CONFIG_PROVE_LOCKING=n
> +CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> +CONFIG_DEBUG_KERNEL=y
> +CONFIG_HAZPTR_DEBUG=y
> diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CPU128.boot b/tools/testing/selftests/rcutorture/configs/hazptr/CPU128.boot
> new file mode 100644
> index 000000000000..1d09a6446080
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/hazptr/CPU128.boot
> @@ -0,0 +1 @@
> +hazptrtorture.torture_type=hazptr-stack
> diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CPU256 b/tools/testing/selftests/rcutorture/configs/hazptr/CPU256
> new file mode 100644
> index 000000000000..b00a984977f3
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/hazptr/CPU256
> @@ -0,0 +1,16 @@
> +CONFIG_SMP=y
> +CONFIG_NR_CPUS=256
> +CONFIG_PREEMPT_NONE=n
> +CONFIG_PREEMPT_VOLUNTARY=n
> +CONFIG_PREEMPT=y
> +CONFIG_HZ_PERIODIC=n
> +CONFIG_NO_HZ_IDLE=y
> +CONFIG_NO_HZ_FULL=n
> +CONFIG_HOTPLUG_CPU=y
> +CONFIG_SUSPEND=n
> +CONFIG_HIBERNATION=n
> +CONFIG_DEBUG_LOCK_ALLOC=n
> +CONFIG_PROVE_LOCKING=n
> +CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> +CONFIG_DEBUG_KERNEL=y
> +CONFIG_HAZPTR_DEBUG=y
> diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CPU256.boot b/tools/testing/selftests/rcutorture/configs/hazptr/CPU256.boot
> new file mode 100644
> index 000000000000..1d09a6446080
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/hazptr/CPU256.boot
> @@ -0,0 +1 @@
> +hazptrtorture.torture_type=hazptr-stack
> -- 
> 2.43.0
> 
