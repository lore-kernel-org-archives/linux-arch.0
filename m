Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC9634CFC2
	for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520523; cv=none; b=bagsUhL9drpD6CalvB+9gvbZWYjvrXfA7Uu8HM/xxji/xXYJ0chZr6swMpSYiVzldBgaG9gsdd2hkZBNljhJBnVfM8ScLK+ekePB968s8X8QrYdUhvzMxy9torm7eA7CvWEiJwAE5g3MRYd9TpIElArUZfMKO9+HJjFhNKbySrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520523; c=relaxed/simple;
	bh=zY26AoTDT5sXs+cwH/35lsu5KHT7UoaJFyISX4/PEiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PaAmKe2H0z1j9S2h7qAaHgEtcSkqbBsmmPyE/kH8cfDRIo/MTpZbPGCSi9AcA3aYrSDSsLQM4B6qm11jOy5bXJOc5cinVHUOMIehsJ0DY8gWKPMgkzKyrMoXGJbOM6Dt4OoRRb0kKvUoZ+1bLh7gTOKH9S4Q608ILF2GEC88tDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q1/6ALyK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1/6ALyK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490426d72f7so14009765e9.3
        for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 00:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520520; x=1780125320; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UrPKdNKgj6LivKrqLr8CgMfwExcBZv4b+V8NB+o2xak=;
        b=q1/6ALyKibzj3o6aDV1YE50rTA6024QvKw3ZMDxGxL4M8KD4ulePXnYjLcYZV6Dm82
         D0/JSnDgtpuyRGAA3X773ftyiBUFTqFmNzYWNY/kEhXRabRuJTbtMKdqB+ZQayX3o8li
         tYwV4bq0mCoFzsJfaWB7E2y4kwgGuOvDw8oBJDsA8872pW1uPo00o3M6PTg11vt0pH/2
         qLjiqBKEo/nJUh2Ctjc7Pd/vE2MnjOKqwTZz35lBkxdnaNZ7JZySICIStiqMQEhbo/Sj
         w2hSkv7Rf6Y31QWsi7rHTIul8z90/l8t8UQebTv91J06loPE4m3c0uGIDJyots/FHK5o
         T1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520520; x=1780125320;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UrPKdNKgj6LivKrqLr8CgMfwExcBZv4b+V8NB+o2xak=;
        b=AuQjM/mg5sN5tn8o4OQ/1L8wK2jk5GEz3chbF9mJDYPeyBppOZl5PiO8WeTYSKxgh+
         9xnNR2zc+IwmLyfPHUf2UuMwTjeEMd60rslCXnwHoXFDsSDlneWIqgxIai+5ScpO9rkZ
         emyVrUvS/huPdgeXgCy1qYmKNfccmZcUv4GA7Rk38OGQSPr9vwvE8H1LVshqbj3P1iYc
         MgU+TTeAFFpP5Emih2hoMm7v/6ejHUelXlDZLVYDS2ISBXaWXTg9f7AQzP/co9Bt3n9m
         d2EsPqao+k2Y15YhbzanbxQnPwk//bDhSqsrQZ6mgB5Nkd/ycKHPc8SYaKkV3porwroz
         RJbA==
X-Forwarded-Encrypted: i=1; AFNElJ8mxtF7Q3/jHFYSRxFubJ9xyy9Vi1MKGdoEP+j9Qm149upadmAlV0nCwDlke8HXprV2flgrkIMkNsMr@vger.kernel.org
X-Gm-Message-State: AOJu0YwkFDojVB6xtrXJGndzoFG2XZmrLIPXEPU6nN3364AbpQaJUYAB
	1z57nMfIztl0VjP4ThcrwevxE8z2aXYlG5+nzmb9Jb9IPX8JXdaNpQ0R
