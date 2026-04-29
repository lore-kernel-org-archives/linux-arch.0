Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE7C390C9F;
	Wed, 29 Apr 2026 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458501; cv=none; b=LMS8T9AYDHAu7XnaINfeGUjQfoAUSA9YWP/gtaBW8gWh+MkbExDfXSPwDoueAyfwva6ii4NGolDXbP6RMe/EhJglRQX7lX4bdixTW6UiebhxDA4X9xt5C0Q3arai7MU+JNwJF3eSen6sLslL1JmyQs9gB0QfHIaW+fRRs/17CZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458501; c=relaxed/simple;
	bh=Wk7w9lhH1k+YWbLTG0ALVUDnoHIRsitzS6tZ9UC4swc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aH+eASBsObfsp98Kzl6L8j66Z4h5Kx9o9zuzRw4A96/gW1hOsqBayd65/sMf5gFACw3YRbPCQ8e1vIjDE11V1jJ03qEgwR8qyFE9GpZJSzWjdJkGfHcUg17oS9qFIPRi15s4XuE8XnBrt2cOTJOUkesy8FzOQmk+obYxGAxG/kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=T6QBMkrR; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="T6QBMkrR"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBD562A68;
	Wed, 29 Apr 2026 03:28:13 -0700 (PDT)
Received: from a080796.blr.arm.com (a080796.arm.com [10.164.21.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EA4B63F763;
	Wed, 29 Apr 2026 03:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777458499; bh=Wk7w9lhH1k+YWbLTG0ALVUDnoHIRsitzS6tZ9UC4swc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T6QBMkrRy4jK7cyGHC88StfkMlvC7TKCLOf4uKVKSxH0q5oOE7SFbPc/FukftUdc5
	 s1nYC8B8aMvQLMUmQTHVG4LAktohXf0VpI1n02HmiFkLc7jEpu6EsiGLIfUCkWBrPh
	 ya7TyfdwFxyc1myoadrkLjQOXFWQkf9o6I9zkBfU=
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	urezki@gmail.com,
	kees@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	arnd@arndb.de
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	tglx@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-arch@vger.kernel.org,
	ryan.roberts@arm.com,
	catalin.marinas@arm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v4 3/3] mm: skip KASAN tagging for page-allocated page tables
Date: Wed, 29 Apr 2026 15:57:04 +0530
Message-Id: <20260429102704.680174-4-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429102704.680174-1-dev.jain@arm.com>
References: <20260429102704.680174-1-dev.jain@arm.com>
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
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

