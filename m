Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9503BB9FA
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477144; cv=none; b=onQuystMAF5XfLhWsLIaBBrtgMoi8we2lpzWLtcAqKEdxWcLIn/OzW6CPOK6W1Vgq1EBgyn6ALIuLuLl+6WnwU3fHJR8484QidbToBIi6+pdeVRGAuX4w97/B9XhPSG4I1KyvXKo/0yJivypEslmXLf5Dt0imJ36fFDTJvcwd1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477144; c=relaxed/simple;
	bh=f1LMLcm7HpUCjY0LgwqyXWI/nbYSKkJlJGfL377JIvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U3ioWAG8xAgHWZCxcjwnKiWV7+mcsMyUot8PZbt+pVsAcFYvTvMsYmmhw1ZqMYcZczZ9Xb6crkOA/DsS2E7uP7GuxRWI0JYwhZ9OIeXpS6uNqTRRheVBU2sWBB6mc1+lQdrRXUH9ClJgB2HAZJhRgZ1YvmQdJslyxu9rZPbE/yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+9tixgG; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+9tixgG"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-495b250b01cso188064b6e.0
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 19:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477140; x=1784081940; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k3atFQ3HfHjIkDoR1IKy8zbGv01SGi/asouemJLY7Wc=;
        b=f+9tixgGI6vAOSH8Yy51o4nLhf/xg5DNdd9rRKA/F2MSMfsIFgGdNROB0EpBarjBEV
         QHCdZkcWEGUZ/ZxUXq1uMN57Jk+z2Qvmn3vR4AaaIpZ34AepTmMuOlKeTpAOED1FEgra
         3rXeZ/cdkF7YDEf82UekpSmkPozT2yKjnY94HTxHMzJOB/QCz4/1vBoAb86TqwmSobvZ
         xDjVBZx7g6TbnZk9IzfJs3ouchR7u+1ri2zA4eJmDVRc6fng+Dz/tY83Q/MuSjM1mFso
         ipAfaV6IovFmVvv67SZAQU3sDJwdObhAv87mblY7XhXZUIKzqZzPIuQg/THNIrbAdeJM
         9z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477140; x=1784081940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k3atFQ3HfHjIkDoR1IKy8zbGv01SGi/asouemJLY7Wc=;
        b=gSH/P3LOEtIThnbqggT0NmqVK4DE5W0IMgPGReToF68mdMPzxE4YVUzsBG1ReUVxJK
         cyrQ4ldTrwN4M2tt3qLkqOtoHQYlrIJpKRhYN6a+m/uzHjjpHjNzuZn9BDL0sLPZgsqN
         af2dfXr0XSVncLtFBuz6adVQSAsuTEgB3AL0f8D6RY/r+6l3UlFl94Slzf51J+L9mWDQ
         HZMG0hCm+5aJZAkGPHiG/2FOD+DP+eQxVHSqwYcfpvAVvUgoW9eUMTA0d3zSCc8lQHYO
         sSZ6lvNCevGnbX2qfiFVwv3ZnlFrJJHQ3TBNChnfCV3frT4RMy+xG7x4LxPI3T9Fw0cw
         dpXw==
X-Forwarded-Encrypted: i=1; AFNElJ9eupId/2rbbIwTdnq3A/0aivB1UajoTgGrGdXIHwJTqBcmgozilpkLWjipQ7wO2HPxQO+inwRvx4MN@vger.kernel.org
X-Gm-Message-State: AOJu0YwDSJZ4tsF4wJyYb6NKdUMISOW5+DmzxxG99jL/RT8IGAUj4kmo
	kUvYURm6hDtgPxIg0dekD7vEY0zIbxoZKwPeBNSl7M9nQt7/ROpcQq/C
X-Gm-Gg: AfdE7cmE5pWi5T8/BJ5L8AIXd08PnYm0twV5Fc+b65yI50I0qVe91WzYlh2YgfwE545
	R4+Je8k5i2JaoDsWnv1Bh4y2ntSNn59qrukR3q6LRp6unf+xjkCOhLnaD3zZWLpSndp9YrXvn2O
	WdtGkJ+XeIUYT6i4+qRzriLUvQPUAXzLPnpaNGTFwn88CbAOETYxK+Uct4SlWSeVzh68DxjeTpe
	0U/Cc6Ef6xnFRTRUxbvywH80NCQXDn4uwaYMSErkMIzqu2aPp3ulHZwkkC5CbRTepD4AE4oAuZE
	keNSYpVSL5uxJT6FY7VgskH7VKfx5pABGC0fi+xY4NmH6kYRF2FKAYpUugZrPSBZClgmoHn9XT9
	awp9YXTTDf6vPaJVgfMfse69ZzmkrTdN+rpalevBuVU8r4AdOrMkJnLQeUG9hwrdJh6RwGEicqZ
	Bi9St02x1w9VSpiqNiNmUxYMDLMp2xWrk5X7n2ZkAwFWQAne8bx88=
X-Received: by 2002:a05:6808:124b:b0:496:e0:a47b with SMTP id 5614622812f47-4a2039be59bmr318703b6e.20.1783477139780;
        Tue, 07 Jul 2026 19:18:59 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:18:59 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:18 -0600
Subject: [PATCH v6 18/24] dyndbg: macrofy a 2-index for-loop pattern
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-18-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=2812;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=f1LMLcm7HpUCjY0LgwqyXWI/nbYSKkJlJGfL377JIvQ=;
 b=trvcg9ZaNLsNIpDb6Uahb5ZcOJlCuDAsyAa+3eRBSZB7MO61jqTE3zrEhQimlEmwi6binJuG6
 P6IJQn6YMJGAAWzMGNmmmraV/JO+uz6t5b2sQ/9PueOX3S0uipM51O6
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
2.55.0

