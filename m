Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB2F346E6D
	for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2026 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010498; cv=none; b=LNyWeed4C74ju4MXFK1WrQ2PUxxfOs1pQw4by0j/kdfbRo57vWRYxrdyc7MFmhe2l+M/to8dLD95lQVeNZ9VfjLFXwfSO/GxZRoELVdLKqZVfBdoQnJooepLQyZBL8QH9owrW9KfkW++eRTnyNwqrcVXgPAZhO1+npUMyUgwnH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010498; c=relaxed/simple;
	bh=tqt5MwiD6HrQDvcR6oykSbqGC2S5kT6zF+EiGPTLOLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JofUUJyO3e3e6jlSFWZMdmPcllNes0BnkNVYADwRMajFC4iic/4I5/L7+V1C9RLCDGiFThKKThJVDjrEWcoIEfKIpVPfVwFhw070y/WogebCOvGcfqWqe1MMX/P71egkUZwOLDNAUK0kk5qV6k4WtbS9mwvQujq+QhHdODUHQJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVZtfy3n; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVZtfy3n"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6a0c7c4f55fso1402255eaf.2
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2026 09:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010490; x=1783615290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7bxxo1B+K2xgi+Y8TLpeTHXA6asmMdj2sriPZDg0Jo=;
        b=BVZtfy3nYf9Qz6wxNxRNWnF/SG6hfhEbWrzTI5JMJ38ugsz5nnhg0m0PNkni8ZLbCZ
         BaWiZcdZOiOgtMf6ZvZhvgdj5nNiaY19IAICOiTicE3TKCAIWCIcnN7SB5KBZuhamti8
         4yvD+/EhWIrPRnB0Uob1pQpbvBzEKZBWM9ky+Z5I5Y8FF29X7kqrrO5MdnNrl04xovMo
         J1VMDJJPwYa97ufEfLRc8arT8fPomZg3A0PEWC0KnA+h39esUEaP88hOQEwBNqwoWCy9
         X1sSZb4CUqGZOebnSDnbgZfLUQJvcdHYtwqSxoh7OuKOBBgUCdPWwJCpTvbTtkSclhej
         A6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010490; x=1783615290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z7bxxo1B+K2xgi+Y8TLpeTHXA6asmMdj2sriPZDg0Jo=;
        b=NRkiz6s0dTu5PKgvxGAfjcNweb5Nvk4iX0HrFxjKIlYi6lXxd7h4ex8FtJWzI4X6OV
         Q/shfD1oAUg0MuB0dpOywF5ULZS/x1QkWuIxRnfvq+QzKn0YmSb21QfIhKcCcdSakgi1
         RVzvgrS2a+qW2Yct5nSl0UQTio7uDR6RbZlhCBJbgr99whPOKD5+4wLddjDw17WqzBEK
         /crw7Hb0bHiIsq+57aJxQkqR2AUDeNU8AHZSSl9tdfVcqj2OrUlnodDpuNjFSw/n36fc
         rjEMSS3RFg/UmOep9univzVBOIwYDgP/vZ+Tsbd6jLr/XTMqI9Qxm7Oo4VE2WVKg9NJG
         BZPw==
X-Forwarded-Encrypted: i=1; AFNElJ8WaJuxSkemiblrEMj3KQkXSV7Q1WJGPfXdHZgAH/AMp3wPcpwNwPiXuDrbkfsLAnk3ueyJQ0PBwFSW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4h3lBTn2bnK5lCpAGjje4t4QHt0x+zJgBty/LhsHXecPAOJra
	jdLy7SEJkeWI9rLZD3dwPs90nOeHT4c8IjaO1LbDiUDRx63NQoxtV31C
X-Gm-Gg: AfdE7clZcOEk5sYfnsOdu5hi+xVCEG2ldCO4eFF22HH52s3Jrfmwtkcadj/21PBkTVX
	XNSNd6YIoJyQmGP3v/4paTYK6/fOyoI9KCK2RoQtp7q93fCDRbJP6pH9elO1RvVevokX1trSStP
	GMmCG+XFDL8lyJvL+QWqWC7Wz7EgZnTn2gQAeJ2CJ6RgwYtAPzN3xYelkfjeXX0LqqFga8Qn+Qy
	rlRmj35XDUGyWg6E0kyNKZ2XYkeuO++omo0Vg/XCHCBuc+pKo2McDcwKkCbIlbOzQu/z2dPuj/4
	ZQ8jaAlT1A41tRp0QExwrP/YxqPX694bNN0l4itsjmItEw4EzIx0cVsmyjWYPrexe1e9z/BMf6O
	SzzwgXjkenME9zDBsC6QNYdWg/OX3kGbdkfMdEi4+NRHOE5PCPuG+3PRS4m94k06qaV4TyqRNzq
	CUg8PMKiGkSgg4NlKW2GzDJarvB7v21yu2X0VzLL2YeFA6bMG4a5937SbGUZKwTw==
X-Received: by 2002:a05:6820:151c:b0:6a1:3e91:dcad with SMTP id 006d021491bc7-6a309974cdamr4260572eaf.29.1783010489767;
        Thu, 02 Jul 2026 09:41:29 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:41:29 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:41:02 -0600
Subject: [PATCH v5 10/18] dyndbg: refactor param_set_dyndbg_classes and
 below
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-10-24f22b052bf2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=6125;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=tqt5MwiD6HrQDvcR6oykSbqGC2S5kT6zF+EiGPTLOLQ=;
 b=dtCmCUkIoPQyPYUkmr/tIhrdAZAkTruYS8RLcJJsPFM2W/MJ8aSTSu3o3jka6HXYcJGj2EFzb
 n6Z4WZZ41aDBc92CXsRJa3H8g9D+rPox8CYU4Ywq9+x8JepISk3xy1l
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Refactor the callchain below param_set_dyndbg_classes(1) to allow
mod-name specific settings.  Split (1) into upper/lower fns, adding
modname param to lower, and passing NULL in from upper.  Below that,
add the same param to ddebug_apply_class_bitmap(), and pass it thru to
_ddebug_queries(), replacing NULL with the param.

This allows the callchain to update the classmap in just one module,
vs just all as currently done.  While the sysfs param is unlikely to
ever update just one module, the callchain will be used for modprobe
handling, which should update only that just-probed module.

In ddebug_apply_class_bitmap(), also check for actual changes to the
bits before announcing them, to declutter logs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: move RvB after SoB
---
 lib/dynamic_debug.c | 51 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ce42e03f1600..0fc9cd14e2d2 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -615,9 +615,10 @@ static int ddebug_exec_queries(char *query, const char *modname)
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
@@ -625,7 +626,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	v2pr_info("apply: 0x%lx to: 0x%lx\n", *new_bits, *old_bits);
+	if (*new_bits != *old_bits)
+		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
 		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
@@ -634,12 +637,16 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
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
 
@@ -652,6 +659,7 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
  * param_set_dyndbg_classes - class FOO >control
  * @instr: string echo>d to sysfs, input depends on map_type
  * @kp:    kp->arg has state: bits/lvl, map, map_type
+ * @mod_name: module name or null for all modules with the classes
  *
  * Enable/disable prdbgs by their class, as given in the arguments to
  * DECLARE_DYNDBG_CLASSMAP.  For LEVEL map-types, enforce relative
@@ -659,7 +667,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
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
@@ -682,8 +692,8 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
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
@@ -696,7 +706,7 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, mod_name);
 		*dcp->lvl = inrep;
 		break;
 	default:
@@ -706,16 +716,33 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
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

