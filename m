Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D0B3537FB
	for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520526; cv=none; b=uIMFyaTdn/5YKAHJohdex7G9QoflqR/UyJNHXwAYnLNxYAonGijo+mWW2xotMvCSnkDcntYF5qJ1Mk8Tyxo+yRQ9qAad9mmI2tvKcUwTqu7aYiY+/Udx3aZvgScL4yuMKYMu9jT4H2xuRkYFPI2EWmepJs+YwmjMq/MgXeHIGJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520526; c=relaxed/simple;
	bh=ygsmS8nDEMGOXvT5j/lBji0LpEvx5xSLv8ALq0O4lqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mh4FKqLGg/DqL903oh3iFEovPSXcySK4lcikhFFM1c+oDBmOgMGQAMImed2GCFOWbSLgMpY65OW9UJXNjVRv3yBbTh04F/3FvBxzGNZYvkOGCL6oXjyLD5/ouoITgZHAg9E19/rInyNkwx+bf1Z1jF70zk/FgFvTxt5Sl2sBKYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHMtdxUn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHMtdxUn"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48fe26a177cso60374165e9.1
        for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 00:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520523; x=1780125323; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=obhyzCtxE4cJp5irEWyYUuiOZnV3I91tI0nfkiFOkUg=;
        b=aHMtdxUnQYJiPc0r55xbVKytNn5huzHxGYzcBzr6fz5SKVZ9HPpKGCmasdhWoSEQAZ
         H97XCtOEoO8E8zvoEeW52dAuEOwJjWhebN2rsO8ik4sQ3DG32mI+TCSnXEytH7Kk8cOW
         cDJ4lFXSj/3WBjTSCBfvRraZNcmCSTunoSHAB1w5ltP8oLeQHrQdt7Q2RzJ3xFw4d3qK
         A0md3xe6DP3IVsqCT8qjoOVvDiBhuzr+SVi37SiUq7q6Mc72KGImwGeTzpbk57N4HFDT
         GfDzMkhcGvvFdZxWFnnzHhDmWxznBQYERX63vgHTxgG5+MgMR5BIqTNGgARyAD2o1ZXv
         RI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520523; x=1780125323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=obhyzCtxE4cJp5irEWyYUuiOZnV3I91tI0nfkiFOkUg=;
        b=tLwdlw86vOQ1W12mk4W58a+T+5dxnTRJtU7m67qOw48WG1FBKjSawZtdVyADG7Ob0W
         YHFik1Vh6+dwXms4gCXdWFm7tU73ByjtfnkKmEmWnRM40KJeNUVntdAUHAxDly3H0ENW
         n1KSXYCcVFibPvTAp32SOe4/yPS7t7WhAdnhPrQU1LAcw3m8mndcb67RUiJWr3nZ6Gm/
         qHC7UOoUgCgtvynqOCfUy9UPIVQWDHwnlwxH2SDDCr4DBgOIo36QArSibViLtwU7AZQV
         iYCNKAAclWm4sqK3NlLm1lVN0SDdwujCfBToNwvCg4MgHcDqPds3VxdAI3YTjc/JjYUn
         Bt2g==
X-Forwarded-Encrypted: i=1; AFNElJ+5ijfoy0OOt55rBTTILjX7bdYFCozjp6DEiRrPFnQvm4EnxEBN0x8EiRRbEq76yzCnp40G7bge96BL@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwihuj518jR8MnUO4qupv9KuIBN94EAIbmGgN335hivQXum2ip
	uw41AIR54lj9U4KvPKEoR6I4lo2a0iLETzHi4smk3V+nyuLDJGoIZ8bT
X-Gm-Gg: Acq92OGzqTXCk7wYVmNWoudcbqa7oOjO38gp/WCpAtVdpJgWXrptCy3EW+DpiZxXsIp
	kWqvgntbVeITWCV2yRMf7mhFJIuIKPUecKKcrqvjfUqP9cENmMACdsL3pjW7kY0vqAwUOpUg3Oc
	045jNWfoi+RX3xaKTNchZwcmvMRGu77DMubPXE3DHq6o+1Ry/08cg/beelob/MFKUV/vWyWRPvG
	xi+DhO1Fgho2cM57dwqG5fY9lIZ0R5QTlY/40EJtPEybZrMy2hH8oT7KJdFSIviTOxRJr0t8NR9
	F5EniiErUkZ5LSM5lOEqNLVHjNucReMaZBzv1byf0ZtNZIUCNkS0JQbNZdb6K5mozTNBfi3QxTJ
	pAyAqxe3zSHBcHil5/DnRcz6BxDZYiPNH0d+0wCOo0UE6igDQ27Imd7+rBk3sfqEeWWUYv43Cwn
	TvRjLs5NZNE3AhLwxjIG/eFQaL9n6yLn7hZuL9hWY=
X-Received: by 2002:a05:600c:46cb:b0:48d:366:b962 with SMTP id 5b1f17b1804b1-4904248776fmr96093385e9.6.1779520522358;
        Sat, 23 May 2026 00:15:22 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:15:21 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 23 May 2026 01:14:47 -0600
