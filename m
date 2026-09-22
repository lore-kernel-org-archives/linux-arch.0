Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6A95208C8
	for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2026 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790063314; cv=none; b=MuLsERCDoX2ASl5bemBcmETSJ903taOWhc5cgoUwDbrysqxDUMskJrr1N7mxIQHLq1A+tbM1rZv5QbTulUy/KZyQfqvG4Jylu1oSRbESup+yisiKLgmhzES5wYoqNcbpq2WnMUwMOn3CkJiZm4UN8NJPfC7iMmc0FDKHTwQAHA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790063314; c=relaxed/simple;
	bh=aMOhc0ldV668vt/e+WA5biePCrSs89b+CWvn43zLsfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZAEwjEPLzg69uS3CU3vSJvjM+gbilb5pAsnJuRAgRQeg34qb4hLLKfQp9wk1p7/6I7PyFxa1k6rWzBsHHYfuJ+iRK0KpLfRNUJu+hwcdP3v1OLgubxp0w+IbabjfpjVFr4owhOW/fm01wztCx8KDLJnNXV0auKH3QfH6hnErLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdO3n9kY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdO3n9kY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0141F00893;
	Tue, 22 Sep 2026 07:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790063307;
	bh=emOEIGRJ9Xc98DPV3QzUaBhGq6HZ04J1D7VH7rHaylM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TdO3n9kYs4szfq5h+lUiLbWm+/xLoGaGRL1f0v/9k9URPUxlXQeUyBzJQRPdlQvIV
	 n5p4V5RcytMnbCHedClS39SgGKwzvqL61c0kbKmc1AI9aTzBqKnkJin0nAmN2E8Jth
	 2BKsRVM4Bw4B1o69A3f/BhoIBaWn+3S65fQNXA28ikdymg93YL2sZXOmouQJPEBe65
	 /h0Dmk5yXnRqlCkf6sohI+nxH3Y+tolddaQ4vqtWJunCqJh2y/e1NfIwxWY7JI3loA
	 nAmeSnsmP1Np2uW+77mY/VnE/H64ihqZg9k9ovJmFRDOJPuwRC1iVuzV7crUKYwgFG
	 vxK5J2Mq3hUHg==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id B3E31F40066;
	Tue, 22 Sep 2026 03:48:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 22 Sep 2026 03:48:25 -0400
X-ME-Sender: <xms:yTKyahEZBqnS9qW_lOSNWFeZ68lw_i6IxRH9l35F_rZ_XkkHsYLqAA>
    <xme:yTKyatJX6u-mbcJgEAeftOWkHj2m5vhD0duM6oyCVcZr1halxoNcQs6D8FSbpGDOo
    n_fy2ffObpQ6GUsbiYpsOtli0BK3i02iLI7MwRVgrJ4g65mlL_l96A>
X-ME-Received: <xmr:yTKyasGm06CuM9zWqUrgxiwRkN91ycXa4PFeEU-j8TDVlkgJa8kFPuTeMwjPL8u2WDuQeSw1oFlimXSJwBzdYvUFcPLarfGEu2DCQfNLEu1VNwQ5JqypCHes>
X-ME-Proxy-Cause: dmFkZTFmo2bX95nAx79xvRlh4d1wdS6MwdhUVFc4sFjJ/nM5wX9RdGAHZTjzAiJP2YqVmF
    Nb+S0sDsNeDoCJ7vjDptpfIIW2uhkZ2VK7/haUzuOF9zAQF0EPzRMpmbKeQ/ZVJweETYKI
    w6n5+fhDgGtQ+sduEjRtYFByosjDytaU5+fey6NjiKYrfsZGhzX6XKNkdPKhMvGI9GZO3d
    JKAuSM1Ac76IJkymWqgoO/L54t67vG6vkjGrt0baMOmYkaybBY/FNzsrPfGyHJoXuTowGz
    L9egtjEvoQjlYPYy7nejmnR12fi0iTcS9vQNwl3tB7C7cmEzR78f6ugyL4MiRa12rJsoPk
    K7JIl3gTWNKwSCKR4IqxO0EvKnIXZKm8bIaGPX/0YNdwN4JPKtQkd/A1YxpHBdq8/Iom96
    Z+rn6Ti6y+ko1LMY1jOf2QSW8/0LyeiOwHgbmX4X7JDPD7WcDJYzACnpeyeX4tL70c/Q9v
    /PxeMPuMVzb+naS0utY9EcQOG4emDwNduhFhhysS+7XWF5lx+ygGglcI0ej+X4oX7+8a/p
    ZhbnastXOpK4I1l5NuI9EMzIhC1p4K4lRNQRzI4I2QX4hAt/rauDMZUCpaJSwkVKStuHTk
    OgR9wJs6phqzid0bOYxb6Et0/yJmpCVKXH4I7EdyoICpnIRvFfoAEBHFi7ww
