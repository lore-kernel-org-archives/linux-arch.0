Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F31C40C5A0
	for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2026 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549075; cv=none; b=ROg6xkzdpPoK1JXkKTl5hAYMurJHyVvzjgaBjhJHmT3ZpnyjPlVEeIAwQKQ6e9aoBvI8GhPWmZlqoW9KOmQWOU+RDXNj8KC1KOZVFgt1oNeuYS2SpULaKbrIza+hD0FQqS/z6MOnIeciP5N5eIYoqMFgd/PD7cQgLCwRDmI+vrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549075; c=relaxed/simple;
	bh=CSS9gwks0lv/fJG4J+/DCdPNhjgQ2fB/8r3a7lOVaFM=;
	h=To:Subject:Content-Type:Mime-Version:In-Reply-To:Message-Id:Cc:
	 From:Date:References; b=ukOILHlFjzgf7Xax7/3ou8xYs1YnIhfArG1eC2KaEqDEZxMzDNgNfYmQI0g5t7VrToDvHblzJl6mcZTjMkrtre3bEXJCDIVE9VJat3grQH7k0cLCi1Ccpe2mW79FHCtbGEx7MAVgfDY3yk/5OvwTXIJNuhmEeXT8bwC8gyZ6oG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=A5NekaIJ; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="A5NekaIJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784549068; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=6LDfmUcelxmT9nJB/bHRwgrk2ZzY+G3Dy0t3Kxw/TPQ=;
 b=A5NekaIJyAFlECrGgRgRqQaxnKMRsmqIKIteayYHk3n8ScAbPaqT+ZHSc/k8phL4tbIAW6
 mjHo6VyuJYqG2nS2pM3cX/xVLzO7Y6ASrHr0/m4LSgOCrMY0SbZAYdwG6+ddQeRhySNk45
 JDk92v9+HVl7r2c/Pw9h+D5WJ7FAjleAVBtTq7NzKUNxRu/SmvT+KUjNYPOHBW7oT+Wof2
 EcfP8xw5a/9vssmr/lKe5PjaqqQuGNnoYSuMVxWqLXfshDS4xTa5M6lN5TYj/NA2h834mY
 7G82HmFecyFcencJqW5uKj/cugYQe9ldqPxU3DddMZpt9aOJt0sl3XDlX/oyyA==
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>, <muchun.song@linux.dev>
Subject: [PATCH v7 1/9] mm: fix stale ZONE_DEVICE refcount comment
X-Lms-Return-Path: <lba+26a5e0eca+bc1c24+vger.kernel.org+lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260720120259.1545-1-lizhe.67@bytedance.com>
Message-Id: <20260720120259.1545-3-lizhe.67@bytedance.com>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Mon, 20 Jul 2026 20:02:51 +0800
Content-Transfer-Encoding: 7bit
References: <20260720120259.1545-1-lizhe.67@bytedance.com>

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
