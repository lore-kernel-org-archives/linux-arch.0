Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEE6368D7F
	for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520547; cv=none; b=gX4ahFQHPDLxlczTG5QIhWywU5ehaGuCrMc3cmeJlISYpSqIadCmtmaeW2N9UdxW3SqlbJECQXk4iK1tikNBfU302Ar3wI7/K0RNDQoPQSDYkYscfW8cKSyTdRx87NT1+/hxUlknJkKQShMy/6secPAsZlW08yjfywj1rZsq7UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520547; c=relaxed/simple;
	bh=M80+fNO6OBurAzoDghArAT2ZgkzXj59Sg4wMHAAZH/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yoipi8Hy/dm+C8MuAf5BNudFpdClUF5RSmijxM862SO7JgtOdAOM/NYuXsL/ggSxpB885ehEylIomSgzupQLQDLid0eyXUXoxrT2uVIWmpqJE7e6Aod3moiwyIxRFEZv7JTIT4pc79yJFZVU2th+XBBhMsNCKtU5cNs9lDJDj+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ok/XYjGG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ok/XYjGG"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4526a8170ceso4024551f8f.2
        for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 00:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520543; x=1780125343; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCBDtFYH6irn68vEcfgObGsGHdxoBTw2InqF805Jo2w=;
        b=ok/XYjGGYqAhEicSNuybCnnfsy8bqOXgCc06ot6kit+8FPh4pLs0Avlh2sk0BnDsX+
         MzL8mRgOhcH9AwrMrX1SlHBOQPg6o1LJ9dQeytRgccg4LV9IimeJOgVSUEm7Ag4XjZoM
         PXiUt9MPkO7k5cFzHIuRJVfa67B4exvMhBgWex1g4nhTEC1RoK9uZdyXtTLrcsG9PTY3
         8jmaoepoKpk6ilkAndTRjTenhHt54uNbgEPXedLZJ+e2DcI8eqNSTOYC3ZnNN6vab+8G
         V+bWn3h4CeY088xxYi+rkLnco8ruh3yRDqWa9uX4MLNqZ45muvMlP09oYIAknGwSxxm4
         x81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520543; x=1780125343;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wCBDtFYH6irn68vEcfgObGsGHdxoBTw2InqF805Jo2w=;
        b=oHrfYTfj3Ros08Qi7Ni91lPVB0UzgzQefUTLldjTApvjTDlZ/fti9peS1WgXUhmlx2
         BThFxEEPlUYSXx+15pFiJynLYOkqfdgTcwE5PyGd0CfgkSiKTV1mmLc3SrYdMtBQk4fR
         lWzj8/fbN7HVY0lcLCBdPvq3lVBmKrIu4NNMbOpAJBwUMNWPK2H9mKuYMb7VpwcoyOAG
         j611hSxc45RmTQAn1TcZ+uxmVfr6BMD588Nki0NRih9YVlpoyQm7CxibrowrbaF0YEKp
         M/Yd8GMruY9B0t1kupFhCEQrvlPv3+IV+1xaP88H3MUv9x95IeAou9r0QjrNn0pm4lVY
         WYrQ==
X-Forwarded-Encrypted: i=1; AFNElJ8zXH/9F8ylTbXhVcp03s1/xdcjO6MhWlPM0Gt0Ryv/P8hdnj+VbwDlXljitGIjYsCCmWnsQLubZIQW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1qOmHoPjt9M6TfBYpow9NT1qdcSzzLrB4QbRfjfSKOJIT8NTB
	dDDqFLy4I9s1x82hdq21h3Rqdf65+ypHXTi8AhlTAvSq/JSnaOaOl0tkvbBWebfmj1E=
