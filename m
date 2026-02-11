Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8C8158535;
	Wed, 11 Feb 2026 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770830762; cv=none; b=JzXyDCqBzwiOaJAsl8tFz19l9DzvGfGljiwnTvkWSvdUMb2C2PHcBBsITem+6pQqaKvphrQONtkh9NsOlgA5OcOJsQSV95iS7xVKf8IFab9axglYa6HKHXhuM0sSoCP5qohYJkClsU2Xi0bT9gYqwc4G5tGr0/698UAfjnhAmek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770830762; c=relaxed/simple;
	bh=D2E1NXyiokyF0AcslM+lLICqgwW7uhz6rza+KhltRSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDZYsGGiTDznz8+twqFuD+oEhPxGfzpr7OS7cWGV9ntG5Wz/jbEOC6nGLHDMPeIQ67rXedFD3XHWaglb1xfiZ8gGXgRhp5XonMAk8uDzyMv+nIS/r2CmzkaDW7CM+zE0SsEOhq7kk0gRgyxclzwP6Bce0uskZ2DqgZItc82qKuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61377339;
	Wed, 11 Feb 2026 09:25:54 -0800 (PST)
Received: from arm.com (arrakis.cambridge.arm.com [10.1.197.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C74A33F63F;
	Wed, 11 Feb 2026 09:25:56 -0800 (PST)
Date: Wed, 11 Feb 2026 17:25:54 +0000
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
Subject: Re: [PATCH v9 07/12] atomic: Add atomic_cond_read_*_timeout()
Message-ID: <aYy7ogNXVaNNL5NC@arm.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
 <20260209023153.2661784-8-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209023153.2661784-8-ankur.a.arora@oracle.com>

On Sun, Feb 08, 2026 at 06:31:48PM -0800, Ankur Arora wrote:
> Add atomic load wrappers, atomic_cond_read_*_timeout() and
> atomic64_cond_read_*_timeout() for the cond-load timeout interfaces.
> 
> Also add a short description for the atomic_cond_read_{relaxed,acquire}(),
> and the atomic_cond_read_{relaxed,acquire}_timeout() interfaces.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
