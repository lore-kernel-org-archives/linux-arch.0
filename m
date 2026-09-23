Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405CB58B6C9
	for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202924; cv=none; b=p1h4jt+y4KiewayzR8YRVmlEatg6xnHN3BsnymIwuXyufDYBRbBVYTi24/+WocakT0rUV7/cY4nPNiRMIPnZcsF+UEjj0vBvCccKh8VRHiNFvKwAF2HOWpXktnPP9lCpuYTwYPpAM3nBHhQJPu9/CER7o2TOYXyIkccWUAvMdPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202924; c=relaxed/simple;
	bh=zCwr+VGqKnNAOkzayghTBT7W0F9XwKbxJ4/xtvRrwII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f85oaXmL4N/HVN5LkxFCaM+vd6Ws0grPi/PpbpMwUSl4LOaRQm5KYhMqktOji2WvbU7YM3b+x2LNbNKjlj28zlv1NMPZpDdF7wzJ0Lpv8d8BSLSljWuMs0q4y82mHqqQti7P+6GWh8nt5aL8WzNilx4zEeoQMUdEbiaTEozXbZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nzja11FM; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzja11FM"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a3ed714so1020269b6e.0
        for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 15:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202920; x=1790807720; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zfwGwbUwBRuvPTUiKX1AIC4L/SKKbUUkwfFbVYVud+k=;
        b=nzja11FMb/s4BNpfi7CK/AvhmbHstDDYJKUhXQfnGZS8AblwgppnFMuZolhLkW4/DU
         A6bHAmkIXYx8Ovj8ZO5dU5sCL5+MAzfLwRTYdXKferqxJBzV+5m9WHU2fO/Vh+jbDlmZ
         LROZ+1eGKV5LA5KfbtSrSEZ4W3Qe+KqxpyRjss0m18AMAXDdd0niqpIle8L9bCU5wIXt
         fqkWECLtaJ5AZ27aG5OF3W6/mW4FIRG1qFr9H9ldmJBQslzztYHuaj28vtO9rc54A5NY
         3ZvbUuJcaXNg6tXtzwFxjlECYiuECs5JWG9mr6cmuZ6OAjvRW+rkMc6gjicBDF2vs91i
         ojOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202920; x=1790807720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zfwGwbUwBRuvPTUiKX1AIC4L/SKKbUUkwfFbVYVud+k=;
        b=hEq11g3FYbcxJo87KG/A8Ng7L4yNZC2J++zSUlL2jLDSsmNVHaz/G720d8tXI9FcnV
         vpl61i7lqxbU/EkW7nrAQ4cnwhMVGanubiTBM16yHA3heqG+u5hKSMbxAQeZX/Ho9q1u
         S5iT4KSNAM/75ZXEDMYqW2O7q9+ilU1inmbNyEt2O3goAlbf1U0tJQJeaPzRw/+9E93S
         6/bYSuCGWFL8WJrPfHp5XiNfmMjgRAPXCvNOc7pOm7eioRBAeGj/0GcbaUuPBuyf5mgS
         FnItSsGhSQGLxG7gqOeUa9iz7EZHOLbEZblfZStOrrBw4h/VdDCaSWK3XJOEZ46OWEmq
         mYiw==
X-Forwarded-Encrypted: i=1; AKwUvByS+CKvxHRp8pmEekHmVn0JsGg0yuxUoapoYPKqGVtddW2YBpcRdMv7Ecwi36LODf6piKljruCsr3Tk@vger.kernel.org
X-Gm-Message-State: AFuF++lWUTJ9q+s91SbROqPkrSUcNb54NOSO/IlxSu5eS/Nry7X7wzPS
	9cQx2KAJbQomwDbSni77d3foaD8yn0x36Dol3+j4EsuHhPJjh22Pg7Lv
X-Gm-Gg: AYBFou02OQD7oBcRZn9Q81SDId1c985kpuWzSYiTJvRwxfWPMks0B3mEuAvg2hoJ6tW
	QaEqqRJBTDUwWQr1GH4AoHwGLWdnBUsItXpVEeCu7+xKtoHy1buU+qXhuaWTXv3xkI71iMqidEY
	qgnpbuPcyqvPSD38iY+o2nyRvOXhyj2Lm6VEMFFE7WwACParYGdcnZRaUYkpNluMrGTp9BK3vDn
	oj+fxKpknsbD48rC2OxtC1Ovk06timnVzxpaXBs/CGdL5VW/RCt26oeqAyRyNDAyBj+7G0FAd1N
	dTK/n/dYaEIAfPsPTJ5/VvGCqcFk4ihco1X5oHnSqEROkxOM+xw2iqj10I5uSqEeLCjU0JtUDgF
	wjPfEh1MBK9jsHnzO4STor94OeRZRgxhIxxIYb0BRxQnqp7z5qgM+eV0V72SVMrmmRg9PVFX6+4
	7PiYeE1niX30OWZ7+4L/4HeY6KKTP4WzYCZnnkFAZVsPW2dOHWU8ib+0v37awNqScCzjf2V9Lwy
	fNHe3NELffiUp8B+S7fbAlVGT9PHv+Zsqi9O2AfWwm7Xdsc5KnoQL0DdZASp4kX8DT8zUAo8WjN
	z0NPIn3FlIGpuKqTctqy
X-Received: by 2002:a05:6808:15a0:b0:4d6:9252:4644 with SMTP id 5614622812f47-4d72ea60fb1mr765397b6e.56.1790202919796;
        Wed, 23 Sep 2026 15:35:19 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:35:19 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:42 -0600
Subject: [PATCH v11 18/38] dyndbg: macrofy a 2-index for-loop pattern
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-18-9b6c217fdf2f@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=2812;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=zCwr+VGqKnNAOkzayghTBT7W0F9XwKbxJ4/xtvRrwII=;
 b=MtxKW5tqPWiU+c3h1aFiaFOnaqcptE3iPisUyD4ekvG6WyZ6vBzitYfyBmZ8s+ZdbA9UiPRPj
 IK6yKEbDE07BHfoCfxQJDvGQ52SxUshC0CGJ1Kcd+c1y+apgADflV6h
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

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
2.55.0

