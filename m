Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C4D3B5847
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 02:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477132; cv=none; b=M9waphuWsZTxJEFSxLamUJ+nSW8PmoFdVm0iAN/CvGkDea4+v5YuvcL8lGCaCwm0zS/9QUcABW1J9ByEZZjZtShkLp3L17JsLV0Fx92tFWq5S5zSZa76IL5s+nO1bKqNZGzokEpGY0HCa3qSYRpBIO2GSGy9p19fqkBe2VzqgO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477132; c=relaxed/simple;
	bh=LKcWOgQjOSSos9Y+vfT5MoZ88a0A/4utKPeiOYeZmDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lLfdv/fvTpQ9Fpa2gy0V0P6bKsgIQreFtDThDCdkw06vnd53AuKNq3XMitxP6cuHMBcz1xh/YFy0XmLtc8qc/3syx1vuasjcZ6QKnTuVCZ2Uxv7oBGnhA/0JaZa6hpFH2qfI7X3ozfMYSfvwa569v0YviG4b0lCCnAMbt32W4zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfM1tA0s; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfM1tA0s"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4877a7b451dso145493b6e.0
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 19:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477127; x=1784081927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PMdUWN55evypGlZW0ubXM0NSUuJGy0J2aNFMM8kAHEo=;
        b=CfM1tA0sOmeAy+XexSBYsz16Y/P72r/aTvXSOSa+EWUGrnf9Q3GI4MT3icCmQfhxuE
         F7QB2FG62wipVpiRz6WghTXsruMDZMzc4+P+yGdwQ5T4wWpmBvljQCOHrIYzNkOprP7D
         daO/PyPn30/aYBYTkIOkWJs9U5bs8I37ZaMgUEkhA6x8s/HAWOb0pgubfkkKd1Cviu67
         1dhUGc+xd+1gvdxU+aA2RnbhuLSLM5pp8UnGjRpczcuQdXpjl9+d2lJvbpR66qel1N6M
         HGxjbE8nL1wYUyDqUC7Lk9GuX0IiUQBz567atUe4IMDtrj60GR94xdOfQuHrhc2gS3tq
         RrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477127; x=1784081927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PMdUWN55evypGlZW0ubXM0NSUuJGy0J2aNFMM8kAHEo=;
        b=EkXofWxPzcz1L9zw2jsbN1P7GRH5t2ckT5wC7EQwGI9T6oVwxhyl8mxooIbpAk+WSz
         IfIf/Vs5sTbGEzUN6xjDU6Lzoa7G+4yeR0vVtnxLi+17KoCj4unbjRjE8xM98qQQnc0R
         wOv+XSPO3YXh6sDQPL5SgEuQsK9wRVj7B/rtX5IjN0/WBS57NF0R3SrIZ2wGMkqCChBP
         rcU0g0UKwnrHhwhsSr5lKG16jICpqNoSkUWo2RIztmt2s8gMGBDcqIlkoEdvSUX70iwr
         4qduP0SncFHCe+LTD5Ce3Yl/3iQ6ESQ2WftncaPf1gDFYdQB+vda74jS9sNDXV6ZQaCz
         Zb8A==
X-Forwarded-Encrypted: i=1; AFNElJ9XnlyMGwVAn6FrKEwx+qg9fK5T0cairzJZea7pXJSlKgP9Ma59S8VNEXPJCLX+Fq2PK5rT1zX5SiIT@vger.kernel.org
X-Gm-Message-State: AOJu0YwDVqrYPcfThJCeBzrJZ1nFIQTY3QXHAIeGQ5RXuE7AyVGMghA1
	AY62cOLzaSAhmCvvFaZGxnfDxtwIZhDVFz/mHdrcPcVG8ylPqUP3SKlW
X-Gm-Gg: AfdE7cnPJZeV85TYADBMvIpBg+bFgJsI7GvgCkMwmT3LSMlbVCuvJRnJHbok7Y/PFUJ
	eqqCj0SRgg51tylVjp4w8HfkvAJdNxqjGKY9J+VVIzHjrgFdLq1r8Y7A7q4YrwkdyZoEyhoCBfU
	etw7ZRRtjOj4uRmBR+ujJBEowupkMrXgWTBP1BW+4ysLupk3ipjDZVC9QPn3fxRQS/Y61Vvp9Bf
	mlgGKRkwGdaLqpkCAXLD5tMj+802QhWtJPmO6YOqM4gV1lpTWfGMtRHK6BVLMKD6+h/sg5PDDVU
	77rSpk0v4nv4aKKL4AZYMyxB2pIjZeLWzSGVxVakYmQ+C946nthlr4eXcf62HpSS/9a4aij0He8
	BL6bEMJ46zXlbrUTiYRFC04Y8bTyr//BygGavng5xnsDv3Q/fd6uHAgHXNwSVfIpqVYqHD2BdIc
	NheeNykPNpy4jdRtnbTJLX178R3mpePsY8YGWWz+lB+DJ8Ud69Fbo=
X-Received: by 2002:a05:6808:1511:b0:492:2420:a722 with SMTP id 5614622812f47-4a20541901fmr294508b6e.20.1783477127013;
        Tue, 07 Jul 2026 19:18:47 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:18:45 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:12 -0600
