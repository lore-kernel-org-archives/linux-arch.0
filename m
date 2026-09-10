Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DCD38237F;
	Thu, 10 Sep 2026 23:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789081499; cv=none; b=XtjP+kFm8rk1qDGJJlYxEmeyth6JW+MtcpesURslJQGBUBEImJ51jOMsGTvw3/yVGxstUkPhM9pgKyv8jZbDAvExV4x8AsCdP1+z7JRmAZLYkEEg+Rcji9Nx5EbMALiAYcDvBdZhVOUII6+ewVxd/84J+kxIvO9VsB2V7Crv5GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789081499; c=relaxed/simple;
	bh=jVUWsFjnTkxFQjWUlWXzsvWXAkzItBYf1BTO5E3F/7M=;
	h=MIME-Version:Content-Type:Subject:From:To:CC:In-Reply-To:
	 References:Date:Message-ID; b=kDBs/n7GtWgUfCAeOteKQBSKnJsP5ICtrmsz1WK8kVIg2nEImQqxj2XJltCi58KwFWUYrnAeLNyTZzzOaOiK02Kz/LuIP4NGvjBTYPWkw+rKqh59JuWijVB8tT21zRkhU1mcS5qbiRyS2Gd5PAjE/WOoFk8kZGbxDCt3KItw2Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=jEdYidEm; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="jEdYidEm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1789081498; x=1820617498;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=IOsxt71KzjuvZPnWRLz+Zt819tnVf/OX6nBy2DXTBZw=;
  b=jEdYidEmEOAEAq64DH+3Fa2+cfIL2zj5db34V2I7PvZ6XqH20lNRM0/O
   FdogPfwiIOQ+YH6/SwAVIbRqpW2g1EscU+o186zbOfTFPCH9VxwhHk9uY
   eroGJJ9cFS/OtojRJkkAnIz6HEUWERCMGk1ePQANOLHsiMvbY2ql+SalX
   OZFDhKItyVhadNC/nCiRj1ALIZq9mCeM5cOJjgYgu8kIant8jnKwdJCBj
   fkHaJRMSqNNPZ5OC4JtmyX5kJyWsJyU4Z1+REEc6VW2RpPTFdyFKVmbCk
   AaCEnTtrW429Lv3UyZPUhN+6duBj5cqriubG++6aeh+dPo6gP71lznUYk
   A==;
X-CSE-ConnectionGUID: b7E1F3vDSUuMCM84df39YQ==
X-CSE-MsgGUID: 5KMnDUnCQjmoC2958yP+VA==
X-IronPort-AV: E=Sophos;i="6.27,96,1787011200"; 
   d="scan'208";a="28174146"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 23:04:58 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:6383]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.160:2525] with esmtp (Farcaster)
 id d5404f53-ad6a-4991-8fbd-b62fddfbd916; Thu, 10 Sep 2026 23:04:58 +0000 (UTC)
X-Farcaster-Flow-ID: d5404f53-ad6a-4991-8fbd-b62fddfbd916
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Thu, 10 Sep 2026 23:04:57 +0000
Received: from u34cccd802f2d52.ant.amazon.com (10.106.178.32) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Thu, 10 Sep 2026 23:04:54 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v15 16/16] barrier: timeout validity checks for
 smp_cond_load_acquire_timeout()
From: Haris Okanovic <harisokn@amazon.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<bpf@vger.kernel.org>, <arnd@arndb.de>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <peterz@infradead.org>, <akpm@linux-foundation.org>,
	<mark.rutland@arm.com>, <harisokn@amazon.com>, <cl@gentwo.org>,
	<ast@kernel.org>, <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
	<memxor@gmail.com>, <zhenglifeng1@huawei.com>, <xueshuai@linux.alibaba.com>,
	<rdunlap@infradead.org>, <david.laight.linux@gmail.com>,
	<broonie@kernel.org>, <joao.m.martins@oracle.com>,
	<boris.ostrovsky@oracle.com>, <konrad.wilk@oracle.com>, <ashok.bhat@arm.com>
In-Reply-To: <20260831202251.305046-17-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
 <20260831202251.305046-17-ankur.a.arora@oracle.com>
Date: Thu, 10 Sep 2026 18:04:27 -0500
Message-ID: <178908146779.2725577.4332112514491271355.b4-review@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Mon, 31 Aug 2026 13:22:51 -0700, Ankur Arora <ankur.a.arora@oracle.com> wrote:
> Extend timeout tests in smp_cond_expiry_params to also test
> smp_cond_load_acquire_timeout().
> 
> The interface supports clocks that can return error on timeout.
> These are used by rqspinlock. Test that by using a similar clock
> that starts returning error past timeout.
> 
> [...]

Tested-by: Haris Okanovic <harisokn@amazon.com>

-- 
Haris Okanovic
AWS Graviton