X-ME-Proxy: <xmx:yTKyap4x3dH6-YgPrAfduA7ymICL2rWT6Sa7JfwnBLwYut8TO8Buzg>
    <xmx:yTKyarmXGvcp3562G1UJJlw9vZDBamBW_Bm3H2AQoeekrM1-lv315Q>
    <xmx:yTKyags4HcrMgYgfuUQqBWxzI_UeJ8o9w_6_M6wf2xki98a1EnKi_A>
    <xmx:yTKyamT7ro1OojYU1R8VGN94P0iekWyih3lheOHHCTLD6tmh3mTTAQ>
    <xmx:yTKyaiEq9pRwAQOiKbLEihMY5WPudtoZDcqLM03zfpKRVn6EEGv43Psy>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 03:48:24 -0400 (EDT)
Date: Tue, 22 Sep 2026 09:48:23 +0200
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
Subject: Re: [RFC/WIP PATCH 0/4] hazptr: add shared scan path and lockdep use
 case
Message-ID: <arIyx4BaA2eArvYM@MacBook-0RXW5>
References: <20260922070950.4173245-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922070950.4173245-1-kunwu.chan@gmail.com>

On Tue, Sep 22, 2026 at 03:09:46PM +0800, Kunwu Chan wrote:
> Hi all,
> 

Hello Kunwu,

> This RFC/WIP extends the current v3 hazptr implementation [1] and
> adapts the lockdep use case from Boqun Feng's earlier hazptr series [2]
> to the current hazptr API.
> 
> [1] https://lore.kernel.org/all/20260919000056.3132131-26-paulmck@kernel.org/
> [2] https://lore.kernel.org/lkml/20250625031101.12555-1-boqun.feng@gmail.com/
> 
> The lockdep conversion replaces the expedited RCU wait in
> lockdep_unregister_key() with hazptr_synchronize() for dynamic-key
> lookups.
> 
> The series also adds a shared-scan kthread for concurrent
> hazptr_synchronize() callers, rcuscale support, and an LKMM test
> for the acquire-before-scan ordering.
> 

Thanks a lot for picking up this, much appreciated.

Do you happen to play a bit with rcuscale and see any performance
difference between hazptr_synchronize() vs synchronize_{s}rcu() on
various configs?

> I tested the lockdep path on a 96-CPU ARM64 KVM guest with Boqun's
> original mq workload [2]. With a multiqueue virtio-net device
> (`-device virtio-net-pci,mq=on,vectors=6`), tc mq add/del x100
> completed in 850 ms with hazptr and 860 ms with expedited RCU.
> The rmmod workload similarly showed no measurable difference
> (1360 ms vs. 1380 ms over 10 runs). There were no crashes or hangs
> in these tests.
> 

You could also use /proc/interrupts to measure the IPI counts during the
whole operation, and you should be able to see the difference there.

Regards,
Boqun

> This is still RFC/WIP. I would appreciate feedback on the shared-scan
> design and the lockdep conversion.
>  
> Kunwu Chan (4):
>   hazptr: add shared-scan kthread
>   locking/lockdep: use hazptr to wait for dynamic key lookups
>   rcuscale: add hazptr scale type
>   Documentation/litmus-tests: add hazptr acquire-before-scan test
> 
>  .../hazptr/hazptr-acquire-before-scan.litmus  |  49 ++++
>  kernel/hazptr.c                               | 274 ++++++++++++++++++
>  kernel/locking/lockdep.c                      |  30 +-
>  kernel/rcu/rcuscale.c                         |  65 ++++-
>  4 files changed, 407 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/litmus-tests/hazptr/hazptr-acquire-before-scan.litmus
> 
> -- 
> 2.43.0
> 
