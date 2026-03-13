Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C0E318EE1
	for <linux-arch@vger.kernel.org>; Fri, 13 Mar 2026 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408155; cv=none; b=WYpkx8JNwAZFEiWnuCTrdaGFybWie35Yktzf3whdrXV06WoHN0p3OqZyAvTZfqsN7cM7clJRbtTuxKa8jHfKZIUVXSqjMmsHYXjOjtwCsaYpGoe6UV28zCorneWd+aKqCi1n5z2M+CK/BCjrScDPj9xvHGdsHIlQERRQXZ48dwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408155; c=relaxed/simple;
	bh=IDRek7YZfB+4Kr1w0QgBbJ4cZK+zQPKPw+4cJp1INA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1WcIdIIt+R08yOOr4EL1h2rsP7xIjm+01QmmPKT8XVgOwS/71vJKkEQjbYrwCQHFbgMFue53MN4XjcAGijmaOTEdKJabDTyUNN3oa36MdYhRxtY0b5UJML+zI37Fem8teOSBi4jlHXgRngRQoX+WC1B2Yh52T0H4bjbMHMsNJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai4Wapwg; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai4Wapwg"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-464bc03efd8so1513984b6e.2
        for <linux-arch@vger.kernel.org>; Fri, 13 Mar 2026 06:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773408153; x=1774012953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7LRJl13Yqup7eJj7JB8u2raYRuugKEd6d7nm5DRaag=;
        b=Ai4WapwgseEQ6CVd+d3uDQyCFpY2RCuB77GyVqTYCsL5CAple2htyyXfmP5GKp8rxP
         vEQRdAE5Krt0yEif6tL9DWso3ScpEavh8bsk89zvzJnkXD/kxp2AG2Ji0iC0B7XzPTVU
         R4m5QzQJhDXOSg400VxP3JCgduQgpvrIXeo+wJUOng0Y8e4IY1wgKo/Nclw5UkgyDV9U
         T3ztz3aC74u+kCOm30nwc/N8qD31YHKyju5jBlmjzrQJlL3FJr3C7DEE/SSmd1Utwwa0
         41hDueJQB66DR/HPp00cDRTMft4idMgtpGdHkbwBsK/BXKrYTlsE9j2xNp/SjhmUW5O3
         raFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773408153; x=1774012953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J7LRJl13Yqup7eJj7JB8u2raYRuugKEd6d7nm5DRaag=;
        b=eRRu18G+aPVlF9ms4mhyqEuR8Kn9RuiUb6w4DP3xIohLhKk202ZnRCenVUuOQnswLE
         tpiW+zIO3tWHihUOmPITJOG20yVqGAfRVmXsOsfsLYh0J3hC8hyjsEelqIQg/5qEN/eC
         MLMIaGQagQ+RIGdatHcku3cGAEU5mSWBB8b/aDey4Ce5xymQxpcPwCNQm2/P/aBiDihv
         DgSm/uRlwFLTXxABqV3rJCa/Bh4aIQoThPz5RDA88Ey1m7Y0hq8g185kzMXeFnLDCkf3
         DygHZe/kfAdZHCcQt5IITL4xNd7TnIjXObhOzVMZau1OYXGpwjIFt4o6S2FSPFwp+3nY
         1zgg==
X-Forwarded-Encrypted: i=1; AJvYcCWjo0+th+reyxPLEt5D81ciYzRpVTqT+r+IpW0PXc7r4BycrImeEyXzJRejX0F4fghBIysHZejhbOu9@vger.kernel.org
X-Gm-Message-State: AOJu0YzUQLwPKB2TpvMjUCDx8DBRGypo8btIXvMKtTWTIobfHrlbf2OB
	VX1PNNvdoIDS7sx3zClUeK+oY5oirK6KVi+VodqGwgAWB6GzcsblpHLW