X-Gm-Gg: Acq92OFClHAN2gjAerkN/0h2MArJK4vqDP0+SqA98Bj4dIspERnvetm/fMOmQU2ze99
	vVjQ/Z6cg2FyT5y0xplz6YJcBM+YHwsNOcp07D8YvfdiFT2D8inDVqU1KAtK0eZlcGz7soj0ZV8
	49btZJ5qeCNznGLwZ+M8OJ61/cdBIMLLCUv7kZGr4D40w2BNsP0FhT4zwih36x2kE3jZB2KI8hL
	+GHcnFb67e/4FxWV6+kryp2M58ZuYURYTkvzbZ5rN+bfxb7SrHVVPFKbCS9anoIK1ygBakix2Eg
	X0SM/CzvJTMIECQu+xjCAIw08SQl8/qP/kpotsrFukBux0k4y2kJSTAjlrS2BjhHt9xHruuIGF5
	4NOaZG1pGIBM2NTrXGTVAfEQRuxSv6HRZWaLhJg4AFw5dPEYjgz1fiX+phJHKQtpchTLKY+laLN
	UIYoyYKxDndWdnn+clmwZTZiHyQlNv
X-Received: by 2002:a05:6000:2889:b0:45e:5b92:1e45 with SMTP id ffacd0b85a97d-45eb38c7d20mr10565597f8f.40.1779520519421;
        Sat, 23 May 2026 00:15:19 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:15:18 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 23 May 2026 01:14:46 -0600
Subject: [PATCH v2 13/24] dyndbg: reduce verbose/debug clutter
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dd-maint-2-v2-13-b937312aa083@gmail.com>
References: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
In-Reply-To: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=4656;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=zY26AoTDT5sXs+cwH/35lsu5KHT7UoaJFyISX4/PEiA=;
 b=L2RL4t6UeiHcEGIX7kfDlIJ3EmHkqwuLl8YVbLdl0/jhDPOyxEy1b8gUT+0am8u8QIKmPveZD
 uy88jHV84ClDGG73VhFpecIhC0yryh1axgP4R06jKvH8P0W/nSkUzUT
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

Also drop several verbose=3 messages in ddebug_add_module

When modprobing a module, dyndbg currently logs/says "add-module", and
then "skipping" if the module has no prdbgs.  Instead just check 1st
and return quietly.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2:

RvB after SoB

trivial change to verbose-debug output line to output the actual
"module" keyword rather than "mod:", and do so only when the module is
constrained by the callchain (ie as part of a modprobe).

 was:   query X: "(keyword value)* [+-=]flags" mod:*
 now:   query X: "(keyword value)* [+-=]flags"
   or   query X: module FOO "keyword value)* [+-=]flags"

IOW, adjust output to reflect the input grammar more closely.
---
 lib/dynamic_debug.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6d9dbeb68ae8..dfed3725aa44 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -277,9 +277,6 @@ static int ddebug_change(const struct ddebug_query *query,
 	}
 	mutex_unlock(&ddebug_lock);
 
-	if (!nfound && verbose)
-		pr_info("no matches for query\n");
-
 	return nfound;
 }
 
@@ -512,7 +509,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	v3pr_info("op='%c'\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -526,7 +522,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x\n", modifiers->flags);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -542,7 +537,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+	v3pr_info("op='%c' flags=0x%x maskp=0x%x\n", op, modifiers->flags, modifiers->mask);
 
 	return 0;
 }
@@ -552,7 +547,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
 #define MAXWORDS 9
-	int nwords, nfound;
+	int nwords;
 	char *words[MAXWORDS];
 
 	nwords = ddebug_tokenize(query_string, words, MAXWORDS);
@@ -570,10 +565,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* actually go and implement the change */
-	nfound = ddebug_change(&query, &modifiers);
-	vpr_info_dq(&query, nfound ? "applied" : "no-match");
-
-	return nfound;
+	return ddebug_change(&query, &modifiers);
 }
 
 /* handle multiple queries in query string, continue on error, return
@@ -594,7 +586,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (!query || !*query || *query == '#')
 			continue;
 
-		vpr_info("query %d: \"%s\" mod:%s\n", i, query, modname ?: "*");
+		vpr_info("query %d: %s%s \"%s\"\n", i,
+			 modname ? "module " : "", modname ?: "", query);
 
 		rc = ddebug_exec_query(query, modname);
 		if (rc < 0) {
@@ -1160,11 +1153,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
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
2.54.0