X-Gm-Gg: Acq92OFATcatauv2udoeGKpg3k8ou7dR1ocp9ZI3jxqnc18sE6LCHE73in/oBlJ79LC
	8j5Yqxb16C6r1EuWOVblVSKoyK3ZICbSBIiUS2rrpAVa9/lMmLfJBwX1j4H3OXC7DAlKBx9fr9O
	UVVmLl6yBBVyqoHNXmdCQ/3Vi6sbcnzu2MX4L928SznVINGsmd9EvgDhOxyFKgQE8EphEyBQZ+X
	HiCcyfsJR64KLPHEULtV4jvgvZ9+tu7s5VxDdCHN/JWxJIOl6X84k/xZF6DRDPGvGS6ckuL/UZu
	oGcK7L756sFPnGX5E/GieLkVZmEmIB7NLOoDY6Aa4ZXv9v7OuMjpz7fPOzo2cBPFyldPwQeBQEr
	MVH2/OWOtFDfXDU3KjXFxyvdMiAH7eKzxxeI3+jnMSBUB89VYJsniU53b+sg7F+AEMfybDG/i84
	bcvbZ3XUUQsiotXx/cHXmqw64H9nWC
X-Received: by 2002:a05:6000:25e3:b0:43d:68ad:3b7f with SMTP id ffacd0b85a97d-45eb38af5c7mr10081766f8f.21.1779520543058;
        Sat, 23 May 2026 00:15:43 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:15:41 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 23 May 2026 01:14:57 -0600
Subject: [PATCH v2 24/24] dyndbg: improve section names
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dd-maint-2-v2-24-b937312aa083@gmail.com>
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
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=5623;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=M80+fNO6OBurAzoDghArAT2ZgkzXj59Sg4wMHAAZH/c=;
 b=IPLjgcIxtWsAYl+aBjchTE9EychEIqrxQak1IFTHfNKzY4NcwzKCPKwEW2llTS3/AdszaVr7i
 N1vE4tjKZfgDbjInXaxKzrJqaN4Ut9tfGi7eVcksJB+R0JuwRT+4HCD
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

change __dyndbg to __dyndbg_descs
change __dyndbg_classes to __dyndbg_class_maps

this sets up for adding __dyndbg_class_users

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/dyndbg.lds.h | 14 +++++++-------
 include/linux/dynamic_debug.h    |  4 ++--
 kernel/module/main.c             |  2 +-
 lib/dynamic_debug.c              | 24 ++++++++++++------------
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/asm-generic/dyndbg.lds.h b/include/asm-generic/dyndbg.lds.h
index 9d8951bef688..ec661f9f3793 100644
--- a/include/asm-generic/dyndbg.lds.h
+++ b/include/asm-generic/dyndbg.lds.h
@@ -3,16 +3,16 @@
 #define __ASM_GENERIC_DYNDBG_LDS_H
 
 #include <asm-generic/bounded_sections.lds.h>
-#define DYNDBG_SECTIONS()					\
-	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)			\
-	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)
+#define DYNDBG_SECTIONS()						\
+	BOUNDED_SECTION_BY(__dyndbg_descs, ___dyndbg_descs)		\
+	BOUNDED_SECTION_BY(__dyndbg_class_maps, ___dyndbg_class_maps)
 
 #define MOD_DYNDBG_SECTIONS()						\
