Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4A52931D9
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2026 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175078; cv=none; b=an6WjyG+3/JdjuI3oH6/PwL4DPvdohcnxmGwsjKnH1NGiIhv3vxpbJ2+wnynXGSqmY6goifUORuPocyeicCGFkh0qspsTvmpIB0RO5LAheog38fSZjDiln16BRHl8UmVGzs2UlNYRMmjv6vmnDzcIR7TStJpTZ7KXOjZbWZQCJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175078; c=relaxed/simple;
	bh=1tzC160XRVFTBUvqo0eRGovwFSfOVpQWnrqojoT/RKQ=;
	h=Date:References:To:Subject:Message-Id:Cc:From:Mime-Version:
	 Content-Type:In-Reply-To; b=LHAUOjGUByLQF7obpueISiYMGnPs66st2tvjKs2tSQYSdS+VR/jAqG6PlU4BHXjLEbAr0cn7PEFHwxMiA5K5kgjnyZLXveNGNv1Z85UJksOR7BCJh07og6/wpzuKicbF5Tr8A9wIsFdpq+S0FSHcCg//NsZ+i+EUlg25oKq2TAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cahwJPC8; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cahwJPC8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788175071; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=sk7m5/tft/ydmLxoPchPzp52VQWS3uxvgVEj6+c0Gmk=;
 b=cahwJPC8yhwEKN/G30w4+TGWKh1rlYTtEwLnyaIiBYtyoJd2zPvhs08amO+XVusVPW+TSO
 DBVSSJOFyC7uGOeFje2QGOZjUHYc2D7jZcOmJDbrLyi81CcIU+/vrdTXQ1gf8wQrmhnciB
 nr3km+POkgcMbOog3Qj/CWZFXuIy3n/UJkELyl+tBnRpNBaVAt5ke1rAVDDLD+MCsrMz76
 soRy0PoE1c3dO+Zk3y4IgCSsNlBWwmSzsaccRzdIcblt4geR+1KfhI/udj8mXUsGn8Yvyg
 cJGoiqaI2MtrJA5spGrfakitPfofjDaqxdvoSMox3ZVFwUoJepOXQTWNOISZkA==
Date: Mon, 31 Aug 2026 19:16:32 +0800
X-Mailer: git-send-email 2.45.2
References: <20260831111638.76012-1-lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <rppt@kernel.org>, <tglx@kernel.org>
Subject: [PATCH v11 1/7] mm: fix stale ZONE_DEVICE refcount comment
Message-Id: <20260831111638.76012-2-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a9562dd+5a6432+vger.kernel.org+lizhe.67@bytedance.com>
In-Reply-To: <20260831111638.76012-1-lizhe.67@bytedance.com>

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
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/mm_init.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 1533aebafb68..8f73d5850db2 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1000,13 +1000,9 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
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
