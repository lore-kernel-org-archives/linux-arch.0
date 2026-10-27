Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132545;
	b=Fwhy0W03xutjM0yRV+SjDHroNuh6s4P8qkwJaAhDC4vnB69GuFTzo8/HcgCurXEIJJ7z
	 t7nho0pz/KtRLjqNUhU7XUifMAy8TFlyNTJfY4qnpz6x0D6xD17lVMGye5suCodBCjXXL
	 cozOjQ3XqnomE0qkbkp8YB4QZP57Z+bVlKi/BiiAe/SBhpMa++LcItSl4L0VzX22OI+vr
	 R98r61Sa7STcFKISY/FKW+CCtfNGXw9T/y8zaT+K6U1Q0fCXqXpZjeR7sc8Re8RQrv4IW
	 mwbbhDjymtMAlO77nOJXbTlg6i3zZqeqEWOphEB+JCnRbiZUxeNkLkt+102TsdeKYaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132545;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7irLKmzjDJCrQVxQYI/Jd8l60rk00tZqlZ6y0Y14hI4=;
	b=y08AsqE1AZ4k3c0RjirMfBza9YiWUkMFEKwvLlVxn7P1tB+OjL6U0tj6ibwjHJjXiz8W
	 DYha1t3q0ejTpM/PcMdyYxznTVqpFTDbrQjniJfN83gCdIsDrhAJ8XwdAhQQ6wH73h5js
	 H96dOwYl0fNb8CicaWpvujK8w5UA0rmm0zHxt6Vd00P7tz62g5wKvgfpA1NCEZ2eZb5Tu
	 nBZM0GznMW86cFKjBZ0/mQe/HF7/+GIV7lOzPrpwr6EG3xFBArkydslHsNc0zr0PbV21Q
	 9FnBpuicj3yXD09igo15mZ2YGu7OgNfGv3Iu5806h1YU/TENlUQYt8/Np9RkwFwgEJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kNP18L8A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8750860A5BE5;
	Tue, 27 Oct 2026 20:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kNP18L8A
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132545;
	b=o38YOFXVGFTjIost5fFVIMM4bs6pO8bUZ6ZEiQJMh6rh1+aA8k4H43NJvxUkfhECQL3A
	 7wxUH2HzDqakBSyGksUq/WAt3QUMWQyXwZ9A+q9U2MlcgS36dSWThdI45Ps9LZSqBaqjs
	 nAwTutAPgyAWUxlnK8BaFL9i+30URjHjI+vuWBFUQ53tG0iktg7DjRqR+Forr/G4qt7fV
	 9WQtmaOo4d5pA65X9e1X1z4fHlDSRMye/mlDJGLPJ+e69PdUiQXCVj0/Dxr5ZACyb0DdA
	 Q5D2ijUczTa5Fbow3dmZUQe5N+kUVXpuFIAcoeJdledjbULUmNh0rZNqKyXUNK6rnyQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132545;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7irLKmzjDJCrQVxQYI/Jd8l60rk00tZqlZ6y0Y14hI4=;
	b=AzhUN7N7wlWOXVVnQ8byJBdE+fDaCvVA7hPfxxML4OQ7IybQMOO8EPTc5E2A4APGC0a6
	 Mog2rk349LBaYMobLQI8kmkZtWiHUBzRu0sjz6sEAxuxglzAaFaOlDODWsWA/3x+sQe/6
	 kCkOr+0CylRQkIn0vtevmr70YYN2A5rHz1ME5xKjh/EeYZLkn6bYLM5Nk2F443FADkBx6
	 cC8tx1mtRh2h1v4lgOX41eABU14z5GjrdXr/lTyhTgI9VESbuIL9gvzoEVG4UDLJFVy1I
	 ef3++rNTJ2kbQ35YOVhwOQtfOUJr2Zu+pLmvh4MlhWpy5bVO9Ph9xeGiTMtKn928JjQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A0C6A1F01341;
	Tue, 27 Oct 2026 20:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132545;
	bh=7irLKmzjDJCrQVxQYI/Jd8l60rk00tZqlZ6y0Y14hI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=kNP18L8At5mdIa0W5eTLbTlUtb+6/5Ig+mW0tWgBm0PiS2FvrTyX7fmrGhOkWWnHe
	 mk80RnDQ/0nqoglaXLKS5g3QB1ULxYhsAO0Tbix7GvwnPTFsmSGrJsxMvG7TEmJGuU
	 w7t3n8tf5ZEZJM6jHpO2CnI2vG69c0uSHq848G12M+EPEzZLg+Q2ePQ4M1MRtWeeI9
	 q5ZC4/mh6+5h5E3W+W54uP9HxzzgwIC+UukCgTaw0o8Q5MeaaDqNITCKSkc0xyptaS
	 PxU1dK9FewzqtBZ9QrbY+llBdR2t4Y+G2Boy8TauWXQ0B6mVkpD0/mqWqJmMwQo0Vs
	 wsz5rrfCm40Zw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D585245255;
	Tue, 27 Oct 2026 20:22:10 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:25 -0600
Subject: [PATCH v13 25/39] dyndbg: check
 DYNAMIC_DEBUG_CLASSMAP_{DEFINE,USE_} args at compile-time
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
Message-Id: <20261027-dd-cmap-part2-clean-v13-25-9267923be612@gmail.com>
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
 Jason Baron <jbaron@redhat.com>, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=3645;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ghzwH3o3jabLz27l0hBrJ1+AjVePZJA2GuQHvcYhnZA=;
 b=Qw8iwXHrNuklN9pySdX9NVg+OD0LBTiLUTpqUc+i4QoX2kZ0MePdE8iGpJuEV/J5dO3QVBQWi
 ccwBWGjhzNQBSZAHFn2wT16N1cN+Qc3QnQdxO44/gqKS9bOUcg6n+iZ
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

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
 include/linux/dynamic_debug.h | 14 ++++++++++++++
 lib/test_dynamic_debug.c      | 20 +++++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 72e2efa86e33..c786b589c87e 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -185,6 +185,19 @@ struct ddebug_class_param {
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
@@ -198,6 +211,7 @@ struct ddebug_class_param {
  */
 #define DYNAMIC_DEBUG_CLASSMAP_DEFINE(_var, _mapty, _base, ...)		\
 	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
+	__DYNAMIC_DEBUG_CLASSMAP_CHECK(_var##_classnames, (_base), (_mapty)); \
 	extern struct ddebug_class_map _var;				\
 	struct ddebug_class_map __aligned(8) __used			\
 		__section("__dyndbg_class_maps") _var = {		\
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
2.56.0


