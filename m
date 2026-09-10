Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D369237FF43;
	Thu, 10 Sep 2026 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789081491; cv=none; b=Lyn+f9Dw4og0D8WHpand1VV/WJ8bHiaaqiU5mlC2TEjbDs2Q30m+sCY61t4bXH2dO2p63qKlkdHJlrz1mHSsI/BQvJF0XIkbegIQnFBoEOqVBM9KGj7nphMlObTskzGp3aR3GKMiy4tCADlqQPR7dwphPDqEsm762p25uEdRe4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789081491; c=relaxed/simple;
	bh=RYnKZzkKeQ7QHnjYCSAWgVSUvUc34WJD1tWKkdH1mss=;
	h=MIME-Version:Content-Type:Subject:From:To:CC:In-Reply-To:
	 References:Date:Message-ID; b=tbnJxWbDm2SBnLFx1FW2DvuS7GJvorYS09qylTNUBSxiAdK6U9d7z7GU3OSNXEwHk1hPxwNA6uaPorFzZgZMKpofqa8LxEQQuMAEgyo3BCzG6tdNjq7Ddc+uXUtb6YDrs+udeGrURMYG5uhpeDAnd1hLBTlNXTsDe/1HuOj+FOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ViU7V12a; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ViU7V12a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1789081489; x=1820617489;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=Cpm7fRwjhhvI0gL9ZWF/CWGjObI1IMCPM/5oBJgqSTI=;
  b=ViU7V12a41Nio92O1KBAsjiUousx3oEtZcr8LS8ZEcrw8S8fQ568TXXm
   anY8ygkrZGBP4ybqi+2OGUNQTzXrGIcd6tg6BNwppWO7DRdVLuiBgkWAf
   6TDe6zmGFJ0XzRYoFAJTNL/gccQTg2jbyTEbEohtrYFRODEB/edhwcVjC
   2A2Nee6N7aGfp53FG84s91tDEtQ/PnfNmyjyJz4uEsMCUAbFHW6+uRKuW
   o2SVj+lRnX2ml5qDPVizjZZvQhlmJoTU+OTfOhE7bQPleTRA52LBLjITE
   rMi0flkUOc2J+Xf8OXAoxrJRMGKxuLnIx6iSkn77U0qkc3y4xN2R20N7l
   Q==;
X-CSE-ConnectionGUID: syaoVgMbQSW/3j6FV4MDug==
X-CSE-MsgGUID: rGLszRc0RAmv4QW0+sJ8yA==
X-IronPort-AV: E=Sophos;i="6.27,96,1787011200"; 
   d="scan'208";a="28168128"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 23:04:49 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:21450]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.49:2525] with esmtp (Farcaster)
 id 2a193d5d-bee9-42f9-b267-05771716733e; Thu, 10 Sep 2026 23:04:49 +0000 (UTC)
X-Farcaster-Flow-ID: 2a193d5d-bee9-42f9-b267-05771716733e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Thu, 10 Sep 2026 23:04:48 +0000
Received: from u34cccd802f2d52.ant.amazon.com (10.106.178.32) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Thu, 10 Sep 2026 23:04:45 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v15 12/16] cpuidle/poll_state: Wait for need-resched
 via tif_need_resched_relaxed_wait()
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
In-Reply-To: <20260831202251.305046-13-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
 <20260831202251.305046-13-ankur.a.arora@oracle.com>
Date: Thu, 10 Sep 2026 18:04:27 -0500
Message-ID: <178908146776.2725577.2613699832033292946.b4-review@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Mon, 31 Aug 2026 13:22:47 -0700, Ankur Arora <ankur.a.arora@oracle.com> wrote:
> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
> index c7524e4c522a2..7443b3e971baf 100644
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -6,41 +6,22 @@
> [ ... skip 36 lines ... ]
> -			}
> -		}
> +		dev->poll_time_limit = !tif_need_resched_relaxed_wait(limit);
>  	}
>  	raw_local_irq_disable();
>  

Tested again on AWS Graviton3/4/5 (ARM Neoverse V1/V2/V3) with haltpoll changes
atop latest master 8ab1afb2e: still seeing average 6% improvement across various
workloads (mysql, postgresql, cassandra, memcached) in latency sensitive configuration.

The new unit tests all pass on both metal and virt variants of the same machines.

I hope we can merge this soon.

Tested-by: Haris Okanovic <harisokn@amazon.com>

-- 
Haris Okanovic
AWS Graviton

