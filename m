Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794756862;
	b=2ncpIkM4t3rFO6PmGP1795Stn99UMG1J1TlkZ4klGsdEBPtvuqPdgnYhCzUswyL3APHE
	 XPlQp/qraLRJ2Z/glAXouNVkyixZKAFgZM4npoYinIzxszkTiz29eBUJNmiTAc4kaQf1R
	 pFEZ1FmhhOCPYpPu4xqWQSvFY8cw7S2UPTIM88qS3ud49L+z1HFVosIcmW63b5t11MCve
	 00erMQCXSB73kKPrta1pP8hm/yx4MRydrluRZPciY3eThcrbxbX47jEZrR+mFqU1yEMTR
	 waoOtxcXNzb0gXJwyUlaNTkm0Kh22wDJAebDxutEoJX4cp3Z0Ghjh31mKDD0CCIKadg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756862;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=D9eYfMQniN4MTERSNCoJWid+KzRgcjYDpVDX0WIaOcs=;
	b=kKRvdk/1GFqZSOIv7We/Say8HTyS0ZTgX/q8Dh/WraXDjrgfeqMJI6tFAaVoXesZY7TF
	 OkqY0IAPVo99u1aGkmsaTuiS0XZi6BawiBU2m+dgZ0YOcoB2aojPNEYIV1gUPor7dxSKR
	 IdeON23T29ET1uvq9nEAPQNkxrJGvRJpm0NcVxhD3NdRdGPmFxo46epgomAZzXPZIE7iD
	 k1XSR9agpACT3OMGgBcjULZlQJc9fM+jz01VjdCvpkQExjbo1aJ8RMsaHTqLzRATeugBq
	 4qP6MY87iyVXB5v2cpzIO3QXckXDTC/wb1vIXTuYTB286Qt1hdFYYoSUtcpWN7cr2Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QOQ5B2UQ;
	arc=none smtp.remote-ip=95.215.58.64
Received: from mta1.migadu.com (out-64.mta1.migadu.com [95.215.58.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8809606A31F
	for <linux-arch@vger.kernel.org>; Sun, 15 Nov 2026 15:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8809606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QOQ5B2UQ
X-Envelope-To: linux-arch@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=D9eYfMQniN4MTERSNCoJWid+KzRgcjYDpVDX0WIaOcs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794756857; v=1; x=1795361657;
 b=QOQ5B2UQUdcw2pVPpUCjj4AzTtujU0vVL/9lS/ybwhefeK0OL1KDpz5YyyEQT32Tld+5tlWQ
 o/n1ZUi7xHptYeppnRU11jU6bGNnkp9pzXyYX6MkVDZSvWmAlB+LzYHsm6neXixTKCVmbTNhJco
 D3+nId2JmO73KCc4Zgw1eVec=
X-Envelope-To: linux-arch@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d21ea3c6ecf23a6a;
	Sun, 15 Nov 2026 15:34:17 +0000
X-Mizu-Trace-ID: d21ea3c6ecf23a6a
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: will@kernel.org,
	aneesh.kumar@kernel.org,
	akpm@linux-foundation.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	arnd@arndb.de,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jack@suse.cz,
	zwisler@kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	mason@kernel.org
Subject: Re: [PATCH] mm/huge_memory: flush dirty file PMDs before removing rmap
Date: Sun, 15 Nov 2026 23:34:11 +0800
Message-ID: <20261115153411.87967-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261113-dirty_file_pmd-v1-1-8c11f2a2e65f@kernel.org>
References: <20261113-dirty_file_pmd-v1-1-8c11f2a2e65f@kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Fri, Nov 13, 2026 at 06:15:26PM +0100, David Hildenbrand (Arm) wrote:
>Unmapping a file PMD can lose concurrent stores when it races with
>writeback. zap_huge_pmd() removes rmap and drops the PMD lock before the
>gather flushes the TLB. Writeback can then clean the folio while another
>CPU can still write through a stale writable TLB entry. Those stores do
>not fault and dirty the folio again. Filesystem DAX has the same problem
>with its dirty tags.
>
>Commit 5df397dec7c4 ("mm: delay page_remove_rmap() until after the TLB
>has been flushed") fixed the same race for PTEs by adding delayed rmap
>removal to the mmu_gather infrastructure. The PMD path still removes
>rmap before flushing.
>
>Flush the TLB under the PMD lock before removing rmap for dirty file
>PMDs. Skip the early flush at address-space teardown, when no users
>remain, and for mappings without writeback, including shmem and device
>DAX.
>
>Use tlb_can_delay_rmap() to share the PTE path's architecture checks.
>On s390, clearing the entry already handles TLB synchronization, and
>__tlb_remove_page_size() immediately drops the mapping reference, so
>rmap must be removed first. UP cannot have concurrent stores from
>another CPU while holding the page table lock. Make the predicate
>side-effect-free and set the gather's delayed_rmap flag when an entry
>is actually queued for delayed rmap removal.

Right, I'd expect tlb->delayed_rmap to mean the gather still has rmaps to
remove :)

>Queue the folio before the early flush, while the gather still has a
>valid range. Keep batching references and drain a full batch only after
>dropping the PMD lock. The early flush resets the gather's TLB state,
>so draining the batch does not flush that range again.
>
>Although writing to files through mmap is generally discouraged,
>unmapping such mappings may become slower: each dirty file PMD now
>requires a TLB flush under the PMD lock. Future work should properly
>extend the delayed-rmap machinery to PMDs and hold the PMD spinlock
>across multiple entries, so their TLB invalidations and rmap removals
>can be batched.

Nice work!

>Fixes: 4b4bb46d00b3 ("dax: clear dirty entry tags on cache flush")
>Cc: stable@vger.kernel.org
>Reported-by: Kiryl Shutsemau <kas@kernel.org>
>Link: https://lore.kernel.org/linux-mm/aoWw_iKEDLjKL2jr@thinkstation/
>Reported-by: Chris Mason <mason@kernel.org>
>Suggested-by: Lance Yang <lance.yang@linux.dev>
>Suggested-by: Usama Arif <usama.arif@linux.dev>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nothing jumped out at me, so:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
