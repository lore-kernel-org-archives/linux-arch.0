Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132546;
	b=yzzp9qTX9DIdXUhIb6H2lDtS8rOicWzzu/e1Bp4npnDUPcjr9AoU57La2IQOg80R+0CH
	 b2EjBI1qdZjN+Kudn4HJOSjdXwVNkTu0L3lRGUZsac3RP3wk3eWO9PPNwSAEMpIYv4ImT
	 ix8rvz2zS7ghBwZd87sAy3AJlWZkwx1Wm3gkLzKOWN/fOC1SrDrViolTpT9Z7snmqS+Op
	 00SDK6XmMf15R8SgZoDk3VqJZHvtovK99eJ1usF1E01aYIzmykvCZHCvMMdYc+x5GcqEz
	 tuaB3WJqtKZOJNGVURuEitCw2OZ8L+e4r0GNcdNBzwB1e52J7tDJFhcQoWOcBY3LVOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132546;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qDF2HU5HYTyY24acBukEzCv6gxdX0qa94jrmJpjZl0c=;
	b=fVywVjXVnSV4orvxX48Sx0OErfWjZZW2xh3poJQrxfOV8wsUFoF4Agna5xgBKWXDTdp5
	 Its8qweebTD5pe/exwYzAwh2xeUZEDtVq2RVMSu8h5qEBQEEDx/Pj6ctdu7Jo9fuWfElz
	 af5cFlN9dXHMY2nwwfcyVn/h5Oe/+VQTOAnDIwdXB9i4qEEV64u0Fs6GU/LnMC0AQTidH
	 XGqKP0zZWJiGdC2D31ws9EBS3vrT+e+dkHAflkdgwRdOBs1KuWlvlU4NU2goCUtu7nXBH
	 bMfPnrS1OPXI3eceRzwlDkGKzYtjoMcd7m4yDoNQqsTCQq+H24qn6PA6ZPwtH7bOZMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nv+yN6BW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86FB60A5BFD;
	Tue, 27 Oct 2026 20:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nv+yN6BW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132545;
	b=JPzL80H+0oTDewbRbx+7YwAC/597kDHoyZK/e2aL7dpW23Wyd+bebM7tJLH5kflPvZUZ
	 c8yfJ458mbNEL9RnJVVmEk5ys0gGl0zRngl6J2QDFDhvHSkPzIU4+PK8osYpIrDWdYptE
	 J+/j2e/8NHl/SzAWbC0nTAbK1YExZ8GkTY58YRtW80b/iQE5XymHajYBs3FrItSlEeY+s
	 0hfpjYYHctcHXuuJfvkBRSCqgdfWzDOTvylnfdAg+/FzFxId5xlnpsclfkKrMZUP21cBN
	 WU99WryJnuYmXVy9w36W45FC3YyRXYkTc+6s+KoJxsGRBK0X2KJ7nhizV4agw17OYtg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132545;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qDF2HU5HYTyY24acBukEzCv6gxdX0qa94jrmJpjZl0c=;
	b=vg2fA0mQNI6me1wUPyuyszx68TpABp/0zPUbNrN9rSt03X883w1XpRlTFXRtOLw9o1io
	 K8j0fjmzrDwuBbQl6zN3THEADgqMd4Z18qJq4Ht8ajdzh5bSC8QvMnzvtu8TG8leu8WBk
	 XdCRKuKIfXZhIV+Gl/bRpIJNEj2gx7WTf7pCkTwVs1u1HlTmdoDL/GZKNtHzG8Q8eYVHq
	 3TCDnUAdwM7YjOmGd0/+Ewo63qc9y0CkLbB4bJX0qwS2473wRBtSGoVjsLvaGlLpJFzxv
	 pF3DJjsQaNphGe8DpnkDGEL+WDiRwULbNodC4cmi+zCuUjxpNlaBNEA0bj9SzUBDoOw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 802F71F031E9;
	Tue, 27 Oct 2026 20:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132545;
	bh=qDF2HU5HYTyY24acBukEzCv6gxdX0qa94jrmJpjZl0c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=nv+yN6BW7lKn9Zcz6D6RpCf3uDhGXleFosAkKydCOUKcZhoxivKtFyVucv/wn+6t1
	 vfaQBCJ/VTHSIZYOfWGr+u7ZueuYQBOMgoauTSwiPEqKzoZCXljc0qRdajAZEpwALF
	 q+bZILCjq+nyPS81vJuaf3PV0jK42XO6K/PVTBShBMYTi1zl05DU+wqxVHqQPiss/5
	 IcA7vOUBYt85iKmLaZxMPjxFxzLMyiFQ/6qtBktbAjmDE0woW1Vbv0Ts99Wmkj4LWL
	 +CXTGFAVv8vWZY92qw3tVbn7GaLbi4zc5fxLAvzmIL2YulLii+LPrvLAIKDvq+fLM0
	 a0FdTJXu/7hAg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4661945229;
	Tue, 27 Oct 2026 20:22:10 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:14 -0600
