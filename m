Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0D8270545;
	Fri, 24 Apr 2026 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777035762; cv=none; b=QsWjdX3rSfNvt3s1JQvYhRO+wnf08nLWXpLw/IcwG8tyxxM1bv4KsDtoA+YbUgUW63cfv7K1+cE286en+/sN8gdL9qWfa04OjP8LeH5PzLGFgc/w0HvvkwwisId51QQPRg72rYp5AP8RKUAJdP+dcLUNzkUMxmhHUEJ14O2Vdl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777035762; c=relaxed/simple;
	bh=uOi1Rk96oeur1i6i7Mh3ItL6sBlXiIQnfqF3cWvMO04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WewWa5A3GMsRvEOcZm1iM0uadWEBhtTdfhzWxE8KiSK2ikfvqC1a6DvWlePKmFE5zWKgmApmemIvKDB+2J16xaBSyOsK0/yoW0NHo1/Q6hhttOUP6FFY4GMOPCnkbmMw1zgM5+gk0acRC5vYE1kj7tMFa5DptCFEhlEe+Ljj1U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mqr3co6o; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mqr3co6o"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54E8F1BB0;
	Fri, 24 Apr 2026 06:02:34 -0700 (PDT)
Received: from a080796.blr.arm.com (a080796.arm.com [10.164.21.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CAE253F641;
	Fri, 24 Apr 2026 06:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777035759; bh=uOi1Rk96oeur1i6i7Mh3ItL6sBlXiIQnfqF3cWvMO04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mqr3co6oZde7WmeQ7llcR+8DKaBN6lEdV2rzuhYWXuiAOG/rOW4u/uqnqvMcnrVT9
	 WNtGghnwtzskbxD0OblP/47MNHQJQeWXs7DPMybVKZtIhHS+GFf2mzbMd1Ey9XuzMi
	 vJHvOkfbleWtTQT86FCRDg5sXi0b91IgL4QhTL20=
From: Dev Jain <dev.jain@arm.com>
To: arnd@arndb.de,
	kees@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	urezki@gmail.com
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	tglx@kernel.org,
	usama.anjum@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 3/3] mm: skip KASAN tagging for page-allocated page tables
Date: Fri, 24 Apr 2026 18:31:57 +0530
Message-Id: <20260424130157.3163009-4-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424130157.3163009-1-dev.jain@arm.com>
References: <20260424130157.3163009-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammad Usama Anjum <usama.anjum@arm.com>

Page tables are always accessed via the linear mapping with a match-all
tag, so HW-tag KASAN never checks them. For page-allocated tables (PTEs
and PGDs etc), avoid the tag setup and poisoning overhead by using
__GFP_SKIP_KASAN. SLUB-backed page tables are unchanged for now. (They
aren't widely used and require more SLUB related skip logic. Leave it
later.)

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 include/asm-generic/pgalloc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 57137d3ac1592..051aa1331051c 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -4,7 +4,7 @@
 
 #ifdef CONFIG_MMU
 
-#define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO)
+#define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO | __GFP_SKIP_KASAN)
 #define GFP_PGTABLE_USER	(GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
 
 /**
-- 
2.34.1

