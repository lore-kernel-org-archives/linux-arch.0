Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440348;
	b=VClG1e+qq8jU2/+GU5dbOAMye4HN8KO92s+YewTuSfzpDCvvDg0OoevYUJeorMjISd2h
	 2jbtIfb//TXvQTBBUiCYGmsHzR7LqgNWI5o3sMUv+I8JJko8JW4rgqJnSTbYx51Dzer/N
	 NJaodtXPm7jhS6cJNawUE401fXqGYa7X27xHzgaBNyIWkP2witQQDBGCrC5f76r7Hb9dq
	 6096dybfqRtVJJti3KMIPBq8SIAbNhZVkE4G70+YsrbkNaj7AdgCJzkDiqBugRCO1oup1
	 eOF9MY/H1aSrMiqHdCfRek7zLX7Ij/Gxr4nVDpO0lNSG9eYEJO+krWeI07enPnqm8lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440348;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=P+XDhasxBREAHMJWaTnaRrbmO35vpS7TJxAQhlwiqYY=;
	b=IShThGVaL7BJOV9YINdl6r2KRBQtbYaTIyXc2gTnbKIpGgzGeUXbrAUfNssmTaVktnk5
	 z8V/N/P2F8FgZIBeSKfZxlIaGN+XwKz2eB1Kv21Kh1wyLVbvjtKDpc1kmyXtXmP/sR3FM
	 rDfSrv6pFxtl0pXNvTtqwJKNhO5l24sGND2JNXlPqhlXmKiYFH7dL7germ+A+AwOULzfh
	 gCDVU1gihUojgr3olcA0sZjwwDCcFP/plvYEqVXb/SFTKTJdZ38yihL/hzPcD3qayyek3
	 2EoNh4XhdYxIVWFiHDK6igha0+SCqgjS7aRX4NX06R4tVPQov/dT0c86HHw9qynBYxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mm/XhP7H";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090E7606A31A;
	Sat, 31 Oct 2026 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mm/XhP7H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB401F000C1;
	Sat, 31 Oct 2026 09:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793440347;
	bh=P+XDhasxBREAHMJWaTnaRrbmO35vpS7TJxAQhlwiqYY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mm/XhP7HPzo+iFoVllgXYlAnByRSGdmEmQ/9WKMRbKjP9gf3uokjKC5NnR5B3Ub/0
	 df3PiunpjyE567NZ1zBV+tZM/rAOyYte79fMgzRX8xb1Jw5+RRsKg9cba6L4fDpu4J
	 dbeRuNMuFh8XWCB3F2fTvLcoauM/ZmvDce60MDqxjOp4hjk75ZMWebupjRfd1ssHP3
	 RF1SriyTNMONJLj1srRxbt9Lj/xl7DWYcaVNvpp2N+phftZoU8/tH9J9wXRfuk02EY
	 OjKf5XK7hX1//dPKa46gIrs8/UpIGMlYMN5XKpuUgrJihaeRboayI8kWy1HZdnQrGU
	 oJnIAqua6PDFg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:40:16 +0100
Subject: [PATCH v3 47/47] fs/proc/task_mmu: refuse addresses beyond 32 bits
 on 32bit
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
Message-Id: <20261031-fixes_core-v3-47-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
In-Reply-To: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
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
 Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1750; i=david@kernel.org;
 h=from:subject:message-id; bh=d8AVCy95kfas+cJ7pSeAW9fI96TKmix6WWb4ARgBYj0=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebs+uWlm2vM6eedFfrsPlmn5VRldO9lvIXFeflLt4m
 UjDL9sJHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEykXYWR4eH/x/2/vSJVbgRt
 27d0zhqZ4nL5itJpMbbKUsv1G6dMymb4X93EcfrTp/qNqTE90isL4+W72IwZ/7uandbptO5xmr2
 PAQA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

The addresses in struct pm_scan_arg are 64 bits wide.  The first thing
pagemap_scan_get_args() does with them is to cast them to unsigned
long.  On a 32-bit kernel the upper half is dropped without a word:
PAGEMAP_SCAN of 0x100001000-0x100002000 scans, and with
PM_SCAN_WP_MATCHING write-protects, 0x1000-0x2000, stores the result
at the lower half of vec, and reports success.

Return -EFAULT, as for other addresses outside of the address space.

This is probably not worth CCing stable.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/proc/task_mmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 7452b695fdaec..762b6dbb81e4a 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3032,6 +3032,12 @@ static int pagemap_scan_get_args(struct pm_scan_arg *arg,
 	     arg->category_anyof_mask | arg->return_mask) & ~PM_SCAN_CATEGORIES)
 		return -EINVAL;
 
+	/* Don't cut 64-bit numbers down to addresses that happen to work. */
+	if (arg->start != (unsigned long)arg->start ||
+	    arg->end != (unsigned long)arg->end ||
+	    arg->vec != (unsigned long)arg->vec)
+		return -EFAULT;
+
 	arg->start = untagged_addr((unsigned long)arg->start);
 	arg->end = untagged_addr((unsigned long)arg->end);
 	arg->vec = untagged_addr((unsigned long)arg->vec);

-- 
2.43.0