Subject: [PATCH v2 14/24] dyndbg: refactor param_set_dyndbg_classes and
 below
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dd-maint-2-v2-14-b937312aa083@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=6146;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ygsmS8nDEMGOXvT5j/lBji0LpEvx5xSLv8ALq0O4lqE=;
 b=CvkI+eIsz4Q/Tyr1eAzx+2ubgxfi41aBUty7f+wZa830b5xgUya8Fm1cwgnOP6Mrmut/4/Xdq
 bC16E7poX1QCAxKE/c46VCHpR+H6DiF9wUcZBqAAqcaXYsKRZD+ql0m
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Refactor callchain below param_set_dyndbg_classes(1) to allow mod-name
specific settings.  Split (1) into upper/lower fns, adding modname
param to lower, and passing NULL in from upper.  Below that, add the
same param to ddebug_apply_class_bitmap(), and pass it thru to
_ddebug_queries(), replacing NULL with the param.

This allows the callchain to update the classmap in just one module,
vs just all as currently done.  While the sysfs param is unlikely to
ever update just one module, the callchain will be used for modprobe
handling, which should update only that just-probed module.

In ddebug_apply_class_bitmap(), also check for actual changes to the
bits before announcing them, to declutter logs.

No functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: move RvB after SoB
---
 lib/dynamic_debug.c | 51 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index dfed3725aa44..ce069459aafc 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -607,9 +607,10 @@ static int ddebug_exec_queries(char *query, const char *modname)
 	return nfound;
 }
 
-/* apply a new bitmap to the sys-knob's current bit-state */
+/* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits)
+				     unsigned long *new_bits, unsigned long *old_bits,
+				     const char *query_modname)
 {
 #define QUERY_SIZE 128
 	char query[QUERY_SIZE];
@@ -617,7 +618,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	v2pr_info("apply: 0x%lx to: 0x%lx\n", *new_bits, *old_bits);
+	if (*new_bits != *old_bits)
+		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
 		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
@@ -626,12 +629,16 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
 			 test_bit(bi, new_bits) ? '+' : '-', dcp->flags);
 
-		ct = ddebug_exec_queries(query, NULL);
+		ct = ddebug_exec_queries(query, query_modname);
 		matches += ct;
 
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
+	if (*new_bits != *old_bits)
+		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
+
 	return matches;
 }
 
@@ -644,6 +651,7 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
  * param_set_dyndbg_classes - class FOO >control
  * @instr: string echo>d to sysfs, input depends on map_type
  * @kp:    kp->arg has state: bits/lvl, map, map_type
+ * @mod_name: module name or null for all modules with the classes
  *
  * Enable/disable prdbgs by their class, as given in the arguments to
  * DECLARE_DYNDBG_CLASSMAP.  For LEVEL map-types, enforce relative
@@ -651,7 +659,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
  *
  * Returns: 0 or <0 if error.
  */
-int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
+static int param_set_dyndbg_module_classes(const char *instr,
+					   const struct kernel_param *kp,
+					   const char *mod_name)
 {
 	const struct ddebug_class_param *dcp = kp->arg;
 	const struct ddebug_class_map *map = dcp->map;
@@ -674,8 +684,8 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
-		v2pr_info("bits:%lx > %s\n", inrep, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits);
+		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, mod_name);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -688,7 +698,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, mod_name);
 		*dcp->lvl = inrep;
 		break;
 	default:
@@ -698,16 +708,33 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 	vpr_info("%s: total matches: %d\n", KP_NAME(kp), totct);
 	return 0;
 }
+
+/**
+ * param_set_dyndbg_classes - classmap kparam setter
+ * @instr: string echo>d to sysfs, input depends on map_type
+ * @kp:    kp->arg has state: bits/lvl, map, map_type
+ *
+ * enable/disable all class'd pr_debugs in the classmap. For LEVEL
+ * map-types, enforce * relative levels by bitpos.
+ *
+ * Returns: 0 or <0 if error.
+ */
+int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
+{
+	return param_set_dyndbg_module_classes(instr, kp, NULL);
+}
 EXPORT_SYMBOL(param_set_dyndbg_classes);
 
 /**
- * param_get_dyndbg_classes - classes reader
+ * param_get_dyndbg_classes - classmap kparam getter
  * @buffer: string description of controlled bits -> classes
  * @kp:     kp->arg has state: bits, map
  *
- * Reads last written state, underlying prdbg state may have been
- * altered by direct >control.  Displays 0x for DISJOINT, 0-N for
- * LEVEL Returns: #chars written or <0 on error
+ * Reads last written state, underlying pr_debug states may have been
+ * altered by direct >control.  Displays 0x for DISJOINT classmap
+ * types, 0-N for LEVEL types.
+ *
+ * Returns: ct of chars written or <0 on error
  */
 int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 {

-- 
2.54.0

