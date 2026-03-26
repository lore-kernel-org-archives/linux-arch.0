Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD5F3A7586
	for <linux-arch@vger.kernel.org>; Thu, 26 Mar 2026 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560334; cv=none; b=tNpN9mwEu3/csOO06RhAVMOf6sFzCawn0hCYD+cGTY/bCBwtDtj6G2JL5JXAEEGdxR3DWUl5eKe8XCErBTC5la90a54MPwu09MzqQfRxKe9iTIRusnMQAxLlCEC4aZyTsO16g/oCQC/vwngtVmNuRMel0wvWg1b+3fH8WXkRa48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560334; c=relaxed/simple;
	bh=YJ12M66JVdOPpUyl/ZnRqsezMQxQSFmDChR9hjNAYhg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l/alDgHQFcRx0svqdR/xG6O4qr76MfZB1q6rSI7fOVGfYXtW5V0m6aDh/iY/xSRFkDLiL+zo+vetE5gViu+ENlcXItXZqipWRtJ/Nx9dXgaujaCMuNLetNxCM1cYm68H/xiX6UHQKSjP+y1eCxOZ7UhhiDs2bmt79+eB1ooPKtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hrulh1gG; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hrulh1gG"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-485c45885e6so12125495e9.0
        for <linux-arch@vger.kernel.org>; Thu, 26 Mar 2026 14:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774560331; x=1775165131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aGYiW8Rqw4kRzbw632ADCfNRFJHG+c2ihwrVrUq2DSI=;
        b=hrulh1gGqhNnuV8fxCE6id19q2iVakr4ShCWs7LspkNhac3nIFZ7p/VDmTR0B4Urn1
         G+7e+a7DM5dnjX9yT8M8dwczz66cIEIQTk41GH0q497fMdtx3UqKa4CwXEk8tnmRQtFx
         oUdHcb2mEAFTmswhO0/cy89+vNOfbwIGOgna3nbpGweDy+XU4W4HwA9J/WFGFfQUbl+f
         +OxHzc2ls8TqBFrYOIwLnX6Yum9z0V4hOdDzCBom7AAA9sYX2HgcZ2klSYpUrXIhRRo9
         0Rloep76eThZ44MuBVRGXEb1FakMaihGH/BLePmCRZcyZAGhya/ijWmI+CJnbObd/ufs
         Xbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774560331; x=1775165131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aGYiW8Rqw4kRzbw632ADCfNRFJHG+c2ihwrVrUq2DSI=;
        b=fLRWlefghM4uhJ16GCSy4oA8cuAqZ8070UjFv2nbjp0kdOPvrg5rhwxQqZfdgBbOfj
         yqA/5Ot1FP5TPDmCFqVs7r3ElIhjvh3azUCLFsd4CyqmX9B0IBLA/rTV2JwfJc3BV+pX
         qxqhxnZWwF6oB8m46K3MBaFXsKMdr2xvA4LFs54UK3nvAd7e40rXYfN5Fh9XMXR8VQSz
         +NdEL2e17Reug3LDmPmzLG3wyO5gJ8WMCN0PtqZQ2s+L9NEiMkfxFp9RexOJb91QyLDV
         Rdd+b95SW+PkGxDjw2dI/CmBFlfFy0vFpVFJVB/nMH/4/MLPenWbv9zTN/gE6VHbe6ou
         jNbw==
X-Forwarded-Encrypted: i=1; AJvYcCWIcdw2xls+aaRThq/c2/UefoamgNH2sPuC3StSHdvirwy+qnf+2uZ3XxLuvxvUwKHqpmZpAmc+oLWG@vger.kernel.org
X-Gm-Message-State: AOJu0YwvR5ZZeJhjexPQlnBXUrBCk8bE9FkHUQssgetlehWSV/Fe+Upl
	j3XgpfW3gorWhNmAqX0+QGECR0sus3cRA4KXnzG51yXcM9BdyHx668HfQINqea+MeDt5YeH3Hot
	AQigm4JsMKfsnyRBi4w==
X-Received: from wmsm27.prod.google.com ([2002:a05:600c:3b1b:b0:485:3b4c:3e34])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b1c:b0:485:6bcc:87dc with SMTP id 5b1f17b1804b1-48727f27c5fmr3066095e9.14.1774560330845;
 Thu, 26 Mar 2026 14:25:30 -0700 (PDT)
Date: Thu, 26 Mar 2026 21:25:07 +0000
In-Reply-To: <20260326-kflagstab-v5-0-fa0796fe88d9@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-kflagstab-v5-0-fa0796fe88d9@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260326-kflagstab-v5-6-fa0796fe88d9@google.com>
Subject: [PATCH v5 6/7] module: remove *_gpl sections from vmlinux and modules
From: Siddharth Nayyar <sidnayyar@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-doc@vger.kernel.org, Siddharth Nayyar <sidnayyar@google.com>, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="utf-8"

These sections are not used anymore and can be removed from vmlinux and
modules during linking.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/asm-generic/vmlinux.lds.h | 18 ++----------------
 scripts/module.lds.S              |  2 --
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index d64a475c468a..6f47c4c56574 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -508,34 +508,20 @@
 									\
 	PRINTK_INDEX							\
 									\
-	/* Kernel symbol table: Normal symbols */			\
+	/* Kernel symbol table */					\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
 		__start___ksymtab = .;					\
 		KEEP(*(SORT(___ksymtab+*)))				\
 		__stop___ksymtab = .;					\
 	}								\
 									\
-	/* Kernel symbol table: GPL-only symbols */			\
-	__ksymtab_gpl     : AT(ADDR(__ksymtab_gpl) - LOAD_OFFSET) {	\
-		__start___ksymtab_gpl = .;				\
-		KEEP(*(SORT(___ksymtab_gpl+*)))				\
-		__stop___ksymtab_gpl = .;				\
-	}								\
-									\
-	/* Kernel symbol table: Normal symbols */			\
+	/* Kernel symbol CRC table */					\
 	__kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {		\
 		__start___kcrctab = .;					\
 		KEEP(*(SORT(___kcrctab+*)))				\
 		__stop___kcrctab = .;					\
 	}								\
 									\
-	/* Kernel symbol table: GPL-only symbols */			\
-	__kcrctab_gpl     : AT(ADDR(__kcrctab_gpl) - LOAD_OFFSET) {	\
-		__start___kcrctab_gpl = .;				\
-		KEEP(*(SORT(___kcrctab_gpl+*)))				\
-		__stop___kcrctab_gpl = .;				\
-	}								\
-									\
 	/* Kernel symbol flags table */					\
 	__kflagstab       : AT(ADDR(__kflagstab) - LOAD_OFFSET) {	\
 		__start___kflagstab = .;				\
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index d7a8ba278dfc..23fa452eb16d 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -20,9 +20,7 @@ SECTIONS {
 	}
 
 	__ksymtab		0 : ALIGN(8) { *(SORT(___ksymtab+*)) }
-	__ksymtab_gpl		0 : ALIGN(8) { *(SORT(___ksymtab_gpl+*)) }
 	__kcrctab		0 : ALIGN(4) { *(SORT(___kcrctab+*)) }
-	__kcrctab_gpl		0 : ALIGN(4) { *(SORT(___kcrctab_gpl+*)) }
 	__kflagstab		0 : ALIGN(1) { *(SORT(___kflagstab+*)) }
 
 	.ctors			0 : ALIGN(8) { *(SORT(.ctors.*)) *(.ctors) }

-- 
2.53.0.1018.g2bb0e51243-goog

