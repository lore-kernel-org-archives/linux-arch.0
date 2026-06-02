Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771BD3C988D
	for <linux-arch@vger.kernel.org>; Tue,  2 Jun 2026 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440504; cv=none; b=NTxYsRrYhuxtEqTTWUbSuIUcE/bgLU9sN3lCmeajywRYQeK7Y2x0PvJvfSXMzZEpIoJR0AJ/LZv1bIx1oFMkGxqEo9u5wqIZjaiAmjvrhOGP7s+YfTQOkkBIGIS5AaF1qPmlhJHL6vaI2390OK2Ad4IXpfscJDImsYE1ZxkdHM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440504; c=relaxed/simple;
	bh=gyhl2dDHOhDRfo2EoLm//e3PBy86xHd/L/qSVe14+FQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PvaRGlUHgaDwspc7bjyFwFGZqCoucbOe7HfKDk30J6uc4Qa6n4Oe7QxC/FPWciuq9wZvVIFg9h5FLiRloKO9o8qO+6Ordh901Df7FAUY+kZYBSq9r9jvzMgwhDTh7R6upKZlKwKIJIbUOmu1pxA8Jg+AEkn1I6bNDeS3jQIKXfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhpFbID4; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhpFbID4"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef616daf6so4553070f8f.3
        for <linux-arch@vger.kernel.org>; Tue, 02 Jun 2026 15:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440502; x=1781045302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
        b=AhpFbID4JCIUXOJSzh/dJxAv0z16VlrytM49g+48C2VKBz/4pL55rX2dgMdicIM6Xc
         i4c6K7ehBhnVPYB0MqlPvpqEmDZVXlCHRze4fUyzXeHUOT/maImXRE1FCVIG0iKF3B0U
         J4XQCUeCFpzPJcZ8o6uh7jnpTCG1zRmkEHggRviL/qQdwzx6AT8TIcZgsoZOzcgT41Gj
         9WWX09T8frTb9pXONy4hRAYR8Jd9yeZcv1U6eb3KAdbQBmBNcgCIma75xUgt0rGaByhu
         A3qdVmyrtNnS90D1UMln/kcTxNH36oOmJP0NbQ5VnAu33eOmoPW6yPBRb9J29+HwTtjG
         G/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440502; x=1781045302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
        b=dIuvDFeZWyNilU0q3c77eEsikwtIRSf8iCAK9lpXnJ8TR3B0QNgrAL9LGYkKLAD/SR
         NOyM1gCEBtLt0asbS4iH+9pDG5eFkd54Nf9nmyDaBu4XhzqGhazvXAX1FxiDE8SNYBV3
         VbOFKmZX0YEe4jDhSLQiMcNIu90qntm+pe6BTfklnbBxu/3Arfk6UDSUjzwBZwXGJJqm
         sgiNVmVD7CKkVt/65BkCt/QRM9b0xBps1nVOalO7Qwq4Vo1PnChW3cTWx1RhAZupiN0M
         abMpNT/aG/0wjOKqtXZZBEs0PmXp7WYrr0tC2c0Ic6lZXxEA8ZLrVg4Qc8YeotIVytRL
         2dkg==
X-Forwarded-Encrypted: i=1; AFNElJ8IolPHYUfX1beM1n253fOUB2OGYtleaYTm9EdyrE45hYH3FMQpbg+tMhuZP8nbbu/7e0fAVLnaoewy@vger.kernel.org
X-Gm-Message-State: AOJu0YzqReBab3o1S1ept0GfjdsAXhTCBC+pt4Y3mmn3zDklI4BdU4vM
	uZD0VNgjjMHmnfUV2kiTC3Q3y2ckPJ5VnzvnV5LZnxFnX7EsCTCfwJIZ
X-Gm-Gg: Acq92OEYaH6q/2Q9lEPHZdp8xn0rd7dqtbDPLVbYi9HOm/T/NtJJzJF3I7q4mr12Ccp
	kYq2Qo6XQf4RFgTPEF+8MNKBxuWB2Wma6a3v1UsCnUvztJ+1LwL05ALGv2hkMKtSBCjnUUtKJue
	RWSyzPqMXkcxJHcseS/MLTrPuA5elcdmhOAfabjlCKWWfa6Q/YBJl2OiZQmufdadFVYp8C1J/oO
	ftcsK/50xvdIi/hezAGW/r+vtuhaDnFvW4k5QQyVTnwth24D5ybTBJ+QVPp+OUH+bIDK+dqKGGW
	Ba6qp/1f/zWZm+jJm52yhtYAc0Eo1KfDz8jaroOIt/opojj3qbCmwTx1szgN8v26egNIPr31T2v
	FaU9oZuNj1G9amQxrLil3jVbikuPBOWgsWNauakrHYAxKkQhnNIxYpINfpaF61R2U2a5Iun3xiB
	c6djZ7tUomPhKcHtyIFqkYmccHyNJ+vwsCaC9+IycMrHj+j8xfSIdJ
X-Received: by 2002:a5d:4987:0:b0:45e:f780:6181 with SMTP id ffacd0b85a97d-4602182cd9emr456749f8f.23.1780440501948;
        Tue, 02 Jun 2026 15:48:21 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:48:21 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:01 +0000
Subject: [PATCH v4 04/25] vmlinux.lds.h: drop unused HEADERED_SECTION*
 macros
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-4-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
In-Reply-To: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=1428;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=gyhl2dDHOhDRfo2EoLm//e3PBy86xHd/L/qSVe14+FQ=;
 b=MvsNf/S/xSTGRA+QFVkd0l5ykeS++JYaB1FrXileFx3gCJmyjVcFCFJQIWqeiUZo7GqEj3BlU
 9d1r+RLMW7bDHjfviGujkjn0nEiFeEV5seia07THPaU+H02yfAvWuLZ
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

