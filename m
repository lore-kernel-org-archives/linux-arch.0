Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C68638B14F;
	Thu, 10 Sep 2026 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789081494; cv=none; b=RfNB+AiLMcAap7I+bvkMl+6PU2C6PwIpJGRMav0eiFeC+F1uLTZy3Jg7+bwZSa2vmMNe+/CBsurzDx4aF2uBLLg4BhyZ5Lurm5u54PQNxHsRGN5/xmAor6YF3d6thc9xZB6jnDFkDWhQWHZdKUWJJJDI97gTKbgDy1wI8CU7wTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789081494; c=relaxed/simple;
	bh=1svIq8EWADIzQ0BF7HYEasYEMhCoi1F2lsUmrUJRKvA=;
	h=MIME-Version:Content-Type:Subject:From:To:CC:In-Reply-To:
	 References:Date:Message-ID; b=QZbffq7CZpb8Zbv/bxwKWWYE/4knc4AQmQmO50SkXOKiUwsZfXq4LFwKKqr/49hMOcVrLPvyaIxXe8kFMO6UlX/OCD+O1muZzHINNaMjGvc/Q5FQC/wQp1LS6L51TxJNlRzoy70ZUDnnlG17YkHFGPAXxYN9+PCX4c0KgJVGrYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Y1Oil3p7; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Y1Oil3p7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1789081493; x=1820617493;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=zNgSNTNR480O9vDPDU7zC5Px0iicu4f1bsiOB9344YU=;
  b=Y1Oil3p7zpm6MOKRvK6RZxMofcFEa/4cFbOytXqOZtszesPUnSGoltxp
   aohJvfT2ga2zVyYhr9tlz0CuJ3bdwUTFIKAssJuMOX0mXyvEoMtYgW3xe
   p5PZn8Om9D5qz0n2WNPQRDldQ/3DTBzuuq9eZTiL3Fr1Qa+zUnUI7QrES
   bRID+twXjEKGKfOVr3WMOYzbvVLkGa+nIOFt+S4LPXb1BGG09tl2mMPKo
   x6D4rWF9LwrHE8e4GZj+6ON5FEcZMesYwrUEr2BPbA60O2eKQ8+OxBXE/
   2EgT5+T1L4pHNjPjLjd4qMh4kqBKzGRmydvcQnUWOGULhrJqWMVSYh2np
   Q==;
X-CSE-ConnectionGUID: TbvrUZYeROSbPZZjBOSTuA==
X-CSE-MsgGUID: CWtiIfh7SySJRPaM6/vy7Q==
X-IronPort-AV: E=Sophos;i="6.27,96,1787011200"; 
   d="scan'208";a="28174137"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 23:04:52 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:18934]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.160:2525] with esmtp (Farcaster)
 id 7a1acc50-bba7-4809-926f-d08daac21daa; Thu, 10 Sep 2026 23:04:52 +0000 (UTC)
X-Farcaster-Flow-ID: 7a1acc50-bba7-4809-926f-d08daac21daa
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Thu, 10 Sep 2026 23:04:51 +0000
Received: from u34cccd802f2d52.ant.amazon.com (10.106.178.32) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Thu, 10 Sep 2026 23:04:48 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v15 14/16] barrier: add tests for
 smp_cond_load_*_timeout()
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
	<boris.ostrovsky@oracle.com>, <konrad.wilk@oracle.com>, <ashok.bhat@arm.com>,
	Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260831202251.305046-15-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
 <20260831202251.305046-15-ankur.a.arora@oracle.com>
Date: Thu, 10 Sep 2026 18:04:27 -0500
Message-ID: <178908146777.2725577.14495389857776220340.b4-review@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Mon, 31 Aug 2026 13:22:49 -0700, Ankur Arora <ankur.a.arora@oracle.com> wrote:
> Add success and failure case tests for smp_cond_load_*_timeout().
> 
> Success or failure cases depend on the expected bit being set (or not).
> Additionally in failure cases smp_cond_load_*_timeout() cannot return
> before timeout.
> 
> 
> [...]

Tested-by: Haris Okanovic <harisokn@amazon.com>

-- 
Haris Okanovic
AWS Graviton

