Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5873CB57F;
	Thu, 17 Sep 2026 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641951; cv=none; b=ax0vqHT9YoJzxu6UKGJs1Lgucvx3kd2G52PaDudEj77GYMhkNO+xr0YP2uRGxHCmwjzHGLyfPnD5AjrmeTs/XllyuClzaQ7mz+n5ZkqXw9eaO9ureEANg72h2YSlCHiGzv/Li+YhCtaPG8P71sPnBYaEphcvBMNnsRvD7Tcv7kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641951; c=relaxed/simple;
	bh=A1qJUzoEx4MjxX5KJ5zP6XztKc5+3XRYmk3SylEfKJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbEWxWtgK65LhlP8rWd6ILVo1d9FP2VU43dm7CW7cCgROz5MQx/P8gRpszYlaCkZm+5Hfy5QIG5u/Wts7/WcucD43k0LIAor3OilKatQkfp9OHgXD+OBb783GqQ/qID2QhuQLsMRb5ezVsQM+JXYVyMDX0R0HTZlHBia6uNxcWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=n3EKRXU7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="n3EKRXU7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77CEF1476;
	Thu, 17 Sep 2026 03:45:45 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 830FF3F882;
	Thu, 17 Sep 2026 03:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789641949; bh=A1qJUzoEx4MjxX5KJ5zP6XztKc5+3XRYmk3SylEfKJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n3EKRXU7Cq0DBTHyOGTTXwg29ME9vRYoBg/Zu9Qo8a/ZRg4WR/J/U0BVm+v1OMi4g
	 HNkWPW0bXHN9fcTqmsv5rJx7nhcBoRmjzGf42teEOckKeKZ3kfBaAjMrxSeXMoZqoc
	 j6309z9kZ3G1alSAYIaABBDQGB2YjpiPXZfdXtnw=
Date: Thu, 17 Sep 2026 11:45:43 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Florian Weimer <fweimer@redhat.com>,
	Darren Hart <dvhart@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
	Uros Bizjak <ubizjak@gmail.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v8 2/4] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
Message-ID: <aqvE1w1-FQPD4AoM@J2N7QTR9R3>
References: <20260821-tonyk-robust_arm-v8-0-077707b6f1c7@igalia.com>
 <20260821-tonyk-robust_arm-v8-2-077707b6f1c7@igalia.com>
 <aqqkX8GyxgdtoOmc@J2N7QTR9R3>
 <9d9a804f-c1f3-4c0c-b12a-975206f6c34c@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d9a804f-c1f3-4c0c-b12a-975206f6c34c@igalia.com>

On Wed, Sep 16, 2026 at 10:06:25PM -0300, André Almeida wrote:
> If I understood correctly, the correct approach here would be to use pop_reg
> as an input operand, making sure that we store the address hold by *pop on
> x2 register right? So something along the lines:
> 
> __u32 __vdso_futex_robust_list64_try_unlock(__u32 *lock, __u32 tid, __u64
> *pop)
> {
> 	register __u64 pop_reg asm("x2") = (__u64) pop;
> 
> ...
> 
> 		"	str 	xzr, [%x[pop_reg]]		\n"
> ...
> 
> 		: [val] "=&r" (val),
> 		  [result] "=&r" (result_reg),
> 		  [lock] "+Q" (*lock)
> 		: [tid] "r" (tid),
> 		  [pop_reg] "r" (pop_reg)
> 		: "cc", "memory"
> 
> Does that looks right?

Yep; that should work!

Just for completeness: another option would be to drop the memory
clobber, and have separate constraints for the "pop" memory location and
the "pop_reg" register. I think your suggestion above is simpler, so
let's go with that.

Mark.
