Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132534;
	b=m6PuGr9GyHqIC+/eFxc72tbVUZxgR8OGd1RFmtLXKLz0d2bGY5vxgOdLBa7TF2Lfb+In
	 OTE2vau6zJoXO2PrM/Hbqpf8WmT1xmKeQ5hcDy+C3wcYMFBEDUShrgD9mKzuc4Gp+Wqm0
	 b+shUt/e5miOoq2tANJ2gCMs+Es1TN5KfPziszplFvkP7UVoGcQo9EwVPvS/Q9zjwE0p+
	 XstPcoq2kIMVHWv3BbMPGXDLEQMxR0c8ft3TL/TRm2iqYSSxD7oGzMB+93OSDgNHzixpC
	 MfqUYxraDZw4dlr70IGWuoNuF+G6ZsMcbeBcJFP8HXofM/SHHSDs86D6eqsitmrSI3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132534;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=p8OLfPjJJxghmVweXow3lGp05o2c//rUSd8L9sTgH9M=;
	b=RSWJ2rwi2gQv45XW9k1ChSQxPh7sc+p/zJ6bPzN7tBAAuNRrs0SsIuVeydIrpuL+m8g1
	 CSPCzgURZIP7A5S4DITE1fUKNI1Uf/1R7wFgl6LHp3xBav349vfpUQM7TknOrmSA8Se+f
	 /B2RkPe2UdPL3YpyLyUQhY0YL9Kk1IP4moOik1+/d+agSWZ2PPEWFWw/5QYHxGkjGMcdU
	 S6vyyru9mVKVRK4n5IXlPF5Q8CKJg9Vvbd5vesEx3R+iwexQKxgYDPlFz3gj3SLyf5HKR
	 WsHz7/5agaH9RLJeNH+9n8x5RBOmfAx4ab1ouGNI2JI3OJYn42eFFsUSE+8XRnxMCJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UW8SQd30;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB822606A333;
	Tue, 27 Oct 2026 20:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UW8SQd30
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132533;
	b=Vk1Mt/xLiobDJz1URboEVtBDeT7vDgnV0v7XO9aTsL+hazovudT/Nuv2ZWPdXTW2HEbL
	 HeBBgQGbmBkDFGroHz+yGPnOpQsm620fSuDhyrb/MO5pjN9zFb1BQhCr07zZnXQ6ezH7J
	 OBluHwtUNC5R8FQeTqO6aI9I07bjRwx9njUxqAKfJnOCaKwDX6pcGjwIfucfLffoX9+yU
	 DWrs/ag9XaDuPZZplTspBUbSxj+QH1rBIAPkSxvaGSCYiHq6YTWUNrrsjFkMmtUHH+etN
	 KTzsHC/SbPUagzxoaFoPq+kDbn9qThhTNBT5G0AMyETffoV7JvdHcEclJvFcIy5rHxA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132533;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=p8OLfPjJJxghmVweXow3lGp05o2c//rUSd8L9sTgH9M=;
	b=gDPFKq5aHQoT+NEEV0h3fpFtvrS1kFtcJCX8jNl6tJkicBiouBeimFeIm+YnUYInzpBC
	 uXBLNkHIpFaKq8Q2hZZzcqV2E8XCqWflt3v1umnxcf9bfRtSeQELOAk1OAAfDQ5NufEwl
	 ev5XsWfEENi45xK1HUyAi6BGeXpQ+gFUcelsIomVWKl95bhVB9N/QYi58/UrEcQh2wOwY
	 Z3TwOuuHqTX56diGxEDsHf1OKIpxIZC9e3HKQTDQUUspdgQWMja0NyucS5ma3WGide9yr
	 orU5vvAbjNFKg34m31LPHUpG03RQ99p0MMPIW081Filew5+/LVlD6MlTl9VxyrrxZKQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 556CF1F031E4;
	Tue, 27 Oct 2026 20:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132533;
	bh=p8OLfPjJJxghmVweXow3lGp05o2c//rUSd8L9sTgH9M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UW8SQd30kqgnY5kGH4WIw6rnXJkqaKizcXwXOiIPV9I/YEoejLZVUMEXVV3qFwaJA
	 QwGgEbWERnDv/lhlAwMZ1DEa1o4RP55ej58NSZV6JWcYBceKLAhCvtxkbkqET0pQq/
	 WNABAhQeIUGHronuz+AdJ+WELGN5wO9LAghPKczJg7jeZDIIU9ZB30BvMTaL4xmyiv
	 ISq+Q5fDHyGKPalyEzeXm3H5ujQcZOd8klMdQfdbVttkeTH7S9BIy5ye5a3bElBkwx
	 tgo/C8tysa5sGvj6YgM0zjwK2mbJzHXTtQTtBftT9gvDaygVILo5CQEHD1PBtmo5n6
	 juNsYg674hDPw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E59BE45211;
	Tue, 27 Oct 2026 20:22:09 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:08 -0600
