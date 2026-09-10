Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F583815DC;
	Thu, 10 Sep 2026 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789081497; cv=none; b=ipmpkMSaYTIQsv75me+ZXFtCjWbKotfoNDi5b2WjDbyk83qsLWXoLtXb7Af3eQLTE91nDRwFncUiFnpzzum1SEtgMDbDGwXb8cAvNVCfEHtC3y73WTkTUOA+znahE/kzdA7yl0QOO71uTATdu00ujxgyetlrh06xWoAYmjug+Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789081497; c=relaxed/simple;
	bh=EFIlYbqZQybpssEIeswYV2aYYwyxhlUC9eUDefOseT8=;
	h=MIME-Version:Content-Type:Subject:From:To:CC:In-Reply-To:
	 References:Date:Message-ID; b=d8qXPN9S5jG5D02R2A32+dcYc1tXozZKZMNhTMFDUm8RMPYAdtT/7dryyMcr0ULASWtRTFX7WEETNokreTxb5AexqmpVGt/3NiPRGjBZ4+oZBMA3ca7GcZxacnCeOmaBq/nDgEIs/RaiisdR8XZcBd5LGatm8S4SnYU5sL0jCGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=gJSdwWRr; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="gJSdwWRr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1789081495; x=1820617495;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=j7l7z1mpmxbRfASwFkI/gOw9Q15D1cjZKLx46DX6Ups=;
  b=gJSdwWRrtNINRPKNM0HQY0HwApEax7uSEmUf1tQgZ92qEjE+1q1ZuOCH
   AdVL4HQe74LS1J1W4vHei33RV4roYXiaiWObhf1QGPFQp+95uun0ysS25
   MINTPRv2hWP61cP2qqVipFWFLCSXEO55Psh21r1oE+k0Q3qtZjkBqH1Sk
   ayV6QxPd5+VBvEKddCsvvtlXW/rmIWRLAwOIOe5JrRedzJ+NAmVZq+LMt
   +q56ohnECtJzzv+DhAPRhfFbWuMEkS06bDBbXDamxHppZmmJ+2nyvcfVw
   k/3ZL5CXzX3a5i5oRk4Ul6IrVrxjdMovz/xPiXb0ZSPvrdNGiXjdt7q/q
   w==;
X-CSE-ConnectionGUID: EaITWzvPTnqWhJn1j//q6Q==
X-CSE-MsgGUID: uu1cUFSCQ+qcv21O108oPA==
X-IronPort-AV: E=Sophos;i="6.27,96,1787011200"; 
   d="scan'208";a="28351480"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 23:04:55 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:7707]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.113:2525] with esmtp (Farcaster)
 id ba131792-6492-4a10-a6fc-dc6b9d93c693; Thu, 10 Sep 2026 23:04:55 +0000 (UTC)
X-Farcaster-Flow-ID: ba131792-6492-4a10-a6fc-dc6b9d93c693
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Thu, 10 Sep 2026 23:04:54 +0000
Received: from u34cccd802f2d52.ant.amazon.com (10.106.178.32) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Thu, 10 Sep 2026 23:04:51 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v15 15/16] barrier: timeout validity checks for
 smp_cond_load_relaxed_timeout()
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
In-Reply-To: <20260831202251.305046-16-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
 <20260831202251.305046-16-ankur.a.arora@oracle.com>
Date: Thu, 10 Sep 2026 18:04:27 -0500
Message-ID: <178908146778.2725577.4108944992215893353.b4-review@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Mon, 31 Aug 2026 13:22:50 -0700, Ankur Arora <ankur.a.arora@oracle.com> wrote:
> Add timeout tests for smp_cond_load_relaxed_timeout().  These check
> that the implementation returns early on invalid timeout values and
> handles edge cases sanely.

Tested-by: Haris Okanovic <harisokn@amazon.com>

-- 
Haris Okanovic
AWS Graviton

