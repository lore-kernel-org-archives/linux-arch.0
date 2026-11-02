Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.143
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618556;
	b=zTRYJv5Zc0q6fNnX4puEHoIlnW6i2frAtgVHD7UIHy/JjbzGh4m/ynJnFTEeFSe3JSyX
	 ceR8wfaoi8kx7q8gEqWkz+Yo47RuEpxbV9zNKUUozHn4ChvvSeYYm3MabmLCudyuDzCnN
	 Ha8dXJC9H4KV98JdAQJI+62fA1nvHHSbUAvdHK3lufc96D2inkHYTyM0phCd9naFyD21i
	 IDnCPZNKQWaGyDEHWyK/EPduVjTE3XHtg3fGw3y8GLKlL4Lw0YT78CXbktcOAb5k3/O6h
	 se/Vk4CAruIoZXM/+O4EOitFJ1vQzm4rDGTUuMP5++LNiTFBTpK5gSVKkZ89yGTafJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618556;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rlYYUg5m282yLIStEKkIHTozLzxeQHV9wO/ECVNrg9o=;
	b=rCAr5a41AVVv8IoyoU36lrvv133WuLqWmQ/7aaCs2TEKHuH7npzTu/pJfciP4QN3MIs6
	 JpAWMW0lRF140q6lrdKkEvv0X38qqy2NZJ+nPnpA7PQUeRnz4eGZ4sTnS1+smTVO7rMK/
	 0m8yMi13sorX1Fe/skJ4ovjcekuFDYaygmumAL3zrArkAIqg7lHK6EW0s+s5NsJHg1V1k
	 PgXZbd4LiFVsnP5f8CNbIDl9Sz64pdH4m5trP+Mm56dpNaouLSV5IQt1o+bzHr+LB5Qbh
	 N7y6AdEhtW0DJz6vHc/RHArTAdTwU+A+ziIAFSM1a9I9IWqD49YfmBDeiEjnIncqPMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dNl8kU2Z;
	arc=none smtp.remote-ip=95.215.58.143
Received: from mta1.migadu.com (out-143.mta1.migadu.com [95.215.58.143])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BCD60A2633
	for <linux-arch@vger.kernel.org>; Mon,  2 Nov 2026 11:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51BCD60A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dNl8kU2Z
X-Envelope-To: linux-arch@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rlYYUg5m282yLIStEKkIHTozLzxeQHV9wO/ECVNrg9o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793618553; v=1; x=1794223353;
 b=dNl8kU2ZZnY7p+1AZb5FkPRPxnYNE0pNnRkYzfMXhsQ6nzU8z5o/GWyH69JI2jndGu8pOXov
 iCXfD2V18rj7VtN0dm54SEJgnoT8r9LSk12pObDE1JIpBZph6bgTHoxZAQEPzv45DOvyDH48795
 PK/VAB0uVps+jfwrxgnpYmZo=
X-Envelope-To: linux-arch@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0a735c2090dc6b54;
	Mon, 02 Nov 2026 11:22:32 +0000
X-Mizu-Trace-ID: 0a735c2090dc6b54
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
	mason@kernel.org,
	stable@vger.kernel.org,
	skhawaja@google.com,
	usama.anjum@arm.com
Subject: Re: [PATCH v3 20/47] mm/gup: fix clearing folios in memfd_pin_folios()
Date: Mon,  2 Nov 2026 19:22:27 +0800
Message-ID: <20261102112227.62593-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-20-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-20-d6437171ecc3@kernel.org>
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


On Sat, Oct 31, 2026 at 10:39:49AM +0100, David Hildenbrand (Arm) wrote:
>From: Chris Mason <mason@kernel.org>
>
>memfd_pin_folios() pins folios obtained directly from the page cache
>without checking whether they are uptodate. However, shmem fallocate()
>can leave newly allocated folios uncleared and not uptodate. Callers
>such as udmabuf can then expose uninitialized memory to userspace.

Right, just make sure the folios are initialized before handing them to
callers. They shouldn't have to care whether shmem deferred the clearing ;)

>Clear non-uptodate folios and mark them uptodate under the folio lock
>before returning them to the caller.
>
>Fix generated by an LLM and sent by Chris Mason in private.
>
>Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chris Mason <mason@kernel.org>
>[ david: simplify description and comment ]
>Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
>Tested-by: Samiullah Khawaja <skhawaja@google.com>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

LGTM!

Reviewed-by: Lance Yang <lance.yang@linux.dev>
