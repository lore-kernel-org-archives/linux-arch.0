Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EDD194C98
	for <linux-arch@vger.kernel.org>; Wed, 27 May 2026 03:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779853157; cv=none; b=Aza2c2dr6qc4yzPwq9PWcMURFMRZ/G5mhQ4JZcq6Vav+zG+xJEJ2fSpdTmc2W3d1yZ6/o0enXS1aMIKg2t1sDzWQjKvHAJJ7D/v9hmrU2lkFsKyTXSFUOrdk/pKYbE7VTrTNdWrol+gkQ9f5mTLidLKAksFnPCZO9P7PjUL9p88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779853157; c=relaxed/simple;
	bh=d0aczSMYu0LsWJWfpHcpC5eYLM8CWn7oG+3NwJ0kky8=;
	h=Subject:Message-Id:To:Content-Type:In-Reply-To:From:Date:Cc:
	 References:Mime-Version; b=Pn2vYALRQ0+3DrkyvwfMIYPBydpV+pLo9LEXyEcm2rocZJg7zl9GKFNK7BG2aVGbKFxNh+eDS1hXXL/WYEAq21p5b87eSSYnV4P7O6wTjbShYAujOxljlDIlxkPwQT3qgJGJ8AjurwMGjnEWMyqxFT9XdAhSDqnexcLdk/StiX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XjjgQoyL; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XjjgQoyL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779853145; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=+cxbxhZdlUYhyShSVcB1R4gZ5/57w7jfc0KexcGnvXs=;
 b=XjjgQoyLWWQRwtjh6asBScAkA0PK9toxFsBttGjSQcgZ4F9XO98k//o+68O3y2pHGXVkB/
 5K7HEiU46Gbz/1eE+Vye1TJUbGbKOymhOZ56PlwfiAQ4LbITsNPAUhefiM+P/sJM/cSL0K
 e9GDYrM65m1oJn3NeK8d1Xq8Tt8Yp4ce23/MPxQPmoOqsgK/UVlFFWgsQLrjhdbXorW5Ti
 XVGP56elmQ6qUiZsYmmeI7l+9FL/TJLGGSqfJCUQUN6ydG12yhFEUzUO4wI1x7V7F5CPfb
 wj8c/6YMrH5jlHA1FRssV1nkwLzSQ/xALh9/N/9xET8UOll52wJL1fSzepzz8A==
Subject: [PATCH v3 3/8] mm: add a set_page_section_from_pfn() helper
Message-Id: <20260527033636.28231-4-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a166757+94f111+vger.kernel.org+lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20260527033636.28231-1-lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Wed, 27 May 2026 11:36:31 +0800
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	"Li Zhe" <lizhe.67@bytedance.com>
References: <20260527033636.28231-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

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
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
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
