Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33A41F371
	for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205873; cv=none; b=XggOe1znHLMjJDiIzjafpmiCe3xzkiQuvQUyS2LaiBY6rEYXtZalxVEn+ESQZcsckbHrR1z/LFJt9w3EtrK9bNLTMLmJ4wenFu6mOdUvZUVnmikpGz/rXxubwzwvqj9wkd6cPj/kc1jpUngLlWjobmtLYRB/4AXrZCsZnVJGB5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205873; c=relaxed/simple;
	bh=z8jC4aCjR+Oesc+bLFA5i5JVDTkwm+Fh6FK3DV0FuyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BAOHP1Fs3DDv1XLhBWtj3+TcGMk8qgI2nLvY1VL4mMq+ilsNiKqiAfzJY6UVfDSl/r4s4kRmcgqKHh5RuS6mJRPQT9fcHxFvXddjlWov36q9pLOfRCgaiJzcbDaGWPZL/xQ5ERFKsIU3L8MdwF5gvjJw7wfblWZK2qdGNPTz08Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=C45IRpyv; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="C45IRpyv"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84a2dcec51cso5131609b3a.3
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784205872; x=1784810672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s0haKjxFEA+XqfWLiPeMGRklJhvkZG2bsdABvuKjaV0=;
        b=C45IRpyvX6HmHdRZR3ZZ+1wy3BA5jkkEbDBp8+0GIb3o9EyyKPwbNvHw2gGop+WH2c
         pJiaNzVp6Tniz9si9bxp1FJoCGkPE8k84euMkqm9kHAOFakSHiXZCDq0Q+XNGenmtk0X
         AcNSdJFQzBIV3POW6J76B1U56B9a2HCGgTukkQN1LtUpyVMDf+QoJHwDHIP6cYbYhScP
         4Dl8WlrRhjr4kPy3MarWxpCJp9GcpM6nLT8uYIJ1cgPvf+qJwvLg+0bPsQ6qcGg1d3A1
         k+9C/SiPoGlnyNUZlQMiavpIldAGPonCUQBrMKCOqletZW6U9r8Ivbrkc7cDS/RvKyUG
         xz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205872; x=1784810672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s0haKjxFEA+XqfWLiPeMGRklJhvkZG2bsdABvuKjaV0=;
        b=Yz0qVPKOoc1sr3OHnBdZPqk8KfACXaCuclVBs5Mi6OasHR47H3cwiV27iI8AYaImgF
         QbjafchU9kL6KOMYorXYJbcrJHWTDliku2v1X8s/olQZJ+KzoBmnpZd2Gzh2nys1by1Z
         LOai3d2JOI2kjEnsE+sLxCR/6hTEJ4o+uuXT/qbLnOlMOZ/tBBE7z+rfkZKG7kLGB4RQ
         MQkmfm296PsOChBgmitt8q6Pn4MwkM1NmehUKCOWGNc37vAHuAlgKAWGTPJz5X3fzoma
         DLTIIvgUm7uDFuGMMBLo9hobna9vloJ/2MD7xsHkzJwDzzL+Q2SZ8PE/pr0dJAs9hLci
         isAQ==
X-Gm-Message-State: AOJu0YxQ4cGlHTEEA4/fwSnf7MGAG73Jvl4lJBIfLvui1+02VnMbh9d9
	8CyK+pgZTs+7LQTsXWxD+SQUey/WtwWde++1BpdL5EbrUeoDGA3//sDO6NB2syZYF80=
X-Gm-Gg: AfdE7cno7Iwo8ZKRdmki9SsGvhuZ6hfZ8urStun2eaPvh552WiqUfmq9hU26hYGDZ0t
	EIEazcZm4tLB/Y1cbOQvJWWwr8df3/fFW2gIWc3gEmN9/iTolMQlzi4A7BcawxqmiAjzS1sI/Z/
	9/l3vfpiwZvrAnjERoCnKzXyICr6yH39iyfMf6UtxRHTheKbCXajKiuqukt7H6gWlXSi7stDCtU
	SshMiUJV17+4LIKfKQniAi5wQ2/cKjSu3r9bEj3Zw+F//cPSfh9vdDbknb4Z03ZLQC2fr8J76CW
	IXE8Yp+QDhMYKde2CDMd2s7lzBqOqhB2hxNAt3a3pM0Ep7NYzASA3zuqgQHASYJkv68dDEb/fdc
	I9/RtXzyNsa4Zix6rAAwybhLR6KiUuuSSEYY6+V/nRZSTErvzj6AtA5EBAj5SER+LdYm8HRXxh2
	y6XQ++ffv4F1YSQg3zgnlmc1b4yclYpOYnHg==
X-Received: by 2002:a05:6a20:e615:b0:3c0:9c19:6590 with SMTP id adf61e73a8af0-3c3576c37f6mr12235735637.74.1784205871769;
        Thu, 16 Jul 2026 05:44:31 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([2408:8606:1800:501::2:f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eeaba2sm1730793a12.12.2026.07.16.05.44.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 05:44:31 -0700 (PDT)
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
Subject: [PATCH v2 12/15] arm64: mm: avoid contpte A/D aggregation in fast-GUP
Date: Thu, 16 Jul 2026 20:41:47 +0800
Message-Id: <92fbae3247b4bf0d7989ba20a8763ecb836d0279.1784201104.git.cuiyunhui@bytedance.com>
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

fast-GUP only needs the PTE state for the current virtual address and
revalidates the raw PTE after pinning the page. It does not consume the
contpte block-wide accessed/dirty aggregation provided by the public
lockless getter.

Override the fast-GUP PTE helpers to use the raw PTE for the current
entry and raw revalidation. Keep the public ptep_get_lockless() semantics
unchanged for other lockless users.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/arm64/include/asm/pgtable.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 018781a1fcbee..d1e08dce9f7c5 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1760,6 +1760,22 @@ static inline pte_t ptep_get_lockless(pte_t *ptep)
 	return contpte_ptep_get_lockless(ptep);
 }
 
+#define gup_ptep_get_lockless gup_ptep_get_lockless
+static inline pte_t gup_ptep_get_lockless(pte_t *ptep, pte_t *rawp)
+{
+	pte_t pte = __ptep_get(ptep);
+
+	*rawp = pte;
+
+	return pte;
+}
+
+#define gup_ptep_revalidate gup_ptep_revalidate
+static inline bool gup_ptep_revalidate(pte_t *ptep, pte_t raw_pte)
+{
+	return pte_val(raw_pte) == pte_val(__ptep_get(ptep));
+}
+
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
 	/*
-- 
2.39.5

