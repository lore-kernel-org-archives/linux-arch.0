Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F39288AD;
	Mon, 16 Mar 2026 01:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625767; cv=none; b=gy2bMxJNmqwAq5Z/BJMwRkIkng0wQIZcNqWels37wkm660MkrMmZsrlwMceokH2Dl6fvAKlXHwPAvJb3PahImwgvWFtsvQpx2yVhekKguKEd+lRgTh82vyEwK/Wc9slKcJaSek+snpgpbW150AU/zK2Df1G57GTvWZzhtkEcsic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625767; c=relaxed/simple;
	bh=49DKbJ2akvpTxFFdAzXpo9gxcykYKuOsV8l6BaRz7Zo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FdE06FNLvfMW4y5bImNBlgZkVq8kLnJqVNyQwto6lGWsrshaAKobdS/ANkts/DEsMkOSK4wB0zk3XH6dyMFI6ICZxKxB5FlP646wNu4qnV60wXWAOhWB17nfDp4l2kwLpS2VfPGL7dT5nfgYH4O9lc7dTILxhMYi/rIg90/uCJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LqhsYN6a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LqhsYN6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE51C4CEF7;
	Mon, 16 Mar 2026 01:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773625767;
	bh=49DKbJ2akvpTxFFdAzXpo9gxcykYKuOsV8l6BaRz7Zo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LqhsYN6aRdj0khaTOrMtu85Myq6Tp+iQVgIqKVCv4HCPxw5E2j1i1owENsDugu9qS
	 z8yiMjaYrdWBkrfbJc4pUA2iCe7Onm/84lGvucfz2q96rRzOInYVqqpnHBgW4Htk2T
	 ESZjOCMSOBbtNy3xGokfL9Dy1WG/Q17KM9MZMKuE=
Date: Sun, 15 Mar 2026 18:49:25 -0700
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
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v10 00/12] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
Message-Id: <20260315184925.b6f93386e918ca79614843e3@linux-foundation.org>
In-Reply-To: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Mar 2026 18:36:39 -0700 Ankur Arora <ankur.a.arora@oracle.com> wrote:

> Hi,
> 
> This series adds waited variants of the smp_cond_load() primitives:
> smp_cond_load_relaxed_timeout(), and smp_cond_load_acquire_timeout().
>
> ...
>

How are we to determine that this change is successful, useful, etc? 
Reduced CPU consumption?  Reduced energy usage?  Improved latencies?

>
> Finally update poll_idle() and resilient queued spinlocks to use them.

Have you identified other suitable sites for conversion?

> 
>  Documentation/atomic_t.txt           | 14 +++--
>  arch/arm64/Kconfig                   |  3 +
>  arch/arm64/include/asm/barrier.h     | 23 +++++++
>  arch/arm64/include/asm/cmpxchg.h     | 62 +++++++++++++++----
>  arch/arm64/include/asm/delay-const.h | 27 +++++++++
>  arch/arm64/include/asm/rqspinlock.h  | 85 --------------------------
>  arch/arm64/lib/delay.c               | 15 ++---
>  drivers/cpuidle/poll_state.c         | 21 +------
>  drivers/soc/qcom/rpmh-rsc.c          |  8 +--
>  include/asm-generic/barrier.h        | 90 ++++++++++++++++++++++++++++
>  include/linux/atomic.h               | 10 ++++
>  include/linux/atomic/atomic-long.h   | 18 +++---
>  include/linux/sched/idle.h           | 29 +++++++++
>  kernel/bpf/rqspinlock.c              | 77 +++++++++++++++---------
>  scripts/atomic/gen-atomic-long.sh    | 16 +++--
>  15 files changed, 320 insertions(+), 178 deletions(-)
>  create mode 100644 arch/arm64/include/asm/delay-const.h

Some sort of testing in lib/tests/ would be appropriate and useful.
