Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8653783C4
	for <linux-arch@vger.kernel.org>; Mon, 10 Aug 2026 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364536; cv=none; b=LEd1T1riQdFUBJi9BOs1WwCbabLu2bz16LMjRqNF1Qw8rcz9zG0tnHTMtOSyBemQlF2kaMrn6zv6spqk0hFBP36LBvAOe2GCqKokY91ZM84Soc/k+WqUhDI91zuHZzBZTuCrIkNVgIHEw4/I4FYoBUyONlyhn58dUJ7aJdJEmn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364536; c=relaxed/simple;
	bh=CSS9gwks0lv/fJG4J+/DCdPNhjgQ2fB/8r3a7lOVaFM=;
	h=References:Content-Type:To:Date:In-Reply-To:Subject:Message-Id:Cc:
	 Mime-Version:From; b=DDGk5drGbroWUp9Lyv4iRe+yILS/lLJPhg/siDFEznrUHLUG/1KjkMAVJFEmtRyXttJGSPJQ/tDOLhY3hKnFkOWVwJdwjTGeE6/ixkZJjaWoLj5iseOPutTFXOSBlUK+L+AxR8aYy49vDFv97KeyiNRRqGnrX9D9kQZnkahKlGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=frEo5qcW; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="frEo5qcW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1786364523; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=6LDfmUcelxmT9nJB/bHRwgrk2ZzY+G3Dy0t3Kxw/TPQ=;
 b=frEo5qcWDYAkeE5zop7vhFKmQ/ytTyiQE/r+DxfGySnuncBnp94UDWzDhCG2wcJhUA5aJ6
 8NQVn1Ac+ZXgIz13HiQ8fu94x6y78OvfIXZ2MNtaTq+uSA7sP99C7syMikaeGhlRsOLqjk
 dSQJBW30ANxMW6Mjb8U8ehsbGOu3bTnaYbnQvziVLTAaWb5iJtnyCkUaUYijjfqKHZSQYV
 E/7G1JM41O6TcxuuWqEwsKPbkJHhdbtYtfjMmwrHRNR+gw5AEZPD4vc2OxVxi077fUREek
 yp3rna9iHYXoHXwZYRAYPjsb1ENgpXFGngYjbE2hwsOU0bef5/M6Nj38rh44Lg==
X-Mailer: git-send-email 2.45.2
References: <20260810122057.30447-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <rppt@kernel.org>, <tglx@kernel.org>
Date: Mon, 10 Aug 2026 20:20:50 +0800
In-Reply-To: <20260810122057.30447-1-lizhe.67@bytedance.com>
Subject: [PATCH v10 1/8] mm: fix stale ZONE_DEVICE refcount comment
Message-Id: <20260810122057.30447-2-lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a79c26a+41b026+vger.kernel.org+lizhe.67@bytedance.com>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Li Zhe" <lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>

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
