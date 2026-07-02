Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F88433E9D
	for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2026 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010488; cv=none; b=kegn+h01XoOAmgMvKSq99z4OmEl43zeo+jmlrWxyIxrWH83pwYmeg9nOF+JcFnEoKcd51j3A/owhGQQ3SwAq6JxmVk43atyhHaMDUKbjFFqCvv4C5LgA7TtLmq1/MkNdyOV6jIxeqCPoRV1ZDEt5QEoL55rGOKjpImnbItuQdBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010488; c=relaxed/simple;
	bh=DQaYrrCHfOWyw6I7/Alb/oOYcgAlY5tv2FwAXCcG82Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=seewd3V2sZ7h82Ett84HRi00MjwL9VLU/fD8xqRfiANdB6pNxMn1tBudrRjh6vi+Ah4ti58BTA4ed7RnnDKx4C1CNZ620b23rDqOUpjT84uGJ6xsF2ip3jgpGmxhAmFaOKz0kZg+sBZTGX8cHF32iHAaMejht3txIFTBzFO5+bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pvwo3Ggb; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pvwo3Ggb"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-44aeefa1c00so565860fac.0
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2026 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010483; x=1783615283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Er/Iig+CT06OIxgKVI6YA3M1QIseY8trv6Rj+aIwPm0=;
        b=Pvwo3GgbtFTfmQ2/AdoM+nDfVazqkpfwtm0LFE9i1gL1GilHvUlEh1VCGzyBsJ1C5w
         rleQNPRM6TRM/gaWS8B4BhPUDfWB6UUcMMBxzmkh3Wbbhe5pFc0PvZOVJWjTV07pxNY/
         XRymfzNr4kJnaNhS9GOXW5OVK1Jd+l0KniKyLUd+/KX0lit6hoxttkyxI6haeaH0Mrg+
         u1ppyyGx9TC5mDkaAUnCli+IT5t9gctsOlJu/wH8vSVS4/saMXb24mrNJyAgrIkq7zMK
         Vy0UYTfH/O0dzPOboMg6kgdkW76ub9o++gFldcFxreMk8yeKMci7KLFCUPxxVQ+C3Ji8
         GHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010483; x=1783615283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Er/Iig+CT06OIxgKVI6YA3M1QIseY8trv6Rj+aIwPm0=;
        b=K2Jwom8Aqcc1Qd+OQMCChnpo7iq/2/AXn87AVD117pPjWQ19Iz+0TkR4gpYF/XIE4j
         Aay3aMRohdEhRDaH1WCCi1knONctrsZNyyTQCpiJtiTR6HFfss4g+qG+LCP3F8cTbnX7
         5UyTuugprAGaeCzs9oSXPbagK4vH1+vBGf5NVRMlmVpklHAKOSXeMmoV0bZqx7XEzuJs
         DeVKMwaPcoh1wNkAxihPLY4zgXVUl4pCB/zuBu5p4o+4ubAx61KSfHIe9MmSVSqqP+xS
         t5YxYzisAtLp/CjlFqBIZpoTSab1q9eBth4qe8e8eN/Z73zHq8ukgtphDQ2MkR9BX/Qo
         Z9Ug==
X-Forwarded-Encrypted: i=1; AHgh+Rp784zD2maQMuoAK7jqN8Rc8nQWgXN/mMTD3HadNRuGEFRbRN6TjKVBdDEo8/bTujKfUnq8y2dhqwpq@vger.kernel.org
X-Gm-Message-State: AOJu0YwVrsEuVR/0aJc9fda+mdk13vSxC9cqFndZWllAmxgUWZYlgdJr
	T0+ZH2llakk/7DHLwRPlbBcg4kxvakXShy/rBT7ibnvXs86dTLs2namu
X-Gm-Gg: AfdE7ckdxh1XLUJwi7U44u3/fo9JzcxeX5eGfpdg/ZNvjPjXYhMHvE82f28B5NKYhyZ
	S7siENGmFMa06qTK3P+lXQ3HhCRvkBACwkbU1KfKyoR6AkDEMacQgfPY3NV/5hnUfw+OKa5MnTr
	jTo3IMVibC4QeZnh2eKuLm9WWPwVf+dEvlguwAzJJ5bhSft9fjzKcHF8g2pL8fbEOLVZ+lXePn0
	1uKrrkv8o87ltR7w4fhSPTARAl+SFqKH9HN3NjJ63I9NUn2V0OM4wtvfaerUUAYU+EznBs+dteP
	+Xqgp2rBdVpFo93C8RwXgxtZAWte0g8ihCpn4jDdPpNthurKwha956b7Spd4HhWaeX0UKuW83Of
	Wa/6mHaao19FB13fDzGVKrWq2jRS5zANxOyK00ZJAOj0mRjN+c4bfeXqCw8POWQ1cmfFpjkFeME
	rqSJGvUVs4e+A6I2Tu/Hc0r7R2ic0VTTHgs2gcANeCwgTcfebeK04=
X-Received: by 2002:a05:6871:408b:b0:43b:891d:7c89 with SMTP id 586e51a60fabf-44cea45e2abmr371405fac.11.1783010482676;
        Thu, 02 Jul 2026 09:41:22 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:41:22 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:40:57 -0600
Subject: [PATCH v5 05/18] dyndbg: drop NUM_TYPE_ARGS
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-5-24f22b052bf2@gmail.com>
References: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
In-Reply-To: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=1538;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=DQaYrrCHfOWyw6I7/Alb/oOYcgAlY5tv2FwAXCcG82Y=;
 b=GFSnTtMH961Y7o+VaLt3lNBMKb5UiiKt2BLUAkWCu4TCnoTeTkKBd+sR212fvqeMrEWN2Opcz
 uYRSplmYhnZAjmAT8j1DEyjDJT0j/OaxPRXs/r1ayXuYUbIjiGKHIRN
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

ARRAY_SIZE almost works here, since array decl is complete.
But define it locally, named __DDEBUG_ARRAY_SIZE, to avoid
include conflicts with  boot/<something> on some arch.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v5: drop include, it causes redefined probs in /boot/* for some arch.
v2: include linux/array_size.h, correct commit subject, review after sob
---
 include/linux/dynamic_debug.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 9607121c3072..9ae1accb9bf6 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -8,6 +8,8 @@
 
 #include <linux/build_bug.h>
 
+#define __DDEBUG_ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
 /*
  * An instance of this structure is created in a special
  * ELF section at every dynamic debug callsite.  At runtime,
@@ -122,11 +124,9 @@ struct ddebug_class_param {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = (sizeof(_var##_classnames) / sizeof(_var##_classnames[0])), \
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);

-- 
2.54.0

