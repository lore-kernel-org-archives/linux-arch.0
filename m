Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132538;
	b=nGG8UjmQZvpOnHJ+JcBrf1T1AqqY7Zm1h2UNeig/D5XB4RHYpIKz0DnUsjepqGeDGarw
	 06XWxRKT1HdoqQ7CmsPONuD4GGQMgC3zSd+V3qRc7nXh9sp5Sr1u/BubrAyDKdbbBZ8kM
	 HRV5d9aowXnA+kKGjpe7XeZ55kdwbxPxIYxSWVzp/fciwKolY9XbTPZagYuHaxGYEmFFi
	 cXHolg6kTc7H4hidDtIvG7izGaBz/qGSSWyJmc7uMjADPV+Rh76dTl/pbzvus6raWjgtB
	 My7+z5se6zsJltB61cH9XK/mUNBEx/GNbcuL+Ajogh9y6P1zQ7dTxgMEXp/0EhYuF8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132538;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=emuw/obLC7nb1Pb4ljgujKeblxNZF1zKewrlqVyhTws=;
	b=jFBpvMzX8GIt6cxGwxm+H9quRrWI82r3wA3caLZ7CtQdKdVf8uzIgEt5zTBKZDtdt/Q4
	 cpQex8B3AbHw0ET56wd7afjVEFhbzh8yGt3vmD8ECVcV1EIowSTY9JnDo2leX3mEaRKIE
	 jmMf92gSEP/xs7qQXUNm9evtzBzAU4zldXIHK0lwt3R6O82yxdZoB9rN2bJ4xSx0WL22j
	 ZboHN7oYTrOpZHC2rjhtJgRohLtyNoh7Df9+1uhfcVk9/gQ/M43ptboj65eqILibNwTp5
	 8/y/b9oooulRsEdpNdK/D2K6gHtHNYndiLYclIqH29nKfu3DtdX3+9eaMPzm4AhfSqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BG6OcOlA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E072960A2631;
	Tue, 27 Oct 2026 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BG6OcOlA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132537;
	b=m86kiYJ3qCheGhgpYuZZBXWHZQiYRK61QK8amnYsLi99srWESvpFI7JUda9fIzvKZ14I
	 7Tl4woPLL86oCVnje84qiWA5pC2/GDyGQRz5NZ8pQ+l/4Wb+4jvNqVkTus57cXqCWEpTu
	 wJDWBHNx/w0FDB2/plcw9rfqOhpXhIadP/v17dxFHOcKdyOLBNbWkud2VSc/8jNlVoNaW
	 4kfewmHn1xI0xNPmfI2eCxCIsn7QKaZGZxup6MPb8slpvY0kc/IgprFXIdaMRPDaiOdLe
	 u8kGGbiu8j7Q9vb2XuXfV6FNCX7r0BQjaFoshERY0+U34sqiybvpS5ACB5n3mKPDiUg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132537;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=emuw/obLC7nb1Pb4ljgujKeblxNZF1zKewrlqVyhTws=;
	b=pUcJa4rf7V0WqsCtxAaJnv6RUqJQs5joF/RU5TMOIUqPOmObFs5k6nROetPp3MBbBITZ
	 cJMb3AYLIem5iUX+TPEdZ1Rax7h4fCdi8TUAe5FEpQ9mWFlr+DOCFobKcpOEgvLO1csdl
	 dlB7qXnan7kn1YgbrChzuzy7pXhrZmuNIk5tk9MN6uKWg8pvq9GeV1pEoJqcemra6GDCG
	 kEJngBX1t8e2mhQpDQRrHcoPsQfWD1n7g7DtlMg50GrZhP1Yex8usQYoEoWV+mG7J5k+z
	 JhNoz5bEi49qGO2bPeLq8Nu5AmL1FQu3KGP3namYLp/iCXx/ByR/sygywhTy7VFQ07g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4F6BF1F031F5;
	Tue, 27 Oct 2026 20:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132537;
	bh=emuw/obLC7nb1Pb4ljgujKeblxNZF1zKewrlqVyhTws=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BG6OcOlACafwBSvZRojGR63LHPL4CsKzyUat90vLdRldbW8px/Z5PpG/M+4PSv+A7
	 Ap2KBZa8ArDvYl6Is2pIY51tjb/oiwF6RYiHMH6pF07bzV42tbr0L1hDXBHcHexi48
	 CWK8RCUAsVwsnuK+yYkMsvG4BTjSoyzvmydQO9lA7bRVlx8udZ9Tfd+W7jDio9rd+A
	 158/jHJS3xKITnMtLuhNtq51ODNNbOWGj8Jr2F4ca8llegEJ8MKZnrtNqF5mu5PXxy
	 X4uNO7sv5hC71MkdSQ6pFlHzagYRWd8cb2+ghkBFmYO43ghQDUs8W19nAhuKCC7O0Q
	 fQIl2nNWY9w3A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 72DD045235;
	Tue, 27 Oct 2026 20:22:10 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:17 -0600
