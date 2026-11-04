Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761975;
	b=hzuvNfi+DFZcBt7U+DCMETN1lnV70L1zEFAdgks9nVgKIqMjaP1nSg+SIqzcLxta7Is/
	 WjTS1fyfpmW8MuzkkzNb8JaZRZjp8UnwYuCF0blBJSutCUZaWR1GWK35Uic7F30GQ4U4M
	 Sah3xmH0WXo8f1dRFMMw/1bdj9LCxcOkI54s3YFxcRiq+l29rN85tWdeeZJYyW09VjvNJ
	 0kGHsGjhWJmlUuf5NyhYwHosq0UtTE5clwWzGUIwJsig8aBnOtjJRjEsrHHP5BuGO/Mgf
	 5/OuQkW5LodBSNrrpGpmUxNrlyZXJ+U8Q9x2i7lUIO9ODMCD8wkK1w215DgoY+BwjMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761975;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BFKdbCnvgEnPUCR+piUdwFlucy5SNy4ZmkD3FremwV0=;
	b=nalOvQSiL3jkqxGhobfSm6xA0/StVyUp9JtTUqGZ2wfvIpiQ8FIlP8gE3YV3Z79PDHPS
	 Erj78jYJJiYEdk8PkFt0G0BOEGv2+6uVPzHND0mY8Zq6l9jp8dpzcoqOmoHIKMe+m4I6n
	 3FUsV5sKTJza0g9XqISGQCDBJSzofaZ4iOz4JeB7eXoqbMD5hUiD8c6YHddlwJwYtfbhF
	 2XabdWIAPfdIUXqtKRd840z8FiPpKgPPTknDF4McCjYP2ylcRC1XE6bCkGM2uCav4/yFy
	 6xOQTL0+ftUtd+fsnrnp4Zj5pC3iXaemi0APatdDqCuYFAKz1nIrjleopBH2Pi7Co1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MC8VPNm7;
	arc=none smtp.remote-ip=91.218.175.236
Received: from mta0.migadu.com (out-236.mta0.migadu.com [91.218.175.236])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB58606A326
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 03:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAB58606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MC8VPNm7
X-Envelope-To: linux-arch@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BFKdbCnvgEnPUCR+piUdwFlucy5SNy4ZmkD3FremwV0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793761972; v=1; x=1794366772;
 b=MC8VPNm74Ok18sfdmxnpsI6xRh7R0Zk5W//KSoh4oQqgT/S/C7qdI564Yzn9q9U82YW5fQUa
 bHEVLCzq9Vqzf9FcDE7exA0+xlnDu1bTQ6V7pBzRG57qh+3OeK8awrDIx3MWDyYkXpPcFBKY+AD
 RqEEVje7E40Z3XH7oOIjjkYY=
X-Envelope-To: linux-arch@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 888f0105953f8a83;
	Wed, 04 Nov 2026 03:12:52 +0000
X-Mizu-Trace-ID: 888f0105953f8a83
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
	stable@vger.kernel.org,
	usama.anjum@arm.com
Subject: Re: [PATCH v3 43/47] mm/huge_memory: split huge PUDs when adjusting VMA boundaries
Date: Wed,  4 Nov 2026 11:12:45 +0800
Message-ID: <20261104031245.9524-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-43-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-43-d6437171ecc3@kernel.org>
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


On Sat, Oct 31, 2026 at 10:40:12AM +0100, David Hildenbrand (Arm) wrote:
>PFN mappings such as VFIO PCI BAR mappings can use PUD leaves while
>allowing VMA splits at page granularity. However, vma_adjust_trans_huge()
>only handles PMDs.
>
>After faulting a writable PUD-sized VFIO BAR mapping, changing its first
>page to read-only with mprotect() makes the PMD walk treat the PUD leaf
>as a PMD table. Applying MADV_DONTFORK to the first PMD-sized chunk leaves
>the PUD spanning two VMAs: the PMD-aligned boundary skips splitting.
>
>Walk the page tables once at each adjusted boundary and split a huge
>PUD or PMD leaf as needed. Handle PUD leaves even when the boundary is
>PMD-aligned.
>
>Fixes: f9e54c3a2f5b7 ("vfio/pci: implement huge_fault support")
>Cc: stable@vger.kernel.org
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nice work!

Reviewed-by: Lance Yang <lance.yang@linux.dev>