-	__dyndbg 0 : ALIGN(8) {						\
-		KEEP(*(__dyndbg))					\
+	__dyndbg_descs 0 : ALIGN(8) {					\
+		KEEP(*(__dyndbg_descs))					\
 	}								\
-	__dyndbg_classes 0 : ALIGN(8) {					\
-		KEEP(*(__dyndbg_classes))				\
+	__dyndbg_class_maps 0 : ALIGN(8) {				\
+		KEEP(*(__dyndbg_class_maps))				\
 	}
 
 #endif /* __ASM_GENERIC_DYNDBG_LDS_H */
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index fe73aa27b350..206337af71e9 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -128,7 +128,7 @@ struct _ddebug_class_param {
 #define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)		\
 	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
 	static struct _ddebug_class_map __aligned(8) __used		\
-		__section("__dyndbg_classes") _var = {			\
+		__section("__dyndbg_class_maps") _var = {			\
 		.mod = THIS_MODULE,					\
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
@@ -168,7 +168,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
 	static struct _ddebug  __aligned(8)			\
-	__section("__dyndbg") name = {				\
+	__section("__dyndbg_descs") name = {			\
 		.modname = KBUILD_MODNAME,			\
 		.function = __func__,				\
 		.filename = __FILE__,				\
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c2b6e70f2e77..bd7899a91755 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2774,7 +2774,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 		pr_warn("%s: Ignoring obsolete parameters\n", mod->name);
 
 #ifdef CONFIG_DYNAMIC_DEBUG_CORE
-	mod->dyndbg_info.descs.start = section_objs(info, "__dyndbg_descriptors",
+	mod->dyndbg_info.descs.start = section_objs(info, "__dyndbg_descs",
 						    sizeof(*mod->dyndbg_info.descs.start),
 						    &mod->dyndbg_info.descs.len);
 	mod->dyndbg_info.maps.start = section_objs(info, "__dyndbg_class_maps",
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index b877f4c6d778..ce70cfee50c5 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -40,10 +40,10 @@
 
 #include <rdma/ib_verbs.h>
 
-extern struct _ddebug __start___dyndbg[];
-extern struct _ddebug __stop___dyndbg[];
-extern struct _ddebug_class_map __start___dyndbg_classes[];
-extern struct _ddebug_class_map __stop___dyndbg_classes[];
+extern struct _ddebug __start___dyndbg_descs[];
+extern struct _ddebug __stop___dyndbg_descs[];
+extern struct _ddebug_class_map __start___dyndbg_class_maps[];
+extern struct _ddebug_class_map __stop___dyndbg_class_maps[];
 
 struct ddebug_table {
 	struct list_head link;
@@ -1379,10 +1379,10 @@ static int __init dynamic_debug_init(void)
 	char *cmdline;
 
 	struct _ddebug_info di = {
-		.descs.start = __start___dyndbg,
-		.maps.start  = __start___dyndbg_classes,
-		.descs.len = __stop___dyndbg - __start___dyndbg,
-		.maps.len  = __stop___dyndbg_classes - __start___dyndbg_classes,
+		.descs.start = __start___dyndbg_descs,
+		.maps.start  = __start___dyndbg_class_maps,
+		.descs.len = __stop___dyndbg_descs - __start___dyndbg_descs,
+		.maps.len  = __stop___dyndbg_class_maps - __start___dyndbg_class_maps,
 	};
 
 #ifdef CONFIG_MODULES
@@ -1393,7 +1393,7 @@ static int __init dynamic_debug_init(void)
 	}
 #endif /* CONFIG_MODULES */
 
-	if (&__start___dyndbg == &__stop___dyndbg) {
+	if (&__start___dyndbg_descs == &__stop___dyndbg_descs) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
 			pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
 			return 1;
@@ -1403,11 +1403,11 @@ static int __init dynamic_debug_init(void)
 		return 0;
 	}
 
-	iter = iter_mod_start = __start___dyndbg;
+	iter = iter_mod_start = __start___dyndbg_descs;
 	modname = iter->modname;
 	i = mod_sites = mod_ct = 0;
 
-	for (; iter < __stop___dyndbg; iter++, i++, mod_sites++) {
+	for (; iter < __stop___dyndbg_descs; iter++, i++, mod_sites++) {
 
 		if (strcmp(modname, iter->modname)) {
 			mod_ct++;
@@ -1431,7 +1431,7 @@ static int __init dynamic_debug_init(void)
 		goto out_err;
 
 	ddebug_init_success = 1;
-	vpr_info("%d prdebugs in %d modules, %d KiB in ddebug tables, %d kiB in __dyndbg section\n",
+	vpr_info("%d prdebugs in %d modules, %d KiB in ddebug tables, %d kiB in __dyndbg_descs section\n",
 		 i, mod_ct, (int)((mod_ct * sizeof(struct ddebug_table)) >> 10),
 		 (int)((i * sizeof(struct _ddebug)) >> 10));
 

-- 
2.54.0

