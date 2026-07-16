Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C0240D564
	for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205837; cv=none; b=Vq9BZElwx22NFhJp0bFubdpqMvCPwSwtJeEzM0MXwUeNFnKDcUYOSjOLuOebDCFTyBQSkC9bgKPXnEmE9AvSSQo+Ousxm9ZigKbX45HaqNWVCXpBVZX3gSTPdpSqowEMn93rcHboCdFHVOZJQNTHbXBVdeyNGE3h7d4brIxSp0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205837; c=relaxed/simple;
	bh=90nS3q4DtnsYAyUyFabfkm3foM3+3QOdYnVlr+MPWhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H1OcVgJSWWpPbPvGborcTYvMCFfqABDNqv9G9WB+ijuPfh8J3THKqtXXgwj2LJEEa8uMiY2+q0bgddipKZLpdto2eLZI6Lc3NPoSNpexdvWPtymNpp5z9T5UzNrinjXnSRbeUc9JXianGHT3KRnEeuf+ltzKyPNe5o1yv4OKWzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LHQ5UwQN; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LHQ5UwQN"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c999f162c9aso4162246a12.3
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 05:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784205835; x=1784810635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wO7rgHUMjvOOREbomqim3hRFXtwbnBvZKsCnDiin3lw=;
        b=LHQ5UwQNIf/GJkpohzKV5XQoQrxPWGPirBss/d4VcG/+5OpbyR/WeSHPbyBY1SsZv0
         1m61k69AYNpVglRebg2jjshqg9IEbKrpzH+8Fx0orFDIFtxNtoYOOfx36dwWCR2LpjdK
         Vu699vFjZMbQrCCUsnnTVnBhemixvPbZam/wKUME2NUlHkPK1ejPKZli4XxYQe1mqPql
         3l6WsxnHEzkGsTLDxdldqgEfC1F/xL/4LWg8w5Lx+/Px0F18aPbfQ9U2jsM08yPSqnBG
         SWnWmCQ3vaC1dUdF/51QRQMp0QJwZkPqFPMqpY2FLwCVNW0UNtiye/uj6kEVUdavI+cQ
         Y/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205835; x=1784810635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wO7rgHUMjvOOREbomqim3hRFXtwbnBvZKsCnDiin3lw=;
        b=JxGo1S4MxCranRQk9OZUq3VOqumaEgHFc0neDOArDFtujpMgvxHefLDwV+4USZVf9n
         d/WXiJ2r1xgAQzrSFuallGCdJqPb4qdQZEzV5gVM10Km/53sHShfCbaZoWKw23zQwF92
         bxmvxpq+zGGBS806QeLjv/tfjnk56uz7FnuTet9iIwBvsTQdXos12Y28vyYIw5a7vfr3
         egXjQ/1MhXpfEZaY29bbFnUXmR1Bp/Vm/plL+GPKdIntr7OkDG1ODmUUSb+95svxcOOa
         WlcAmZXO3N7XGGaiWQaB/IGygp1CQACHzVGqkkyKGnJr2h6wkByND/oP1pFKLncLccuX
         oZtA==
X-Gm-Message-State: AOJu0Yy5m63gAvR6iLNZq0vEyyP/Q0S5bmq3Y+ZQXIPXd9Adk56m+RZu
	2UPlEUTPe9sWrpQRepTQvIAHrJr4MtdKfBTfp47LhgB4BWG51dzjLvDjdZ9eW/CvDJw=
X-Gm-Gg: AfdE7ckyK4oH5DQTn89Bv8fz5mzNYZIF21WWcUqrGouKNXeOeBZdDsRQS0sHzFjbmgS
	gkw1gnBgD4bODPAfO1Q4uDwgkq3hpEXv8psduftkEKXb9DWOIioeiYlIosHKhL748XA6QFpaPP0
	4ayNcYN7GzY8iRJY7I5KYqolqeUIiY98yf/L2bcT5feBhs/so8BGhv+M8sFg3AC7RM4nDK/Bjsg
	/BHTB67kd3uz/NSPgDIsbzjd9jKZpqWLZFJxq2WIpmg+bP35EHy2c616f3TocjZzQN10ig5SxJ5
	YcO7EmY97mU25oh8MkhKzKKp/Cb7fbEJJpSRZoqO4JmxuNqaRVCuUoUODb16/JuZcNK4ADJIXUw
	NnN2+mL9KByKGJmVb6cvDXkv4qWYhb4wBY1MufxJovVLApNpijG+RMwzF85MI6R8UCkNyybrmqS
	/JmgJBmfwdrzZ/mGIrf4k6/wLnj7HdRGTk7g==
