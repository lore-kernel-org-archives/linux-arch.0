Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CE9583AAD
	for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 22:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202945; cv=none; b=AgtMs224J1rmRxP6UGzgBUnV9GAi5I52eAuZqXXNnv1teVuT1sB+rbVDvQwgpWtlWu0nCrQ/QL2WHmBkPy6IBshpAIqOnrZfTaNEgfandsoQpfzDkCdt1nuDm2ZzKThHNZWNzC5f2f07idL7iAF1rx0sXBMP7u9//VGqVljWEI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202945; c=relaxed/simple;
	bh=XlwJxsMLoOEmQpSddsPPKLnRgIC9ISIuuOLCD/BSHY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rVgOdQM1seKoXjlnxj7nBPGPOl4CRAJbqQ+pQbtCzOlKLk5pImbZj8zOtekRbC89QCSVROvAippXfVErJd2YF4h139CjRlX0p1OmS3dm84vQhpYIBEujprLeB+z9Zc7HoZkVCsshs5VfSsOonambIVCKaX2q8GAMiIh5cOj1z+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rKZH8RMB; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKZH8RMB"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b4bff33ceaso835038eaf.0
        for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 15:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202938; x=1790807738; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=txroU8tpb4AveGN1UplgKFnHMl0k756Ds3MugkCIGpA=;
        b=rKZH8RMBl5UXx5C1Qa/6reLphVljT0gOiJgfa1oVPArfkBaSb/5FmtvYhrFh05XZq3
         0v5vn6+w+5yDX4q23k6GV7wB3oM3qSwKyi6xyduTDAn5/XkqwfwWrTMC9tRrDZtS0w13
         bVNz3bUpkZ2g93ekQ6rjqRKE1PdH66vEBBTiFjOStzFt0E5e/7trbAHNCq9PoqK+OTUZ
         aO6Dmcny0tkLYrpIQxVICq0DJQPitE8fsXIAZBmHExR2RIJhWvugn6EYqn/TmTxQLKY0
         utDSL77uuTFqnKX5V4XYNyCyAJSh3dbaSoMvKXG32PMwqtMspdhd8ZlgN0bCRyrCC6pY
         +UlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202938; x=1790807738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=txroU8tpb4AveGN1UplgKFnHMl0k756Ds3MugkCIGpA=;
        b=EXfx4Hie7bgz0TwlRwrAHrMSuF3cpxPlCc2TIG52+gNXAMINyOrYDAwRTr7GmFIgyp
         Ppsgzh+KjI9akUKXJ0gA2D3CEckih4Yr11MOXmLNJvEl7So0tBnv4OZ+CHhnBq1w85rp
         1O785RtnRmGYp1IyNLRmYltSzjeEuS+RIjXDfKPxUw5qLoVHMNGmhNN2jsRGmOdn9xXm
         10gLSVQ/F7i+jTbH+s/Q57gN4jo6Gl94cCXnPfRUuAtBBScfVwePZI35MVNvylOo7MIS
         bsKMjOk8Jp3Z1DWYPrvPz8IDZF9Y8NDBqVk3QbL8V/oCr0h2QCFMPgR5CRXrInkDyByz
         IwWw==
X-Forwarded-Encrypted: i=1; AKwUvBw05aa9fS/yO25D9Mllzpl9TcJfiiBKAEzdkW8UMSKla2leT/Rk7Z9nRmDgm8nAjZ6HZDBmzy++Ficm@vger.kernel.org
X-Gm-Message-State: AFuF++l/kyVuU7DP6SU4Raiv5i2D3aSkCIWPDXhnrhYgMjpqmUJI09Fy
	s0s2M8b+Loiy3vICEt8VyxtpyRf++288TmygdN5znksBy47d6pkDZKsF
X-Gm-Gg: AYBFou0w2KpXlvu+T0fQJXNGyZe41yo8hYeO3AosvfAtJ2T4T3lEUoDtqmpp9ZXZjIZ
	3bnhapfo5CDoRA/o0Ig/g0yVOcTTBgOTnjOV6fIdjTfjjUfLbz0HzKj7FY44sbgZQ+GdO2a0v8g
	wx/XY49uFYhKvX9rSL2GWYZfYN1GRI2JYCE70sivQN0BT/kn1+JGtn6wT82CWVTRoyaEtPspG4V
	0CmukONAU9V5hdn4RNITJysN0emoH+vsh8fKk/u8pm/cnizkHgoJKPn4YXspYZmkCPpE2Fu90VC
	krAk8ygk29ajiF1k2XtYc+21gJsUdugn8hB3QLJBp5JPYdWcctfINKgd4TiN7ybUUWLf7nAxAVZ
	IppwtriRYW72G4RICm1sSqPfH6Sqf+mLVECoe/m+6RPPJiugWfERI6X76ML491Q2HGIVvdZEjLH
	FCm4MwGIePrTJ9LgUdnnQqG5OD/NFGZUVH+nnY4tIYONfuBbwbOW4Q7Galf8+E65DF2RZMbAI4R
	QgEWB0BacjlVvmlKCRD3PEDDvPKmXzF9ynz+ur1a+fWRK8iLSj7IkdN0vAFsqYudIr5v4NKC1Hd
	udXwoeGlZoMIHMrymCE=
