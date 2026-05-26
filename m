Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48ED22157B;
	Tue, 26 May 2026 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800487; cv=none; b=FVDGkbSz0vDaQFspPdxNg0T8pwFDBuRGZXI9S/fcInB6ttBp0eeMpeN85Fic/0t0s/HTiTARC+bhnbS8KJIkugTI7mO4NJdVxF/MDLxLTitZeKHIpuAGMpHkcDvD/I2GcBVRQII/1LZemGhiown4BmKkxpwy0N6EMyYTkkgyyZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800487; c=relaxed/simple;
	bh=QpvJy6L0CWjMFpDpW8hAGQht5XAWKU3uc1IdSsCVqqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQlDfCSi46IRnKhlrgYVarLwFfY9WJBGopP3PCrdKoqn4PSeIOnEjJcIO43lr4GH5X3xM4cJoIwmRVAB4LH4EST/A6TFfjzhnPMqSmjX+5T98YSVeFwVdd8D2RLLY3IodH6vYwRzzqTpaB0S3oLU3tt8Qv3vkWvCKUTJUI4koiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=p5Dsr0Xg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="p5Dsr0Xg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E9E9169C;
	Tue, 26 May 2026 06:01:20 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F1563F7B4;
	Tue, 26 May 2026 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779800485; bh=QpvJy6L0CWjMFpDpW8hAGQht5XAWKU3uc1IdSsCVqqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p5Dsr0XgPS8sKERaqTqbDerx+Dn5jf/pmbrKN+O+qEDCMgx32IF7d+aOy0yyNZYcH
	 +XwBPVX+lcDnvbKX7Dms7cneX8kxmoejWuL43TPu0moc2NGzHIA6y7Q0YGice4hMx+
	 eCJbFlg5YILwosv9Sj8NQkWWJYc8jsLPEp/mmU1g=
Date: Tue, 26 May 2026 14:01:20 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Zeng Heng <zengheng@huaweicloud.com>
Cc: will@kernel.org, akpm@linux-foundation.org, npiggin@gmail.com,
	aneesh.kumar@kernel.org, peterz@infradead.org,
	linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, zengheng4@huawei.com,
	sunnanyong@huawei.com, blingxue@tencent.com
Subject: Re: [PATCH] arm64: tlb: Flush walk cache when unsharing PMD tables
Message-ID: <ahWZoD9Ubaxx-GdK@arm.com>
References: <20260521073011.4121277-1-zengheng@huaweicloud.com>
 <177944657885.252010.9796978866224637120.b4-ty@arm.com>
 <f5b7460a-5719-bdb2-c53b-413468857f57@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5b7460a-5719-bdb2-c53b-413468857f57@huaweicloud.com>

On Mon, May 25, 2026 at 05:20:14PM +0800, Zeng Heng wrote:
> On 2026/5/22 18:42, Catalin Marinas wrote:
> > On Thu, 21 May 2026 15:30:11 +0800, Zeng Heng wrote:
> > > When huge_pmd_unshare() is called to unshare a PMD table, the
> > > tlb_unshare_pmd_ptdesc() function sets tlb->unshared_tables=true
> > > but the aarch64 tlb_flush() only checked tlb->freed_tables to
> > > determine whether to use TLBF_NONE (vae1is, invalidates walk
> > > cache) or TLBF_NOWALKCACHE (vale1is, leaf-only).
> > > 
> > > This caused the stale PMD page table entry to remain in the walk cache
> > > after unshare, potentially leading to incorrect page table walks.
> > > 
> > > [...]
> > Applied to arm64 (for-next/fixes), thanks!
> > 
> > [1/1] arm64: tlb: Flush walk cache when unsharing PMD tables
> >        https://git.kernel.org/arm64/c/c2ff4764e03e
> 
> This original issue was reported by our customer, who also participated
> in the root cause analysis and resolution.
> 
> Could you please help add the below tags:
> 
> Co-developed-by: Xue Xiaowei <blingxue@tencent.com>
> Signed-off-by: Xue Xiaowei <blingxue@tencent.com>
> 
> Thank you in advance.

Too late unfortunately, the pull request went in on Friday. It will be
in the list archives though.

-- 
Catalin
