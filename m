Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DEB340DB0
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2026 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175207; cv=none; b=oQZQPRvHYf5fbRB22PE4dPKzi+2nZhtD9AW+N1vBBff+5Q4vOAdJwrhC8aT18iCpwVd9iFfQdho1HPcacWdMHNEPYWII+hqfmXkxXkWbHIdLaeQbhW+EBAyOPfIAJ/JqAgJ7OhKWETEZEnwP1mTIwmaPFrbbLe3zb/nAr1RJMvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175207; c=relaxed/simple;
	bh=qi09e+OoIqKkSrQPZgn/hyumFnoCGX1dsiMnT5m2bNY=;
	h=From:Subject:Message-Id:Mime-Version:To:Cc:In-Reply-To:
	 Content-Type:Date:References; b=bxUJQqtPYan0M856WGwB8Xg+kBkFlJpH5qaMeyaGkY2klRWCsdxf12Z+TsW7KarJnUcgiVB5OXe8zMFb0Vq9odVtNrRXSPLAaBKzYWN38JqqLZLR/ZUrNElMqL6ofiEWmvqtijlZxyCGtzHbeR1WZy0KefXGsiaQmybbHkL0lPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GE/I5DYu; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GE/I5DYu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788175202; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=dRKkwMKAA6/qu2BI43qh+QT7VmhddrQx/gvVs4FuAwg=;
 b=GE/I5DYuIJwsNpKjzL4KSnd/3U8/WCKrjNNyEuq54QJBOp5HKmt5DTwX532iEWrORgwfQL
 X+GVZNqEqfdgrYAqN/sxfYWeopLzKRDN8CNn/uJud6PrH4z0D7zmZpJuq3nu4ca3EI2pNW
 dkCFmVukal3IG2/+uePazxedJrM0ytiIYPfYeycX0g/RvzuP0ND4npslowncqaNYRy8zli
 vaVX7vozrn2nsCbwUTkimB3e25jrJwxmktm5dcC/ImV5PmOj3wQaL+RN7V9HFt+M105oVl
 FYJJDP0orGg1DShX4X3vXExw9NlfPQHtyJ2tzXRgCqA81Dxr3v/rV6SPq8iUrg==
From: "Li Zhe" <lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Subject: [PATCH v11 6/7] mm: use memcpy_nontemporal() in zone-device template copies
Message-Id: <20260831111638.76012-7-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a956360+af137a+vger.kernel.org+lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <rppt@kernel.org>, <tglx@kernel.org>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
In-Reply-To: <20260831111638.76012-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 19:16:37 +0800
References: <20260831111638.76012-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2

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

Do not add a KASAN/KMSAN-specific fallback around this call site. As
Muchun pointed out, special KASAN handling for memcpy_flushcache() or
memcpy_nontemporal(), if needed, belongs in the low-level helper rather
than in this ZONE_DEVICE caller.

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

Tested in a VM with a 100 GB fsdax namespace device configured with
map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
server.

Test procedure:
Rebind the nd_pmem and dax_pmem driver 30 times and collect the memmap
initialization time from the pr_debug() output of
memmap_init_zone_device().

Base(v7.3-rc1):
  Average of rebinds for nd_pmem driver: 221.07 ms
  Average of rebinds for dax_pmem driver: 191.20 ms

With this patch and its prerequisites applied:
  Average of rebinds for nd_pmem driver: 150.40 ms
  Average of rebinds for dax_pmem driver: 161.83 ms

This reduces the average memmap initialization time measured during rebind
by about 32.0% for nd_pmem and 15.4% for dax_pmem.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 04ba37d95bfd..5a61c0c83fa7 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1025,7 +1025,7 @@ static void zone_device_page_init_from_template(struct page *page,
 	if (!is_highmem_idx(ZONE_DEVICE))
 		set_page_address(template, __va(pfn << PAGE_SHIFT));
 #endif
-	memcpy(page, template, sizeof(*page));
+	memcpy_nontemporal(page, template, sizeof(*page));
 }
 
 /*
-- 
2.20.1
