Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132539;
	b=Cta1Sq0KSxsIwvxOY70zLeDDTgqt+rvoRiUK15GuEsqJTej96NFy9XAD2imkXCf5taUX
	 kSXfVEUIPhLEPfd2378clRMMfr7qpCgOqoujCiIido6dO/eumhRe+xIVPv46ePUXtqeKJ
	 eNkJSmvYwtJZAdrUwbY6g2ivoGXnQHKoyiTXq12vrYCLcXtX6+2NETZgWnQdvb3RKm6m5
	 gt1iB4umih5RM/3fbwjmDeAznophii4UqTkAgHBm8hg88QGfYm85wVyOpdIwgk8/j53/y
	 5g31Ql9KC9sJHWh4GeCRYk9RH97mZbEv6beSsIKgl2LUs4pkVnwVGJxKKIfHZQ8kONA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132539;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pAbzIfs3ymgyt6UeBjNwybzpsbVvnSgiP8ksXvEvp7s=;
	b=KPhF6U7dZV5xreEzOPBTPhA/AbYANRmw/spkQZ0UTa2PG+QaCg6tH1Q/QJG8bIqoj9nW
	 HEuLe06o3K+ZirI82b8anlU5hfYZls312G4ncrn9M05tfW1BJzcmesal5VVQzdmgZLoY4
	 UPRXZWiZeCJpWJ3h25tR82bpOnthLAer7qEUhiuwXyNNAFpuX5Fdy7spr7cD0CoQMSvTM
	 BCkkaVSdgBpb+I2VYb72X/RjoMHnlbXU8nTOeOk/0RfjSMr7rSU/tepKFfDXtGNoyS4Hx
	 jy4sCEzzX3zZtbKTOec4j0FRml6Pb3ZnzO+S/c+YR9RmY0oSmvXpa0D2vtAuZKKFsSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lGZZxAAX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A39560A3817;
	Tue, 27 Oct 2026 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lGZZxAAX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132539;
	b=meb7mlC+tYvO+fsQnAbH4CevMrGRIltA83YAQrrlwfAPn4tmBsDXPxSWz+IdnAiYbPku
	 XteTFMG+fWm0CCu9vV7N0Ve0lZCH4ENUqkN6WWGcphB3Eg0sCBoE8gPrJabJTjqa4BhOp
	 Nl4XyEsKSoYRx5a8os0V2HcUPR0mTKdEUVwNkjWnQWGfgJha4CBHZjo/p5KM40BtBFtN7
	 nkSIu6V+2K+cgMV6DLKpsUU/lDlucotuePlSdX4T3EYjVeYVCuEiwyS3gvklzP3y8Vzdu
	 wK354G9uLhkY+e3vKywSN/zMD/p2nXbXi+E9aUcWqOSlNC2be53SvVPx9fauO+iOOzQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132539;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pAbzIfs3ymgyt6UeBjNwybzpsbVvnSgiP8ksXvEvp7s=;
	b=h0TxgOD3b08Wzfx572e8Tsqw5bW2w9ejwxPI2lCr8agses1hSrJf4q5eo4AxDA5YyzTp
	 GTMizCc2FLkW9QS3hzuKj83ZMFuf/MZnzV6myofKgB9181srwIS/s/aHAOn4tWL/Gi49o
	 5ariV3Ia0p0eDyfzX3mTOlS8FEvsL+BWJ9T649MHMYyOzPlShnJLCrR+l78ZxhDIJYYG2
	 0aSkz1ziFPpxxSH9PGlBaVK3Fb2ogaQIkO25z1r0PkD+oaBKKJe0vPMfzy8J1qsYi0JJV
	 uS1XVE5BidTtCASbArsE5CANN5VkSfTUP68+DoG2FX9nXemiH+ab1Z0fSJwV+36Ct7A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 51BDC1F031E5;
	Tue, 27 Oct 2026 20:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132539;
	bh=pAbzIfs3ymgyt6UeBjNwybzpsbVvnSgiP8ksXvEvp7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=lGZZxAAXEaSYgW1Zf+OecAfycWk7Kiz5Cc7JwBsZzAnNIVSut6Zqd+J8d7zpM91TI
	 tj7SFc3qiTmlY5pIksxqSGG9vhhkMo3codnQe10vOsbJkEi/mclcgxhl181D1p6hbx
	 11zMJbzi1KIca6nKF950Oya8XWvVO4SZ2O8kEuA//PYmV4vjcFLuLDVkpU22HyYEPq
	 Q9I4TkYMQ4OKfdKxa49mZg3YJlmC9CkZQZV2ZWAVzh78NYB+FH0q5IHLLj53RXijFE
	 QUS+hQKLzbZvA6jpCnW0RcmmecHZOHJ3Qm/P1dSH/Bk+jIi/c3gqjtAZyfuMfo3sDT
	 n18Rj4ZXN9I+g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1A4C24521D;
	Tue, 27 Oct 2026 20:22:10 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:11 -0600
Subject: [PATCH v13 11/39] dyndbg: drop NUM_TYPE_ARGS
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
Message-Id: <20261027-dd-cmap-part2-clean-v13-11-9267923be612@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=1542;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=4fUQ6VDuWM6S7NYu7bhh+z3cfhN2DdlYIxp8VPxliP4=;
 b=WGx/gQ/TRPx53OR2rejypIgr1c5iw+X7Bv8tapAH0PrZsCEWZloxnH2slTGJFcWeIptJ2You6
 FpBG8tL053xBbOSnnJ3nKlK2QKmeTLo7AlGnFP6+Ebm2jCc8jt6SpcX
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

ARRAY_SIZE almost works here, since array decl is complete.
But define it locally, named __DDEBUG_ARRAY_SIZE, to avoid
include conflicts with  boot/<something> on some arch.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v7: actually use macro
v5: drop include, it causes redefined probs in /boot/* for some arch.
v2: include linux/array_size.h, correct commit subject, review after sob
---
 include/linux/dynamic_debug.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 9607121c3072..baf5c0853f45 100644
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
 		.class_names = _var##_classnames,			\
+		.length = __DDEBUG_ARRAY_SIZE(_var##_classnames),	\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);

-- 
2.56.0