X-Gm-Gg: ATEYQzw8/Q8+JK96i8njdPWs08XJPhwSMFVW+0bjrC02hNk8VKT6usHbf5MN0xsh56/
	2EYsjQ4PPjkWqhLr3wMam/CVB4KPPSKW73OsUMnuBT7vJP5VgNo1whc8hm7WHnZIV0368sr96u/
	n/tR0yCtb2K7tjndOpHaXBR3pTtpSKHlN1L+jnaBE+P5YLTohRAZzef3PisWuBAY0PS+7DEb1qH
	8/BDs6VxZo2duc+h3xpimGV3YQ67vK/X9olMV2i90ifC0vF0gYW2oAyHZfPeM8sxLcMqu5Jjy5g
	STM94B/T93BRhdrJ8RXcGpXCIKBrCCcAvGBgbwIWujBjQIR2qCk4M0CKPeKaNyedn2tCO/R+RGX
	oUKBZU2+aWkX+ksLfW+Eeepx5eW4j5JZYY5ydWuxfcq+LkJ9Fo99LAh8TfV9/kcyrrr0enR1j2S
	xYw4uA4b3Qx+yZJY4IFykMkqpka47XGQHlq0JoREMbwLsleUU1
X-Received: by 2002:a05:6808:1b24:b0:450:d471:dce5 with SMTP id 5614622812f47-4675701babbmr1567747b6e.6.1773408152897;
        Fri, 13 Mar 2026 06:22:32 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:22:32 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com,
	simona@ffwll.ch,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>,
	mripard@kernel.org,
	tzimmermann@suse.de,
	maarten.lankhorst@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	christian.koenig@amd.com,
	matthew.auld@intel.com,
	arunpravin.paneerselvam@amd.com,
	louis.chauvet@bootlin.com,
	skhan@linuxfoundation.org,
	pmladek@suse.com,
	ukaszb@chromium.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v11 01/65] dyndbg: fix NULL ptr on i386 due to section alignment
Date: Fri, 13 Mar 2026 07:19:26 -0600
Message-ID: <20260313132103.2529746-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When dyndbg classmaps get used (later in this series), the
__dyndbg_classes section (which has 28 byte structs on i386), causes
mis-alignment of the following __dyndbg section, resulting in a NULL
pointer deref in dynamic_debug_init().

To fix this, employ belt + suspenders:

1. move __dyndbg section above __dyndbg_classes.  This restores it to
its original position directly after the ALIGN(8), and fixes the
immediate problem.

2. add ALIGN(8) to the BOUNDED_SECTION* macros.  This aligns all
existing sections using the macro, and also fixes a future
dyndbg_class_* addition which would suffer the same misalignment on
i386.  Many of the existing macro uses already have a preceding ALIGN,
these are now redundant, but are harmless, so are left to avoid churn.

3. remove BOUNDED_SECTION* uses in ORC_UNWINDER sections.  These have
smaller alignments, *and* scripts/sorttable.c does not tolerate the
added ALIGN(8) padding.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202601211325.7e1f336-lkp@intel.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index eeb070f330bd..a2ba7e3d9994 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -212,11 +212,13 @@
 #endif
 
 #define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	. = ALIGN(8);							\
 	_BEGIN_##_label_ = .;						\
 	KEEP(*(_sec_))							\
 	_END_##_label_ = .;
 
 #define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+	. = ALIGN(8);							\
 	_label_##_BEGIN_ = .;						\
 	KEEP(*(_sec_))							\
 	_label_##_END_ = .;
@@ -383,8 +385,8 @@
 	*(__tracepoints)						\
 	/* implement dynamic printk debug */				\
 	. = ALIGN(8);							\
-	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)		\
 	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)				\
+	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)		\
 	CODETAG_SECTIONS()						\
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
@@ -867,15 +869,21 @@
 #ifdef CONFIG_UNWINDER_ORC
 #define ORC_UNWIND_TABLE						\
 	.orc_header : AT(ADDR(.orc_header) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(.orc_header, _orc_header)		\
+		__start_orc_header = .;					\
+		KEEP(*(.orc_header))					\
+		__stop_orc_header = .;					\
 	}								\
 	. = ALIGN(4);							\
 	.orc_unwind_ip : AT(ADDR(.orc_unwind_ip) - LOAD_OFFSET) {	\
-		BOUNDED_SECTION_BY(.orc_unwind_ip, _orc_unwind_ip)	\
+		__start_orc_unwind_ip = .;				\
+		KEEP(*(.orc_unwind_ip))					\
+		__stop_orc_unwind_ip = .;				\
 	}								\
 	. = ALIGN(2);							\
 	.orc_unwind : AT(ADDR(.orc_unwind) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(.orc_unwind, _orc_unwind)		\
+		__start_orc_unwind = .;					\
+		KEEP(*(.orc_unwind))					\
+		__stop_orc_unwind = .;					\
 	}								\
 	text_size = _etext - _stext;					\
 	. = ALIGN(4);							\
-- 
2.53.0

