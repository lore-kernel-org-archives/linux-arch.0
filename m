Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0810E407569
	for <linux-arch@vger.kernel.org>; Wed,  3 Jun 2026 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473836; cv=none; b=aRH/hhn0TvNvs7XVYnBWFUeafw8m0bXcn9fO9eciFycwWUKeLCvxkk7v1woEZqWAzFM+Qk1JrHF4DEY0641yNw/I74tX0gS8pmj6vwn08mG6cqXRI0RJvBvZvgabKObXsw/rkKtapjH33SL64rxde/C7AHkyuxwt3dm34EcDhPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473836; c=relaxed/simple;
	bh=CKJrgkBXuJL76tNULqACYxiYPuJim8xWXoUjKVuwOWo=;
	h=Cc:Message-Id:In-Reply-To:From:Date:References:Mime-Version:
	 Content-Type:To:Subject; b=Uc+ValeMGB0KQSNaF8/EMJZPR5PXNqShEt3sFxTV0I1zv4sNwpRqbssxGIKy/T5FHYB+xIXjZlaRARJkLKNnVVx5JoS33mLblEcSIaCEYLyawq1xBcXDok77V9dxV8hriop+vem4Y/8/Jaw++kSo0YCTKHelStAT+/Fu65g0QsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DWwfEf7Q; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DWwfEf7Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780473824; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=g/rmtPD1MKrWC7BjiewTdsAoLxWW7dzbcFZmhvRKNSg=;
 b=DWwfEf7QMoGjXqoTXelNAgI/iLEGIR9X5nbC2Epz1dDNoWtgSK6JJc1/kL46HxLEQ49lMG
 YjNAqK7lNtmte7uWYLGELUWyRQIJyZwPXvs7/sGnJUvZMY+7jqYT7ZwjjSWff7XSySlxaw
 XITt71tgA389mo2kRmrCgHveYE4I7P2Qfr873wMhcooitIY/Rik2EbpPUIU3liIvgdwK1C
 ZKJu9+Gj3a9+7JYWKbhq3+xNN6p6FapbLmb56awEeo7TU7iaBOCBCjMOIEaI3TXthHHp/+
 G6agip45lUq44QDNRsYSkyAzr5kjHzzw9fdgoR37WIXZmtIaANzqswAI4ztXJA==
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Message-Id: <20260603080152.64728-2-lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260603080152.64728-1-lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Wed,  3 Jun 2026 16:01:45 +0800
References: <20260603080152.64728-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>
Subject: [PATCH v4 1/8] mm: fix stale ZONE_DEVICE refcount comment
X-Lms-Return-Path: <lba+26a1fdfde+e98511+vger.kernel.org+lizhe.67@bytedance.com>

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
