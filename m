Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13203F5BC7
	for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2026 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596378; cv=none; b=qiacJ+/28FoWAU0Omkh7zTDVKeprxJ/4Z5JR1yo6GiULsoUd4Ki5Jq57OLNOSl7j+vRPpifwcLMQsTgoa/SWvbHiJ1E8Yi6SJnftoxZyExqgthXnsu12HAWha7fjCbFz3Aie+HP2kfW3EDoVpP7mvPWRwxfx4f4/ej4wR+KSJCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596378; c=relaxed/simple;
	bh=JoDANVva75ciK/1NcNe6lkdXyCmLuTqwqqUGwbsK6kE=;
	h=In-Reply-To:References:Subject:Mime-Version:From:Message-Id:
	 Content-Type:To:Cc:Date; b=fOguw7mdGYOPlWhIPaVnbu8ZsOMZbzcpVB9twlearo7z433XtgRfo+iDvBhpJitr3+iBHKakTrf/NpTLOwOi5nqLxTC3CNZCP95YgT/3VTDpNEtfzW6rXFoNRiULn8D6p6yhjoN044Yx15o0iQJ1xzVF2bqpU/ZYm1iDESuCYpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ckWWnCQ0; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ckWWnCQ0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783596366; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=yJkQbYDrizZdEszOQSdVvOLkhzaQUCCImlFR4zOjeQQ=;
 b=ckWWnCQ0n5uaBYjphnlUeOq4Z/eI1uC2u4Q4U0HKL+u2O/aHJ3Rw/X9DT75z+81h3bEL8S
 bZFVVOYIO7EqbhhOQHI2SqCU1O78O/DX/iMEa494KtWvkjTJQBg7QM00lVQoKdttSa8v32
 K0XLFF43ehtH2hqzONy87nMLrNjfWdDIGonVWkwknpe7aHOH+OeI4vUZsQPBg7fMfY0GY9
 kw1aGT40BocwNDPDJqGlkdxUa/xBfWZbxZhMJtsdjUXtqT+IvvNqSoVMMMX9l13/ksSAqd
 j7uRu2VrL60xfV4bwvAl/4o2igE8oCFXpjf8lU1UY2ZRUvtSVQjes9+n9YMccw==
X-Lms-Return-Path: <lba+26a4f854c+778198+vger.kernel.org+lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260709112520.24857-1-lizhe.67@bytedance.com>
References: <20260709112520.24857-1-lizhe.67@bytedance.com>
Subject: [PATCH v6 1/8] mm: fix stale ZONE_DEVICE refcount comment
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Message-Id: <20260709112520.24857-2-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <x86@kernel.org>
Date: Thu,  9 Jul 2026 19:25:13 +0800

The comment in __init_zone_device_page() still uses the old
MEMORY_TYPE_* names and implies that FS_DAX pages regain a
refcount of 1 in the free path. That no longer matches the code.

Update the comment to describe the current policy correctly:
MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free path,
while the remaining ZONE_DEVICE types start from 0 here and raise the
count again when the allocator or driver hands the page out.

No functional change intended.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
---
 mm/mm_init.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 0f64909e8d20..95808ab5cfdb 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1030,13 +1030,9 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	page->zone_device_data = NULL;
 
 	/*
-	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
-	 * directly to the driver page allocator which will set the page count
-	 * to 1 when allocating the page.
-	 *
-	 * MEMORY_TYPE_GENERIC and MEMORY_TYPE_FS_DAX pages automatically have
-	 * their refcount reset to one whenever they are freed (ie. after
-	 * their refcount drops to 0).
+	 * MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free
+	 * path. The remaining ZONE_DEVICE types start from 0 here and raise
+	 * the count again when the allocator or driver hands the page out.
 	 */
 	switch (pgmap->type) {
 	case MEMORY_DEVICE_FS_DAX:
-- 
2.20.1
