Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9CF3D3008
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2026 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175107; cv=none; b=aeCjeBEt9cTlpEfeQMdFUbxatLDh+s2MEd6zZqD8Hs1pOcOFX2K1NTdU03e0K28cbZCdHPpFWhqVSw0Nd8yNlMMnRSIzkiHxeEzazc7OPCwLFx1qPK9/XQsZl/J/7jKuthmvEprFdBsz/u6BxUebQU4sv5asYjoWs46e2RHjT6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175107; c=relaxed/simple;
	bh=TXr+PizXeUinczIJIbNEYY5V0bJAfItxsfEKmy4dDxk=;
	h=Cc:Mime-Version:To:From:Subject:Message-Id:Date:In-Reply-To:
	 References:Content-Type; b=eplgi+wCBQbBXhYVV+ivxQAXBKeSc55ib0PyOAIhw9KBNUbcFMpzvrBEXJuqYlhEq2LJBv6YUb/UOYFPYCPmtAEKGFKUubMvqWTwmAvYeYLfMRwChPDA7eTfV4I+mbPMhzQHQQkgf11Z4Vc0yVsi1fVx8YGErRhKxTTSDnMAQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=e6bQxNRc; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="e6bQxNRc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788175102; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=3cbkuNFC4N1fAhS6eNTbPmQJtMCLdt2nXyAfh98ZQIw=;
 b=e6bQxNRcHzCKsZZJZ+/iFaBsoc07y6qbZ1fxiy0HYE+oyhe2Q6ljMgr4mSeX+/YG1k7O5G
 9hx+K2/O8omQJcavD9JIu5pYz7aw5PBDUlO4tHIW0AUbxOtzRlUlvOC+ZduCXnNYkUvqdW
 nEIVJ7BasMyQfyIkY/lHIXscK9SQSpblfXlL2WSJWaPLg2QOdPrKVvIQgBq6m9+WSIck4o
 bUZqaMvg9ulHpeP88X/K36TKY1C4Y4ZIO8UaBhaitMRH2PwtwW6/Frph7OTUNoUFBHY3Qo
 xfnI8gjg36j3IrPDlpjc4W8p44dzoJ9hKt2ioDVS6Oiuz9EPGm9/SqVjw+sRaA==
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a9562fc+4ac6c7+vger.kernel.org+lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <rppt@kernel.org>, <tglx@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: [PATCH v11 2/7] mm: add a set_page_section_from_pfn() helper
Message-Id: <20260831111638.76012-3-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Date: Mon, 31 Aug 2026 19:16:33 +0800
In-Reply-To: <20260831111638.76012-1-lizhe.67@bytedance.com>
References: <20260831111638.76012-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8

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
index dd09c438fa23..6640c7522822 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2644,12 +2644,23 @@ static inline void set_page_section(struct page *page, unsigned long section)
 	page->flags.f |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
 }
 
+static inline void set_page_section_from_pfn(struct page *page,
+		unsigned long pfn)
+{
+	set_page_section(page, pfn_to_section_nr(pfn));
+}
+
 static inline unsigned long memdesc_section(const memdesc_flags_t *mdf)
 {
 	ASSERT_EXCLUSIVE_BITS(mdf->f, SECTIONS_MASK << SECTIONS_PGSHIFT);
 	return (mdf->f >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
 }
 #else /* !SECTION_IN_PAGE_FLAGS */
+static inline void set_page_section_from_pfn(struct page *page,
+		unsigned long pfn)
+{
+}
+
 static inline unsigned long memdesc_section(const memdesc_flags_t *mdf)
 {
 	return 0;
@@ -2872,9 +2883,7 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
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
