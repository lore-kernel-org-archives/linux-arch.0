Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024AD3DEFF4;
	Wed,  1 Apr 2026 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040280; cv=none; b=L5uA8rB/D1h7p8coiP+pyuIDkemE2CtlrGvBLQnTdWImjbyY+jD5WlG7Il1uqWesE7vIpDRaJ6hMhyfBiZzPq3LvOCwIZCKXOScqEEOyLH2yovAV3pAnJzb38ZxvLv0KPtBPRicZAQmUedtysvyggnSiNh/X9YsMfV97TymPFf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040280; c=relaxed/simple;
	bh=vpIPJp6qKXZs2RoYHC30XBTLU8o8yKndpTBkfQ9uCE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEBIXEhXL4HzIxhtgtHxV2JJAarenCYOXa5hrQvmrV5CacMtfHfsVcBpPZcieQAz6OcsY/f7eKQKWJHmoFCOS9vjTe4R7Tmy+Lbt0VE+avem2/ffEI8AuB6/WZHVOve304uDbwuw231WsHVZkVDGiPGO6NF1Gwvl/8DtXIhMlVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZoRRizeY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZoRRizeY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7597E168F;
	Wed,  1 Apr 2026 03:44:31 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DCC73F915;
	Wed,  1 Apr 2026 03:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775040277; bh=vpIPJp6qKXZs2RoYHC30XBTLU8o8yKndpTBkfQ9uCE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZoRRizeYLglzeTWg3NXrJlo14WJTIqN/m55Cvxkvhiz92W/IyUVqSTBtiJWR4Deiu
	 LW6Wupi0xY2S7259D4eQOAbY76ZfplaFH/S99iESGJZ9FUEOAHwQKM1rGDvlWT8ES7
	 t7zSd3BH41VQIvZz0gd5AMdunBMrD1He+F4Dm3uI=
Date: Wed, 1 Apr 2026 11:44:31 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org,
	peterz@infradead.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
	ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, rdunlap@infradead.org,
	david.laight.linux@gmail.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v10 04/12] arm64: support WFET in
 smp_cond_load_relaxed_timeout()
Message-ID: <acz3D1SkqDqyH0Dy@arm.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
 <20260316013651.3225328-5-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316013651.3225328-5-ankur.a.arora@oracle.com>

On Sun, Mar 15, 2026 at 06:36:43PM -0700, Ankur Arora wrote:
> To handle WFET use __cmpwait_timeout() similarly to __cmpwait(). These
> call out to the respective __cmpwait_case_timeout_##sz(),
> __cmpwait_case_##sz() functions.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