X-Received: by 2002:a05:6a20:20c3:b0:3c3:859b:c20c with SMTP id adf61e73a8af0-3c3859be277mr3653741637.15.1784205835267;
        Thu, 16 Jul 2026 05:43:55 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([2408:8606:1800:501::2:f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eeaba2sm1730793a12.12.2026.07.16.05.43.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 05:43:54 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: linux-riscv@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v2 08/15] riscv/mm: avoid redundant Svnapot A/D aggregation
Date: Thu, 16 Jul 2026 20:41:43 +0800
Message-Id: <66e43057442a0f37e0c7348016ccef382387898d.1784201104.git.cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <cover.1784201104.git.cuiyunhui@bytedance.com>
References: <cover.1784201104.git.cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Svnapot mappings encode a 64KB range as a NAPOT PTE block, while the
public getter returns a logical base-page PTE. To preserve that PTE view,
the getter folds accessed and dirty information from the whole NAPOT block
into the returned PTE.

This aggregation is an OR-style operation. Once the returned PTE has both
accessed and dirty state set, later entries in the block cannot change the
result. Avoid reading the rest of the block in that case.

The lockless getter still validates each entry before consuming its A/D
state, so it preserves the self-consistent range requirement while also
avoiding reads that cannot affect the returned PTE.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/mm/contpte.c | 60 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/contpte.c b/arch/riscv/mm/contpte.c
index 9ffdffdc2b0c0..70f9a0668b50c 100644
--- a/arch/riscv/mm/contpte.c
+++ b/arch/riscv/mm/contpte.c
@@ -309,10 +309,34 @@ pte_t napotpte_ptep_get(pte_t *ptep, pte_t orig_pte)
 		cur = READ_ONCE(start[i]);
 		if (!napotpte_is_consistent(cur, orig_pte))
 			return napotpte_subpte(ptep, orig_pte);
-		if (pte_dirty(cur))
+		if (pte_dirty(cur)) {
 			pte = riscv_pte_mkhwdirty(pte);
-		if (pte_young(cur))
+			for (; i < nr; i++) {
+				cur = READ_ONCE(start[i]);
+				if (!napotpte_is_consistent(cur, orig_pte))
+					return napotpte_subpte(ptep, orig_pte);
+				if (pte_young(cur)) {
+					pte = pte_mkyoung(pte);
+					break;
+				}
+			}
+			break;
+		}
+
+		if (pte_young(cur)) {
 			pte = pte_mkyoung(pte);
+			i++;
+			for (; i < nr; i++) {
+				cur = READ_ONCE(start[i]);
+				if (!napotpte_is_consistent(cur, orig_pte))
+					return napotpte_subpte(ptep, orig_pte);
+				if (pte_dirty(cur)) {
+					pte = riscv_pte_mkhwdirty(pte);
+					break;
+				}
+			}
+			break;
+		}
 	}
 
 	return napotpte_subpte(ptep, pte);
@@ -343,11 +367,39 @@ pte_t napotpte_ptep_get_lockless(pte_t *orig_ptep)
 		if (!napotpte_is_consistent(pte, orig_pte))
 			goto retry;
 
-		if (pte_dirty(pte))
+		if (pte_dirty(pte)) {
 			orig_pte = riscv_pte_mkhwdirty(orig_pte);
+			for (; i < nr; i++, ptep++) {
+				pte = READ_ONCE(*ptep);
+
+				if (!napotpte_is_consistent(pte, orig_pte))
+					goto retry;
 
-		if (pte_young(pte))
+				if (pte_young(pte)) {
+					orig_pte = pte_mkyoung(orig_pte);
+					break;
+				}
+			}
+			break;
+		}
+
+		if (pte_young(pte)) {
 			orig_pte = pte_mkyoung(orig_pte);
+			i++;
+			ptep++;
+			for (; i < nr; i++, ptep++) {
+				pte = READ_ONCE(*ptep);
+
+				if (!napotpte_is_consistent(pte, orig_pte))
+					goto retry;
+
+				if (pte_dirty(pte)) {
+					orig_pte = riscv_pte_mkhwdirty(orig_pte);
+					break;
+				}
+			}
+			break;
+		}
 	}
 
 	return napotpte_subpte(orig_ptep, orig_pte);
-- 
2.39.5