Subject: [PATCH v13 17/39] dyndbg: macrofy a 2-index for-loop pattern
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
Message-Id: <20261027-dd-cmap-part2-clean-v13-17-9267923be612@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=2812;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=LKjnKP7NYPVguPjLEUxkCUPSBa11rZIxcGjRB4ZSd+M=;
 b=EOlvd5AcBN7hje+OUnFM5AHINjVhQYwDEt56r8b6ZF0g+HFbgKFRv7J8GDjG2prqYfM2VngEa
 /2TcaaiQ89TCBujsomLXdhbwIO7qexocs/tB6QGobEbV1PU6/ngQqs0
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

dynamic-debug currently has 2 __sections (__dyndbg, __dyndb_classes),
struct _ddebug_info keeps track of them both, with 2 members each:
_vec and _vec#_len.

We need to loop over these sections, with index and record pointer,
making ref to both _vec and _vec_len.  This is already fiddly and
error-prone, and will get worse as we add a 3rd section.

Lets instead embed/abstract the fiddly-ness in the `for_subvec()`
macro, and avoid repeating it going forward.

This is a for-loop macro expander, so it syntactically expects to
precede either a single statement or a { block } of them, and the
usual typeof or do-while-0 tricks are unavailable to fix the
multiple-expansion warning.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: move RvB after SoB
---
 lib/dynamic_debug.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 1c0604d7e3cc..84a311fac657 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -149,6 +149,20 @@ static void v3pr_info_dq(const struct ddebug_query *query, const char *msg)
 		  query->first_lineno, query->last_lineno, query->class_string);
 }
 
+/*
+ * simplify a repeated for-loop pattern walking N steps in a T _vec
+ * member inside a struct _box.  It expects int i and T *_sp to be
+ * declared in the caller.
+ * @_i:  caller provided counter.
+ * @_sp: cursor into _vec, to examine each item.
+ * @_box: ptr to a struct containing @_vec member
+ * @_vec: name of a member in @_box
+ */
+#define for_subvec(_i, _sp, _box, _vec)			\
+	for ((_i) = 0, (_sp) = (_box)->_vec;		\
+	     (_i) < (_box)->num_##_vec;			\
+	     (_i)++, (_sp)++)		/* { block } */
+
 static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
 							const char *class_string,
 							int *class_id)
@@ -156,7 +170,7 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	struct ddebug_class_map *map;
 	int i, idx;
 
-	for (map = dt->classes, i = 0; i < dt->num_classes; i++, map++) {
+	for_subvec(i, map, dt, classes) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -1166,8 +1180,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	 * the builtin/modular classmap vector/section.  Save the start
 	 * and length of the subrange at its edges.
 	 */
-	for (cm = di->classes, i = 0; i < di->num_classes; i++, cm++) {
-
+	for_subvec(i, cm, di, classes) {
 		if (!strcmp(cm->mod_name, dt->mod_name)) {
 			if (!nc) {
 				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",

-- 
2.56.0


