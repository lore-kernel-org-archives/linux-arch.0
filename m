Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897793CBE7A;
	Fri, 22 May 2026 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779446590; cv=none; b=AlKsnf0ChG49p3v81Pcs46M77cxsSbKbQMnwX8n9qrQLZeE7EeHz4UOla2WsQpPJWCAKW3DEB5LiKGr/QyewAut8WUw4YklLYAejkMjKDDzszEXS2Iv5I3tUhbxNyrdyz8OOfV3eljCSQTYNKhRYfmyi2fLfcEjMh8TatjS+FiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779446590; c=relaxed/simple;
	bh=49ERVB42HbkzceUNDuiP0n4teSxNaWaUsT8J9PiFBJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRpoJG2In3BLAQYFUJXCGzf/5dNuJSdz2h2sG3HGM1yaigjLShk3iiY6L7AlhV0Ecj2RVTd1ZxvJcgdunC982o8HJa1sOWdmHfpMNS77Dar7fS0Yq2dtNXoTLFeN4OKSjNlKSFIFRVOMfdG29fqcBaKkJBuH/v9MEkfV6k+GsaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=D1qNWdO1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="D1qNWdO1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CB9A26BC;
	Fri, 22 May 2026 03:43:01 -0700 (PDT)
Received: from gaia.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8013F3F85F;
	Fri, 22 May 2026 03:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779446586; bh=49ERVB42HbkzceUNDuiP0n4teSxNaWaUsT8J9PiFBJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D1qNWdO1SmfjrQQ0lb2yVnJDiMBnyUxUuurt3x2TqS+jPAIpxjgjR37proU0VrQI7
	 yhEAc0n648oP4KiXgGRQ5RveySpxd1jY7QX7ErqNVvWx/sbVbTfrglaYEeGhN57oAi
	 fe20E8ILDxz3vz1Q63o39pebv6lu5c20hDthXK30=
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	akpm@linux-foundation.org,
	npiggin@gmail.com,
	aneesh.kumar@kernel.org,
	peterz@infradead.org,
	Zeng Heng <zengheng@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org,
	wangkefeng.wang@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH] arm64: tlb: Flush walk cache when unsharing PMD tables
Date: Fri, 22 May 2026 11:42:58 +0100
Message-ID: <177944657885.252010.9796978866224637120.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521073011.4121277-1-zengheng@huaweicloud.com>
References: <20260521073011.4121277-1-zengheng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 21 May 2026 15:30:11 +0800, Zeng Heng wrote:
> When huge_pmd_unshare() is called to unshare a PMD table, the
> tlb_unshare_pmd_ptdesc() function sets tlb->unshared_tables=true
> but the aarch64 tlb_flush() only checked tlb->freed_tables to
> determine whether to use TLBF_NONE (vae1is, invalidates walk
> cache) or TLBF_NOWALKCACHE (vale1is, leaf-only).
> 
> This caused the stale PMD page table entry to remain in the walk cache
> after unshare, potentially leading to incorrect page table walks.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: tlb: Flush walk cache when unsharing PMD tables
      https://git.kernel.org/arm64/c/c2ff4764e03e
