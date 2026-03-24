Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A763FA5CD;
	Tue, 24 Mar 2026 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774358817; cv=none; b=A3Hwc+AKakKC4UIzy9kgh9/NjPCEUe6idErN/cHrzcrBqS6vw1nMwD+YdC3iD2ZuHql2M+Zbas/lX6502PsSa4vxvDUCX7sJzxOoDdhNLpaZI4dGYoMppBRiMuh7oN3kjifZklj1PWoaFB1a1Qk/yKwbOCDPMkX7GSkRUC85V80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774358817; c=relaxed/simple;
	bh=6NeQ5I/ff6UfPXauvKRLpzI5NjSjxiyGIQia/li5NEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oeHT3WMbE+VueT7OInNbvayYg0xmyNfTCXujbZgx8st0WA3G0uXk+s1qrrDwQB/xUyUXIVulgSyDNlQZ5ZwRAGJ7zGhflS1qKppPrY+sp5ax+IoouWqcKWxqCaUpa2zS+9e/R7m/xM2j+4vZdCtg7Jsxie5XoxQSfSEwBOcZYfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qz9/LE2J; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qz9/LE2J"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76496153B;
	Tue, 24 Mar 2026 06:26:47 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.1.194.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2EE9B3FAF5;
	Tue, 24 Mar 2026 06:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774358813; bh=6NeQ5I/ff6UfPXauvKRLpzI5NjSjxiyGIQia/li5NEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qz9/LE2JSIbVqazwJDD5xbnrNC8yrlPETODw0hoy5dMfyizDqY+VzFRYSDYSH/CKK
	 /c9GnUSEMsxDYg+JwKJvfdE3F6zZf3HzVb5xugM3CNuCzTEyDWJOiPTXlZP3CT4dzm
	 Fj5EDqeQR83LSB8bdK9Sen3d8QclJAhA7SuLh9v8=
From: Muhammad Usama Anjum <usama.anjum@arm.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Peter Collingbourne <pcc@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan.Roberts@arm.com,
	david.hildenbrand@arm.com
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>
Subject: [PATCH v2 1/3] vmalloc: add __GFP_SKIP_KASAN support
Date: Tue, 24 Mar 2026 13:26:27 +0000
Message-ID: <20260324132631.482520-2-usama.anjum@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324132631.482520-1-usama.anjum@arm.com>
References: <20260324132631.482520-1-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For allocations that will be accessed only with match-all pointers
(e.g., kernel stacks), setting tags is wasted work. If the caller
already set __GFP_SKIP_KASAN, don’t skip zeroing the pages and
don’t set KASAN_VMALLOC_PROT_NORMAL so kasan_unpoison_vmalloc()
returns early without tagging.

Before this patch, __GFP_SKIP_KASAN wasn't being used with vmalloc
APIs. So it wasn't being checked. Now its being checked and acted
upon. Other KASAN modes are unchanged because __GFP_SKIP_KASAN isn't
defined there.

This is a preparatory patch for optimizing kernel stack allocations.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
Changes since v1:
- Simplify skip conditions based on the fact that __GFP_SKIP_KASAN
  is zero in non-hw-tags mode.
- Add __GFP_SKIP_KASAN to GFP_VMALLOC_SUPPORTED list of flags
---
 mm/vmalloc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c607307c657a6..69ae205effb46 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3939,7 +3939,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 				__GFP_NOFAIL | __GFP_ZERO |\
 				__GFP_NORETRY | __GFP_RETRY_MAYFAIL |\
 				GFP_NOFS | GFP_NOIO | GFP_KERNEL_ACCOUNT |\
-				GFP_USER | __GFP_NOLOCKDEP)
+				GFP_USER | __GFP_NOLOCKDEP | __GFP_SKIP_KASAN)
 
 static gfp_t vmalloc_fix_flags(gfp_t flags)
 {
@@ -3980,6 +3980,8 @@ static gfp_t vmalloc_fix_flags(gfp_t flags)
  *
  * %__GFP_NOWARN can be used to suppress failure messages.
  *
+ * %__GFP_SKIP_KASAN can be used to skip poisoning
+ *
  * Can not be called from interrupt nor NMI contexts.
  * Return: the address of the area or %NULL on failure
  */
@@ -4041,7 +4043,9 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	 * kasan_unpoison_vmalloc().
 	 */
 	if (pgprot_val(prot) == pgprot_val(PAGE_KERNEL)) {
-		if (kasan_hw_tags_enabled()) {
+		bool skip_kasan = gfp_mask & __GFP_SKIP_KASAN;
+
+		if (kasan_hw_tags_enabled() && !skip_kasan) {
 			/*
 			 * Modify protection bits to allow tagging.
 			 * This must be done before mapping.
@@ -4057,7 +4061,8 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 		}
 
 		/* Take note that the mapping is PAGE_KERNEL. */
-		kasan_flags |= KASAN_VMALLOC_PROT_NORMAL;
+		if (!skip_kasan)
+			kasan_flags |= KASAN_VMALLOC_PROT_NORMAL;
 	}
 
 	/* Allocate physical pages and map them into vmalloc space. */
-- 
2.47.3

