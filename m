Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E68400996
	for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2026 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155779; cv=none; b=QB7BZLZUagzCge4m0uIuk07BlvqTraULLnuY4i5QXs9uOp3tOD7HC+DfcCmHo6eEn+ddIV5tog0O5YTkNuZ+EfZkFRkEzmBO8RD3aR76YRtrN/nm4qdNj/m+KvWYO52b2h9IkrK+913ZexRWVvef+PibaQaIIl6tD8qDc8zBhlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155779; c=relaxed/simple;
	bh=BIVDw/5zLYeH4lTLhdwm8OUozWu2BrvT0BiGbt//W2c=;
	h=From:Subject:Message-Id:Mime-Version:Content-Type:To:References:
	 Cc:Date:In-Reply-To; b=odEl3xAHG8MjJ8m+HMmCgJJgKRA+an+nRWyoShUn8TbHFkhrgxo/RhWVnWzPLNv/tKrG6Jw/WCSfiZodsSY478cpvCVdkpRgbhds68/gz3w+KCqE7E2evdcMw+acxAMIQ2xLdO7Q/xhF7BFFTBSqcZrxgLPi5J8PsPTBDGlLzTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UEO8kjWR; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UEO8kjWR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785155772; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=HX3xWYPWMGyEZ3/iAdp9cHSDCjeSCNmVjV7Tq4qpRvQ=;
 b=UEO8kjWRshpOkK1saMZNmIA6n8jzVhCqRek2R3PybvpOn71uPIDRu3erxf60OgZu9zOrZH
 rIMaTS2n5xTFgU6aqzQSXxJY1aDS04EYjJW09vkhJvzy+6p855N825zGZFk7qrodqH7gPK
 Bz/hu1gvZBYJATmKutGd5Hvz5uemhQKjCe3PP36xIaULAAr3vlUC4vQ9HunzAcq57p39JM
 XBwGoCIc6feXW6eaufVMEb970aWyp3wtIhpe91LrsJ41b+TgxEoIDvFTXlC/lP2EnravlP
 OHlf8fV8tiOUFVOxp7sKMj9kQr8b3ddUeslDthuEm8K2VyzdSSGiPT5q3zl9Ew==
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: [PATCH v8 3/9] mm: add a set_page_section_from_pfn() helper
Message-Id: <20260727123429.5673-4-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <rppt@kernel.org>, <tglx@kernel.org>
X-Lms-Return-Path: <lba+26a6750ba+b2b322+vger.kernel.org+lizhe.67@bytedance.com>
References: <20260727123429.5673-1-lizhe.67@bytedance.com>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Date: Mon, 27 Jul 2026 20:34:23 +0800
In-Reply-To: <20260727123429.5673-1-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit

Callers that want to update section bits from a PFN currently need to
open-code:

	set_page_section(page, pfn_to_section_nr(pfn));

and guard that sequence with #ifdef SECTION_IN_PAGE_FLAGS.

Add set_page_section_from_pfn() to wrap that update in one place. When
section bits are stored in page flags, the helper derives the section
number from the PFN and updates the page flags. Otherwise keep it as a
no-op so callers can use one helper without open-coding
SECTION_IN_PAGE_FLAGS.

Convert set_page_links() to use the new helper so later ZONE_DEVICE
fast-path patches can also update section bits without open-coding
SECTION_IN_PAGE_FLAGS at each callsite.

This keeps the PFN-to-section translation local to the configurations
that actually store section bits in struct page flags, and avoids
exposing that detail to generic callers.

No functional change intended.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
---
 include/linux/mm.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 485df9c2dbdd..43343bfce493 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2541,11 +2541,22 @@ static inline void set_page_section(struct page *page, unsigned long section)
 	page->flags.f |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
 }
 
+static inline void set_page_section_from_pfn(struct page *page,
+		unsigned long pfn)
+{
+	set_page_section(page, pfn_to_section_nr(pfn));
+}
+
 static inline unsigned long memdesc_section(memdesc_flags_t mdf)
 {
 	return (mdf.f >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
 }
 #else /* !SECTION_IN_PAGE_FLAGS */
+static inline void set_page_section_from_pfn(struct page *page,
+		unsigned long pfn)
+{
+}
+
 static inline unsigned long memdesc_section(memdesc_flags_t mdf)
 {
 	return 0;
@@ -2768,9 +2779,7 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
 {
 	set_page_zone(page, zone);
 	set_page_node(page, node);
-#ifdef SECTION_IN_PAGE_FLAGS
-	set_page_section(page, pfn_to_section_nr(pfn));
-#endif
+	set_page_section_from_pfn(page, pfn);
 }
 
 /**
-- 
2.20.1