Subject: [PATCH v13 14/39] dyndbg: refactor param_set_dyndbg_classes and
 below
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261027-dd-cmap-part2-clean-v13-14-9267923be612@gmail.com>
References: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
In-Reply-To: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jason Baron <jbaron@redhat.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=6792;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=odl1V/VMh+UIrrmqU9jDNQVvpvKfmGuh3/VT//0V6/4=;
 b=NK6EqDIyhkD93auOgsrSuZ6NkNhd9Ilil+4Iqe0pC3+ypRARvhOE6+vNcZXjjTakHI9E/I5q8
 GTjQFM6uIOWCthvDs36khCn15aPhkv55YzMCR5KNltfdOMXI8SEEw8f
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

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
v8: drop kdoc on static fn,
---
 lib/dynamic_debug.c | 73 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 26 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d0e793a05655..bbe32fab74e8 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -618,9 +618,10 @@ static int ddebug_exec_queries(char *query, const char *modname)
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
@@ -628,7 +629,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	v2pr_info("apply: 0x%lx to: 0x%lx\n", *new_bits, *old_bits);
+	if (*new_bits != *old_bits)
+		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
 		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
@@ -637,12 +640,16 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
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
 
@@ -651,22 +658,17 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 
 #define CLASSMAP_BITMASK(width) ((1UL << (width)) - 1)
 
-/**
- * param_set_dyndbg_classes - class FOO >control
- * @instr: string echo>d to sysfs, input depends on map_type
- * @kp:    kp->arg has state: bits/lvl, map, map_type
- *
- * Enable/disable prdbgs by their class, as given in the arguments to
- * DECLARE_DYNDBG_CLASSMAP.  For LEVEL map-types, enforce relative
- * levels by bitpos.
- *
- * Returns: 0 or <0 if error.
+/*
+ * param-setter helper to validate numeric input, clamp its value by
+ * the classmap type and size, and apply the bits.
  */
-int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
+static int param_set_dyndbg_module_classes(const char *instr,
+					   const struct kernel_param *kp,
+					   const char *mod_name)
 {
 	const struct ddebug_class_param *dcp = kp->arg;
 	const struct ddebug_class_map *map = dcp->map;
-	unsigned long inrep, new_bits, old_bits;
+	unsigned long inrep, new_bits, old_bits, old_val;
 	int rc, totct = 0;
 
 	rc = kstrtoul(instr, 0, &inrep);
@@ -686,9 +688,10 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
-		v2pr_info("bits:%lx > %s\n", inrep, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits);
-		*dcp->bits = inrep;
+		old_val = READ_ONCE(*dcp->bits);
+		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, &old_val, mod_name);
+		WRITE_ONCE(*dcp->bits, inrep);
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
 		/* input is bitpos, of highest verbosity to be enabled */
@@ -697,11 +700,12 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 				KP_NAME(kp), inrep, map->length);
 			inrep = map->length;
 		}
-		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
+		old_val = READ_ONCE(*dcp->lvl);
+		old_bits = CLASSMAP_BITMASK(old_val);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits);
-		*dcp->lvl = inrep;
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, mod_name);
+		WRITE_ONCE(*dcp->lvl, inrep);
 		break;
 	default:
 		pr_warn("%s: bad map type: %d\n", KP_NAME(kp), map->map_type);
@@ -710,16 +714,33 @@ int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp)
 	vpr_info("%s: total matches: %d\n", KP_NAME(kp), totct);
 	return 0;
 }
+
+/**
+ * param_set_dyndbg_classes - classmap-based kernel parameter setter
+ * @instr: string value to set (numeric bitmask or level)
+ * @kp:    kernel parameter info referencing classmap state
+ *
+ * Enable or disable all class'd pr_debug callsites in the classmap,
+ * independent of the module they're in.
+ *
+ * Returns: 0 on success, or a negative error code.
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
2.56.0


