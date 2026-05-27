Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3298637C90E
	for <linux-arch@vger.kernel.org>; Wed, 27 May 2026 03:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779853116; cv=none; b=kyUbJdLSIhhaA2Y3u+JVJUcqttCyjWlRyCZGA+lxegGVX+iqIwGle5uNqBgNB/sH53YB7aDTB4Hg8970Ux11whE2s7ofHJiIcZTwmMxO0KCVK5lV3qEKl7KpEYhjog9kCT1LYQXH2zd/1hwwad8EYt1pGcbW9sReX0zA4GhoSqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779853116; c=relaxed/simple;
	bh=CKJrgkBXuJL76tNULqACYxiYPuJim8xWXoUjKVuwOWo=;
	h=Mime-Version:In-Reply-To:References:To:Subject:Date:Message-Id:Cc:
	 From:Content-Type; b=T3vrr3VEDkS6tSfkGec75BEldroLxOXvyuHXu1AwYuVgROHGGUysX7dfWofubbV4OZeeRVamZS8FdAAnad2WObOzuZ7xymX1QOemI3jQ6ymQp/e1L8XZfBstasLILZqNLkx5NesrQGsDO8EfJYCe8eQjOVvgi/zFkgCPQo3/EIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DF8GYFSG; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DF8GYFSG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779853098; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=g/rmtPD1MKrWC7BjiewTdsAoLxWW7dzbcFZmhvRKNSg=;
 b=DF8GYFSG36lQNp3etCvNQwV+MLzas0UlhaS4SMYJRKA8c1VEcZC5GelEe/BjyDeV6kIUgp
 g3ylYPnjU59k5bnlRI6Y23Fm+AwC4Nqr4WyBufR22nGhL2Xyd7EEZ2eRvEZoVmhVuhzEBy
 oQgMMNZJ/DEecfsd5lAm5jhnIaJi93ExDdtzMMHoGCgJMzAhaBjM1uAErui6reMmeD7KCX
 /2bamP9NYkU2rzrMNXfg1A2pe5kdu9Vj4ad9+NBfJ4Ts9zI70Exv4yKvu+l5ueiPxcuDvs
 flvvW8fx+8GEskknjZj3SaVPj8MvebD91j0T3jr/f2+egZgzPL8O07xVA6yFNQ==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260527033636.28231-1-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.45.2
References: <20260527033636.28231-1-lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a166728+00c821+vger.kernel.org+lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>
Subject: [PATCH v3 1/8] mm: fix stale ZONE_DEVICE refcount comment
Date: Wed, 27 May 2026 11:36:29 +0800
Message-Id: <20260527033636.28231-2-lizhe.67@bytedance.com>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	"Li Zhe" <lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8

The comment in __init_zone_device_page() still uses the old
MEMORY_TYPE_* names and implies that FS_DAX pages regain a
refcount of 1 in the free path. That no longer matches the code.

Update the comment to describe the current policy correctly:
MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free path,
while the remaining ZONE_DEVICE types start from 0 here and raise the
count again when the allocator or driver hands the page out.

No functional change intended.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index f9f8e1af921c..35de3b6a186d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1027,13 +1027,9 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	}
 
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
