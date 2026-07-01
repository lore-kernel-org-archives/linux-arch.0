Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3C3F39F1
	for <linux-arch@vger.kernel.org>; Wed,  1 Jul 2026 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896885; cv=none; b=hP0i4/8ojRgZCMarPsDiNRoBwnF+3ZjX7bEszUjbHZJ+MM9+JQrdrlQd0dDCTlku3sOULql9HuFvQ69aY57cuAOryHMhoH0hBLMHHy/IXbrOtWadp86hBiO7esYc7rT2Xi3Mz+aT3ZOQmFeJp4vVbtMmCzhK43Cu9jl6B4BfiM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896885; c=relaxed/simple;
	bh=NUwCnRy/3ZqHOyHaU3MDDZcYWvWKTMcNvZeLw8y5cw4=;
	h=To:Cc:Subject:Date:In-Reply-To:Message-Id:References:Content-Type:
	 From:Mime-Version; b=rHe6Q+mhYjBZfH3YBvTY5b70CC7k4AasV/mKkT+OIqyvyXztlj6g12PIVn4noq9yXBpMhx7mCn0zarBV+u8K3zmTnu8t2NFocN+51n/by0MZ6XeDKHE5U2Mu5SnGZbRyG8CIUR/sE1cRX7rdlsLGrf+3ygYckRaYioZzNmcyxZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=e8ra4vnc; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="e8ra4vnc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1782896876; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=yhHRPns26kjobDeVTfdIaOXkLcuTqZreUPTw3762+fo=;
 b=e8ra4vncVN2meEBGW9TJ+NnnnlAEBXIb/VP5DcHQQ/QKVfpkCHdcNT9OChqzhxWttFQZQc
 oRD02mEVjcOGt2GbJCfXmzqQDJGxhhO66ArICAJ6QAeKWEk8gjgx+KiaksBM7nlZCXSilx
 91rtd7crFYPuLr3VoNV0QcCjrWTmUbMHtUZYaZhbUDHVYwvZ/Rl3/dKayD6pPaTsWU8NL5
 +a40SE4gTTQVMXGAJ2rebTbfSDgrT/rj1Vr1I7VfMve4geWaYGD4vWrK54AXZlsXXIu3lf
 tPOxCcFh3iZqBs7OS3NEPnE5bZbi/uE0DS0fBMK1bNlKtn42YUWUZlN/NhwTqg==
X-Lms-Return-Path: <lba+26a44d8ea+3881cb+vger.kernel.org+lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Subject: [PATCH v5 3/8] mm: add a set_page_section_from_pfn() helper
Date: Wed,  1 Jul 2026 17:05:48 +0800
In-Reply-To: <20260701090553.62691-1-lizhe.67@bytedance.com>
Message-Id: <20260701090553.62691-4-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
References: <20260701090553.62691-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
From: "Li Zhe" <lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Li Zhe <lizhe.67@bytedance.com>

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
index 485df9c2dbdd..f78afa63dd3d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2541,11 +2541,26 @@ static inline void set_page_section(struct page *page, unsigned long section)
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
@@ -2768,9 +2783,7 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
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
