Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41CC34403A
	for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520523; cv=none; b=tWKtzH2+IPA3kU/LRONCBkdh0XvDEFj+mIoWTCkdUnVADjjYArf1zajrU6ZzaWieM6IHJnGQFkdr9/4smmGURcnuDLgceFbhxDNcT2Hu/s/g4XcCTwmADmEXcJUzfL/X9zR42KDq0HKP3pMcRcBgMrgwIguFcbfKGNy/EWLb/eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520523; c=relaxed/simple;
	bh=rOksOAhaWphEcgDsCZEZduEgXwfTtl68VUCgxNPY7/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V0m8+4aasKEEdVb58ojAQPqBp8QcTmboK54ngPoX4wT+Z0k2J7ychpeLA+C1QCjsk7nwLr9cbvmp9EIggynMLe/AMG0cWMxEZmYWbAb2SzpTqWOgW34H+CmiTdw9IXOEo3zLr5igHv4KlbSmcUyLAX7I7vJ2KQmneJBWnD3IKk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLotZ37J; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLotZ37J"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43eb05b1875so4419037f8f.3
        for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 00:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520516; x=1780125316; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kcnaLfaQGctlS33zvErx78bjZPUMxYDde02HXus0bGY=;
        b=QLotZ37J11STgwaAiHh56BoyvTARohcxUqM37DfmdE35eUkT2sjjQZtzfh0CxDZK62
         CY3xksaw8x+q26nNcnhvkU/Cag5f3IzXTr1DX3N4v7v9vLf+ju1O6KB8O4U7QCH82ENF
         1XT/nBKP3MxlqXV/lWgsXM9MEyN64KFS/lEhv353u0pC3AgCGJgVDhYqfCfmm6OWPAfK
         BZ29hK33glyV4VvQIq28/sMidYS43gFQzVymq59LycYey/G110wCxCmVYL5X8So61J8P
         TpJTb52HLtL+P8kOnTDP33xEnJgZzMtZlQG4HCPPBRbOCi3Oo+zuZYX/k6Xay30dlFnI
         WJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520516; x=1780125316;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kcnaLfaQGctlS33zvErx78bjZPUMxYDde02HXus0bGY=;
        b=mhgfcy9ekbGQtLED5tKmegOSI3/A4WOpaNQzuR3MP+C/N1J452sO7spxAXjWwkr3XR
         oR9Q8SHA8E7gTeCmFoTpNXaCG2DpngYo1OjFkeae7KQMwulXaQHa87rzYErfZSOjNwn7
         UfFWTVwst5tB7EOGDOOwE8mY8Uo+Gy5WEpeJlfjMhOBM0p6hO9mAWCaUxMISd1KANxRz
         vzJrW8A2/vmX0RL6KCt408foAyhlcXvuQKHppbGTemfWsYsq8gOz6Q47jNjeR+K3rEgQ
         4GkXaE1zchAPD2MLKAVJ4Vuf+XSG7FbjpVGkVkzKfC+HFZ7oYxsDHP/efYjv/J9AswF4
         BT3Q==
X-Forwarded-Encrypted: i=1; AFNElJ967Ni+2qBonls5uvxoNDMY2+Yw96Ac1wGsnSI7jKfy5CHH7hYnRTrof/CucnbOyCXh6bPy404VQXN4@vger.kernel.org
X-Gm-Message-State: AOJu0YxF3IH90nuCCo9B9cbRHPfUcP9+r2zJvo1brLcn5QrAw91bJhwv
	/KuBjiUd2iYEOyPlS7DSrcpYEC16/Uqe/sCWNAs9ZUyrN3KGgaBHteg4
X-Gm-Gg: Acq92OHZ9PtpN5xC/nK3E/GPoj6nHDt2QhFXr1nxIwQ0pk7OeNkaLy8Fj9eXlF855b9
	d6dCN+U/3bRwzvsgVV37uTFkpvLyINxp7guCZW9whNHMajOAdOZgstrJRI+TREslAQDn51X9T7O
	Lvcj1qIM9SfQzkzdtaUZt4H+0MIWX0tkaSuvewZaPvouoYGH1u4ZBBj5hZECvFM4zq1/VOy534f
	ykpt1WLPt+voXI8UOtjk2GWxkWca8hK9HCT7582/fZipheVCsqBVkqBSuSuBq0oZ66o4gpkbsSe
	v2EV/xfmF7rcmBG1BCzkA+06Y+wzyHQ+KEZw17QuRSX0eS0u6ygOpxIXWDrY3+G/cmOxPh3b0iK
	buNpBhAD4I0kSH6Yk9+NGSch21uMIed6PU6k61NzLususVha3HLjjNAmIj9EtCbv8YVqKBul1OV
	9YaVREZSNtybg5/fjkv2/MNl4u6Cl/
X-Received: by 2002:a05:6000:1ace:b0:45e:9417:556f with SMTP id ffacd0b85a97d-45eb38c679fmr10298303f8f.39.1779520516325;
        Sat, 23 May 2026 00:15:16 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:15:15 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 23 May 2026 01:14:45 -0600
Subject: [PATCH v2 12/24] dyndbg: drop NUM_TYPE_ARGS
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dd-maint-2-v2-12-b937312aa083@gmail.com>
References: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
In-Reply-To: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=1439;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=rOksOAhaWphEcgDsCZEZduEgXwfTtl68VUCgxNPY7/c=;
 b=IMkDxWEEMSyVXwT4wwtQxotcBdIkVon/BYyg9V3iMJcUkveV+jlKy9k+DfRHSnUkHdLpkLm0O
 gslJgQJjRPlCsYxqB/1ZQBFCoQdKro1LQI2q09sXEIk8n+4Le5VrzBd
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

ARRAY_SIZE works here, since array decl is complete.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: include linux/array_size.h, correct commit subject
    review after sob
---
 include/linux/dynamic_debug.h | 4 +---
 lib/dynamic_debug.c           | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index aa45dcf36a44..e724f6b93663 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -121,11 +121,9 @@ struct ddebug_class_param {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = ARRAY_SIZE(_var##_classnames),		\
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0377d9f8dcd1..6d9dbeb68ae8 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -13,6 +13,7 @@
 
 #define pr_fmt(fmt) "dyndbg: " fmt
 
+#include <linux/array_size.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>

-- 
2.54.0

