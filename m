Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDFA367F39;
	Thu, 23 Apr 2026 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776964593; cv=none; b=UxWqqfE0Df8Oepb6cfJEZQVmkDPVQg73vDHmjXaTztaTR7GdhAIj/fbTP6LtSZPuqAoTX0SZSJv8ITdMlXPNnT6bsdz7OOj6KZ5WxGzwIjjVlk0xWnRkkeWo8Johps2/ts534WPYPpxU7X/6clQRzYLSWAZHQ4EvmnoqRtVED34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776964593; c=relaxed/simple;
	bh=5p+VepR5wJHe4o7jIsVUYpLrJUgsXBIvYPh5Xah4Rf8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Fm1JdRXtPRJCxCW4PEv6/ehZqaaE1XoEhr6/Nk28c3+pidWMZvlM5qax4dXcyT1rdytEzWM3T9TePZ/iwUCmF7lt9gGcGpx/zv64rOGlU2Vs5MAAQ+u7YLX5G3y4OlmQdkVL6Ti9Zh7r2KteCnAsPL8U5YUYV+gUyz7zTShSgCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=s+jiOEXl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="s+jiOEXl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B86C2BCAF;
	Thu, 23 Apr 2026 17:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776964592;
	bh=5p+VepR5wJHe4o7jIsVUYpLrJUgsXBIvYPh5Xah4Rf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s+jiOEXlNsToZuAs+kLgiqYKx6+FScUlmctoYOMjAJAav55a1VGjrfI6KzW22oVsa
	 P1wzE2ZqcEIHTYCW9pNyUYoXuuWVJv8JJWU20B9C2RtfMylsjDywAe0lNxy62ZKIAi
	 G2IOPewWlzy+DdieHRfP5JTTHdlX7R7MBfcgJf/c=
Date: Thu, 23 Apr 2026 10:16:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
 will@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
 harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
 xueshuai@linux.alibaba.com, rdunlap@infradead.org,
 david.laight.linux@gmail.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, ashok.bhat@arm.com
Subject: Re: [PATCH v11 00/14] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
Message-Id: <20260423101631.84f26592d629eee46fbde6f8@linux-foundation.org>
In-Reply-To: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Apr 2026 17:55:24 +0530 Ankur Arora <ankur.a.arora@oracle.com> wrote:

> The core kernel often uses smp_cond_load_{relaxed,acquire}() to spin
> on condition variables with architectural primitives used to avoid
> hammering the relevant cachelines.
> 
> ...
> 
> Accordingly add two interfaces (with their generic and arm64 specific
> implementations):
> 
>    smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, timeout)
>    smp_cond_load_acquire_timeout(ptr, cond_expr, time_expr, timeout)
> 
> Also add tif_need_resched_relaxed_wait() which wraps the polling
> pattern and its scheduler specific details in poll_idle().
> In addition add atomic_cond_read_*_timeout(),

Thanks, I'll add this to mm.git's mm-new branch today.

This isn't am MM patchset, but mm-new isn't included in linux-next, and
linux-next isn't presently open for 7.1 material.

After -rc1 I'll move the series into mm.git's mm-nonmm-unstable branch,
where it will get linux-next exposure.

I see that further review/comment has been requested - hopefully this
will happen over the next couple of months, but please do continue to
chase this down if you feel the need.

> Haris Okanovic also saw improvement in real workloads due to the
> cpuidle changes: "observed 4-6% improvements in memcahed, cassandra,
> mysql, and postgresql under certain loads. Other applications likely
> benefit too." [12]

Those are significant improvements.   Three years :(
