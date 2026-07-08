Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F101D31326B
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 02:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477110; cv=none; b=a2nQgjQS0hsxhdwalhv8xIUiYZQy9/gmCpBc3qxwimBeXIelndQdPK+CqRu0u2u8jZoeDxdotnDDtJ17GF4Mo00CDuM0Q3614O3d1iMJIWpIt6g26rKuTWLTbOINcRdlo3maSgWpP3umesuMn75bVfJBYu1N4TdeTB03Q3+Kr1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477110; c=relaxed/simple;
	bh=R+ywodY9/HEwLU1o/08HL92DtAFTrUi2XM/5yuI7Itk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V6iuMFbsTZypIAOSoPCNXp0Qv9alwVEX8BlJSyoeOT9gDUmr3LGcvtroMnMLzzy5QEEg2yXNn3yRIfCSFaI3YXCGoZ0/VMcdioI5EY6OOlzTWjXFYG8qLWU8LuKAbGOVVrxKpDPG9FVM2VHOBaFGF5GknyUJWFTFq+ASMdQFd68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmponPKp; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmponPKp"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-488b3fd8d0dso93734b6e.1
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 19:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477108; x=1784081908; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PGwW+xKeGyj9qdYgvsjMj0TNagE0SwrpwzZecGCbsEo=;
        b=kmponPKpgb5B4dwGxbKJhfF6/mkTx8UP9lZBZ5oSutP5V6U0ixh8T/sCo2sK6I6NUR
         8du3FDdzuoQMB49QfDn/nemm9S50j5+S10/mm9Y7rEkKVzefs21Lfep3BnK1V9uZz9TE
         gBajGwCB7SRhmFhX9umvzmAM2TkJR1PONwwAZVfcjHsia7So+B7AMfjjz/tdw9jCD4+v
         DHctaF1HXyxyDt3WHgOZLSVYLDwfZOJJvcy2x76/+MFQ4IjFfVULiSiWNcYxoIncgxia
         dPKixl4tELyhbC7VJz2uGd8ppRX61MXjuJtRir38o8BQZg2OvelYGt30y6OdvdIgb+vV
         9fIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477108; x=1784081908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PGwW+xKeGyj9qdYgvsjMj0TNagE0SwrpwzZecGCbsEo=;
        b=btixc82gcx6ln2ZKxyqGRtlN3OEIC0WINvU2UlkQbkAz/Wjesutr7/i2iA+04wQlSC
         jNdJI/222xqtHSfjGamIbxkSpd1tHjoFu7dpIBicNg4GggP7abgCoHNr7Z/Dno92GA01
         XYKmXD2QRGsErYZXQ0kQWB7LHi8Ob+gMvBHbZMAMKrARLLhoX2EeiSoSSF6yFfbSU+UR
         A7T/dOsIBtdoYdF0C+uJ8GCU6+di9O6zgY8UFZqkpyq6wvibGefacovnKFFF4Hv5/Ggd
         b+5r/9LHylx7KVHxfaGMqofxzvzwABlQqqGM5LP+XBND3DbMHoNDq4oYEl79DMuVUkHP
         Fuwg==
X-Forwarded-Encrypted: i=1; AFNElJ8o4Ts/38xJenX5oaRwryAktlPt0QNYy++C0NTYIePna2bTtBaUSak9bRrw2qaxuWLGCse5OeMBvweZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzNJNWm5RjXnbopHoWr2v6BiK9wpDbI/LaK/RpHcWK4b2Q9bk5C
	zrTLD7CelxUNv4xW4baHs912NIfPYOoAFlOEdvEdvVYfLSGMcAwZxAAn
X-Gm-Gg: AfdE7cmp7dUVI0WgKW3fugV2JMbZjWsFj1W9nXAZIh1sZa4kUBIttqzwchwUfsojg32
	Ev6BlRP2X6hikBUMmnFOibHCNIVESxvqGLW7svFnOKLmnyD4rkmFcnGcU9k57B6jJD2rlPAYsfm
	PVJEk7wau9E4m9z8us34QY/dre1Dk6LdUx64WnM/oAUhenI/iV5941lWcYZpqBgFLvq8edTfugv
	PibI+kihB3yUbnGqi5zlBEE9rVuLg2NrU7PDwhHHsFjbxl+yYVCdz+5+FPOTTFVL/GRFdTOWnOU
	8RX+MygzH1ublmTHh6F9xqnDaGixGM1LMFM1RPzEstchbCWzomI/81KRJxmZQRmON0oLso3GBqu
	Cn5LM5qc2IoQuUadvZlgPfGfXcQVV+Q2O5hJzoNcS/5u8o8LsmcenLG9zcbaaLVH81t3nIfHllG
	TYoui8Nme5X4IIGGt8+hahCq9LxOjoieXkNe7W5YVmNtYyNviMs4c=
X-Received: by 2002:a05:6808:1301:b0:495:f67c:d96a with SMTP id 5614622812f47-4a20264e162mr418615b6e.12.1783477108113;
        Tue, 07 Jul 2026 19:18:28 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:18:27 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:02 -0600
Subject: [PATCH v6 02/24] vmlinux.lds.h: drop unused HEADERED_SECTION*
 macros
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-2-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=1428;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=R+ywodY9/HEwLU1o/08HL92DtAFTrUi2XM/5yuI7Itk=;
 b=SW23dhkCOL2pSCo6EH2WYcPsMXMwsLEFgTbnzKPCXHy+TJuLv9grtIQXaj7l92AGZ85zaQDO0
 mPpMl6EC6ViDb0cLrpFnIMxdam2Jl2qUBgCdf4+kuCsDM0rZKd2SFlv
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
2.55.0