Subject: [PATCH v13 08/39] dyndbg: add stub macro for
 DECLARE_DYNDBG_CLASSMAP
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
Message-Id: <20261027-dd-cmap-part2-clean-v13-8-9267923be612@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=3163;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=SVpwWYWapDOMkXkjrEEN6bsp08Xgp+vSqsY5/WDA3N0=;
 b=N4vorS3MgiGRVy7XkNmxHoVIAqr3We2GyVw6SRWJxbaj4zDmrrNT++T2yaWHpUSelC/R3+Yrh
 t9lObO0SZH7A48uWGVuaBEInpDbalTDhdoeNa2RoNwtRmpz+bkF4hwx
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

Add the stub macro for !DYNAMIC_DEBUG builds, after moving the
original macro-defn down under the big ifdef.  Do it now so future
changes have a cleaner starting point.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 05743900a116..a10adac8e8f0 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -93,27 +93,6 @@ struct ddebug_class_map {
 	enum class_map_type map_type;
 };
 
-/**
- * DECLARE_DYNDBG_CLASSMAP - declare classnames known by a module
- * @_var:   a struct ddebug_class_map, passed to module_param_cb
- * @_type:  enum class_map_type, chooses bits/verbose, numeric/symbolic
- * @_base:  offset of 1st class-name. splits .class_id space
- * @classes: class-names used to control class'd prdbgs
- */
-#define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)		\
-	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
-	static struct ddebug_class_map __aligned(8) __used		\
-		__section("__dyndbg_classes") _var = {			\
-		.mod = THIS_MODULE,					\
-		.mod_name = KBUILD_MODNAME,				\
-		.base = _base,						\
-		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
-		.class_names = _var##_classnames,			\
-	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-        (sizeof((eltype[]){__VA_ARGS__}) / sizeof(eltype))
-
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
 	struct _ddebug *descs;
@@ -138,6 +117,27 @@ struct ddebug_class_param {
 #if defined(CONFIG_DYNAMIC_DEBUG) || \
 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
 
+/**
+ * DECLARE_DYNDBG_CLASSMAP - declare classnames known by a module
+ * @_var:   a struct ddebug_class_map, passed to module_param_cb
+ * @_type:  enum class_map_type, chooses bits/verbose, numeric/symbolic
+ * @_base:  offset of 1st class-name. splits .class_id space
+ * @classes: class-names used to control class'd prdbgs
+ */
+#define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)		\
+	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
+	static struct ddebug_class_map __aligned(8) __used		\
+		__section("__dyndbg_classes") _var = {			\
+		.mod = THIS_MODULE,					\
+		.mod_name = KBUILD_MODNAME,				\
+		.base = _base,						\
+		.map_type = _maptype,					\
+		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.class_names = _var##_classnames,			\
+	}
+#define NUM_TYPE_ARGS(eltype, ...)				\
+	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
+
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
 
@@ -314,6 +314,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
 #define DYNAMIC_DEBUG_BRANCH(descriptor) false
+#define DECLARE_DYNDBG_CLASSMAP(...)
 
 #define dynamic_pr_debug(fmt, ...)					\
 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)

-- 
2.56.0


