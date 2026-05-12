Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F13215075
	for <linux-arch@vger.kernel.org>; Tue, 12 May 2026 02:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778553112; cv=none; b=ZNZFRmrp+yZ5qFgx0UiMOO8EGCoCHjZrVFYwhIhQxaUthAABy5/sSaHzSDgMhyK4K5l9xu7xCmPf7CMhnVv/9eEPPV41ipQV+7HXzaxCkPgXjXMZinI3YrVWAdYE76CJCDYqQIisjjfKLPLARlbDtKk2U8ZyWSc7VcVdk7LhnBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778553112; c=relaxed/simple;
	bh=MVCYu/raX2Wy6xQBRE7INl6zUVRuRIDA2PgsiB5UX7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=caTAqImvU98jBzH15V+hTOsaqOXHRSw7/Rc6o1HFF6sytr+PTXo0Lr2lEXncA3f6spZcv+zYHrm2GDN5f8HtQlZkOdQj+/jZYLX68FyPWuUu9aSXm92+5aXogLSotHyea8WQJi4DPH+zGZHpUTYwpieQLjO7eDNG2V0lFGAh5mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GyUGK0YJ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GyUGK0YJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778553098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrtZb448NrHIsfPspS1Njut8kvZNG6sBP0VsaE/hSZE=;
	b=GyUGK0YJHbec8/rg/NvHo0Q02EmZGAa7e94VCOrmhBd3dcKkUiij82TaEsuXGxxKpKFMRA
	d/xdNjCaCZp140PimKqafnzuoApiErZ1aok+Bv9U569JWmTHGfzzRpf0kocVXbdOS0g+Ee
	OBCOnaIbMvPdmGPjRu7MW0VTQ0cg73Y=
From: Lance Yang <lance.yang@linux.dev>
To: jannh@google.com
Cc: rppt@kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	ardb@kernel.org,
	sethjenkins@google.com,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH] mm: make zeropage read-only
Date: Tue, 12 May 2026 10:31:29 +0800
Message-Id: <20260512023129.44966-1-lance.yang@linux.dev>
In-Reply-To: <CAG48ez2ed44M=-qsZO7gwcz5L2njdRdk54d47jEg48MhWTkaew@mail.gmail.com>
References: <CAG48ez2ed44M=-qsZO7gwcz5L2njdRdk54d47jEg48MhWTkaew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Fri, May 08, 2026 at 06:26:32PM +0200, Jann Horn wrote:
>On Fri, May 8, 2026 at 6:12 PM Jann Horn <jannh@google.com> wrote:
>> Put the zeropage in the read-only data section - nothing should ever change
>> its contents. Set up a new section .rodata..page_aligned to mirror the
>> existing .data..page_aligned and .bss..page_aligned sections.
>>
>> There have been several security bugs where the kernel grabs references to
>> pages from some userspace-specified source, via GUP or splice, with
>> read-only semantics; and then later on, the kernel loses track of the
>> pages' read-only semantics and writes into them.
>>
>> I have seen such bugs in out-of-tree GPU drivers before, and recently
>> upstream Linux bugs of this shape have been discovered as well.
>>
>> One problem with these bugs is that fuzzers and such will have a hard time
>> noticing them, because the kernel has no mechanism to directly detect that
>> such a bug has occurred. It would be nice if we had debug infrastructure to
>> keep track of whether file pages are supposed to be writable, or such; but
>> for now, the easiest way to make these bugs detectable in at least some
>> cases is to make sure that writing the 4K zeropage is mapped as read-only
>> in the kernel, so that attempting to write into it immediately crashes
>> (unless the write happens through a vmap mapping or such).
>>
>> This patch might increase the size of vmlinux by 4K since .rodata is stored
>> in the ELF file while .bss is not; but the compressed kernel image size
>> shouldn't change much, since it's compressed.
>>
>> I have tested that with this patch applied, calling
>> `get_user_pages_fast(address, 1, 0, &page)` on a freshly-created anonymous
>> VMA and writing into the page with
>> `*(volatile char *)page_address(page) = 0` will cause an oops.
>>
>> Signed-off-by: Jann Horn <jannh@google.com>
>> ---
>>  include/asm-generic/vmlinux.lds.h | 1 +
>>  include/linux/linkage.h           | 1 +
>>  mm/mm_init.c                      | 2 +-
>>  3 files changed, 3 insertions(+), 1 deletion(-)
>
>Seth pointed out that this is more or less a duplicate of Ard's
><https://lore.kernel.org/all/20260427153416.2103979-19-ardb+git@google.com/>.
>
>So this patch is redundant; sorry for the noise.

Would it makes sense to apply a similar treatment to huge_zero_folio
as well?

with CONFIG_PERSISTENT_HUGE_ZERO_FOLIO=y, it is allocated at boot and
never freed, so it should never be written after initialization either :)

Cheers, Lance
