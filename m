Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193153;
	b=J9DIZRqkY5dbdKZ+zLMeJdbWVF6OrShFDEp4v0juD3ipgQ+o0Rq6Sjq6u0yYJbp75xzN
	 Lxy51vZ/algD3hQtuKqScYjUzZs0GUueHZUDphIfosZ0JyxdNC0AgtlcVSNgVBOi6Z78p
	 tq1x/OU2HBj3lBJb8w6088GklFbW8naynCXr1YJweJo/7gKR3jeXRxLpatHAV7Yp/b3kw
	 gaLTWk6HtzbtTAiw97PXHSXiLIvgEZFLJGjj3MY24wcwmMHscbQpO8JKeXY3tRYCB/Of2
	 KiHJvMzC7rsmti6vX60L0rdzhh8NRL7i0uWnHSLH4+5na1DwFMAPMPhwhcMl5Z3b/ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193153;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mHGE9nXbxuB8GQ9t8LPv8LBGWevl1d8ukNIHXAQHhiw=;
	b=cGyqPQV8bcbhuqOjmCmQJJ6BF1cYRa6Rc8LmUm2Rt1RpOFzOBzofSGMRbEWZv/TTDBic
	 uiUBNBxBRbOrUcnsomwfNQboar/K/F/ALzxprDr80h/F4dh4dQ6PNQM+P/f8eYEeiniNc
	 uPfD8qstPXeRnfwRljo9MZZElJ7X0yiFuJWQFZELSjlkbvleUzQCV69Xx6df44F3c9fOc
	 xcLy6SELuWOFVp+k6dxgAKkgX5X6MwRSoeQV5l2PFwDf6zbb+YdB7OnEXvb5t5On292lJ
	 apsPkqczRnPvEXHH774Vx1HsYdIhNkrgZ9jYEFiha+oUBfcyXcwEnZuygsGWeChGqJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lcgLcbFR;
	arc=none smtp.remote-ip=95.215.58.2
Received: from mta1.migadu.com (out-2.mta1.migadu.com [95.215.58.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EA1606A31E
	for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 13:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7EA1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lcgLcbFR
X-Envelope-To: linux-arch@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mHGE9nXbxuB8GQ9t8LPv8LBGWevl1d8ukNIHXAQHhiw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793193150; v=1; x=1793797950;
 b=lcgLcbFRxP9SssJFAOgnV1CTw9QFfBkdyWKEPuYsLAlBTjbYz5VHlKmuRbNAncBCF3cbFKSm
 K050RHcNKJCgMQDi9oO34VHt3Pr96RFHTkelmlLCWQtZmI/r+HSZnYrgItCMY15+OrhycKNKBcR
 vN3sI2hEolJ26DKC3wWPgFvA=
X-Envelope-To: linux-arch@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id db747fb4ed3da529;
	Wed, 28 Oct 2026 13:12:28 +0000
X-Mizu-Trace-ID: db747fb4ed3da529
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	peterz@infradead.org,
	jannh@google.com,
	pfalcato@suse.de,
	hughd@google.com,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	riel@surriel.com,
	harry@kernel.org,
	apopple@nvidia.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	minchan@kernel.org,
	muchun.song@linux.dev,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	jgg@ziepe.ca,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 11/46] mm/huge_memory: properly handle refcounted PUD mappings on fork
Date: Wed, 28 Oct 2026 21:12:21 +0800
Message-ID: <20261028131221.42261-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261027-fixes_core-v1-11-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-11-6f74bec9a5bb@kernel.org>
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


On Tue, Oct 27, 2026 at 12:17:31AM +0100, David Hildenbrand (Arm) wrote:
>copy_huge_pud() copies device-DAX entries without taking a folio reference
>or updating mapcounts and the child's RSS.
>
>For example, MADV_GUARD_INSTALL sets VM_MAYBE_GUARD on a device-DAX VMA,
>forcing copy_page_range() to traverse the whole VMA on fork. Any remaining
>huge PUDs are then copied without accounting for the new mappings.
>Unmapping them in the child decrements accounting that was never added.
>
>Use vm_normal_page_pud() to identify refcounted mappings. Take a folio
>reference and add the child's PUD rmap and RSS accounting before installing
>the copied entry. Pass src and dst VMAs consistently instead of src and
>dst MM. Move the TODO.
>
>Fixes: aed877c2b4257 ("device/dax: properly refcount device dax pages when mapping")
>Cc: stable@vger.kernel.org
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
