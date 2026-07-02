Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359D43ACF0E
	for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2026 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010503; cv=none; b=IU8CLCCM8xH1D+vxUwt0JAwfCk+zVvimD/87Nt9f5+crOoyWeTApjPfpRmAnwPFm0Kq8FuMR6pIhQHDF2Ta5VdkIfBhuacsaWLypqP9ZyNIOh+pU0xUbVKJ0bAuZ0eC/7qc9tIRkjDIm9Ul2b1uLNZ07ZPQ7lCeHtapjS4w85C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010503; c=relaxed/simple;
	bh=P7lO9A8LPVkryGsY8RIV4ZKJga8IqX0oHHS7prrgxeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DZ7xqZu9vtH5WNGX09GvX2KE9xMB6fV21/Q36HLFMENUnAAOsh5ReQWPB2DCtbCmIny68hMgzF1yYY4d1t5IEzJCHcfP7PPFbB0Yg1RH2P/Hw8sdjIGtbvZiXjdyMoUzR4R5Nm97a6kfW9GFWJUB2hi6ORK1sNXpALDuGgLYWLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyA9u7Fl; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyA9u7Fl"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-44cd990a94dso405370fac.1
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2026 09:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010494; x=1783615294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y22IAHS2DQHIuwdJSUGvICtgOAsEzbta+k4+G2yELGI=;
        b=dyA9u7Fl38DO8OiOhVffsqfJQaDn6FYlnv8zxwn/NWUxs0yA/gkZG7hKj3jK90CKEP
         Hn/am9vyNk20rTJAFdhxoefl8Y4X499VNH5TmQjcD5Qezw/UwVT7pnj6gQPxoparuW56
         DkTnzDsWid+gs1TJbV6gAyf0eyyrwdohhFwA17Ka9kiL9qDDeK2nJQeqW8B3ExmGt43W
         TYss2yr0TjyKSXUOS+vUE0p4/n4TGOvRUGvGDUqMUquXB5rgQoZ2DQcWC9gmzKVAuEuj
         44cIN3k17B/Y7gmNXG1RL/vG6iCiLmsE5UCpibmmEYSJ8N8ALpLfAB/fZeoc0VT7aOMt
         lOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010494; x=1783615294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y22IAHS2DQHIuwdJSUGvICtgOAsEzbta+k4+G2yELGI=;
        b=U8aoIVHD+r7iFp7sNvBjL5vC2FBvCKeupBq11v71oXj7x17WHqXg4nJNYGHhvIrYX9
         E9oGbSS65xzJORm6ozG7D1es49EbEniy8WQVFmHKXGk87tqX2ZNOrTuRt+cTmUn9759f
         h6Q7i5kG7/5NpZ/qFxMTfv4MFHHXCSHtdrD2E3gzuOnQWWVgvRquhYIPLSnldWkMhFMv
         bESoOEodoug49su1fyx9SPDtdb6qG+3FFlHf5yItAluHv4TtGhU0BoF2lw4gu9f19D2w
         ziBzcouuJNUH4nqf8vvJNv3MwcTeggzB+iDJ5Hfxkf9+KZXfnn8EFPMnZ7O4Q5CABuna
         DWjw==
X-Forwarded-Encrypted: i=1; AHgh+RpubYRrOpiR4roAdAJflVuTFaMxa3r6mL+R3dUuA3lwg/VhRrYPrxwX/aCE5z6NdPC16fbAz/lHdbxv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ffqwNygVlK9kEZLCYHRKjAzxtZ9TsfCNT0EZP/5ifrm0Xm36
	RGA0wBAqOJFWNHws+/32ZVnzA/BpJNsfmWE7+1PQ7BsZBgBN+qPTnhF3
X-Gm-Gg: AfdE7clWzDOVBw/TM3p70GxlS/HZKsMuJyAQkru4CTfNiS6M0L8YvLQ7OxJYFZgntuR
	q7/6Hapnq+fpXxbgJPOoyImIp6ws681UZnEoStBysiFYxKNhCHB7YtQMogCAjpRxVPVT/bqp/kr
	i/Di6wOLfC3caIyUZ09F9dbtPVzMLrAf1y77Nphu3i8tJ+FBymI4iIWWEkuYn06B+sR69hH4JNo
	RiPVEZg2bB07gU1x3gwhZqrmCMjomPVztHkmPr29/92vPV+iBudsPF2znG56fKdT7QdvTpGbL1K
	hBmbtzCSY1rOv1mfmEkl9napWSYV/mssDdfdsDxX+u5xoYn+ZgNy7BKP+2G2gym/p6cpRoFwdi9
	Jzbe1GNJONzrFqQ0MK4r5Ovh5VjZPM+fS+toMqlA51zFHQEKgAoOTRj5pxgWK/o7miT+qCzFAQo
	1f5D50nGBHKthKq3P3kIrw43zV1Rota2WsbWa8y5VvLtgMIv5IgWs=
X-Received: by 2002:a05:6870:a24a:b0:447:534c:8a85 with SMTP id 586e51a60fabf-44cab72dbf7mr4223853fac.18.1783010493890;
        Thu, 02 Jul 2026 09:41:33 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:41:33 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:41:05 -0600
Subject: [PATCH v5 13/18] dyndbg: macrofy a 2-index for-loop pattern
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-13-24f22b052bf2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=2812;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=P7lO9A8LPVkryGsY8RIV4ZKJga8IqX0oHHS7prrgxeo=;
 b=ZiFRjEQiBoPzgQl6ZTTsrHxeLEogZj8ZTL25G5df3P3s4Sjm5hzaZ+RcbiN9KKPPzRnwz2kQ0
 YGjKn7AsmcgBmT4HfFcylcgtMeY+kn8FVpTH3iojpRO7wDqkeTltnqP
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
index 6b699ed23d26..d99c69b9ad12 100644
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
@@ -1167,8 +1181,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
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
2.54.0

