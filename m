Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A414C444709
	for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667456; cv=none; b=MRYhPVjVdXh2wFVnMHl+1eTr23r3+6HsCEBEEuy7S/IgpBPJHVTFENoVyCkoS44GtgGLSNyW2EzWnUhoBKFRrNTMFo5Ec8GoGzPuy+8IfgDLNM8dpSlAHzE6WxlvFDvhoOsF/OwBVBEWuZ3v/BXEqUqlMXGzqY0X6xzRreDOoG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667456; c=relaxed/simple;
	bh=xQF3TZ2LeT751O4ot9M5wkTEjw+hWVT6LTftpPDlE7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mlTumEiKfOk+XXlTx6Z2hE/gRwwQaojuE2zHXFKllUKH1qy8lAD71xO/K+LgusCQBmQVO7RqWCBPGj491M0z4cwN0/LOmzIibAppygYjYdRv4Ke+k17oF75Ds5pBBHEoFk06NfcYRLpa3ienmdwug1B3CwDFSNs/qToP+OD5/LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sIePYzpq; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIePYzpq"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e9f1f24cbcso3307229a34.0
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 13:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667448; x=1785272248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sdNTmEHPiK9h4TyUe+m6ooq+E12aDWMHxgwfvekgK7s=;
        b=sIePYzpqWofdFGqrPpoKhNU5tKNMlZPSms2ppuzGq64fEOannVU9yNA6w0wGd92E84
         Rr1XCKje7Z8LNB4rYgcEBNcBMVdVoOmIVgkpc7RfAo3aGtSyDQiOxiF1q1v3qtxWDZ/Z
         cBIuEr3rAmS/b+psxhXvh/LIg11yatT5B0uNMs64S1pVOR59w8MrGy1dULrg3fx++Mhn
         CulaPfU/2Jl6V3pQDhNBaahApK3/b4fXhX+G5x+basE92czlk/jIaJK70inubQLMv/va
         1ZkCFaPXnpJTRxRbpEW/iDACioOzlqy6vvZQ2LdH+u1//KOrhoD9mSfwtxsdOjm7A6Vp
         yNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667448; x=1785272248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sdNTmEHPiK9h4TyUe+m6ooq+E12aDWMHxgwfvekgK7s=;
        b=DQ9zZWLQz5QGKUt9kzewEBixWpNBipQgT6WxKEeLNdmQj4QqHlU0+HA7XoY1iC+qvP
         yOLqKwEGOu4RVsiouStolDeBsp9ghUFG2FQYsAGKqQcA/rvnzheJ5Axhse55JZ5qfdfF
         LzdlQ2dEEoYFhsMtGSJYZag6KjDQNmfSWpnsFP9uQc4E+/y8ZZ+TfK7vHZcGJ8pxmxBT
         bz/+Y26rEq3dyibnAXgHl8SnMDHQpmMV53geeSUXKi5Y3F3rULIt4cdQxSrR93I48+PC
         XWwVXNZM35SaqE3gAcsrEpg87Kt8tRFTgFigihgjE1S0lLC1kQHiPsK8SiCx79kYHH8P
         Ea1A==
X-Forwarded-Encrypted: i=1; AHgh+RoRp0gQNEKRQJecvs6195Ezd7bisHlEBiZvCzQowOZizJZj0DwBHZV5P6wWAtnpQOuff4ce0LX2GArB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Md0kZZMa8EaebzSBfblzFT3hDoBVd3OCL8yTH9SCyu0kh67N
	Xp3je7xtm5FDnjuTbY69AKra+Sp50Ergjo4aTROoCGBh08BjjJRN5fFQ
X-Gm-Gg: AfdE7cmL5xST4HDNwzUnnhlBz9Ee7l+KeNkPXnwUMwKsQxy4B9Xj5OUqMgn/Eub0Q72
	wAOdoYIjXc2unaf+4oKGEzqJ6ddOzspV7x3FEVnpzrfLGBepWlHaapzArYAHgfMnYyBas6haBV4
	JhUQqlsAPM3TUPT9P8CeDuCpTA3T1p8+AGn34Suq3f29kvZyvtxqWg6wrUnmC+lwKImCN5J7gQs
	Z164z82GYlVBhszn6Va/bH1J/E6z+czGsPGgUbyS/UAeZeo+SH9pXzKiKIgMWG+jBZwDcpaGS8A
	EjDjLFvBE7fEl3wIKpzqdM36hkT7HxolNfYvEdJmdXGJNzoKIMuZxO2rRnUroHkXtV6xl+W6IkI
	IyxjlYBBhFA6NCsex2SBYoNQxXo75Zy/03D+VgiTPvSy9T0VsgSTqdLFZjh/qRrmWRo3f/pQvHF
	2yMQ0bYVIaIIRtyO1X3WudBWmls4g5bq7DIVVWmd2Pvle9HtCvQyB0sAH8cSkZdWOTlmlPFb64P
	x9U0JDkZwpRixlZ+qM8/8cFlQ==
