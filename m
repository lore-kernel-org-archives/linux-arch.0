Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199866;
	b=UKCvQ3am0oRZAco1MkMPnH0QD+5TUIgnrUYBnSWmvas3XmmWMF92PfOl5eejuejkmY66
	 E9gc/J8OwgfiUFa8NbZWZ8kRWnHR9ubQrqpd/oyrUY5Z5eA9PeyA3/di2GxNMHcxOtkVp
	 z3OpRJTuE/3tHWwIW3zKc1Yw1AJPiyT8q57xJqhne0zpwc2URoOd1BV3rTSwah9kyOlaf
	 xlEYKiVCDSv+Rw7JK2MsZAfI29DlIPMKVeETNGhNZeDpxcDVGga9G18vz3uvC57TmobZ0
	 ujAItu6IVy7FGZMt+ExTB4iDGSeekfEdevXk5dJ882xDfRSdSbo3sK9rO82MiX3t1dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199866;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=77xhCh2ORMf6NIfM90rhR5yS555x+O+M+p2I+XHyw1I=;
	b=WYyDRspcVxjGK+6i0wck3ZxdMgYzUf4sN15agbqqzgudFVJIm2u8HG+qL/cpqJD3JUkk
	 HiCKljePqf5NccJa69MIX0AGHoAI3159iTyBbY8XEDS3KNDP/m1C3CspynRpfccQGUeuj
	 OM0rHzUPhTh8ceA9LYJXIPe0JnpBSqmEVlSF0poxYnt5OOm6CSxrqdgFWkOQOp3J0+Dia
	 x0BoMYwtj7D5JmXKWM497csWbVucNcSYwbNA5ZVOBeB6WDcnGUzUtcCDFjuHLXvNdkCwO
	 durlcIa25O/raOu2bYLANE3p3694PaAFkJ1XbED5zLHPz+koIoZLCMqgpSAJ3yKDdww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.17
Received: from mta1.migadu.com (out-17.mta1.migadu.com [95.215.58.17])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5AF606A323
	for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 15:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B5AF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-arch@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=77xhCh2ORMf6NIfM90rhR5yS555x+O+M+p2I+XHyw1I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793199857; v=1; x=1793804657;
 b=DOaintvDCkIU/aM4mbDkTUbB7KXdOwz/1W14lJYmnPjR1UglE6lkfhl7iisk2fyDHg/P6GP3
 5jciE740/d15e8va8jnQE3dPdseWY1LxdNQxUpMbCZtLmWnGJY0gb3M1wALTIAly7eJpWAaE9h7
 sOj/QiLSS8wumYpDbu7phDXs=
X-Envelope-To: linux-arch@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d7967b914a90b8c6;
	Wed, 28 Oct 2026 15:04:16 +0000
X-Mizu-Trace-ID: d7967b914a90b8c6
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
	josef@toxicpanda.com
Subject: Re: [PATCH 12/46] mm/huge_memory: fix livelock on device private folio
Date: Wed, 28 Oct 2026 23:04:10 +0800
Message-ID: <20261028150410.47065-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261027-fixes_core-v1-12-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-12-6f74bec9a5bb@kernel.org>
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


On Tue, Oct 27, 2026 at 12:17:32AM +0100, David Hildenbrand (Arm) wrote:
>From: Josef Bacik <josef@toxicpanda.com>
>
>If do_huge_pmd_device_private() cannot lock the folio, it simply returns
>to try again on the next fault.
>
>Just like we did in commit b570f37a2ce4 ("mm: Fix a hmm_range_fault()
>livelock / starvation problem"), let's wait for the softleaf entry,
>which will drop the PTL and wait until the folio was unlocked. This is
>precisely what we do in do_swap_page() with device-private folios. This
>avoids possibly livelocking.
>
>Update softleaf_entry_wait_on_locked() documentation to clarify that
>device-private entries wait until the folio is unlocked.
>
>There seems to be no compelling reason to backport this to stable
>kernels unless we actually see problems there.
>
>Fix generated by an LLM and sent by Josef Bacik in private.
>
>Fixes: 4964099163d0 ("mm/memory/fault: add THP fault handling for zone device private pages")
>Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>[ david: simplify patch description, fixup softleaf_entry_wait_on_locked description]
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nice work!

Reviewed-by: Lance Yang <lance.yang@linux.dev>
