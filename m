Received: from va-2-113.ptr.blmpb.com (va-2-113.ptr.blmpb.com [209.127.231.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDAD39D6E8
	for <linux-arch@vger.kernel.org>; Mon,  3 Aug 2026 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785741191; cv=none; b=qLLHR6okhi1Rg35uL5gQdQnBHa5llHuhE/EnbE8HFiL654BNWSmI8svdy5u9f3Ul6C+fp7I+S7deElzXhaVHeB8JDEkS6xpatpLOZ9gvUZ/M9WOk9S+wA6LwGcviqhcpGRqY86ads6YmOYIontEHC1D9VImPd41owx21CvIpv1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785741191; c=relaxed/simple;
	bh=DIf+MYJmJLsTk693QI8cPlBfvGaOnDkShI8XUbuFBoE=;
	h=Subject:Date:Content-Type:To:Cc:Mime-Version:References:
	 In-Reply-To:From:Message-Id; b=Ag39r46rdtNK+24jfeWhtXPVLZoGGYrSbfh3vuA5+xxLIcM8iA0qfTVOQqFTPmZZKaU70UBX0QZSr3N29rtPNMUjf8ngb0SuI1J1cVq8OCLSXze09nJhMhAfEobXLK8N3PIYwhmlHM/WplR9QAcXAJ6MzyWqWiDRO1Xl1nmnOoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=a77cGzyh; arc=none smtp.client-ip=209.127.231.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="a77cGzyh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785741185; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=noN9zN1awgD10Dy4RdMcJEDTTzNu8MQNGVp8sfEJ5vA=;
 b=a77cGzyheUK5x4Qrks8+8wwwFHSPTGxXLt+pCCVcaxhQejz0d9e7FTyTBl55Xvnm4ta60k
 qI/LO4DuaPlzwdq+ZDQf6nuVRcvK6OmzUxYn1QARjQm0wx/OePC5Optox2CYYZ0VSXGFHP
 p7k/nUzVJKXs2VT4ZV1GsvHhYujz0D+pmyL6a7iYbjnACQiYaNft5bcWjBLbHDEQLxfKxF
 8ibykQJV0YqWsLi+dIKQuY2t5lTvObUO61KSn3OSmq6kFuGmn3N94T/kMIr+vYucD+D9Dg
 ppzz+WUUA7F+9bh86PEx/B/wi2HW1QfPMTNBXeLGO1HU06NQirRX4yiNuJ8Nfw==
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a703f7f+ab0bdb+vger.kernel.org+lizhe.67@bytedance.com>
Subject: [PATCH v9 7/8] mm: use memcpy_nontemporal() in zone-device template copies
Date: Mon,  3 Aug 2026 15:09:28 +0800
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <rppt@kernel.org>, <tglx@kernel.org>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803070929.86075-1-lizhe.67@bytedance.com>
In-Reply-To: <20260803070929.86075-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
From: "Li Zhe" <lizhe.67@bytedance.com>
Message-Id: <20260803070929.86075-8-lizhe.67@bytedance.com>

The template fast path currently uses memcpy() for the actual struct
page copy. Switch zone_device_page_init_from_template() to
memcpy_nontemporal().

ZONE_DEVICE memmap initialization is largely write-once: each struct
page is populated once, and most destination cachelines are not expected
to be reused immediately afterwards. On x86, a regular cached memcpy()
can therefore incur write-allocate traffic by pulling destination
cachelines into the cache before writeback, and can populate the cache
with data that has little near-term reuse. Using memcpy_nontemporal()
lets this path request nontemporal stores for that copy pattern, which
can reduce cache pollution and avoid part of the associated
write-allocate overhead, while architectures without a specialized
backend still fall back to memcpy().

Do not add a KASAN/KMSAN-specific fallback around this call site. As
Muchun pointed out, special KASAN handling for memcpy_flushcache() or
memcpy_nontemporal(), if needed, belongs in the low-level helper rather
than in this ZONE_DEVICE caller.

No separate drain is added here. memcpy_nontemporal() is used only as
the copy primitive while memmap_init_zone_device() is still initializing
the struct page array. The ordinary stores that follow in this path,
such as compound-page setup, are part of the same CPU's initialization
sequence; they are not used as a publication store that tells another CPU
or device to consume data written by the non-temporal copy.

Therefore this call site does not need a helper-level drain for
correctness. Callers that use memcpy_nontemporal() as part of a
producer-consumer or device-visible handoff must add the required
ordering themselves.

Tested in a VM with a 100 GB fsdax namespace device configured with
map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
server.

Test procedure:
Rebind the nd_pmem and dax_pmem driver 30 times and collect the memmap
initialization time from the pr_debug() output of
memmap_init_zone_device().

Base(v7.2-rc1):
  Average of rebinds for nd_pmem driver: 244.28 ms
  Average of rebinds for dax_pmem driver: 273.31 ms

With this patch and its prerequisites applied:
  Average of rebinds for nd_pmem driver: 150.83 ms
  Average of rebinds for dax_pmem driver: 153.55 ms

This reduces the average memmap initialization time measured during rebind
by about 38.3% for nd_pmem and 43.8% for dax_pmem.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/mm_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 9691fa2a060d..bb2007806a28 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1101,7 +1101,7 @@ static void zone_device_page_init_from_template(struct page *page,
 	 * to the destination page.
 	 */
 	zone_device_page_update_template(template, pfn);
-	memcpy(page, template, sizeof(*page));
+	memcpy_nontemporal(page, template, sizeof(*page));
 }
 
 /*
-- 
2.20.1