X-Received: by 2002:a05:6830:6e63:b0:7ed:ce16:7d72 with SMTP id 46e09a7af769-7ee22d3db82mr549721a34.5.1784667448520;
        Tue, 21 Jul 2026 13:57:28 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:28 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:03 -0600
Subject: [PATCH v7 14/29] dyndbg-API: remove
 DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-14-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=9445;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=xQF3TZ2LeT751O4ot9M5wkTEjw+hWVT6LTftpPDlE7o=;
 b=8DGHkaIE9NnctmKwq0SwIB7G4nxvy3SGa10d9p6vBYZ5eK0IVv+BqPQ1uQSuIuOvHBNbk+h1N
 mo3qkTUzYwvAx6QeBuMk4UMw4iUOceUFe/bxrU+GB7oNlXeVV9Aie1c
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Remove the DD_CLASS_TYPE_*_NAMES classmap types and code.

These 2 classmap types accept class names at the PARAM interface, for
example:

  echo +DRM_UT_CORE,-DRM_UT_KMS > /sys/module/drm/parameters/debug_names

The code works, but its only used by test-dynamic-debug, and wasn't
asked for by anyone else, so reduce LOC & test-surface; simplify things.

Also rename enum class_map_type to enum ddebug_class_map_type.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v3:

fix name of enum in kdoc
also change name of struct (to future name)

v2:

move RvB after SoB

respect const instr in param_set_dyndbg_module_classes, return -EINVAL on classtype err.
---
 include/linux/dynamic_debug.h | 28 ++++---------
 lib/dynamic_debug.c           | 98 +++----------------------------------------
 lib/test_dynamic_debug.c      | 26 ------------
 3 files changed, 15 insertions(+), 137 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index a10adac8e8f0..9607121c3072 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -59,27 +59,17 @@ struct _ddebug {
 #endif
 } __attribute__((aligned(8)));
 
