Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CDB3DB620
	for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2026 04:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654594; cv=none; b=CfMLu2x7WNH2f1qJ1GCYjlZZmeahw/fbRhu+ziKB2vZr+WE6ykzsg2SzcBVLVRI6bd9/tL/3sIqQvVQVxF2VNLnuDp/HzAHMPPvgXiUAMHfwA9GdA9fPhGEh8XXF7gg2FrQJmG7m2V035kMGeXQyuWsL/gvaDWFwRhrCAyJts7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654594; c=relaxed/simple;
	bh=wfxZIiWhDP3+oFPqhctMkZvaOYbsAemH2FvdQjYIm9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ycd3YDnVxHGcGhO9DEGm0ZCHZ3FsZMgv+aXcKQVpCfu7YmGyI22qg2nhre4Qq2HlbzkOnohdiQp9PpXhHbRpWBjTTOq53cBPwfA9Ym1zFsqimtxgtrrZtqnwQ957OvOjHGHhyvuAiAleTc/L+vcjUw4UZyIbh1282PUM+AWQuD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fhItftJA; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fhItftJA"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3a0a55fa355so965395a91.3
        for <linux-arch@vger.kernel.org>; Mon, 28 Sep 2026 21:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654592; x=1791259392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H1QC7xolz0zAjMGBpXSuPAgwwtLmlzIMyVrA3dvqh9k=;
        b=flsCaBOeX0EHS6A6vIUyqn6SJ3ygy7hvF7rrXnhYrfPkIWHXsCv4QLOdRyBxDaZbnU
         sWx9xbElMxbgfpQ6pR4u53Fl5eCqirJZcU6PuNs7au4AvjHVEq9dZgaWIJp1dh+qJ2BC
         YmksaoUGs3uySbv6vKjFbzvnIo5gB0+zSOPQQhm5aiIeQB0517qfUwyIu6BM1VzlkqMt
         secBC5KXsOLVsPXopnOIOqFncJZvcX9kkbeiLxV1gWh/Vs79KM30PoCAlvyfxKZ/efCu
         wjX7ZA/R7S+q4Mjop81WEOLjB/XhnYwxD5Myh4rDvCIwM3gI2iDWPhQfLPrpkxrcmzJw
         fP/A==
X-Forwarded-Encrypted: i=1; AKwUvBzj18kf+hhSDsrv/biKUnbT1/edqs22FZF5HmGwk9XUtLIczZHVNoOOsQ3dSMe8cWjFUa/ieXT1c81x@vger.kernel.org
X-Gm-Message-State: AFq9FYI8m/VI2b6C9UznUxGsXsDQDYuAq18Oj4bJzfKF9LrQTdTk8Xoj
	Hp5PCuqj7PLjGZZSkpUU0ZNFryuABQJM2w+anyWLlAESfsKlogOPErpGbsxuhB0czZanbxWD1Mn
	B2kjssRxoMR2rqGmETW2zZBvAJcH+OHo/BBm52bkXfjSYobG2DU6nizhgCTrTsEnvxTkNDGo+Oa
	YXhx4nZrsMDgSbGss3zpiF7DhymAai1FnLe4qLmMqWjYpxrN063Aw6MurMOVHFJ+ztbyS3QY//U
	Ve9cTqERlj6Jw==
X-Gm-Gg: AYBFou3HUVlbyRZphRHkdG5LimlrbeweTI+oE1OElvo4n3CvGQoB9EFIl/XMzGDTypV
	X5spqc0kxdnBW7ff4Z716PqshS7ESR95Kro3MproXQeI6gyZSD5XJAVq/oBKqIxnmjO2LdBHZC+
	hUpNgauRe2jXjn7fir6wK6CRf1TedDYiu/FW1ZrBCQdyzxfo0jlKP67/U+fb/tiWB9MnL8CvP+r
	EyHV9aQ98qxe2EIpd+md4ljKcz37n3a46z5VVJIy8DgavB6F0LJckPlPie37OtOVHekVKoWZGgg
	9lIkaw3h9WOm7Q3pOawoC+sQ0yCHT3fergsCjYzPFI8vq6yCkB+RNVmlGl6SCxeuEEA5g4wwOwt
	QGr2cxF4s//MfW6ZBk2tf9/ncWRMeN7k2tqFF4i3/ri/50mdRtggTVWW2Z+CT2MyEGleRSS6UGD
	1RJ+gt8KlFKlCbbuu3oZt5t/T2kGGDCWGF
