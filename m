Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA74B3D4114;
	Mon, 17 Aug 2026 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002069; cv=none; b=CuQ1KTiXSznnHwqTWD6bIFAlK1o8kULiiiR33KwneGBP6mxkmHY2eRCsHeXrleLYiNOb1WbmytCFIremtVapOOZejmyOIAAtFmb4r7AowrRChpIFgBlFkP1Q4+2MENdSH77SGP+slzXW/MQPbmkePEJlHtTxx8rSyTVAYIA1BOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002069; c=relaxed/simple;
	bh=60fJekTBbR11gLxTaWREoBHR2j+XFQ7jRlnXGTD55OM=;
	h=MIME-Version:Content-Type:Subject:From:To:CC:In-Reply-To:
	 References:Date:Message-ID; b=dCqqXChbH9mJ43eysV5r5a9zQev0k3tmATfKPQpMXqET8afB6cN1v7vb7/Xu4sO0MyKWPWPKP5VPraWWn2+Nr14vPaW4CoFaT0rBD8b6DnrSpzsWTZAv6d/7eyuEJK3gmMvWZpiI+9MEjB9sTL1EE24hozNllOg5gzRIDezXWO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=rmgMpLAJ; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="rmgMpLAJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1787002067; x=1818538067;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=7HAQgr7W1Px6oodKSFEqrJXQ5YZXceMvyj/wLnrYFcQ=;
  b=rmgMpLAJ3TQdFYt7QiKq0Haj+EHDDde5UBphOpTqvcrMDXj3fwtJ2uyj
   q8qBtI5gBLeeE9x1PuGC7He7nT+WiEx1KP4D4paBtI7s72x9SjDTLouFT
   1pv6yIPZ0KrSnNDLzgFDeRgg2DTcCsxihEYO3RhUiVt/xm/acdI/8HDCq
   f6a7c7WQS2Cb2j7CdLz+xZnBC/kApC6wg2ZiYVh/w0qgylTO4XT6TRFAz
   SVpWTbIJFIpT+VkqAyzZUpBjgH1hAqazhotHFSkqpzD48g47XpjOWrkfr
   ukXTh4OL/HSTy3A+ukRqPLDRbIZoXfGcTCedsKjhzE4r7C2BgSM2fDfa/
   A==;
X-CSE-ConnectionGUID: xqkOYIIoS5iXSHPq31YmEg==
X-CSE-MsgGUID: siGmvPlBSnSUzy7Vob9ogQ==
X-IronPort-AV: E=Sophos;i="6.25,229,1779148800"; 
   d="scan'208";a="26237258"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 21:27:47 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:13272]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.183:2525] with esmtp (Farcaster)
 id 05c9af25-051b-43f7-8f28-ec338ccbac36; Mon, 17 Aug 2026 21:27:47 +0000 (UTC)
X-Farcaster-Flow-ID: 05c9af25-051b-43f7-8f28-ec338ccbac36
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Mon, 17 Aug 2026 21:27:47 +0000
Received: from u34cccd802f2d52.ant.amazon.com (10.106.178.24) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Mon, 17 Aug 2026 21:27:43 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v14 13/15] arm64/delay: enable testing
 smp_cond_load_relaxed_timeout()
From: Haris Okanovic <harisokn@amazon.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
CC: Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, <bpf@vger.kernel.org>, <arnd@arndb.de>,
	<catalin.marinas@arm.com>, <peterz@infradead.org>,
	<akpm@linux-foundation.org>, <mark.rutland@arm.com>, <harisokn@amazon.com>,
	<cl@gentwo.org>, <ast@kernel.org>, <rafael@kernel.org>,
	<daniel.lezcano@linaro.org>, <memxor@gmail.com>, <zhenglifeng1@huawei.com>,
	<xueshuai@linux.alibaba.com>, <rdunlap@infradead.org>,
	<david.laight.linux@gmail.com>, <broonie@kernel.org>,
	<joao.m.martins@oracle.com>, <boris.ostrovsky@oracle.com>,
	<konrad.wilk@oracle.com>, <ashok.bhat@arm.com>
In-Reply-To: <87tspi7lzk.fsf@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
 <20260714073041.40250-14-ankur.a.arora@oracle.com>
 <amiUWpsL1QGf929i@willie-the-truck> <87tspi7lzk.fsf@oracle.com>
Date: Mon, 17 Aug 2026 16:27:29 -0500
Message-ID: <178700204950.2504314.3914062953110867251.b4-reply@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi Ankur,

On 2026-07-28 16:06 -0700, Ankur Arora wrote:
> 
> Will Deacon <will@kernel.org> writes:
> 
> > Hello, Ankur,
> >
> > On Tue, Jul 14, 2026 at 12:30:39AM -0700, Ankur Arora wrote:
> >> This enables the barrier tests to be built as a module.
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> >> ---
> >>  arch/arm64/lib/delay.c               | 2 ++
> >>  drivers/clocksource/arm_arch_timer.c | 2 ++
> >>  2 files changed, 4 insertions(+)
> >
> > Acked-by: Will Deacon <will@kernel.org>
> 
> Thanks Will.
> 
> > I think this is looking good from the arm64 side now (and appears to have
> > all the relevant Acks). What's the plan to get this series merged?
> 
> Let me ask Andrew if he can pick this up via nonmm.

Any progress on merging this?

> 
> --
> ankur
> 


