Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346664;
	b=ZgKJLTFJrka5oBXT7kj7G1jRaMcLeRPusFr3zOD/ynAQhyr8KixP9WMMR1Ji13n5nAao
	 IM7TBKnrCkZn4pv+aZnD1aHz2z/rQcNoqYPGYyWt27IthIjx7zXrCdpu0NNjP8rZqOOm5
	 OkWua2Snks5KKsFHMZG0Sgg6ftqibCoUvlcJ8F2+ZhmcI36C3+VXBTSyaiTXW/Xy7soGW
	 /o7lJnqGAK1+i6OQl++Ptn7Aq/PsJYaVLe1eOpTqVjID+lbqInBoSEOLyWsicEwE9JIq5
	 sIH80nlGnhPiU7N5CCI7sR+iw0RoDyNYsEPnpqt6RpW0ym8CG7ZjfTqXTJCd/V9zH5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346664;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=NEP7Ae8IL1zS4AFd2NI/v2KYJ70TRfoMA8rwYu6hoJc=;
	b=MnCLfzwt7rvAscBczR5HQawQuM96oas9bKQODnOeCv470jh5RCM3C9eblMHkUVleaV4W
	 TjMOUGLkrBBqiJAOp+jI1ei6e665oGbhpsbZ3EciQcWNl4oyBAyvPiee9ojNM6znY7+Z9
	 LgUpYLXRVmjyHJv5IVAx9trEABPZeyqn9zSTaQLkLWA/h7EeWP6uf8J9v5vMBtDC4oufy
	 GHR2U3ykgCaJFihkfETenKdnbWExQO5ES1nYq/z7VyUHbRWFtA/6Kbvk8bF8cxT9KaNud
	 z9j4RE+RFdGHNYt2FCtSbDfF+ZTJ+qcm7lqgY9HqKKOT9q9wh3wSOidz6BPb9j4S6NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K49S0lKp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30E060A263A;
	Tue, 10 Nov 2026 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K49S0lKp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADDE1F008BC;
	Tue, 10 Nov 2026 21:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794346663;
	bh=NEP7Ae8IL1zS4AFd2NI/v2KYJ70TRfoMA8rwYu6hoJc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=K49S0lKpP6s9saoGWzMH5Mywjt7CyJjxFP4w/nz8/7JO5Gzx0ijaSntFv+HkxhMsc
	 ItoenSXjpGHR/jamv9ViKAIV8Jfb0K2pDtuAQjQoKjBqJwVcDymhVik6X4UG5hbMof
	 TFH5+qu4lB7PoTZXxo7biA7c3XwnV+5eCvzryJYzd2kTHecZooQjK5TJazlOE8wT/m
	 XAqWC8mwXsCy0IxZhFhctP3boThoHGafeaFi4/gNunxatiAgWNIfgYgc3Pb2AnB2KS
	 wRW0ZdBUsQMi38XqdO72KMCAezATGsQJ/Oawfw3e8FGCL5+tKcgeFtMKfOR2v3GRzD
	 LI6fRRxA5Ce3A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 67D4ACE0AD8; Tue, 10 Nov 2026 13:37:43 -0800 (PST)
Date: Tue, 10 Nov 2026 13:37:43 -0800
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
Subject: Re: [PATCH 09/28] hazptrtorture: Add READERS4 and READERS0 torture
 configs
Message-ID: <381033ae-d65e-44de-bbe7-69f707405f40@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
 <20261104165504.2430480-10-kunwu.chan@gmail.com>
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
In-Reply-To: <20261104165504.2430480-10-kunwu.chan@gmail.com>

On Thu, Nov 05, 2026 at 12:54:27AM +0800, Kunwu Chan wrote:
> Add READERS4 and READERS0 configs to cover reader-active and
> reader-free synchronize paths.
> 
> Both use the PREEMPT baseline and hazptr-stack torture type,
> with four readers for READERS4 and no readers for READERS0.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

For these, why not just add '--bootargs "hazptrtorture.nreaders=0"'
to the kvm.sh command line, for example in torture.sh?  Ditto for the
four-readers case.

							Thanx, Paul

> Acked-by: Bradley Morgan <brads@mainlining.org>
> ---
>  .../selftests/rcutorture/configs/hazptr/READERS0 | 16 ++++++++++++++++
>  .../rcutorture/configs/hazptr/READERS0.boot      |  2 ++
>  .../selftests/rcutorture/configs/hazptr/READERS4 | 16 ++++++++++++++++
>  .../rcutorture/configs/hazptr/READERS4.boot      |  2 ++
>  4 files changed, 36 insertions(+)
>  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS0
>  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot
>  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS4
>  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot
> 
> diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS0 b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0
> new file mode 100644
> index 000000000000..c5b12f3bef74
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0
> @@ -0,0 +1,16 @@
> +CONFIG_SMP=y
> +CONFIG_NR_CPUS=16
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
> diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot
> new file mode 100644
> index 000000000000..f5564c218902
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot
> @@ -0,0 +1,2 @@
> +hazptrtorture.nreaders=0
> +hazptrtorture.torture_type=hazptr-stack
> diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS4 b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4
> new file mode 100644
> index 000000000000..c5b12f3bef74
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4
> @@ -0,0 +1,16 @@
> +CONFIG_SMP=y
> +CONFIG_NR_CPUS=16
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
> diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot
> new file mode 100644
> index 000000000000..0d0df3f7dca4
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot
> @@ -0,0 +1,2 @@
> +hazptrtorture.nreaders=4
> +hazptrtorture.torture_type=hazptr-stack
> -- 
> 2.43.0
> 
