Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8DA32A3DA;
	Wed, 11 Feb 2026 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770831703; cv=none; b=LIM6sMlIKINn9EaVzm74xcrJj+dkAIIm3uR/wpTlQs4l9km1Rdsy/E2LNSxxoM33Nez6mlD2Y2yMRJSTgvGNpzHi5hcIotCrmT9pIrFCnRTMpwjMCisqAbPfu95wpMWt65qpYAWyReLjYFQY5MF526EhbMYaFdn76okfmlmUZgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770831703; c=relaxed/simple;
	bh=ZILNHAM2+Zr33iLAB4nQIpiribl+a79iiJRFGYam2nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMimDq+waDB07rxtRVwCNI/9aUus3iZWAoXPBfL09lgBTTQttK2Kcun2lrNwc1OebT/9bIAC5ZOTd3soj6hC/l3nVHqYzahVlksEiJ7EqRQA2nLvl/qwMSlFsLkF5Roumxy7Ngc1sR5jT/07b3zlGFnGuVhranz3Wah09jQ27Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEEE6339;
	Wed, 11 Feb 2026 09:41:34 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE6DF3F63F;
	Wed, 11 Feb 2026 09:41:37 -0800 (PST)
Date: Wed, 11 Feb 2026 17:41:35 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org,
	peterz@infradead.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
	ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
	Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v9 08/12] locking/atomic: scripts: build
 atomic_long_cond_read_*_timeout()
Message-ID: <aYy_T9rbU2-xfFX1@arm.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
 <20260209023153.2661784-9-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209023153.2661784-9-ankur.a.arora@oracle.com>

On Sun, Feb 08, 2026 at 06:31:49PM -0800, Ankur Arora wrote:
> Add the atomic long wrappers for the cond-load timeout interfaces.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
