Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC003EBF3C
	for <linux-arch@vger.kernel.org>; Sun, 22 Feb 2026 00:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771721132; cv=none; b=psdeucncR4P/ebuqYC28ar3DrOS5ApyTb0UJkGcbKa1XMAqTlM3QNjSfWWSWlc3erDSu7ebFlk3XJ+NueNAC8k1TnLOkluERoELMc4YhEf7VvZrc3GL95xM/UHJwvwvG6gdrzLwemb8HY0HN6Slgqo8Hb9zRDcavHcYe89F6ehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771721132; c=relaxed/simple;
	bh=BPbTal8l0cA6sV2OI7saRg0ii8m0Wn1YaxqEWJeOVzA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QyUAyWrJjn8g6cbMfuW+sdpZYAeBT7HUjO9FQzaovYq8c9tCXXTm2WcLsmfjqI9Sh76zNoxxuXqLP7E090k7sIBnTibd+bZAoZ0X54WbuWfLfi0rXLsfA5n1XDdCBvpBvvy10SgIGCFLdeCkyKDaZYmBpGcMIXUAz0xUiFZFOkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdqbNnm9; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdqbNnm9"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65a2fea1a1eso6924435a12.0
        for <linux-arch@vger.kernel.org>; Sat, 21 Feb 2026 16:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771721130; x=1772325930; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYGTIc7SD018JpENXhjw0YCEQOJiW9k0ZXQAJAzD2ns=;
        b=RdqbNnm9p8mfb0yzcrBrNErwh+cRzL48VSEJUCBr8/9+TY9+FQva77sS6XXGKt0N11
         Z5DQOjzvrHNZqyeZlehrb/HeZCAXNMeUgIbKtiwAhhhzCX85p8VhvCCe6vdTRG5lmRtH
         fzpYTGaTkIwySJUBEQHUu1ToCkr42A8cEN13khwZ+gBJLYmlZ+fB4iYzyUyxXaQcYM6D
         ZfmLZKzdkLK8/t0InJEg1I1W6iAdWBqdLFBHmLopUM/sQ/JYS+QJK8g7GiWALU4HmnKP
         W/6FKZyT0cFuDfJdADjHIPYhRbsApJUL4rKhBfGnrJHmPf3QyNA8/P4rGpI55697Dojp
         wWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771721130; x=1772325930;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yYGTIc7SD018JpENXhjw0YCEQOJiW9k0ZXQAJAzD2ns=;
        b=QYqw6vwiWMYUNxukFTxMsCa9AfenmbXMCO/t30uLX4oDsbf4UIpcYIEAIqWG9yarji
         KsKwxcT6GGV5c2inclxqupTwUvDT7dc0/6YmI+pDLeno9OzGj8h6xHwXLYc9ihv40nOA
         WTEVgugDL0fG7grsYMMsdGCMEUYu9jpcoG6kCUoNx9M3QH3owbguRkJJ3Yu59elJQdH4
         q9Xa9m80JJCOV2rBOySxx4F21splTiYpK71nU19ML+M0SHKipc3RUSshAXoeVGymK5n1
         47fzi3CtyPKTAsSMWhVje6IP971ve7T+0aU2yzxnx4zyH7YKf9XwG/+F1l4FDE0TRVuH
         bf9w==
X-Gm-Message-State: AOJu0Yws9R/izagx1kjFIbC1ceI77CbkrPuzeTsHFphwFsaIlvuQ7qQ9
	1+pXE9SMTtCZDA54VDbl4r4v9D09vuyDp04lSZ0souCz8TE0EElKj8t6
X-Gm-Gg: AZuq6aJgCh31d0ZXQte3qUHyU9vfHSfqgQunYwIrL2JHneMqM2l1+ApWUInHoFsh6z+
	Se5JC1xF6DX+WiVa1DI6jw/P4kwLiIaTLzRdl0MSWESgCLD2OwMMP8RjjoluGNrYo+yp4IRH/2U
	c6g+TdwIR0x+z4YwGH3rL+/GMV19e+8pxOnClBvn8LgxZp53kYW3qqhyNQFsgJTegO7ORY9GRSA
	SVtmNx14Evlkrry7q3+avVa8U7GhpSv30wxqWQGlhPMcrWUVL8K3L+3pSsVtTGdd2MhpFsbIrxa
	xPNGgi5MyAH8VLYKaEY/d8hY8rjwtarAJ1+sEzerK4LaZKNESyX0UZhivWtTfkdtp5Z9peCGMpr
	lSymFSaj8Ih/Sm4ItEs2p29z0pDLFPtb3tN/c27mEKayGHlR9ae9vM1LVrDxpCP2tilQ963c0lT
	P5Rm2ohXfvXTsA1KPeRtAj4Q==
