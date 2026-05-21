Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873F635A398
	for <linux-arch@vger.kernel.org>; Thu, 21 May 2026 04:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336210; cv=none; b=pxC8mJCnLvSzw2liwuhbQrA74YdONuYwVJ86/pfnDXtEzgaLKLUgxAwLS7j0vr5ncBZjEUp485BZ5laQiZgk36VbkwCEJ4JaBRMVW0he9C0ZifDYIZgAMH/eBDqLuqaYZP8WwwWN0jdLX6Iz5MCoh1da9St5pWQWAdvxcIuOq3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336210; c=relaxed/simple;
	bh=7rC09xI4HoYDikXsCEwPGZ6dlO7nH70xTrI0pEzY2uE=;
	h=Message-Id:Subject:References:Mime-Version:In-Reply-To:Cc:From:
	 Date:Content-Type:To; b=OH2pb4hn64GzMluu5RL5CI+IrB2sQ3rlMsVcWDNn4MMi4IMc1uFnv1IgdDjkCrsB5m9dqnZbwH3BHALVLwG20znU+Yiyrvdab/WRKQzD8irTnM485fBdZREDRB6AWv7oCyUKDjFgvY8SP3xDkiQ6cBXe+G7i811rhVW9fO9jWcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QgheDEo5; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QgheDEo5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779336203; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Vp1wEakIyL2i5/j5G04i6m4y/xFgX3dqvqhZlULkuAQ=;
 b=QgheDEo5ToVzm/8TqFx7/h8iE0Gbm7QBfH+BFf9w9Fjr0o1MpD+Fi6VlIu2KIWugZ4iJ09
 rDYsYsVck3IwSZj/+Vxt6MlELouX9Dp0IPw8G7h9PZ7TPyYbPKmAdWWq/PHvvBTUcjv7qk
 MwV53R1J904aCEbu8dM8wkKQO02a0DCxBbjFsKX1qtZxbPH8aB0k/ilUgy+D7nW53md4LL
 r3GYT0sAIXUkgV0UqV3SjaBHPO5t66MTXcRFW5U+wEEpvNdgFFFTHbsy2eqPG3wJyQCmWk
 SB6UZVQcjiOYnWkH2Wt5edZUqJkrHRd3R4J4AQIqZcPz0apVN/kzQuieeYcA7w==
Message-Id: <20260521040124.10608-3-lizhe.67@bytedance.com>
Subject: [PATCH v2 2/7] mm: add a set_page_section_from_pfn() helper
X-Mailer: git-send-email 2.45.2
References: <20260521040124.10608-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260521040124.10608-1-lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a0e8409+da8b14+vger.kernel.org+lizhe.67@bytedance.com>
Cc: <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <lizhe.67@bytedance.com>, <x86@kernel.org>, 
	<linux-hardening@vger.kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Thu, 21 May 2026 12:01:19 +0800
Content-Type: text/plain; charset=UTF-8
To: <apopple@nvidia.com>, <akpm@linux-foundation.org>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<mingo@redhat.com>, <rppt@kernel.org>, <tglx@kernel.org>, 
	<kees@kernel.org>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit

Callers that want to update section bits from a PFN currently need to
open-code:

	set_page_section(page, pfn_to_section_nr(pfn));

and guard that sequence with #ifdef SECTION_IN_PAGE_FLAGS.

Add set_page_section_from_pfn() to wrap that update in one place. When
section bits are stored in page flags, the helper derives the section
number from the PFN and updates the page flags. Otherwise it degrades to
a no-op.

Convert set_page_links() to use the new helper so later ZONE_DEVICE
fast-path patches can also update section bits without open-coding
SECTION_IN_PAGE_FLAGS at each callsite.

This keeps the PFN-to-section translation local to the configurations
that actually store section bits in struct page flags, and avoids
exposing that detail to generic callers.

No functional change intended.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 include/linux/mm.h | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index af23453e9dbd..bf84e698385c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2507,11 +2507,26 @@ static inline void set_page_section(struct page *page, unsigned long section)
 	page->flags.f |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
 }
 
+static inline void set_page_section_from_pfn(struct page *page,
+					     unsigned long pfn)
+{
+	set_page_section(page, pfn_to_section_nr(pfn));
+}
+
 static inline unsigned long memdesc_section(memdesc_flags_t mdf)
 {
 	return (mdf.f >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
 }
 #else /* !SECTION_IN_PAGE_FLAGS */
+static inline void set_page_section(struct page *page, unsigned long section)
+{
+}
+
+static inline void set_page_section_from_pfn(struct page *page,
+					     unsigned long pfn)
+{
+}
+
 static inline unsigned long memdesc_section(memdesc_flags_t mdf)
 {
 	return 0;
@@ -2734,9 +2749,7 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
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
