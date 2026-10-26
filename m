Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056900;
	b=sWKk/KZH27vgqqklbo5FV2WpgX9RJw5a3IoRkIhxnuDQOGPua6Dlv2sdcZz0/QwK/wTj
	 7Zus9dvUUFYT13Xrwd6Dpb5uVaznE01qlt4UIR72Lwf9Sf7mL6bmbnuNbaLdubBZ7IFe8
	 BxsBnVM3Hjg0E/41ZpeI8m808xjdkk1jYcqAvT/4ESrXDfABfcZxUcQsbf46rp/bvbftN
	 tk5rSifI7IJ1ngyw5jT7MzKfxUZoeDqhz8tXf4GRHM+Aw1hh0F3wdzPMTUJmPoGgVLzYH
	 c1GVPeQ3BGW9uoPFDU9rwm/s8FOpR5PlJnaAWoquSFqhH0BW20zCBvqkW7S609o3ISg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056900;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=iGg0JuKjpWH+18cq1a8i4lvw2ME9xlVqud6fOrE70qM=;
	b=NOm2nn9UKKAvXIfM7GgIshSBvxtvkbGh3Sc2ctyYFTVKeuQ1/UTRE6h9G4gu2Sq0xI7z
	 b7B1YukjEKjXvE97p/GuL9C1exAIn1pU4S4IGATbFI0nCW1wBjzL2M867w44vEFJSNrgO
	 o1w+JUIRrqiolMjace8usHFPRP0y8KxoJnqSqbGQVv785i44awgn2BXLqMko8uLILf6ti
	 qoVObe5vAjSyKMrJa6skjwl4fwQb/t5jcLs+sFGFKDJI11qVIn9Zt1PDyFHytstpPXWtf
	 Qe7o306evrOXWo8s1Ztd0WPwCXWJ94e+TuhkmhhnEXDjaKzKt4J7Prbul2wpSwNwy4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TH08ns3i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B150C606A31B;
	Mon, 26 Oct 2026 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TH08ns3i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EFC1F01828;
	Mon, 26 Oct 2026 23:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793056899;
	bh=iGg0JuKjpWH+18cq1a8i4lvw2ME9xlVqud6fOrE70qM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TH08ns3i1lGdchO8U/Wa8lJXAKl8uG3gfTu/o5/+L3yVW2EfB0dI1Or6Zye9QA6a4
	 U2oWp3nYq/QVlWgsXjjiuQi53fz5EKConQu9zpfjVi9TXa29hl2mf74m+U1pLCDZn3
	 s4wPRw71BXVh+F07l+672CQViwuZKk2bdsz3BMjjdev51nbaBm1TwDRsLwp60t8JVq
	 wJvSw4iz4piKzE/VBEizjsUxU01KDNU1iMyriQmv/8fbbJ8g02GovtVc7Q71gzsSHS
	 5jpDpO/BNAhDhty+di7pwtZZTtDh3hxVt8Iayp5jDmuSU0W73PvSD7mvQoexLzDt9R
	 BDBPl+UA2DcYQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:32 +0100
Subject: [PATCH 12/46] mm/huge_memory: fix livelock on device private folio
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
Message-Id: <20261027-fixes_core-v1-12-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2169; i=david@kernel.org;
 h=from:subject:message-id; bh=frowMj6hVq4GFUzEcG8t6DtzEstvQZjTWtFOOY06Pig=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35/yw1Tu+suA4g9c83rynqWcE3t4ObxXytNbOFrWa
 Z/5GfXHHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExENJyR4WFBRmja09TbMxP0
 /e3s5l/Tj37ard0oueJCcDRHdUbTAUaGc5Purqs/F5llM/P2uayk7CPH7Tb+f/RlVf5DFp6T9Xo
 v2QA=
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
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/filemap.c     | 4 ++--
 mm/huge_memory.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b04be64a5069f..e85a4114d2ecc 100644
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
index 283c4bc8b927c..2b31a425c7a32 100644
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

