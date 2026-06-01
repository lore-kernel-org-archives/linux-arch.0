Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7742C377ED9
	for <linux-arch@vger.kernel.org>; Mon,  1 Jun 2026 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315511; cv=none; b=aws7lHyRdwXcpVRO34C1BE9VmiLL0nrYGl5UdeZknH1F6opiv7IxgOdBxNuP+a/kXf+tYkzUbWxVnWbKaNhAyTuy/8a6W4neyxWZRgZNqe6uOlBjb7Cc2Uk+sD93cz6bTehUX3yRZe8x2VHQxXvAWI21P8KP9TRf8FI5w94Nm0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315511; c=relaxed/simple;
	bh=gyhl2dDHOhDRfo2EoLm//e3PBy86xHd/L/qSVe14+FQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I1IA/WpHRT51vyCjCjQKITGPkl6+9PbmBId7XqFw4ZklW+MMeDTHnyk3Gop7hIO6klK+UJb1+h3YAveUVgUJLBy4K8/d43FwDtWZvqrVtiJ9rl6hfmm0URTxVbYVhosFeTyopffZa3rm59pNGAGvpCeN3mXUow20F0h4uC9w3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tEGpYROC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEGpYROC"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so1651182f8f.1
        for <linux-arch@vger.kernel.org>; Mon, 01 Jun 2026 05:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780315509; x=1780920309; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
        b=tEGpYROC3b8WCnjNkq74IbPVh3VhTkKWIhG80fGP1fmEKfg+KnXM9yO1gHz3NOxfoW
         zqE7tJW3fsrnLvYSVTEAVNpbyIVfUQtL3XEXhqDT0zw+laN1w3hw+IveJ1aV2QWOMmGa
         +UU+aAMi1/G1SdLc7/uuGznVGII1V4BScfdziBygVqAsjl820SxueggGKeC+k8tKPT75
         sRSLiy+Uvqw/100ZOTUL5j0p8ccb2n/H2p+XUTK5H6xD0xeGwWCA4ahuptlQ8iDctBnN
         mx93C4H5XgdweueMnuPuczAdueT1f3o9FUTLu7DkTKCXPIzO3QM+00MWxMMKpidGoZ/J
         CHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780315509; x=1780920309;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
        b=nNpo1JWbS1acXaPBeTqXhcAzkYYq4iUPaUE6XDyalMoptw8T3gdfQA6vufjXUl3kJ8
         yyb3Rmvsj0FUQ/JMB/qRx5TdrNdMK/VXZ51BFRPixJaSYFf3a8ykzdHViVFH3lO9tvFs
         7Ir0D9gSLeiheag11UlvUC2NFKT85oiTbhuvp6ujPx+M4Z3cDClHjOWdXVhGQwpNHAw+
         lHCb4IE9olTvivIjIwX35YOmHQGexfxYW8kP64DIhLT80bexD8uoxNIs1PvESWruhNzP
         YyQkKmo7QRSnGdib1AqxNHkOIN0pIoiyeP1I72NPshgcH4IvsXL25fBDhp7nVlWp5Eps
         V+Jg==
X-Forwarded-Encrypted: i=1; AFNElJ/SdLWz+PHr4eh+AIaIwcXNUeKGckZI67PDVwjLEqTjJMYltSSsyjfoFR/mtf0WRz5ZntaqyYW9jlVm@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbt292BgbxiHpgjrDgiPcDQTl66yEr65xnnZ2GQKL9M7LW5luN
	mEM1MZHz1VDMf42KVzw9g0qLPJ2FF7Uk/QZoXAvJO2Xjmqb2RQiJJHQk
X-Gm-Gg: Acq92OFxOck1tKxwWjwhzWiTW8u4CelFAS290CMHDc7baT6jJwTcSCf+aUg75rUcM60
	cgNirHCCm8l1Z5TEernCEVmYFntvPzoURCWg4fmUnd0d00cvRV/uPUabkbULY43gwNg5pf0Rkah
	E008/OrnDDCEEbkdkOZ9BiYVfZ+24Z2QVdtICxU9We3Yq5zPw/x5a64HFeT9ix5os5lV9cLwUYR
	YF5QsyI3TgqSOHY/frUQnE1Z3sOR2pPlto5VtGNF3v/sA7QkSWySHmDK5Plf5hK0iWx7QvJ+NYw
	khuWPWhVexOjSK8guG3u79qoZwROyCoIYA6v7abvSVOuq+8Sbscc2vTs3Tmh8BnRTUgJSdtMAds
	CnaD+JyT0DHxblrQUP9L6oiNwIOmAx50QDMTsVtaH3mT7UOAIK84yPR0fzhB567YpxM5j8i7qbz
	86oAJs83IN058QzS/KU8YvBnx2VOUr4UcUQ/i/6JzGaQ==
X-Received: by 2002:a05:600d:6443:20b0:490:a1be:6b01 with SMTP id 5b1f17b1804b1-490a2923a7cmr151516555e9.4.1780315508566;
        Mon, 01 Jun 2026 05:05:08 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:05:08 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:04:50 +0000
Subject: [PATCH v3 04/24] vmlinux.lds.h: drop unused HEADERED_SECTION*
 macros
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-4-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
In-Reply-To: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=1428;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=gyhl2dDHOhDRfo2EoLm//e3PBy86xHd/L/qSVe14+FQ=;
 b=odAHg/A0RFY+meA/TW8ZCLAdsG0OHafCZnPdBgvkp1M24pCVckS1yoK9eKlBI1667V0xBIsYV
 ww1XkipaWKzA8FtpuBJ3CTxXacOCF8vQ5ShKpVOzVqZfQjDgCRGbJXP
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

These macros are unused, no point in carrying them any more.

NB: these macros were just moved to bounded_sections.lds.h, from
vmlinux.lds.h, which is the known entity, and therefore more
meaningful in the 1-line summary, so thats what I used as the topic.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/bounded_sections.lds.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
index 8c29293ca7fb..268cdc34389b 100644
--- a/include/asm-generic/bounded_sections.lds.h
+++ b/include/asm-generic/bounded_sections.lds.h
@@ -18,19 +18,4 @@
 
 #define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
 
-#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_HDR_##_label_	= .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_label_##_HDR_ = .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_BY(_sec_, _label_)				\
-	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
-
-#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
-
 #endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */

-- 
2.54.0