X-Received: by 2002:a17:907:1ca2:b0:b8f:e992:3fc9 with SMTP id a640c23a62f3a-b905415c02bmr661118366b.6.1771721129445;
        Sat, 21 Feb 2026 16:45:29 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084c824aesm157564466b.19.2026.02.21.16.45.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Feb 2026 16:45:28 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: will@kernel.org,
	aneesh.kumar@kernel.org,
	akpm@linux-foundation.org,
	npiggin@gmail.com,
	peterz@infradead.org
Cc: linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	"David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH] mm/mmu_gather: define RCU version tlb_remove_table_one() in CONFIG_MMU_GATHER_RCU_TABLE_FREE
Date: Sun, 22 Feb 2026 00:45:12 +0000
Message-Id: <20260222004512.839-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Before commit 718b13861d22 ("x86: mm: free page table pages by RCU
instead of semi RCU"), the page table pages will be freed by semi RCU,
that is:

  - batch table freeing: asynchronous free by RCU
  - single table freeing: IPI + synchronous free

This commit introduce a RCU version for single table freeing to support
PT_RECLAIM. While it is not necessary to limit the RCU version only in
CONFIG_PT_RECLAIM. It is reasonable to asynchronous free single table by
RCU if CONFIG_MMU_GATHER_RCU_TABLE_FREE.

This patch moves the definition of single table freeing in
CONFIG_MMU_GATHER_RCU_TABLE_FREE, so we have both RCU version
batch/single table freeing if CONFIG_MMU_GATHER_RCU_TABLE_FREE.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Cc: Qi Zheng <qi.zheng@linux.dev>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>
---
 mm/mmu_gather.c | 51 +++++++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index fe5b6a031717..6c1cbd9c717b 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -296,6 +296,22 @@ static void tlb_remove_table_free(struct mmu_table_batch *batch)
 	call_rcu(&batch->rcu, tlb_remove_table_rcu);
 }
 
+static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
+{
+	struct ptdesc *ptdesc;
+
+	ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
+	__tlb_remove_table(ptdesc);
+}
+
+static inline void tlb_remove_table_one(void *table)
+{
+	struct ptdesc *ptdesc;
+
+	ptdesc = table;
+	call_rcu(&ptdesc->pt_rcu_head, __tlb_remove_table_one_rcu);
+}
+
 #else /* !CONFIG_MMU_GATHER_RCU_TABLE_FREE */
 
 static void tlb_remove_table_free(struct mmu_table_batch *batch)
@@ -303,6 +319,12 @@ static void tlb_remove_table_free(struct mmu_table_batch *batch)
 	__tlb_remove_table_free(batch);
 }
 
+static inline void tlb_remove_table_one(void *table)
+{
+	tlb_remove_table_sync_one();
+	__tlb_remove_table(table);
+}
+
 #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
 
 /*
@@ -320,35 +342,6 @@ static inline void tlb_table_invalidate(struct mmu_gather *tlb)
 	}
 }
 
-#ifdef CONFIG_PT_RECLAIM
-static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
-{
-	struct ptdesc *ptdesc;
-
-	ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
-	__tlb_remove_table(ptdesc);
-}
-
-static inline void __tlb_remove_table_one(void *table)
-{
-	struct ptdesc *ptdesc;
-
-	ptdesc = table;
-	call_rcu(&ptdesc->pt_rcu_head, __tlb_remove_table_one_rcu);
-}
-#else
-static inline void __tlb_remove_table_one(void *table)
-{
-	tlb_remove_table_sync_one();
-	__tlb_remove_table(table);
-}
-#endif /* CONFIG_PT_RECLAIM */
-
-static void tlb_remove_table_one(void *table)
-{
-	__tlb_remove_table_one(table);
-}
-
 static void tlb_table_flush(struct mmu_gather *tlb)
 {
 	struct mmu_table_batch **batch = &tlb->batch;
-- 
2.34.1

