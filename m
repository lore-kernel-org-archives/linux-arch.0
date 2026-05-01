Received: from outbound.ms.icloud.com (p-west3-cluster6-host9-snip4-4.eps.apple.com [57.103.75.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B225E2D6409
	for <linux-arch@vger.kernel.org>; Fri,  1 May 2026 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.75.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777614978; cv=none; b=UlVPTXWbAmTGKj6AaKaBlFefiPanKbO4h/VXgLZLQBmM4zIQZLnkD1mAFgXAsH6ZLHd4xoGcObhloRJMdST5nvAc5Kceb2ZUcmV2FY9wunRgglbfQGerLy9Cu33Cm0Z+Ix8+1A4bhoqmj23PDMZKz0lvnWDXQ7EFJ/EG34HC0do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777614978; c=relaxed/simple;
	bh=fe5qUdEup0HLb2HrLDxT1324Rwy5SIK9P92A+sggjFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ClEzlnOiXdRCdTqFBH4DhuCswntKbqAYGvPWG8tUBCLZL3NrVKvGepOkoBNqEOmoYcU5j28uLXmDRbblKs8OB4+YHuwYPZr3GuEcl9Ui7mOxvkQT5AgSSrsDvCR6QMgCwDI0X8kDYzM8Jd/cgYSqghQoqmolAdvib+h5+geNBd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=EwI+l9V3; arc=none smtp.client-ip=57.103.75.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="EwI+l9V3"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-8 (Postfix) with ESMTPS id B115A180013D;
	Fri, 01 May 2026 05:56:13 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhAA0MFWgFeAUEdXwFLVxQEFEYGVg1dE0wLcwRUB10FXVZQAlpLVBQEFEYGVg1dE0wLcwRUB10FXVZQAlpLQBMESgZNXw5eHwQXRhlVBEceXVZeHhkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4EVAddBV1WUAJaS18ZXUUPXwdZBEAMSAJAQwNCL1oXREBBWh9DFEgDWARcBUQBSwReDytGFVcbVgNDRVEfVEYTGU4bV01QG18CQg8=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1777614977; x=1780206977; bh=i/MDV/SdEyba8CAl8JXsfJJlaWhqdQgOiCYK9KUK3R4=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=EwI+l9V3Eq8DZJruLYfJo2dpxYir0zhLiB6TNlieOp7ifXH23lRVEDJC2EU/hq2wz3FO6ybNlfeB5udpXES9bVb4DDPjRx5qGhQeG0RGpS4aeYJlQVqt9gMmBBN+OMqNrOjOHmlA5zrDnza9xoLCQ3Zt37WtiivxOz+wlzcSE/lQsBRuRKtpOJa8Xve9bT7AyzxRExricclw1cf7QwdUFqYSbxqL27mRqA+uuLwh4JFiZvxAMyxdRzSXF29n50bgq85Gcp07zwj4wGta2LzNMkxiF8wkih1e//DMnTvkPyfovmUaHWPCPe6x3NrUb6QI6aD2R4Dxb0NFmsnDNoTkXQ==
Received: from [127.0.0.1] (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-8 (Postfix) with ESMTPSA id DB5BF1800108;
	Fri, 01 May 2026 05:56:07 +0000 (UTC)
From: Luka Bai <lukafocus@icloud.com>
Date: Fri, 01 May 2026 13:55:44 +0800
Subject: [PATCH 3/5] mm: add pmd level THP COW judgement helpers
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-thp_cow-v1-3-005377483738@tencent.com>
References: <20260501-thp_cow-v1-0-005377483738@tencent.com>
In-Reply-To: <20260501-thp_cow-v1-0-005377483738@tencent.com>
To: linux-mm@kvack.org
Cc: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Kairui Song <kasong@tencent.com>, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 Luka Bai <lukabai@tencent.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777614950; l=1685;
 i=lukabai@tencent.com; s=20260501; h=from:subject:message-id;
 bh=l3c8ZOwbATo+2PT4NYOAUghe4sk42dQjWN37S7JdcBg=;
 b=TSo2qM8r3KPPphClijLCEpGTnjI/pFC9+a8AQTQmdnuguNqhfa6BphAbJgkEVtcBJUMnH5Yi1
 ukFPpvM8SE3DKy0cbu0hqLnkQgMtbzyqiZoO3sLbQG5tG9zz+vGRHPR
X-Developer-Key: i=lukabai@tencent.com; a=ed25519;
 pk=KeaVteSWd00GIAjFyWZnuFsKAKixjga1ZkLMcI66nPM=
X-Authority-Info-Out: v=2.4 cv=No3cssdJ c=1 sm=1 tr=0 ts=69f4407f
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10 a=UaoJkeuwEpQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=GvQkQWPkAAAA:8 a=JogxrxylMUJFqwMgd1oA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hB3IhlfY35IDEelkOKd30xeVKZ4dDTn9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDA1MyBTYWx0ZWRfX//GBnMBXJ+C+
 gHIiUEpz5ykqv7rnL7hYpfRWgqfJ+r3gKMPEjydZWch8zDPRgnyic8lbsqmz7W3j9NORpehDbpm
 HKuQctCjN/YpeWJWQpUmbYiEkaC5JrIxyy1VYLmK2OeCTZUFp/ZJTLlnSzwEPF9GWO0BvAqBwZH
 92Ej9piDwed/XU5gqf3lLyK9lyoPcVTUFAwXQRhq6IyviOvKDCRzX5nIdOLVel7x3tE0paAqprv
 knKjDu7zC5UVTLsD/eKxfTzl6wKAa+LQOLDzaRlo39GVGxC/5cSWeEIKnzNoLLM02pYqJyPLP3f
 NLHOvfOkNVMRy2QeQMYWg8GVvr1m0kohvEJxV0b1t4BN80PB9t1gM0vd7O3QsI=
X-Proofpoint-GUID: hB3IhlfY35IDEelkOKd30xeVKZ4dDTn9

From: Luka Bai <lukabai@tencent.com>

We add hugepage_cow_always and hugepage_cow_madvise as two convenient
helpers to decide whether we want to do THP COW under each specific
circumstance.

Also, we add a helper hugepage_cow_enabled to help us know the setup
more easily. THP COW is only opened when hugepage is globally enabled
or madvise enabled.

Signed-off-by: Luka Bai <lukabai@tencent.com>
---
 include/linux/huge_mm.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2a62f0f92f68..3e5c6da3905b 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -203,6 +203,38 @@ static inline bool hugepage_global_always(void)
 			(1<<TRANSPARENT_HUGEPAGE_FLAG);
 }
 
+static inline bool hugepage_cow_always(void)
+{
+	return transparent_hugepage_flags &
+			(1<<TRANSPARENT_HUGEPAGE_COW_FLAG);
+}
+
+static inline bool hugepage_cow_madvise(void)
+{
+	return transparent_hugepage_flags &
+			(1<<TRANSPARENT_HUGEPAGE_REQ_MADV_COW_FLAG);
+}
+
+static inline bool hugepage_cow_enabled(struct vm_area_struct *vma)
+{
+	vm_flags_t vm_flags = vma->vm_flags;
+
+	/* anonymous THP need to be enabled first */
+	if (!hugepage_global_always() &&
+		(!hugepage_global_enabled() || !(vm_flags & VM_HUGEPAGE)))
+		return false;
+
+	/* always enables all the THP COW */
+	if (hugepage_cow_always())
+		return true;
+
+	/* madvise enables THP cow only when vm_flags says so */
+	if (hugepage_cow_madvise() && (vm_flags & VM_THP_COW))
+		return true;
+
+	return false;
+}
+
 static inline int highest_order(unsigned long orders)
 {
 	return fls_long(orders) - 1;

-- 
2.52.0

