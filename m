Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F1141F5FE
	for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205900; cv=none; b=cw1JZt1ht8sEWnobUpFwpdH/Ze0nBVv2UPyuwD2fx6nD82Fr1QjqZEKPNQgIbjzLFrtkxUaNa0dqtyB6GTFiPC/mW6uIM1hcDvveBUlwkBdpqhOLgEz2sb3dgRQtThcmbQE4GOmcDxuVujBb5Nsej3R0/lKHV9qUw+bRBnTbPVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205900; c=relaxed/simple;
	bh=ybAp/Hmnc3TAueG66xnodqF9+Bp3yZdy6u6JbQGTD4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i967Y7jEv4q4ZJBLhV5I3PeQd4u2hX04WOpvZgaY3pe1CsVc0ZhWN41x+z0coK00m2q208Oy9Ids7Tolmh4RTapYWIxHd075bWP7e8sGF1euap2MR5JARl/+365x8F4G2xy2ydF24O161AMsVK7npBYktcbPkAULa1VcsJ50iPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MUbSTRUR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MUbSTRUR"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc73e322dbso79983325ad.1
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 05:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784205898; x=1784810698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=igNuDXnwdUCT2dm/vIcI/M9kQJ6fMwWaxma7wgKaCpI=;
        b=MUbSTRURVANI8QAKE7ELCYR0rI7ExejRVAjeV9XMDIhl5okUOjsWO4JBdblNUhYmtH
         ppZCrNRxUk/330nLIPhHo+fI5J7cJCukbhaGP807E9LqxMy/bkaVJlicpb5Hjf8yXYl+
         PTpc2IF71XhO4uJ5QPFicMgiSMYwV3BPjtsF6IntBi05yOsDRQJq8vh0d2fD+NxHLidh
         wqbdlz3QrVgO2dw/WO7ATLh3cBaJ5YUZHLaM0eGXOPLxS3VCeRW3IVMv/kiull43rv0F
         UqXNjc7ykwlt10+k986cuFuk1GZ6hnGni/37BVT4BjOQxTvkEWmsyFXXWca6MZ4ce/v3
         Cc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205898; x=1784810698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=igNuDXnwdUCT2dm/vIcI/M9kQJ6fMwWaxma7wgKaCpI=;
        b=qQ2D4w889ZnVyESkq+M94N9w0UwMoii7GSr2DDHFmXO4gSuDP1foPEelq7AtagcKxB
         FErItAQJmCIzOGqeeAOmGu26f2mGakD6j4Peo9encr2fh0Xxd9TFd6bqYuoNiKPA4jOR
         rdQDXoVZXtm3e6k702a3XhpllFdmDtjeh5ppOe8dxrZp8E6qOlbXzXK1wmiYXpo0LfFc
         8RvStN0SYybTgRiDydBIJB+RFbCP3QSX/IwTLWFEjoqAQAntWO7wfrIXi7UOlsLhQMzl
         JPJpz5UafzCGo2N/sle2EwyvDTRqlUWcwcWlBoIH1KCNrkrXcWflZtpnc3eKWD0bAYCm
         3w2A==
X-Gm-Message-State: AOJu0Ywj+isQJCBlanrJYKh2FyZ1sPnPRjHdkkXJ3yv3E+sAltKHplgi
	dEE94IYXJ1RzQg7SMH3wC64HM8UmehO96O5YEQ4h3Pyz2ti+sEjVnIAT8PrV+jtAhRQ=
X-Gm-Gg: AfdE7ckL0JY7RvquHNG2PGxFBIA+KNFalnm9RZATqV+Cs2bTXCa2dgBK276BVl5ECGA
	G4owGEcJCdJkK1D4opQel0rbRNN0t29aKdRKW+0lZ/TMk+3pIQ0UqRUlyEc7MGagITtQbTI0yu6
	eMvIti67HDCAe3nmiJ3HTSLmA+vjwpxiTrP3mhR7n+ZC3oScww8uZM3qKihIWb1LM02fY+5upQS
	uhuKBsFVmZgFSD+Ti1bwYoC3L5CEiD+HGj/DMRuLiEcB+5I+M9sr0ACzc+5faiUAVKZfJyC+e0i
	rFxUX3+LNStJ1H7PJwBihYnN8Ow5Dzv0Q7X6hjjX+G6/cMTKBRx/i+nINc+pDM/MpSEyG3lVJaM
	rxjVF4F3xW54IRTmrTNy2sOUF7t2kdGy26eDlui8ZEUnQpYseWWl+n2aaz06MGc24f7LTtQJi6V
	PvHss0+9Cgh9h+x16Cg4kUwYM=
X-Received: by 2002:a05:6a21:7318:b0:3bf:a881:4094 with SMTP id adf61e73a8af0-3c36c35d245mr7182183637.50.1784205898111;
        Thu, 16 Jul 2026 05:44:58 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([2408:8606:1800:501::2:f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eeaba2sm1730793a12.12.2026.07.16.05.44.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 05:44:57 -0700 (PDT)
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
Subject: [PATCH v2 15/15] riscv: mm: Request large exec folios for Svnapot
Date: Thu, 16 Jul 2026 20:41:50 +0800
Message-Id: <88438f09b79ceab1548aff17384814b7f699a43d.1784201104.git.cuiyunhui@bytedance.com>
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

The Svnapot MM support in this series allows generic MM paths to operate
on folded 64KB executable mappings while preserving a per-page public PTE
view. To benefit from that more often, executable file-backed mappings
should be faulted in with a folio size that can be folded into a Svnapot
range.

Request 64KB executable folios when Svnapot is available, so executable
text mappings are more likely to be installed as folded Svnapot blocks
and benefit from lower iTLB pressure. Keep the default order-0 behavior
when Svnapot is unavailable.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index b546e6614c558..6801ba135c483 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -296,6 +296,14 @@ static __always_inline bool has_svnapot(void)
 	return riscv_has_extension_likely(RISCV_ISA_EXT_SVNAPOT);
 }
 
+/*
+ * Request executable file-backed mappings to be read into 64KB folios when
+ * Svnapot is available. A naturally aligned 64KB folio can be folded into a
+ * Svnapot PTE range, reducing iTLB pressure for executable text.
+ */
+#define exec_folio_order() \
+	(has_svnapot() ? NAPOT_CONT64KB_ORDER : 0)
+
 static inline unsigned long pte_napot(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_NAPOT;
-- 
2.39.5