-enum class_map_type {
+enum ddebug_class_map_type {
 	DD_CLASS_TYPE_DISJOINT_BITS,
 	/**
-	 * DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, one per bit.
-	 * expecting hex input. Built for drm.debug, basis for other types.
+	 * DD_CLASS_TYPE_DISJOINT_BITS: classes are independent,
+	 * mapped to bits[0..N].  Expects hex input. Built for
+	 * drm.debug, basis for other types.
 	 */
 	DD_CLASS_TYPE_LEVEL_NUM,
 	/**
-	 * DD_CLASS_TYPE_LEVEL_NUM: input is numeric level, 0-N.
-	 * N turns on just bits N-1 .. 0, so N=0 turns all bits off.
-	 */
-	DD_CLASS_TYPE_DISJOINT_NAMES,
-	/**
-	 * DD_CLASS_TYPE_DISJOINT_NAMES: input is a CSV of [+-]CLASS_NAMES,
-	 * classes are independent, like _DISJOINT_BITS.
-	 */
-	DD_CLASS_TYPE_LEVEL_NAMES,
-	/**
-	 * DD_CLASS_TYPE_LEVEL_NAMES: input is a CSV of [+-]CLASS_NAMES,
-	 * intended for names like: INFO,DEBUG,TRACE, with a module prefix
-	 * avoid EMERG,ALERT,CRIT,ERR,WARNING: they're not debug
+	 * DD_CLASS_TYPE_LEVEL_NUM: input is numeric level, 0..N.
+	 * Input N turns on bits 0..N-1
 	 */
 };
 
@@ -90,7 +80,7 @@ struct ddebug_class_map {
 	const char **class_names;
 	const int length;
 	const int base;		/* index of 1st .class_id, allows split/shared space */
-	enum class_map_type map_type;
+	enum ddebug_class_map_type map_type;
 };
 
 /* encapsulate linker provided built-in (or module) dyndbg data */
@@ -119,8 +109,8 @@ struct ddebug_class_param {
 
 /**
  * DECLARE_DYNDBG_CLASSMAP - declare classnames known by a module
- * @_var:   a struct ddebug_class_map, passed to module_param_cb
- * @_type:  enum class_map_type, chooses bits/verbose, numeric/symbolic
+ * @_var:   a struct _ddebug_class_map, passed to module_param_cb
+ * @_maptype: enum ddebug_class_map_type, chooses bits/verbose
  * @_base:  offset of 1st class-name. splits .class_id space
  * @classes: class-names used to control class'd prdbgs
  */
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a86e1d5845e6..9bd6b87f5609 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -650,76 +650,6 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 
 #define CLASSMAP_BITMASK(width) ((1UL << (width)) - 1)
 
-/* accept comma-separated-list of [+-] classnames */
-static int param_set_dyndbg_classnames(const char *instr, const struct kernel_param *kp)
-{
-	const struct ddebug_class_param *dcp = kp->arg;
-	const struct ddebug_class_map *map = dcp->map;
-	unsigned long curr_bits, old_bits;
-	char *cl_str, *p, *tmp;
-	int cls_id, totct = 0;
-	bool wanted;
-
-	cl_str = tmp = kstrdup_and_replace(instr, '\n', '\0', GFP_KERNEL);
-	if (!tmp)
-		return -ENOMEM;
-
-	/* start with previously set state-bits, then modify */
-	curr_bits = old_bits = *dcp->bits;
-	vpr_info("\"%s\" > %s:0x%lx\n", cl_str, KP_NAME(kp), curr_bits);
-
-	for (; cl_str; cl_str = p) {
-		p = strchr(cl_str, ',');
-		if (p)
-			*p++ = '\0';
-
-		if (*cl_str == '-') {
-			wanted = false;
-			cl_str++;
-		} else {
-			wanted = true;
-			if (*cl_str == '+')
-				cl_str++;
-		}
-		cls_id = match_string(map->class_names, map->length, cl_str);
-		if (cls_id < 0) {
-			pr_err("%s unknown to %s\n", cl_str, KP_NAME(kp));
-			continue;
-		}
-
-		/* have one or more valid class_ids of one *_NAMES type */
-		switch (map->map_type) {
-		case DD_CLASS_TYPE_DISJOINT_NAMES:
-			/* the +/- pertains to a single bit */
-			if (test_bit(cls_id, &curr_bits) == wanted) {
-				v3pr_info("no change on %s\n", cl_str);
-				continue;
-			}
-			curr_bits ^= BIT(cls_id);
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, dcp->bits);
-			*dcp->bits = curr_bits;
-			v2pr_info("%s: changed bit %d:%s\n", KP_NAME(kp), cls_id,
-				  map->class_names[cls_id]);
-			break;
-		case DD_CLASS_TYPE_LEVEL_NAMES:
-			/* cls_id = N in 0..max. wanted +/- determines N or N-1 */
-			old_bits = CLASSMAP_BITMASK(*dcp->lvl);
-			curr_bits = CLASSMAP_BITMASK(cls_id + (wanted ? 1 : 0 ));
-
-			totct += ddebug_apply_class_bitmap(dcp, &curr_bits, &old_bits);
-			*dcp->lvl = (cls_id + (wanted ? 1 : 0));
-			v2pr_info("%s: changed bit-%d: \"%s\" %lx->%lx\n", KP_NAME(kp), cls_id,
-				  map->class_names[cls_id], old_bits, curr_bits);
-			break;
-		default:
-			pr_err("illegal map-type value %d\n", map->map_type);
-		}
-	}
-	kfree(tmp);
-	vpr_info("total matches: %d\n", totct);
-	return 0;
-}
-
 /**
  * param_set_dyndbg_classes - class FOO >control
  * @instr: string echo>d to sysfs, input depends on map_type
@@ -738,28 +668,15 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 	unsigned long inrep, new_bits, old_bits;
 	int rc, totct = 0;
 
-	switch (map->map_type) {
-
-	case DD_CLASS_TYPE_DISJOINT_NAMES:
-	case DD_CLASS_TYPE_LEVEL_NAMES:
-		/* handle [+-]classnames list separately, we are done here */
-		return param_set_dyndbg_classnames(instr, kp);
+	rc = kstrtoul(instr, 0, &inrep);
+	if (rc) {
+		int len = strcspn(instr, "\n");
 
-	case DD_CLASS_TYPE_DISJOINT_BITS:
-	case DD_CLASS_TYPE_LEVEL_NUM:
-		/* numeric input, accept and fall-thru */
-		rc = kstrtoul(instr, 0, &inrep);
-		if (rc) {
-			pr_err("expecting numeric input: %s > %s\n", instr, KP_NAME(kp));
-			return -EINVAL;
-		}
-		break;
-	default:
-		pr_err("%s: bad map type: %d\n", KP_NAME(kp), map->map_type);
+		pr_err("expecting numeric input, not: %.*s > %s\n",
+		       len, instr, KP_NAME(kp));
 		return -EINVAL;
 	}
 
-	/* only _BITS,_NUM (numeric) map-types get here */
 	switch (map->map_type) {
 	case DD_CLASS_TYPE_DISJOINT_BITS:
 		/* expect bits. mask and warn if too many */
@@ -787,6 +704,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 		break;
 	default:
 		pr_warn("%s: bad map type: %d\n", KP_NAME(kp), map->map_type);
+		return -EINVAL;
 	}
 	vpr_info("%s: total matches: %d\n", KP_NAME(kp), totct);
 	return 0;
@@ -808,12 +726,8 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 	const struct ddebug_class_map *map = dcp->map;
 
 	switch (map->map_type) {
-
-	case DD_CLASS_TYPE_DISJOINT_NAMES:
 	case DD_CLASS_TYPE_DISJOINT_BITS:
 		return scnprintf(buffer, PAGE_SIZE, "0x%lx\n", *dcp->bits);
-
-	case DD_CLASS_TYPE_LEVEL_NAMES:
 	case DD_CLASS_TYPE_LEVEL_NUM:
 		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
 	default:
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 77c2a669b6af..74d183ebf3e0 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -74,13 +74,6 @@ DECLARE_DYNDBG_CLASSMAP(map_disjoint_bits, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 DD_SYS_WRAP(disjoint_bits, p);
 DD_SYS_WRAP(disjoint_bits, T);
 
-/* symbolic input, independent bits */
-enum cat_disjoint_names { LOW = 11, MID, HI };
-DECLARE_DYNDBG_CLASSMAP(map_disjoint_names, DD_CLASS_TYPE_DISJOINT_NAMES, 10,
-			"LOW", "MID", "HI");
-DD_SYS_WRAP(disjoint_names, p);
-DD_SYS_WRAP(disjoint_names, T);
-
 /* numeric verbosity, V2 > V1 related */
 enum cat_level_num { V0 = 14, V1, V2, V3, V4, V5, V6, V7 };
 DECLARE_DYNDBG_CLASSMAP(map_level_num, DD_CLASS_TYPE_LEVEL_NUM, 14,
@@ -88,13 +81,6 @@ DECLARE_DYNDBG_CLASSMAP(map_level_num, DD_CLASS_TYPE_LEVEL_NUM, 14,
 DD_SYS_WRAP(level_num, p);
 DD_SYS_WRAP(level_num, T);
 
-/* symbolic verbosity */
-enum cat_level_names { L0 = 22, L1, L2, L3, L4, L5, L6, L7 };
-DECLARE_DYNDBG_CLASSMAP(map_level_names, DD_CLASS_TYPE_LEVEL_NAMES, 22,
-			"L0", "L1", "L2", "L3", "L4", "L5", "L6", "L7");
-DD_SYS_WRAP(level_names, p);
-DD_SYS_WRAP(level_names, T);
-
 /* stand-in for all pr_debug etc */
 #define prdbg(SYM) __pr_debug_cls(SYM, #SYM " msg\n")
 
@@ -102,10 +88,6 @@ static void do_cats(void)
 {
 	pr_debug("doing categories\n");
 
-	prdbg(LOW);
-	prdbg(MID);
-	prdbg(HI);
-
 	prdbg(D2_CORE);
 	prdbg(D2_DRIVER);
 	prdbg(D2_KMS);
@@ -129,14 +111,6 @@ static void do_levels(void)
 	prdbg(V5);
 	prdbg(V6);
 	prdbg(V7);
-
-	prdbg(L1);
-	prdbg(L2);
-	prdbg(L3);
-	prdbg(L4);
-	prdbg(L5);
-	prdbg(L6);
-	prdbg(L7);
 }
 
 static void do_prints(void)

-- 
2.55.0

