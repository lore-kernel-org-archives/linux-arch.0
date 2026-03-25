Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644023BE156;
	Wed, 25 Mar 2026 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454131; cv=none; b=XKHXCH62VxvrstJhb4SW41T1Z6oA5qJiqARytUfPG7/qig8ddiqr1Y1xaykk45JUKl4uIgU1sWSUjvNp5wWG+C3Zrdt4bfx5cNv0S73Ycd+rWqqamo51GEoYRhzG9NysMdfjovUojhVHCJEPVU3EQcme37JaljdknsI+H/GaXz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454131; c=relaxed/simple;
	bh=YQUNJN6zkse+VSauT7FpCBg1zlDjtEPhRb6cnGEJo3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWt30c2/H13ucDem4BEzCHmcgNFVnVyImMv+5Uy30WD9yc+cyyD7X5hjeMgkeRIMxMx2LYhWWV5lpJy3lThYgUgwHDTOH/ArOfFlar0VvwpydxttXYq0AIgdkZI5xmDaNfEUiGnpjM7KqWfaaFPR0Cs/zZ0ZVxvN8CNjcStWZLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=h8JB7WbL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="h8JB7WbL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E2191E8D;
	Wed, 25 Mar 2026 08:55:22 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 066C33F915;
	Wed, 25 Mar 2026 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774454128; bh=YQUNJN6zkse+VSauT7FpCBg1zlDjtEPhRb6cnGEJo3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8JB7WbLLPhhNKdwHewQJz8w+JkyrvDnAG4/VGG5xLycbGrGIBZfkpXEzNGax363a
	 DyMKpQnDFv5EJyjol41ofV3pwnkLQEaHLIv+H/8z64TWhKHXcywuIxr9f1hOB/Iedl
	 g0IhNDMiR/fjZHdnXnvW74mg0i/jF65VNF2vtzks=
Date: Wed, 25 Mar 2026 15:55:21 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org,
	peterz@infradead.org, mark.rutland@arm.com, harisokn@amazon.com,
	cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
	daniel.lezcano@linaro.org, memxor@gmail.com,
	zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
	rdunlap@infradead.org, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v10 00/12] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
Message-ID: <acQFaVR_bGZU2JmJ@arm.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
 <20260315184925.b6f93386e918ca79614843e3@linux-foundation.org>
 <874imftol4.fsf@oracle.com>
 <20260316233712.7cbfac27@pumpkin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316233712.7cbfac27@pumpkin>

On Mon, Mar 16, 2026 at 11:37:12PM +0000, David Laight wrote:
> On Mon, 16 Mar 2026 15:08:07 -0700
> Ankur Arora <ankur.a.arora@oracle.com> wrote:
> > However, as David Laight pointed out in this thread
> > (https://lore.kernel.org/lkml/20260214113122.70627a8b@pumpkin/)
> > that this would be fine so long as the polling is on memory, but would
> > need some work to handle MMIO.
> 
> I'm not sure the current code works with MMIO on arm64.

It won't but also passing an MMIO pointer to smp_cond_load() is wrong in
general. You'd need a new API that takes an __iomem pointer.

> I was looking at the osq_lock() code, it uses smp_cond_load() with 'expr'
> being 'VAL || need_resched()' expecting to get woken by the IPI associated
> with the preemption being requested.
> But the arm64 code relies on 'wfe' being woken when the memory write
> 'breaks' the 'ldx' for the monitored location.
> That will only work for cached addresses.

Even worse, depending on the hardware, you may even get a data abort
when attempting LDXR on Device memory.

> For osq_lock(), while an IPI will wake it up, there is also a small timing
> window where the IPI can happen before the ldx and so not actually wake up it.
> This is true whenever 'expr' is non-trivial.

Hmm, I thought this is fine because of the implicit SEVL on exception
return but the arm64 __cmpwait_relaxed() does a SEVL+WFE which clears
any prior event, it can wait in theory forever when the event stream is
disabled.

Expanding smp_cond_load_relaxed() into asm, we have something like:

	LDR	X0, [PTR]
	condition check for VAL || need_resched() with branch out
	SEVL
	WFE
	LDXR	X1, [PTR]
	EOR	X1, X1, X0
	CBNZ	out
	WFE
  out:

If the condition is updated to become true (need_resched()) after the
condition check but before the first WFE while *PTR remains unchanged,
the IPI won't do anything. Maybe we should revert 1cfc63b5ae60 ("arm64:
cmpwait: Clear event register before arming exclusive monitor"). Not
great but probably better than reverting f5bfdc8e3947 ("locking/osq: Use
optimized spinning loop for arm64")).

Using SEV instead of IPI would have the same problem.

-- 
Catalin
