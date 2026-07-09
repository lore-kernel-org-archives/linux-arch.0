Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878CB413D60
	for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2026 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596422; cv=none; b=NfzRNFCMFytpidI3MQ0qR6cEO7COBNg50wAXpb6NjzRY0zXrTwX6VLYIGLfrT+ge9wG4TSdTpANsZZ0nOW6ghOdGbc3Dwa2bH4cnq/4dxS6hmavMv+pqq0xkWY88oObRtgzkNKDLz+yt+cmxCLmhG1sg79Mmcg1xWHnYEt6pJBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596422; c=relaxed/simple;
	bh=BmpmWhktmibrc478v+9OiwwkmFxmUQ1BTd/op1LKZOs=;
	h=Subject:Date:To:Cc:In-Reply-To:References:Message-Id:Content-Type:
	 From:Mime-Version; b=GjK6ch80Fz+klh3z9gxXBNhPxWQSOoFHv6Dy0CH3LEvqW+KaikjqrCsVvJ2eZaTU8SXn3lc/om6HmPE/nY49suhd7b0K3j+NLellK04Sr4SvlcWfs6e/bm9cZUYmmEeZ3AIH9Kh4tXmyVvlwSjCFPmg4NWPnnuK7N8xseZrm5sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=okSmaLq3; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="okSmaLq3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783596414; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Ys2Upgcdh8Sov7eMQd5S5YsjOZi6b1QwjfihqCLWpT4=;
 b=okSmaLq3Mu7uU7dUerUjWtavAzz+qd7UeIXUy25RBrQO+GlvmFLmQMJW0vXFFsDJAg3Uzf
 Rwa9BrNDI+gNJaSwZkk0N258IrBE5H2UR1m8ZVIfSY2LDPWPZTvae+feaApkOjT5c8COf6
 +sf9eNFFyZeffDHW7Ub09AeiFykw2rWPpEq7eAJ+tByk6CcKxBSSlz55K4Puelr3ghvJSa
 DyJCDwyhLnO+EfzSK/agKs3Pf4zC1NkS9Nr+3dgzj5EOdnExqHYnfmZ5vft+VwcrfHBXWy
 FpnLtO0ss2Hysn8dnyL8WzdXcJjbRQYybxogV8Yb2hth6KiC3GN3p63JHF32Jg==
Subject: [PATCH v6 3/8] mm: add a set_page_section_from_pfn() helper
Date: Thu,  9 Jul 2026 19:25:15 +0800
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <x86@kernel.org>
X-Lms-Return-Path: <lba+26a4f857c+7bd4b5+vger.kernel.org+lizhe.67@bytedance.com>
In-Reply-To: <20260709112520.24857-1-lizhe.67@bytedance.com>
References: <20260709112520.24857-1-lizhe.67@bytedance.com>
Message-Id: <20260709112520.24857-4-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
From: "Li Zhe" <lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
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
