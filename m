Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4439D3D0
	for <linux-arch@vger.kernel.org>; Mon,  3 Aug 2026 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785741041; cv=none; b=hQiDX3bVHSZUAh7UfVxn5zToXDNsgcYdIxuQk2H/q9WfDcnC4XGPr8uzDMXVSPk1NTC66Q3wfUHt7Fru50tu1k9SsczREygRJkJzijM39+koZf9IipqqGCHgVYOxQfPfLq7LYxZmLV5oeSk+A9ZbjYBGh4ZmRPeGXujvjulA3HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785741041; c=relaxed/simple;
	bh=CSS9gwks0lv/fJG4J+/DCdPNhjgQ2fB/8r3a7lOVaFM=;
	h=Content-Type:Date:Message-Id:Mime-Version:References:Cc:From:
	 In-Reply-To:To:Subject; b=u+fm7gnEScZbUDm+TvqS2g2oQLtnkR0AyP422/sWML6NJqckvpfR2onYmkFjDv4PmVFGNRgKz3PwEuk6ANpmJW/Y20EQ6R1I1CKiTEyHvnupBvkkMjwcNhsj6YfmrZkGR8vmNv3Q+3lW8XNKcosRgQcZrb2W6eGjsw4kwIHK82Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jVUc7R7W; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jVUc7R7W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785741029; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=6LDfmUcelxmT9nJB/bHRwgrk2ZzY+G3Dy0t3Kxw/TPQ=;
 b=jVUc7R7Wa2Ok326nyBtCim8LWK/AfgeV/nL77gLtI/shnGmWKC85fFqUje9PUmvXXMrQn/
 2xGk9HhtY/d6MgsDB5dArYU6CI6PnLNYjF6XSCGr8PuX6S+SZuBJBxmg7zBzkdKH82j3Du
 wHbcIHhUBfPlc7zlkzxccX9xBQORfVkP/o7WqdESFv5Y+GfhluE/lhspfDrauxtWatu9pZ
 ZyRtwd62A3BYPD2jPp9W04PrJKhK/ts54tjhBF4I3rHQe2pVGsrTrKi/G6BXc26cjh6Ip6
 WWLmqCMKFrn4tb/sOdDRzLOjrf2k/vnwdPOcqXYD0jdVBfLjzM9IMkVNA7h4vQ==
Content-Type: text/plain; charset=UTF-8
Date: Mon,  3 Aug 2026 15:09:22 +0800
Message-Id: <20260803070929.86075-2-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803070929.86075-1-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.45.2
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
In-Reply-To: <20260803070929.86075-1-lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a703ee3+4c14e6+vger.kernel.org+lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <rppt@kernel.org>, <tglx@kernel.org>
Subject: [PATCH v9 1/8] mm: fix stale ZONE_DEVICE refcount comment

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
Reviewed-by: Muchun Song <muchun.song@linux.dev>
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