X-Received: by 2002:a4a:ee12:0:b0:6cd:3ffc:acf9 with SMTP id 006d021491bc7-6d441b8251amr657309eaf.73.1790202938243;
        Wed, 23 Sep 2026 15:35:38 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:35:37 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:50 -0600
Subject: [PATCH v11 26/38] dyndbg: check
 DYNAMIC_DEBUG_CLASSMAP_{DEFINE,USE_} args at compile-time
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-26-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
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
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=3976;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=XlwJxsMLoOEmQpSddsPPKLnRgIC9ISIuuOLCD/BSHY0=;
 b=EiptybYCzB6D9ZP87jAlknvFfrN1+LB91BbDMF60BOUBfjDrPvXh9+w10WbHf5H/XbP0syE/Y
 IJx5x2PY9QUCJnmB6hoFeKj+1H0mzvCzbpWlc8waCN4UItOiSWdLBUu
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Add __DYNAMIC_DEBUG_CLASSMAP_CHECK to implement the following
arg-checks at compile-time:

        0 <= _base < 63
        class_names is not empty
        class_names[0] is a string
        class_names.length <= 32
        (class_names.length + _base) < 63
        dd-map-type is known value

These compile-time checks will prevent several simple misuses, issuing
obvious errors if violated.

Several bad examples are ifdef DD_MACRO_ARGCHECK qualified in
test_dynamic_debug_submod.c and will fail compilation if enabled.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 16 +++++++++++++++-
 lib/test_dynamic_debug.c      | 20 +++++++++++++++++---
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 61f9fd4aa7af..26c858588eb1 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -192,6 +192,19 @@ struct ddebug_class_param {
  * __pr_debug_cls(22, "no such class"); compiles but is not reachable
  */
 
+#define __DYNAMIC_DEBUG_CLASSMAP_CHECK(_clnames, _base, _mapty)		\
+	static_assert(((_base) >= 0 && (_base) < _DPRINTK_CLASS_DFLT),	\
+		      "_base must be in 0..62");			\
+	static_assert(__DDEBUG_ARRAY_SIZE(_clnames) > 0,				\
+		      "classnames array size must be > 0");		\
+	static_assert(__DDEBUG_ARRAY_SIZE(_clnames) <= 32,			\
+		      "classnames array size must be <= 32");		\
+	static_assert((__DDEBUG_ARRAY_SIZE(_clnames) + (_base)) <= _DPRINTK_CLASS_DFLT, \
+		      "_base + classnames.length must be <= 63");	\
+	static_assert(((_mapty) >= DD_CLASS_TYPE_DISJOINT_BITS) &&	\
+		      ((_mapty) <= DD_CLASS_TYPE_LEVEL_NUM),		\
+		      "unknown class_map_type")
+
 /**
  * DYNAMIC_DEBUG_CLASSMAP_DEFINE - define debug classes used by a module.
  * @_var:   name of the classmap, exported for other modules coordinated use.
@@ -205,6 +218,7 @@ struct ddebug_class_param {
  */
 #define DYNAMIC_DEBUG_CLASSMAP_DEFINE(_var, _mapty, _base, ...)		\
 	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
+	__DYNAMIC_DEBUG_CLASSMAP_CHECK(_var##_classnames, (_base), (_mapty)); \
 	extern struct ddebug_class_map _var;				\
 	struct ddebug_class_map __aligned(8) __used			\
 		__section("__dyndbg_class_maps") _var = {		\
@@ -212,7 +226,7 @@ struct ddebug_class_param {
 		.mod_name = DDEBUG_MODNAME,				\
 		.base = (_base),					\
 		.map_type = (_mapty),					\
-		.length = ARRAY_SIZE(_var##_classnames),		\
+		.length = __DDEBUG_ARRAY_SIZE(_var##_classnames),	\
 		.class_names = _var##_classnames,			\
 	};								\
 	EXPORT_SYMBOL(_var)
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 3a69cc3cae6d..01ce07001d4c 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -148,12 +148,26 @@ DYNAMIC_DEBUG_CLASSMAP_USE_(map_level_num, 7);
 
 enum cat_level_offset { Vu1 = V1 + 7, Vu2, Vu3, Vu4, Vu5, Vu6, Vu7 };
 
-#endif
-
+#if defined(DD_MACRO_ARGCHECK)
 /*
- * now add the sysfs-params
+ * Exersize compile-time arg-checks in DYNAMIC_DEBUG_CLASSMAP_DEFINE.
+ * These will break compilation.
  */
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_neg, 0, -1, "NEGATIVE_BASE_ARG");
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_big, 0, 100, "TOOBIG_BASE_ARG");
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_str_type, 0, 0, 1 /* not a string */);
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_emptyclass, 0, 0 /* ,empty */);
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_maptype, 3, 10, "no such type");
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_len, 0, 60,
+			      "base", "plus", "classes", "length", "too-big");
+DYNAMIC_DEBUG_CLASSMAP_USE_(fail_offset_big, 100);
+#endif /* DD_MACRO_ARGCHECK */
+
+#endif /* TEST_DYNAMIC_DEBUG_SUBMOD */
 
+/*
+ * now add the sysfs-params to both sub/super-mods
+ */
 DYNAMIC_DEBUG_CLASSMAP_PARAM(disjoint_bits, p);
 DYNAMIC_DEBUG_CLASSMAP_PARAM(level_num, p);
 

-- 
2.55.0

