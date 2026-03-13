Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5923164C7
	for <linux-arch@vger.kernel.org>; Fri, 13 Mar 2026 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407503; cv=none; b=bcumKGmzyzCucJ/Bok1DGTPKtvh+6BfaOMieCquwTPNgFx4omXSHXRhOGrNa2VWGlwsDBSOD/uHIwwiUDc9LMz3JM7Qd86pIkCQPEZAEr3FiJ9Gy9Rjb7faJPG/ocsWYLlwyl4kSd4P2CZOPzLOrKi/VWLJz80/EBtgO6CJoaX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407503; c=relaxed/simple;
	bh=IDRek7YZfB+4Kr1w0QgBbJ4cZK+zQPKPw+4cJp1INA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObW2KSmJYAtr20a7e/q0nzbZ0No+xUyYGTcscFcuY7wlhdBah34LrflDp7+QT5ycp0vdfdro9XYdD2eOyCI/vLGEjStFVjMqNsUTqEn00H7p8Nq4P68n1hgGh9VCLj2sX7rlbO0Z4Z2fra+POGeedrZjfMHzmy430IlFX+e7vcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcvJ/Oly; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcvJ/Oly"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d73d6976adso1891895a34.2
        for <linux-arch@vger.kernel.org>; Fri, 13 Mar 2026 06:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773407501; x=1774012301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7LRJl13Yqup7eJj7JB8u2raYRuugKEd6d7nm5DRaag=;
        b=PcvJ/OlyC1eID0BVumFb1vdQIc7Tpwk7MkhA5KoWJZZGLhbgp9CDEARqi9nkFN2c+H
         Y4DpWCpav6wdFazEHUONGatxGgi8GAIct+Zab47SQXichAm3v1RSdHEC2F5ORBqfwti8
         H54PrnPdFDDzj+KECnOcENB/jUflFzn10Oj8K8sL2HxWUVZ+kXngZnFQCOWcQ4k1+HAZ
         7F/d5q8/DBfJT4hamDPw9h01FHHikrHsP6yjvRw1nzndPf7oclQEgFD1Lgz84/idgIh2
         PEQN3hKnlAAYz1a7vRckn2ujisQ2HVVVvm18Ay0wivzK8swKOXzQsguW7YMbyDkV+mCL
         F3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773407501; x=1774012301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J7LRJl13Yqup7eJj7JB8u2raYRuugKEd6d7nm5DRaag=;
        b=WTCCKBLkrXm3aEKFQmdx4yxW5BZHY2lEWuk0o2+ByuJ30TWoNVovOzO/L6+fZbkwAf
         v95LQF18NLId163+eXrvLnTOeqt0WUuhQqyZJxLZul1vOSYFnETe6SBjV0gCgF8/09Bl
         dKm9Rj+wOfx5AI9LxPZMRRuIhpy6TR8Nk8v9Vyk1diioJlrk097yhq85PpVz2h2Vjllf
         IJ5Vjm5Ze9AYswrGdTiNsFXu6sPFuwGQkpvqhsEmJSw5sKsMfuOL8vZSdx6ZKCsm6deW
         XH41ORXoRp3lTqWr1BjJ8Nl32r49e9D19IH8QAZTZnainKdPJoXS4Ocm8QW/dKb3LYDL
         Xr+g==
X-Forwarded-Encrypted: i=1; AJvYcCUSy/Mr67weNDwY1kawOBW6UuDWwFAqAvFHf0b8uUEs2XwzdHoZDiQkeo7Flzeu4px5xo6A+1Azg0/7@vger.kernel.org
X-Gm-Message-State: AOJu0Yxco2iTw3AWMEH/xzewqv1PzDpDFB12Pr3KjNodHu78OT7/HDOh
	Y5rDZmlr+3XGhqc/xi4vBcUeHq48kZPNjUJ+ihK4O7w0VbG+wSBZx51y
X-Gm-Gg: ATEYQzxS2/Xajop+mS9TQ4o//jZpM8rmDcoMJ0jmQ/aGwV1If2f5sCES87UaD7seXgU
	2HwPIMOnqVaneG+8tqPOaLaVr1qR0kcK4JPDoS5YIRZBS/mI6C793XCc+nMmnDGJupDOpcZjhyI
	Qe0ZqeYtnweinAkWbl/lMZnvFFoUBKo1G6h3DbMUraF7PNaY8K/bIBXq6LjwWz0LOmNFE7OM8sB
	N/RFv/z4bEPELE3/JBlSQjDzd7rgibP6gF2WdTTwUCxCHqb4O3RswYrNvagxtkdFWfbT6IK/oL9
	GJFidq/emRCmI+0JUODwOhMd1VapQqjOPR0Umx0f3vwbSObN8BZ/mXvWYFkzkQ9LV3QH+VmRzGX
	luyyGSa1Ul1CEuY1rocMgj6xnfQnFOm1SAZAKg6rZxsPprwLLTMUn6m/GCCsZtJccdgqjm8qQe/
	pBvKuXjR6zR9BAlobEE35kN1O7RUEY7pGLa/7feoYWbf7Rbt9X
X-Received: by 2002:a05:6830:258c:b0:7d1:586a:32a2 with SMTP id 46e09a7af769-7d78232b1a0mr2235981a34.0.1773407500985;
        Fri, 13 Mar 2026 06:11:40 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7d76ae90586sm6733728a34.22.2026.03.13.06.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:11:40 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>,
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
Date: Fri, 13 Mar 2026 07:09:08 -0600
Message-ID: <20260313131045.2526422-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313131045.2526422-1-jim.cromie@gmail.com>
References: <20260313131045.2526422-1-jim.cromie@gmail.com>
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

