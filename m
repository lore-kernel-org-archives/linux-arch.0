Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793184083;
	b=Z07yACqicIuY7x2NBnrw8wr8m6RJxhI+WMu+f1lItL1RGYeZtxC6baKTta0l5rozdh6E
	 472W3xzU2sD1mujIi1G26uyM6q1pF5MD8WUxWW2gc6rx5uuL1dL/Qj/HyjdiDx8qsbPNs
	 bX07OK/YftK/CLra6Ox2/VRrk4ahvQKG/kg0pWRKzkmAmloz/ninta065/2a45RS6K2AS
	 3moUAYt8DYp+9nzuaeGSgrC4EhjMrrwhn5Y3yEpcdOfJenOcLzQWIysKdoB7awEzkkbgx
	 5tniydsOL/D9/3n4kN29O5GkzTLjpKwO2jiMuyEraepiHJQcTtlNAGkAsEMYTbSy5Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184083;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7ohDeqYAoftxje+G2/ZUXITZjGtasxeCYee/Ib/dRfM=;
	b=fzFSWxuCG88cvgilqM4EeIKKIxH2vdmM8OyHuPdb3zfbf3ey6Ui5/IRP0WjwRODl1U1+
	 XN1hsODmCs4OzKYoRKr4lqLfpNrttt6equ9Tr6XFKWeuP3/OAjmOeeTsT0DiiBroo9GI1
	 eOxbTf71PZVIiv71+TYeFQJ3D+CrxqYYp0jKFmn3qK56avBsFuf709JQqJtFjUkI11u5y
	 uAuzk48nI5ezsuENxn4VW2t/uPzhZW0sC3LAKPcfkBNyvuPD6EBExuvTHdpTjxP39lxBY
	 5paV+RzMxdG/pg1fbggV9GYM+VbHCdyX31Lg2cC+PEqY5bTyJxvYNYiJSAa3vNF5MYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uW0yxWCj;
	arc=none smtp.remote-ip=95.215.58.219
Received: from mta1.migadu.com (out-219.mta1.migadu.com [95.215.58.219])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FFA606A31D
	for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 10:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12FFA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uW0yxWCj
X-Envelope-To: linux-arch@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=da6hytzw+BnB+C5CyqKjthZJsFrZnHpNjbdkzPMyrmc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793184074; v=1; x=1793788874;
 b=uW0yxWCjiuY/QAk36l36xDIbaSJ/T96tA0HP6WqCEveTeJBUYemWYRj/4Kdrl9erGZEE7or5
 sUiXKW8oNGaHZWY2AFZKIRSJoe9vBiTzTCKv4/3aisN/9I/naSVMw40cQwofFWY2LRNiPMMzlhF
 fBex+2wJ8adqN7qch7lrDyRo=
X-Envelope-To: linux-arch@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b2f499d91e478fa4;
	Wed, 28 Oct 2026 10:41:14 +0000
X-Mizu-Trace-ID: b2f499d91e478fa4
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
	josef@toxicpanda.com
Subject: Re: [PATCH 10/46] mm/huge_memory: fix list corruption when deferred_split_scan() races with deferred_split_folio()
Date: Wed, 28 Oct 2026 18:41:07 +0800
Message-ID: <20261028104107.31470-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
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


On Tue, Oct 27, 2026 at 12:17:30AM +0100, David Hildenbrand (Arm) wrote:
>Since the deferred split queue became a list_lru, the isolate callback
>moves the folios it took a reference on to an on-stack list, linked
>through folio->_deferred_list, and deferred_split_scan() takes them off
>that list with list_del_init() without holding the list_lru lock.
>
>deferred_split_folio() does not know about the on-stack list. It only
>holds the list_lru lock when it looks at the same list_head, and it can
>run for such a folio: a THP is queued when it is mapped, as a candidate
>for the underused check, and is queued "again" when a part of it gets
>unmapped:
>
>  CPU0 deferred_split_scan()          CPU1 deferred_split_folio()
>  list_del_init(&folio->_deferred_list)
>    next->prev = prev
>    prev->next = next
>    entry->next = entry
>                                      list_lru_lock_irqsave()
>                                      folio_set_partially_mapped()
>                                      __list_lru_add()
>                                        list_empty(item)  -> true
>                                        list_add_tail(item, &l->list)
>                                          item->next = &l->list
>                                          item->prev = tail
>    entry->prev = entry
>
>The folio now sits on the list_lru with ->prev pointing to itself. The
>next removal leaves the neighbours pointing to it, and they still do so
>after the folio has been freed. With CONFIG_DEBUG_LIST:
>
>  list_del corruption. prev->next should be ffd4000000270090, but was
>  ffd4000000278090. (prev=ffd4000000270090)
>
>Fix it by grabbing the lock around list_del_init() so
>deferred_split_folio() cannot race with it.
>
>Fixes: fafaeceb89a5 ("mm: switch deferred split shrinker to list_lru")
>Cc: stable@vger.kernel.org
>Reported-by: Josef Bacik <josef@toxicpanda.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nice work!

Reviewed-by: Lance Yang <lance.yang@linux.dev>
