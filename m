Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179243FF1B8
	for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2026 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155842; cv=none; b=Rzrx+NXWl/khIPaKHcmrmBD2QswzIshMOJqstjhL8vndcfURxxrs1hWuXZzYSqkqtwVASG8Wpv9qevQpvgoHaxLt1T1qTAGJ7dTGJ/cjnYVHYEun3T/9QPqMoEVhyQ+6EqP57O7k0Qu9xOqw9kF250Y1hB67vuG7HXQTCn3Vos4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155842; c=relaxed/simple;
	bh=CSS9gwks0lv/fJG4J+/DCdPNhjgQ2fB/8r3a7lOVaFM=;
	h=From:Subject:References:In-Reply-To:Content-Type:To:Cc:Date:
	 Message-Id:Mime-Version; b=g+l15eVQzuCY7h6ysYyScSNZVtHl15YZ58kbyWSn2Xa/A5E2ghaEyg/Cwm3/4AgsHnkc6uD+bXg+aangPohfWeclg5fHHfPmYXWcPBkwWCQNZ6tcvO8Aj3xmOId6ZSmlYxM2SFbWwaLzLTk9ejit3g3t/sWRJFq7Nr36LS1IeQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Gqkni5Km; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Gqkni5Km"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785155722; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=6LDfmUcelxmT9nJB/bHRwgrk2ZzY+G3Dy0t3Kxw/TPQ=;
 b=Gqkni5Kmv3trTt7ZkyZ87gi/oyZxYrHbp0W/5WSl4V8qY0b6geJIIyIpdPAwtz7vlXZ2nX
 FQ8E2o4qFMdlBnTd+LVgpyQZMB0/Qe3Pe5wMjq8uNWOZJQAUQvBFtTASU6dMPWpTlgwpQc
 MrGWxvNP0brHys1lflfAc9Z+OQntQKG3ezic3oNOaT7AGMd1iVoknbSzCsgoiKvJnBTyTF
 CwxY1yBbfeSNEZnh+7XbdnwSR//iDUEeMZYDw07ezbdlVEktI8RTbXmHcZeA2aKwZDa4Hc
 DI8HUX2o+/aJLbwWOhZezBChiM+LlPsGXMEyUlpAXShOD32ooUGrmRoJqOdK9w==
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: [PATCH v8 1/9] mm: fix stale ZONE_DEVICE refcount comment
Content-Transfer-Encoding: 7bit
References: <20260727123429.5673-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
X-Lms-Return-Path: <lba+26a675088+d79907+vger.kernel.org+lizhe.67@bytedance.com>
In-Reply-To: <20260727123429.5673-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <rppt@kernel.org>, <tglx@kernel.org>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Date: Mon, 27 Jul 2026 20:34:21 +0800
Message-Id: <20260727123429.5673-2-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

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
