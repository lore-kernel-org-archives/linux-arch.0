Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057540;
	b=au4U3uwP9/TN7uE+ila8qhYoXapqstmDj2AgYT6oAzjBAcEJjnAb2Qli3AmLQlfoL4Xe
	 l8X6b7zxCRaWVB259eWBhRtpM1tHzPLfOD8g8HpV2MPFk7ARJNQUk4Yj6ADBAmX2MzGRE
	 lLhmE7Ay8Ahpes07SbOq6yDZOjjZlxqlbyzydpFjF7Zeqt+4RKW1ohuHOaysk1uVesKH9
	 nAYDO+awYHV7tB6iKhE43aKmEDvOodBxDpi16/De5etQ31u9900xtHqxI4fEx0xurdzPd
	 O4A0bESsIV/kYH1a/2HCLeb4xlaM/iLLXr+DBc/fBNUmIbQ3X9WMxXKm0oBgy0qod/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057540;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=leDMySoi7QnuGrXCT7kUTF7p3M2NeDPBgSV/0vbZ0BI=;
	b=4ZhZr27NY60rwCCJuH5JlxaLpssP4bm2HE9COTf99R8qSn9R4u9zyWngSvuNRjFJu8sH
	 oCEAgjpmfaDew3yl6+EHMmH18xTHq9ZNsJrV2ZXzvqCxCek1p//8lnMx5RrKiURRWnskR
	 InjYtkoyupu5+mylOV7dYMg8oKv5PYUkFRSCvOQ/xvrSmbDCN4bssAZ4pwqWJdRb5eoQa
	 clI0YNs0aQ1+/W0g6mz2kydGS9KM79uJdLCvWxqhm5e09uW5fwVG/i4R/hLHP5o9NsZ99
	 1fD2CHv2M666d9LWSKqWix0PlLDZqoSIVRGxWOeg73k5q7WicpZ1/bEDUovb06OH76g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L9akpim6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CAD606A31D;
	Mon, 26 Oct 2026 23:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L9akpim6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72011F01825;
	Mon, 26 Oct 2026 23:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057540;
	bh=leDMySoi7QnuGrXCT7kUTF7p3M2NeDPBgSV/0vbZ0BI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=L9akpim6QbyBegiqBFdq/baFvmFgEdwCFWOYawuBvlzKXZmVSx0OXUe0vIKVc29Kq
	 qFDhmjhE2XC8r2UET7MbseG82Yrlr5rl8uhm+FWZXg9zSHHjcPx6jOzdtkZAUAd57/
	 SUaqIU3cTuXQ5rkuIOkuugP4Oddi+rqpi0RzyFZcXrXMvV1AJRJeL0Ka60cc/6lFzl
	 3aj7CVp9NxQgtlAVViDSO2yiUZAwQ3wkx24AZ9ntSDPW+IGf2vjdQTXbtW5e5vPduc
	 PYBh4bWzA7jbOLzBvw10CaUrJ2jvgAzk/WB3Tm80LB/7B3bjWitIFuSzSjELUy2vBJ
	 OVrw1PteZgGXQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:18:06 +0100
Subject: [PATCH 46/46] fs/proc/task_mmu: refuse addresses beyond 32 bits on
 32bit
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
Message-Id: <20261027-fixes_core-v1-46-6f74bec9a5bb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648; i=david@kernel.org;
 h=from:subject:message-id; bh=+RaX15JldLvyrOg9i/7002o3Wko+CCA0o+GE3n4B9o0=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu3595P/+VmdMlLqcHjo7hx5XfCereZwuyfqL6dWnoT
 tPbz1nLO0pZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZjIuT2MDAtnL/pcH+sjlak6
 xTFMq1Epryj302Srs5J1+1ufKrr0T2FkuFqsNvv532l6H9VM/3dH69amCF5+VDmd8zXP8lDXW2x
 ruQE=
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

