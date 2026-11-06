Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978142;
	b=a5o9D7HiRZR0cUnDKzB+6SRHdcj9VVbOU93i+0OeHbATiRKs6xM3F5RliP4t/0VUCoh7
	 +Uu4C9n3W3PmhSILtlhaC8N1Xu6b6HjGBtsPiVWdScu7ehKiDWAOPawzSDCW7mthUdwEC
	 O+jqibHp5pvCPMKKCDtHn49h8m0Q+tD7ydGMpv8Jp7MALnNMZpmO89vbMKpH5LgM/YUVq
	 mPaX9fUpLRbhktB9KIlsSxyRad2+4BTDq/vzJ6ttUtvdqaf1Jnr6xDo1J1y5og+2fpo3s
	 Hr4xWAo2t/jrURtD0I52QdCJ8gq0elCvZexxGA+IHZHcdycVUUZVx5zb1i39oJpiD/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978142;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BQ98lptuezRaClL/2frvW7Abmv8umTPGLgyOyGvfOsk=;
	b=eU0pCWvhe74ISbF/IgJJMOESLJtlqxG3VDN+7s2YEK9fETsKi38ySlUpLnpVNQobHMqF
	 W/e1vFSSA1qYX5n3JwZTafXR3ImvszTM7/EA2SvViCwHnTwYbK6Tcuw17JUO+EtALviWR
	 ibajU9NNTvjVzE9lf8kFsNSW/MiUIVwVyg91Efn3xI7t7sj0ge//sIRYJftSASdSQ/+jj
	 29W4u8eT2PxOMfuUOkNEp7pzqkqkOcCnNgVjBfxOjkEkI54jFNeDzW4EPQk1siM3urClT
	 0bM1AF600uJBx0cgtmxixoFAX0CJYD2ncAKlln/UI6AbHgeuBxmTc6PP3Z/0rphxCng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BS+wWOBp;
	arc=none smtp.remote-ip=95.215.58.251
Received: from mta1.migadu.com (out-251.mta1.migadu.com [95.215.58.251])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21221606A332
	for <linux-arch@vger.kernel.org>; Fri,  6 Nov 2026 15:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21221606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BS+wWOBp
X-Envelope-To: linux-arch@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BQ98lptuezRaClL/2frvW7Abmv8umTPGLgyOyGvfOsk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793978139; v=1; x=1794582939;
 b=BS+wWOBpkanXuDOzgufMBLVEhna7aL+1g1sop8joueXjNrvUxsu52rtxyL4e5+hOz9zL8jlw
 Rh9ddG2x6Kkkn/xyndIPS43SbZU39nj7wSqa7RQPOvmrrvbiMp0l4BaQy2ZZCzgMAJU5DmfDGTC
 wzRss1N8g3/8HPDXGEJwL1DY=
X-Envelope-To: linux-arch@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8657a346237bb2f3;
	Fri, 06 Nov 2026 15:15:39 +0000
X-Mizu-Trace-ID: 8657a346237bb2f3
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	peterx@redhat.com,
	hannes@cmpxchg.org,
	songliubraving@fb.com,
	riel@surriel.com,
	hughd@google.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	robin.murphy@arm.com,
	steven.sistare@oracle.com,
	jhubbard@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	iommu@lists.linux.dev,
	mason@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/5] mm/mmu_gather: flush pending references early before the folio limit
Date: Fri,  6 Nov 2026 23:15:33 +0800
Message-ID: <20261106151533.89428-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-refcount_overflow_stable-v1-3-70b9c655da3e@kernel.org>
References: <20261105-refcount_overflow_stable-v1-3-70b9c655da3e@kernel.org>
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


On Thu, Nov 05, 2026 at 02:10:12PM +0100, David Hildenbrand (Arm) wrote:
>When a task zaps mappings (e.g., MADV_DONTNEED), it can drop the PT lock
>and defer dropping the folio references. In the meantime, page faults
>can refault pagecache folios, creating more references for the same
>folios.
>
>Let's just request a flush after enqueueing a pagecache folio whose
>refcount reached a certain threshold. Start flushing well before new
>references are refused, regardless of the caller's privileges.
>
>This is a temporary measure until we have something better.
>
>Reported-by: Chris Mason <mason@kernel.org>
>Fixes: 10ebac4f95e7 ("mm/memory: optimize unmap/zap with PTE-mapped THP")
>Cc: stable@vger.kernel.org
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
