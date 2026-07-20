Received: from va-2-115.ptr.blmpb.com (va-2-115.ptr.blmpb.com [209.127.231.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05E640D56D
	for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2026 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549290; cv=none; b=EQbPF2HvH7EummhWUf3H8JzioBM1/thZWRR/wUDf8xO6u/KyNtZ3Un0ZbFaP6og6O/+me4TU/7ZoRO8JcL755u8aDVA6CyYjwMjqJXBrqsuNFequG6rNHksRlViOq18e0uUHxFuFjo6gY94FTi4M5lFz4J0P2ANNdwONXKS/yBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549290; c=relaxed/simple;
	bh=NVdkAhbl9bllswTnkFTRAaSUOKQuVIYHxSNZ4ZJ9tPs=;
	h=In-Reply-To:To:From:Date:References:Content-Type:Cc:Message-Id:
	 Subject:Mime-Version; b=Twr9FKt+zL+XXWqleU+SUeiuAcVwrA64f6SYgqoljfbuvf38AtIBrBFsKI244ffz1hfMLkxCXbCZBkfDQabPL86oRQAg33c40oR/crzQAQa3qapDUXkCS4W3+8MTxRsypTDy+PcWFMiE2tEclkiJTKX84A7eLG/M8RBtvsCcnco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VWU3ZUE8; arc=none smtp.client-ip=209.127.231.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VWU3ZUE8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784549278; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=avcd0GvpHsHr7mxbfL1p/CzBnaA4uWaToeE7s1gnya0=;
 b=VWU3ZUE8cWZh+o3D8L2Nl7R/fjaWU/75RGkcWxynmyrWaZ1jAD38piQKSw3e/SMo73XISM
 sqZ8b5YI3xVakILgJlYrluPosvj7OQJpcjyCIkTxCf8VrNm1A4OsxU5s672uJK6lUMo1ZI
 h4NMfRx6rkbRypNGi+liJQ0yi9p8YVB7ozKMxjB3sLrEJmnhxQdAehkpPIIJwMR7ZNkgKo
 93YYXvgBaSFO6fdchYI/nGgEiLJRdXyi662cQryep4zgucg/gno9CNDe28dMuhUjrMPSHG
 8F2jRoylP7SBVlOUlX7xbkRUIj4PX0x07h71fCsSJRPhfYA9vLr7vr36ZGJtaQ==
In-Reply-To: <20260720120259.1545-1-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.45.2
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>, <muchun.song@linux.dev>
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Mon, 20 Jul 2026 20:02:58 +0800
References: <20260720120259.1545-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Message-Id: <20260720120259.1545-10-lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a5e0f9c+6c9af4+vger.kernel.org+lizhe.67@bytedance.com>
Subject: [PATCH v7 8/9] mm: use memcpy_nontemporal() in zone-device template copies
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

The template fast path currently uses memcpy() for the actual struct
page copy. Switch zone_device_page_init_from_template() to
memcpy_nontemporal().

ZONE_DEVICE memmap initialization is largely write-once: each struct
page is populated once, and most destination cachelines are not expected
to be reused immediately afterwards. On x86, a regular cached memcpy()
can therefore incur write-allocate traffic by pulling destination
cachelines into the cache before writeback, and can populate the cache
with data that has little near-term reuse. Using memcpy_nontemporal()
lets this path request nontemporal stores for that copy pattern, which
can reduce cache pollution and avoid part of the associated
write-allocate overhead, while architectures without a specialized
backend still fall back to memcpy().

No separate drain is added here. memcpy_nontemporal() is used only as
the copy primitive while memmap_init_zone_device() is still initializing
the struct page array. The ordinary stores that follow in this path,
such as compound-page setup, are part of the same CPU's initialization
sequence; they are not used as a publication store that tells another CPU
or device to consume data written by the non-temporal copy.

Therefore this call site does not need a helper-level drain for
correctness. Callers that use memcpy_nontemporal() as part of a
producer-consumer or device-visible handoff must add the required
ordering themselves.

At this point, sanitized builds still use the slow path so KASAN/KMSAN
retain their instrumented stores. The following cleanup removes that
local opt-out together with the remaining non-template fallback.

Tested in a VM with a 100 GB fsdax namespace device configured with
map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
server.

Test procedure:
Rebind the nd_pmem and dax_pmem driver 30 times and collect the memmap
initialization time from the pr_debug() output of
memmap_init_zone_device().

Base(v7.2-rc1):
  First binding for nd_pmem driver: 1456 ms
  Average of subsequent rebinds: 244.28 ms

  First binding for dax_pmem driver: 1462 ms
  Average of subsequent rebinds: 273.31 ms

With this series:
  First binding for nd_pmem driver: 1272 ms
  Average of subsequent rebinds: 96.79 ms

  First binding for dax_pmem driver: 1354 ms
  Average of subsequent rebinds: 119.04 ms

This reduces the average memmap initialization time measured during rebind
by about 60.4% for nd_pmem and 56.4% for dax_pmem.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 2668acef4fe6..2a723a518f41 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1067,11 +1067,21 @@ static void __ref zone_device_page_init_slow(struct page *page,
 
 static inline bool zone_device_page_init_optimization_enabled(void)
 {
+	/*
+	 * Keep sanitized builds on the slow path so their stores stay
+	 * instrumented.
+	 */
+	if (IS_ENABLED(CONFIG_KASAN) || IS_ENABLED(CONFIG_KMSAN))
+		return false;
+
 	/*
 	 * The template fast path copies a preinitialized struct page image.
 	 * Skip it when the page_ref_set tracepoint is enabled.
 	 */
-	return !page_ref_tracepoint_active(page_ref_set);
+	if (page_ref_tracepoint_active(page_ref_set))
+		return false;
+
+	return true;
 }
 
 static inline void zone_device_tail_page_init(struct page *page,
@@ -1110,7 +1120,7 @@ static void zone_device_page_init_from_template(struct page *page,
 	 * to the destination page.
 	 */
 	zone_device_page_update_template(template, pfn);
-	memcpy(page, template, sizeof(*page));
+	memcpy_nontemporal(page, template, sizeof(*page));
 }
 
 /*
-- 
2.20.1
