Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306187;
	b=JMJS4ePf8g3RGc5IoVijEbKUHxCGvMfxS2sj0CIZAmpbGY17Wa/DpyC/5lMMa4AszbvS
	 qaOpAbYuOvkyDGESzBrr7VK3cz1hgTXFfuPRNwBsqlgjB2B5K3QFJLe7reXk4h7Fu19ax
	 emJGEaTdhurJOTqATI1J4vopSOJFTsCq/pABpialN4zMg+8+nqMPnxZKVdoUvFJ6uHhw3
	 HDxoy2+fmtpi/uzLpvf+Ei13vl8NSLZa80rbUslFuCcBfYUr+GYsk/8ARmxSXIKV4Ayxq
	 mKh4pRJSwteN+F6S0x2UZf5uI1WQJQcU2a3l+1SMlpvsXIlijsOu2NoUxae6Lf7aylg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306187;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qltIiuXU+zlhML5RIS5IOe+lQ29Yj3eoAi87jDTJsc4=;
	b=L83Hh4xP+7rmQKy4XFinosttChjrA1kecrZlOibueMpx2GwwJUulXZL8xukIu+qDH1rS
	 QLv+F+VY+KLXcW64GpTFhvlnZLEkpbyVChRgWM5yj/J0KU/2Pfmlw58sANjpzReiFSg1j
	 mbzI5VQOb65/6yrJ85euvFBbhKV2ZQoQlHQho82Y7JqTOY/faVKpMpakchn4Uft7TJcNj
	 LXD8y3JY3bJR7ae7az4Hg5F4suYKgRQbHN95TRgt1MvqbK4XsnMv6YjstwBDGzFvV+ova
	 TRAvY3reCxkyMGvjhyFZOy0Fi9fRPRfNSIiSM+TCsipXuoa3f6b3wBz+wPpVLFgXfAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PbsN8DUM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ABE606A33F;
	Thu, 29 Oct 2026 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PbsN8DUM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1151F01825;
	Thu, 29 Oct 2026 20:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306187;
	bh=qltIiuXU+zlhML5RIS5IOe+lQ29Yj3eoAi87jDTJsc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PbsN8DUMZHet0eiaz/YtPnbseBFjT1WXluzzZmPAiGCnwOVZOmGfKM9mh4Hhr8RQL
	 7YWdZwjM5Y5r6JqhpSIgRiraov8JyP5s3tVFCEdzVv5TXOjLSA1th27MnlnYUVgFgL
	 sTC1CQ2rinSRaPVNA6+7XHDreBot/Mj62PBOaQUurFuFoTySKorBt6xAL5tvLLjPn7
	 mhhTElRxbidvb5VwGdMn4KiqZOXsOdHbTTmCNjbgcCnwq18newaSnJDP+nYR6R1cS6
	 RKvmRadHrc65MZtqR3trGpVjQPff933JBn/tkhEaQ/OjVCubDuvzFbz+wtW8t1s41u
	 n6zXIzSEWRF7w==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:07 +0100
Subject: [PATCH v2 12/47] mm/huge_memory: fix livelock on device private
 folio
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-fixes_core-v2-12-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
In-Reply-To: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2251; i=david@kernel.org;
 h=from:subject:message-id; bh=tTSXVaSqYcMlwqAolP5RSmpCZsM2rRJpm1YXsCV5Hb0=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer20905Lzv2PqpDmTOl4ztoqsFfh5lK3YtmudyjV+x
 SV2qq+mdJSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjARzo0M/+y3cLez3TOs/a+7
 1kfwzeSVL85PeZSotXbB1S1i9enXP1UzMhw/XBApxjFnktgLNZlCZa/Fr75NZQu/Grl5xyH1p24
 +e1gA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

If do_huge_pmd_device_private() cannot lock the folio, it simply returns
to try again on the next fault.

Just like we did in commit b570f37a2ce4 ("mm: Fix a hmm_range_fault()
livelock / starvation problem"), let's wait for the softleaf entry,
which will drop the PTL and wait until the folio was unlocked. This is
precisely what we do in do_swap_page() with device-private folios. This
avoids possibly livelocking.

Update softleaf_entry_wait_on_locked() documentation to clarify that
device-private entries wait until the folio is unlocked.

There seems to be no compelling reason to backport this to stable
kernels unless we actually see problems there.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: 4964099163d0 ("mm/memory/fault: add THP fault handling for zone device private pages")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ david: simplify patch description, fixup softleaf_entry_wait_on_locked description]
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/filemap.c     | 4 ++--
 mm/huge_memory.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b04be64a5069..e85a4114d2ec 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1395,8 +1395,8 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 
 #ifdef CONFIG_MIGRATION
 /**
- * softleaf_entry_wait_on_locked - Wait for a migration entry or
- * device_private entry to be removed.
+ * softleaf_entry_wait_on_locked - Wait for a migration entry to be removed
+ * or a device-private folio in a device-private entry to get unlocked.
  * @entry: migration or device_private swap entry.
  * @ptl: already locked ptl. This function will drop the lock.
  *
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 283c4bc8b927..2b31a425c7a3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1500,7 +1500,7 @@ vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf)
 		folio_unlock(folio);
 		folio_put(folio);
 	} else {
-		spin_unlock(ptl);
+		softleaf_entry_wait_on_locked(entry, ptl);
 	}
 
 	return ret;

-- 
2.43.0