Subject: [PATCH v6 12/24] dyndbg: reduce verbose/debug clutter
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-12-381f3edb0045@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=5280;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=LKcWOgQjOSSos9Y+vfT5MoZ88a0A/4utKPeiOYeZmDI=;
 b=8Lgqc9DREOjM+ZVTh2w6qFyVZbsU0Kjvp3BUcN6vC2a7lzixoefXPGo5M3mnkjEj+duXIIScm
 909ikVkabvjB6DYCgRISjXbILVp6EA3O80ayAxNToEMAyJzcVRudXO+
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

currently, for verbose=3, these are logged (blank lines for clarity):

 dyndbg: query 0: "class DRM_UT_CORE +p" mod:*
 dyndbg: split into words: "class" "DRM_UT_CORE" "+p"

 dyndbg: op='+'
 dyndbg: flags=0x1
 dyndbg: *flagsp=0x1 *maskp=0xffffffff

 dyndbg: parsed: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: no matches for query
 dyndbg: no-match: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: processed 1 queries, with 0 matches, 0 errs

That is excessive, so this patch:
 - shrinks 3 lines of 2nd stanza to single line
 - drops 1st 2 lines of 3rd stanza
   3rd line is like 1st, with result, not procedure.
   2nd line is just status, retold in 4th, with more info.

New output:

 dyndbg: query 0: "class DRM_UT_CORE +p"
 dyndbg: split into words: "class" "DRM_UT_CORE" "+p"
 dyndbg: op='+' flags=0x1 maskp=0xffffffff
 dyndbg: processed 1 queries, with 0 matches, 0 errs

Also drop several verbose=3 messages in ddebug_add_module.  When
modprobing a module, dyndbg currently logs/says "add-module", and then
"skipping" if the module has no prdbgs.  Instead just check 1st and
return quietly.

Unmatched query diagnostics are intentionally restricted to verbose
level 3 (v3pr_info_dq) to reduce dmesg output clutter on standard
verbose levels (verbose=1 and verbose=2), aligning with the overall
de-cluttering of dynamic debug logging.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v4: rename vpr_dq_info to v3pr_dq_info to tell its active logging level
    adjust some vX levels per doc'd intentions
v2: RvB after SoB

trivial change to verbose-debug output line to output the actual
"module" keyword rather than "mod:", and do so only when the module is
constrained by the callchain (ie as part of a modprobe).

 was:   query X: "(keyword value)* [+-=]flags" mod:*
 now:   query X: "(keyword value)* [+-=]flags"
   or   query X: module FOO "keyword value)* [+-=]flags"

IOW, adjust output to reflect the input grammar more closely.

drop-info-parsed

vinfo-applied-nomatch

dyndbg: tweak verbose-levels per doc
---
 lib/dynamic_debug.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index efe12fac6363..2e321b7eb957 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -128,7 +128,7 @@ do {								\
 #define v3pr_info(fmt, ...)	vnpr_info(3, fmt, ##__VA_ARGS__)
 #define v4pr_info(fmt, ...)	vnpr_info(4, fmt, ##__VA_ARGS__)
 
-static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
+static void v3pr_info_dq(const struct ddebug_query *query, const char *msg)
 {
 	/* trim any trailing newlines */
 	int fmtlen = 0;
@@ -280,9 +280,6 @@ static int ddebug_change(const struct ddebug_query *query,
 	}
 	mutex_unlock(&ddebug_lock);
 
-	if (!nfound && verbose)
-		pr_info("no matches for query\n");
-
 	return nfound;
 }
 
@@ -491,7 +488,6 @@ static int ddebug_parse_query(char *words[], int nwords,
 		 */
 		query->module = modname;
 
-	vpr_info_dq(query, "parsed");
 	return 0;
 }
 
@@ -515,7 +511,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	v3pr_info("op='%c'\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -529,7 +524,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x\n", modifiers->flags);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -545,7 +539,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+	v3pr_info("op='%c' flags=0x%x maskp=0x%x\n", op, modifiers->flags, modifiers->mask);
 
 	return 0;
 }
@@ -574,7 +568,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 	}
 	/* actually go and implement the change */
 	nfound = ddebug_change(&query, &modifiers);
-	vpr_info_dq(&query, nfound ? "applied" : "no-match");
+	v3pr_info_dq(&query, nfound ? "applied" : "no-match");
 
 	return nfound;
 }
@@ -597,7 +591,10 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (!query || !*query || *query == '#')
 			continue;
 
-		vpr_info("query %d: \"%s\" mod:%s\n", i, query, modname ?: "*");
+		if (modname)
+			v2pr_info("query %d: module %s \"%s\"\n", i, modname, query);
+		else
+			v2pr_info("query %d: \"%s\"\n", i, query);
 
 		rc = ddebug_exec_query(query, modname);
 		if (rc < 0) {
@@ -1163,11 +1160,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
 
-	v3pr_info("add-module: %s.%d sites\n", modname, di->num_descs);
-	if (!di->num_descs) {
-		v3pr_info(" skip %s\n", modname);
+	if (!di->num_descs)
 		return 0;
-	}
+
+	v3pr_info("add-module: %s %d sites\n", modname, di->num_descs);
 
 	dt = kzalloc_obj(*dt);
 	if (dt == NULL) {

-- 
2.55.0