X-Received: by 2002:a17:90b:5410:b0:3a0:ac34:f7be with SMTP id 98e67ed59e1d1-3a0ac34fc4dmr8666475a91.4.1790654591570;
        Mon, 28 Sep 2026 21:03:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a49835dfc6sm995811a91.6.2026.09.28.21.03.11
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 21:03:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-342217d8d53so12162270eec.0
        for <linux-arch@vger.kernel.org>; Mon, 28 Sep 2026 21:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790654590; x=1791259390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H1QC7xolz0zAjMGBpXSuPAgwwtLmlzIMyVrA3dvqh9k=;
        b=fhItftJAmbd5w4nLldXjYdujimhcBno2xM358LQIK+THcQYYx0bt6TiEyG7gjmcGLR
         tDCMg3L/hdbu05TXXFgxfWQdgxGwCtTmbKr/CGmO/TOVU0FLsjPHPaN7N110tbrJWY8/
         ADsyxvJ6pEHue+JcxGxeRU2wukWIvSLNR2IHg=
X-Forwarded-Encrypted: i=1; AKwUvBw4K+P58qopoYo6qcnTn2hVkntg4AsAeVrz0w22As8Xta/2EzI2bfASxgLdmykwIT8mDUGMAuK08GWX@vger.kernel.org
X-Received: by 2002:a05:693c:88d7:20b0:344:c0fe:19ee with SMTP id 5a478bee46e88-344c0fe1acdmr7715257eec.14.1790654589502;
        Mon, 28 Sep 2026 21:03:09 -0700 (PDT)
X-Received: by 2002:a05:693c:88d7:20b0:344:c0fe:19ee with SMTP id 5a478bee46e88-344c0fe1acdmr7715216eec.14.1790654588762;
        Mon, 28 Sep 2026 21:03:08 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347323f5a7esm10952571eec.15.2026.09.28.21.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:03:06 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Kiryl Shutsemau <kas@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bo Gan <bo.gan@broadcom.com>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 1/6] percpu: Page-align decrypted data in UP kernels
Date: Tue, 29 Sep 2026 00:02:50 -0400
Message-ID: <20260929040256.543767-2-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929040256.543767-1-zack.rusin@broadcom.com>
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Without SMP, DEFINE_PER_CPU_DECRYPTED() places variables in
.data..decrypted. Align both ends of that section so that changing a
variable's encryption attribute cannot expose unrelated kernel data.
Keep the section in permanent data, where UP variables are instantiated.

Fixes: 000f8870a47b ("vmlinux.lds.h: Fix placement of '.data..decrypted' section")
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 include/asm-generic/vmlinux.lds.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2988aa12f66..64bc2bfdd2ec 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -368,10 +368,19 @@
 /*
  * .data section
  */
+#if defined(CONFIG_AMD_MEM_ENCRYPT) && !defined(CONFIG_SMP)
+#define DATA_DECRYPTED							\
+	. = ALIGN(PAGE_SIZE);						\
+	*(.data..decrypted)						\
+	. = ALIGN(PAGE_SIZE);
+#else
+#define DATA_DECRYPTED	*(.data..decrypted)
+#endif
+
 #define DATA_DATA							\
 	*(.xiptext)							\
 	*(DATA_MAIN)							\
-	*(.data..decrypted)						\
+	DATA_DECRYPTED							\
 	*(.ref.data)							\
 	*(.data..shared_aligned) /* percpu related */			\
 	*(.data..unlikely)						\
-- 
2.53.0

