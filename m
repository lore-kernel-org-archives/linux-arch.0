Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B643A0E81
	for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2026 02:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997195; cv=none; b=skVZtrOqjCDrd+fhQbjTqsDnvplMQchvTUvFLCNaCdbqPEFL8E3cI5KzJK1Rusbt/zSZTujx/DwgOyzzOjSnsFyAHJy4Q2/amufgK9AWP2G+cVXnu1TTjg/7Hpo0PMEz+wS/EF84UHVBycOrYfQHkM7/0G9UGOapzESfhI7+bfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997195; c=relaxed/simple;
	bh=9bUacWTJi0a97hmDwxtNquaIhVVwoI9zj+xO3eJwnuo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cQXrrqU/vwMIeS4I6nD2ZBGR2aPzHfxH6NQZ3kOklwHZm8KbS3gJr++toefjJVnNZMvTMUuB5YEfuVjbqpG25JdYgiICUyJ1I4/5XABV8PLynF1Gs4jJwzjLnsfm5+dcbabW0DNFmGAaLXEXP91fOMHZZDxWBoK6viGmS5D4LTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mClcqMyN; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mClcqMyN"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783997189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EAQHSDx5Pf+w4+v4uxcesiEVqlXwwknrma7QzuTbLYc=;
	b=mClcqMyNV4sFTQazeEiZNF5uDwQLQhez8hYB4lH6ijsXHxaEdK7XG/mIiCfJdQb7RPf5bd
	2fiOxABPjI7E2jAbl7eAiY6MNJnUN6xTLjVE78wHQmn1D6S5R7TOBzUqy6H5uXrahWl0qB
	eNc/y8IWLJ9AhDmXEIBwS+W2nimHfKQ=
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v6 3/8] mm: add a set_page_section_from_pfn() helper
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260709112520.24857-4-lizhe.67@bytedance.com>
Date: Tue, 14 Jul 2026 10:45:52 +0800
Cc: akpm@linux-foundation.org,
 apopple@nvidia.com,
 arnd@arndb.de,
 balbirs@nvidia.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 david@kernel.org,
 kees@kernel.org,
 mingo@redhat.com,
 rppt@kernel.org,
 tglx@kernel.org,
 linux-arch@vger.kernel.org,
 linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 x86@kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <ED913AB8-0DF0-4F2B-9E7E-ABC4BF926C9D@linux.dev>
References: <20260709112520.24857-1-lizhe.67@bytedance.com>
 <20260709112520.24857-4-lizhe.67@bytedance.com>
To: Li Zhe <lizhe.67@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Jul 9, 2026, at 19:25, Li Zhe <lizhe.67@bytedance.com> wrote:
> 
> Callers that want to update section bits from a PFN currently need to
> open-code:
> 
> set_page_section(page, pfn_to_section_nr(pfn));
> 
> and guard that sequence with #ifdef SECTION_IN_PAGE_FLAGS.
> 
> Add set_page_section_from_pfn() to wrap that update in one place. When
> section bits are stored in page flags, the helper derives the section
> number from the PFN and updates the page flags. Otherwise keep it as a
> no-op so callers can use one helper without open-coding
> SECTION_IN_PAGE_FLAGS.
> 
> Convert set_page_links() to use the new helper so later ZONE_DEVICE
> fast-path patches can also update section bits without open-coding
> SECTION_IN_PAGE_FLAGS at each callsite.
> 
> This keeps the PFN-to-section translation local to the configurations
> that actually store section bits in struct page flags, and avoids
> exposing that detail to generic callers.
> 
> No functional change intended.
> 
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>


