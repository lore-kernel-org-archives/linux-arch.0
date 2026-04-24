Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCA23D88E1;
	Fri, 24 Apr 2026 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777040927; cv=none; b=Jk+uHlDKMUR15xMO14CogOqAoxLWuyKR2hNIFzECzGwINtRPNeAlleeH3w2cBVhQkW07q5mFcoB8etxq/WSnTSrIST0tyjAJhGuiTVtQQrKItq9cEwyzPVQ0Fsl7hPNBzAgeS89CqQCNG8B4Hey98HRTkBk8Nd4utiQjs5ZuE4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777040927; c=relaxed/simple;
	bh=JOLAjUJZxkORvwjV4KMyJPPQMlPzeGI+Xzat5mLfNAY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=G86wwzcCjRBq/fr7GEb6AQWs1NBDiXjB8p9Pn+EXBzk1s43VNQqIjlP8bBr71KW2GlDJpKlV+zdUDVUY4u5TC2t4CAohcWth7XDsogWJyY/8Zk3Qd2Bm+26WNn2n2Pp2IU0ogHIccoBcyCL4LnFQiYZV/XgA3Su6s07zx+Jbv1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O/Y3cojL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O/Y3cojL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C434C19425;
	Fri, 24 Apr 2026 14:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777040927;
	bh=JOLAjUJZxkORvwjV4KMyJPPQMlPzeGI+Xzat5mLfNAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O/Y3cojLauCIDvWwjW8Rm82ldPv3YcF1tPNTv5blC/JP9MAXmk+S1E/ixk8QGUnSZ
	 uNi6C8iJUYmCjyfO1nsdEVAGvuO8qVfAIFXa6DJd354zWaVct5od0w3QdENXrPAFNb
	 ad9f0JF2uEcsiwTOBisrjCjaT8bU4mViiybAgp7U=
Date: Fri, 24 Apr 2026 07:28:45 -0700
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
Message-Id: <20260424072845.5eba94c2d732204f143b8629@linux-foundation.org>
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
> atomic64_cond_read_*_timeout(), and atomic_long wrappers.

AI review has been busy:
	https://sashiko.dev/#/patchset/20260408122538.3610871-1-ankur.a.arora@oracle.com
