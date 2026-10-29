Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306706;
	b=yiSEDBXjm+ow8sz79UpvMUCd+QQaQAjilLZrNqjRZaXKufPn6Weng/ms1g9NHooN3VS7
	 DJGt4BJeTsjtLzyRSpigrEN9v+LGMC2Bzb65Nq4cir2kqVmt+F/ajLHc6r4w731JBXByl
	 K6xzMCgfSwF+G2AEJWTCZD5euhRsUnz0HGu2MH7Kkl50r9NIboU+5+GFjpiXBWx1W2gfU
	 QU7Te2e24RlRNsIKpTEyPXVir+YityxtoQm39fYSkzQe85Tyuk5VMkjd1/d1I0FX3rGof
	 613uDU6ATINSI6aZnXuwp2vpOQU5bpkfOT2iPRsr28BXGDkr8mxtfvYT2LUiyqd1yyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306706;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=GTbYn1B9uEaHo+IwnQISx6DSu8nadScf/DEgScNsxUY=;
	b=Ko1e0GW4xdBuqRtt2k0706mPAkJ19cVaJYBJnyvBZhEXl/75XZrNhRnxYw7hEkCy89u+
	 7zget1MDgtV6Qto1FpLMAZQCcyM8rwSZwtYfYcSNxjd9W8twTtjdoHDrb72zuwmULY5FO
	 f5PxPknZDn0jClMPdjd6aB7dQVb/HmvtOzkx/WIwxEYxMARBMS0+EGHka9BJfMTWhszzL
	 xR1xGR2feHKxFMM1dx7os6P5HDGEw+sHzOOke61Wjcoww00gaPJC73N6fHWfMwUJRb4YX
	 tUczL8exJfwraiYnQarZLWJROGJJz1vP2dW0+RjCI2bH8d+Vh/hx3m7S7XuSSaKedJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WhdvjoN5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE4060A380F;
	Thu, 29 Oct 2026 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WhdvjoN5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB641F01826;
	Thu, 29 Oct 2026 20:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306705;
	bh=GTbYn1B9uEaHo+IwnQISx6DSu8nadScf/DEgScNsxUY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WhdvjoN5s9yBtKL7TO38yUQNFfwrtZV+RPRgO+dXzIyrW8v5zeF7U9sUJeRD31dCv
	 tnqMt3RnlqgeqbFDBeJAps0ju8zYO89p+SoK/or2UoMdEm0hCT/TD/yDv0PCOqJ85P
	 fNE8dHo04vvN/YtksdSHaEnUUy15/kf2CTeZdHFG47FJoXBqSAglNrRlOwaDjz8AAy
	 wlfc60h5OWJMf1LQnsGiuPdwzn1ZbsCsvU/CR2NPTcn/RQ5ASf9KNEV4lkEIoVlIr7
	 6AOCkbODg+/zUBE9orFJVeVfbx5hHhBwXIQMFWWkdVDDspFJ9Pj/83r9qJZySYzwBG
	 KUEYRbyPx4IGw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:42 +0100
Subject: [PATCH v2 47/47] fs/proc/task_mmu: refuse addresses beyond 32 bits
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
Message-Id: <20261029-fixes_core-v2-47-a64ce7f83abb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1693; i=david@kernel.org;
 h=from:subject:message-id; bh=H23iSXQ9Zo3UCvNDkTgZhR+Jd2mqfSBMzvPG+6Su2Bs=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer+36dd5g2Q4ND87Jf761zFBNvRKV+lT8j+vKzflze
 YyOa+w70FHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEvrUyMqy5fPDlzml6Z/cX
 79h+PNfDilFB5ZDotvsSF56fsl9+5eVERoa/IndyDIr42sM3z5yxY7reXodOs79NDjUek3fdtxO
 tdeEBAA==
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
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/proc/task_mmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 7452b695fdae..762b6dbb81e4 100644
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

