Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.167
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793603079;
	b=lTZ2qLf/egll2PDanQZUhZvI9/8xIH1Rpf3setiU41Jn6hqVAYVG8PHrGCrgTMr4XmPB
	 uQ6MmJpO+RGK6gaRtIhfNVzxLss5RWOVnqEmvO3MRt/DMitQE+dBwK2TVpb0PChzf8LOl
	 fmcwxqeVGozdESTvO8WCb06gFf4vBSo2E90msSo+c2PZWBYOiBlyvb6AtR/8v/LW46Vfv
	 11/7OJO+iMtPwee4AjdEVDUH8hM+vGL4/9nGHlWyvFVydgn0NT1iPWYEwzupDJrnXiLlY
	 uINIoRKGhoHfKlY0jopJ97nApfX39Ku/T1TH8UvkziBUnP5hx1Uc6sdezWBhPnBDmdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603079;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HKrmzfM/lfs87w6cnTmZ3Teou0HRxUok6ugK+JqAXis=;
	b=VzbplAyT0qttLwHAqQi2f9JDGgI1qm926mD0b/uDzd7VCrI1pffPdP2RNiWYQrJlyav7
	 Le3x0K6C6I+JAAxB28J2S1vYVE4VJ8fGAh7qGbBdC6W+rrepU/wRgfAcBtgly9SKXbFQu
	 wDvWnyaaOG2aYuEgFekaAmCL7mmXrcBS9OncqsVHmMlcv2HMAap92+ygcG2Aib4WEUMxK
	 bw+dGWqt7KYy2gvrTQi9LGzAUwDkwP+CYCXd5EAzQ0HXx2T/TbpPCicjvBeZlGb2/G6/B
	 cyGnK4SF3k84/4SrgYPQsQLvTkEFgj7d3nPgB7XkEJc+lKVXb/E7NVTQfTvTckrj0Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QiYgY6HB;
	arc=none smtp.remote-ip=91.218.175.167
Received: from mta0.migadu.com (out-167.mta0.migadu.com [91.218.175.167])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197FB606A326
	for <linux-arch@vger.kernel.org>; Mon,  2 Nov 2026 07:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 197FB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QiYgY6HB
X-Envelope-To: linux-arch@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HKrmzfM/lfs87w6cnTmZ3Teou0HRxUok6ugK+JqAXis=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793603076; v=1; x=1794207876;
 b=QiYgY6HB1mW5E+FEecHdTmLFOegmRB/0Kx7ma4l5h/2qjPvozuRb5Nl7U8kxuJgGo8EsEZWR
 S5bpb779UuW1wWS0WUl/cAtINpj6P6ikL5UuxKgEg2su2eVSGCz8y+cgiDg7di06ITDFb3kKKxx
 BUsNdjRhR6pc39oxlYQF3xEk=
X-Envelope-To: linux-arch@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4b82456d18ca3934;
	Mon, 02 Nov 2026 07:04:35 +0000
X-Mizu-Trace-ID: 4b82456d18ca3934
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
	usama.anjum@arm.com
Subject: Re: [PATCH v3 18/47] mm/khugepaged: check if PTE table is empty in try_collapse_pte_mapped_thp()
Date: Mon,  2 Nov 2026 15:04:26 +0800
Message-ID: <20261102070426.45406-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-18-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-18-d6437171ecc3@kernel.org>
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


On Sat, Oct 31, 2026 at 10:39:47AM +0100, David Hildenbrand (Arm) wrote:
>The existing code is rather horrible and already resulted in bugs in the
>past: we special-case UFFD inserting anonymous folios by grabbing the PMD
>lock early, but ignore any other markers (guard, poison through uffd) that
>could have been inserted into the page table in the meantime, effectively
>dropping them.
>
>Let's just unify and simplify the locking: try to grab the PMD table
>lock and if that fails, flush the TLB, drop the PTE lock, take PT locks in
>the right order and check if the page table is still empty.

Yep ;)

Taking the PMD lock up front would make the locking easier to follow, though
we'd hold it across all the PTE zapping ;)

>We still perform the heavy lifting (zapping the folio ptes) under PTE table
>lock only.
>
>Include <linux/hugetlb.h> for now, as x86's flush_tlb_range() macro
>depends on hugetlb helpers. This dependency needs a separate cleanup.
>
>Both issues this fixes are rather corner cases. Let's not CC stable for
>now.
>
>Fixes: f807123d578d ("mm: allow guard regions in file-backed and read-only mappings")
>Fixes: 1043173eb5eb ("mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()")
>Tested-by: Gregory Price (Meta) <gourry@gourry.net>
>Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

LGTM!

Reviewed-by: Lance Yang <lance.yang@linux.dev>
