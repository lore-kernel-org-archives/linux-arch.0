Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C35F443AB7
	for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667457; cv=none; b=O3TXvBuqiXp8+bEk+Ny6ttJXDCvLzzy59dwuvG89JypF7QObgbwzAWi3Bs2IWsOTwa3VTVJKQnb1zhNSt/mMUw7A4IjHNGYVWI0a1mKkSgqBqh+p6ii/EKWU64bdsyUcap9nUFCEprU2bmrjTdEFcq9sLsJboTtQZh8qyoxIjW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667457; c=relaxed/simple;
	bh=cLKnBGLyc0C1e6gZoIwI3WoXGqvA0tV/LNVEeqhi3uo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RDcPzMN5p8TL049zQoZNWSf+mPhM11VLjGeriSnAQoq5yk9oiyDX30ws7PGcHw8VHfy+lE9/z0ATFLO8Qe+k67s4KmNC1oa5JYdAhcAAgKZbv61Kl5YYJhFvu7clQLsG/bVk0/6NInRnD7faR4aNvlBnjy7rGIYftU7pqdBenfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaplYQ3F; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaplYQ3F"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7ec3b429a3aso822239a34.1
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 13:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667452; x=1785272252; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LzQw7dDR1Ksv5n4PA2VrgYGS9XTOJwt3lOBXVgxnNqw=;
        b=VaplYQ3FoUgVrLFsB3hmH80UxXKxjTQFjayIcYbzqNMc65T/IKbntX+slsxdIdg4Ea
         /afSv5CMCIXrD8Xi7eHoUB83CxL4BbMms8yi5sHmnlWmS/S2/N1sFQREWE0kFd5/P5Rb
         u7PPGrxUWZ1+ueSzEtZyZTliO/gvBlOkY6QVHySzolhYLSFlIzK8s5E2MQWOYABD1IZ0
         KullGfsHPVCTyVS0c4oB9U6MoEEH+yS45h7NixvvhIxnbGGwlu+4eSIqDnt12FE6m8dd
         u8Y7nSFCWMZndrLyBexrkxmDAyzXUfnLV5sAUCGlcSg0qOGjqyZyLTrGATjUrBiYcNjt
         wXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667452; x=1785272252;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LzQw7dDR1Ksv5n4PA2VrgYGS9XTOJwt3lOBXVgxnNqw=;
        b=b7E/FL+ivnoKJDaPHVBCllH1xqJXyjcGMbD0kCJk/56dDNHWfe0KYUOpsu6omJyVZU
         T+6qKQQGnVxP9l9o8DmvSUGtBxsNoK6697ZFPWSgwAb5uQLzYts+gLdByDcx+Wudtz8r
         eYvIu6Z5oZuVVvbHQ8KYFN8Q/2ZP1J5mrHzCIjP4oudKuZRs9FfgbIhnABG0bwU5q+Zh
         H8CwBrsLosCZ5wJ6wNqc0gcwYLZPiINngGGcvSh/ZU1TZOnJt6AqgyRmb8XVOW5F5RqN
         IuTXH8v0o1LJyTt27A2KVtKrteQAv5eryJXQwPoI6p7vNijZtkPw3LbGzUfwVb/zJC9V
         HfAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7gHKoqFEEwGcszLvJuefuiJWUsnQNtjmdcO7eSHWcmtknhD1Uu4KjIbu7hkfKjpMjLKUuxfDxy6hu@vger.kernel.org
X-Gm-Message-State: AOJu0YzO6aJgLMOuO+/d/cBI27d1aQsl+OnTT5x0RBMGgCD9RqQvA38P
	0RWA6OKOp8Cz0knLo9ZRo6NQTU/cjF7Bqj+BwPnAZLERcRoAAYvrlCNG
X-Gm-Gg: AfdE7cmYG1aCusm4VqAQ24QlD5Q6RhZc8FZzRe5TAnp5eG0XHM3imot7uu/yNz4lzlM
	APyfB0Ftk7U67NZwTv4h71m37iyjRaCkEnx5a7ssqd85wr2krUbh1wA/i/5fXla/hel9g3XQkBk
	kAYkXPEAqZfq7TXiXSa9oT4TFQsBjAXvgCkQp2Ruuo0xxt6MvLPw7nphu8cEMeSaDDr0N/WLjtr
	oQ0ZP1CVy8HX2QwSa9Cv0Iii7N7g4zlBVUf339tRDA54yjieCf9VDikUX/VK1Y5jOa2lLjZBj0r
	+tZCt5xDIGIhdqXvLvjAvBhoOS7lOoTLqjEF9+KPPMu55wv9x7kG0OIf3tQkH3qs5YvK60Y6j5w
	ckSrY3VL2bIaeVRiPZTA7BeI8pNhK5yemEWO/QR4D45lwpZ8QleW92/0c9NeQL5dNADGmBg1ToF
	RRkJIwXpOzXRD0TzULF52bLfKKkFlS2IxFqsH6/1SD+0FmPHZCSnns3jq9qxoTZ12Q/DP0aV9z6
	Tok+ujhxXTevSWk54wkcDHbBJUgi3SalEkU
X-Received: by 2002:a05:6830:6690:b0:7d7:58b0:7685 with SMTP id 46e09a7af769-7eda093c2a8mr11498594a34.13.1784667452025;
        Tue, 21 Jul 2026 13:57:32 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:31 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:06 -0600
Subject: [PATCH v7 17/29] dyndbg: reduce verbose/debug clutter
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-17-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=12365;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=cLKnBGLyc0C1e6gZoIwI3WoXGqvA0tV/LNVEeqhi3uo=;
 b=GxcRaAsglHYL35H54YZTOctz4nny15qVsDRugiho3tc5nqoOL2XOj9cQ7vj++q5W2kvN354JK
 kdxRdaRquS6DmZtSPDn0QBpPdjYpOCfLxmgqdfV30smN5mbLGziHwII
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
v7: update fingerprints of grammar-errs changed here
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
---
 lib/dynamic_debug.c                                | 24 +++---
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 86 +++++++++++-----------
 2 files changed, 54 insertions(+), 56 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 2fa034177268..251df88cb04e 100644
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
@@ -1164,11 +1161,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
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
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 446455683df4..6e977486ea90 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -645,54 +645,56 @@ modular_tests=(
 # ==============================================================================
 function GOLDEN_RECORDS {
     cat << 'EOF' | {
-#K= bb85d28739876b0fdf1eb426baae8ef7 FT_grammar_errs.1        dmesg
-#K= 9c405e06fcea50284df82d1ae9692403 FT_grammar_errs.2        dmesg
-#K= 0b0d9b0e6f4c45c7d75d699fd3b6aa93 FT_grammar_errs.3        dmesg
-#K= e008644e159c2a9d99a8d0806c06e71e FT_grammar_errs.4        dmesg
-#K= 5750ed178633f9a68623f928c093d16e FT_grammar_errs.5        dmesg
-#K= 2cd51e5e3c3e2501544524bed0fab620 FT_grammar_errs.6        dmesg
-#K= 3e1eba65bd936e1276c7e1d76b399595 FT_grammar_errs.7        dmesg
-#K= e3ac86676e309d4e72ff3da287736c29 FT_grammar_errs.8        dmesg
-#K= 466d325c23519119f754fa7860bae7c6 FT_grammar_errs.9        dmesg
-#K= 51c489366cd86c16280858b95adf34ac FT_grammar_errs.10       dmesg
-#K= dfc632c6c0cd6206b6141dbc5fb989db FT_grammar_errs.11       dmesg
-#K= 69650fc26e97a78082bd851eb4a5c83b FT_grammar_errs.12       dmesg
-#K= 5cfe5665962a482f416836793067f2a2 FT_grammar_errs.13       dmesg
-#K= 661cc9a2d8d3c381bfeae41392432575 FT_grammar_errs.14       dmesg
-#K= 5dd0accf9be37ce2f4bf697e9bdebe30 FT_grammar_errs.15       dmesg
-#K= bd8d9cf661c9aca54dac93c74cfc1501 FT_grammar_errs.16       dmesg
-#K= e991391048f2fdffaaed99ba36b787ed FT_grammar_errs.17       dmesg
-#K= 82d99278f471ebfbf47eeb19898525cf FT_grammar_errs.18       dmesg
-#K= f3f088fa7d276981bf2898c048087f76 FT_grammar_errs.19       dmesg
-#K= 984ecc198e0fa9fc91bc31caf7da2a5d FT_grammar_errs.20       dmesg
-#K= 76c8a33c585d414fcc3f1c8b5ea5b4b3 FT_grammar_errs.21       dmesg
-#K= 90cfc66e9d61f5c448353b97baa99145 FT_grammar_errs.22       dmesg
-#K= 37a51dfd6e84cb64b69d3a0e23e68ceb FT_grammar_errs.23       dmesg
-#K= 3aefa325b63742710b45e4531152c9d8 FT_grammar_errs.24       dmesg
-#K= bc8d2c23282cd6834879bc1f1b303d05 FT_grammar_errs.25       dmesg
-#K= 092ec5530d875be1dc96ad4202fc7dc3 FT_grammar_errs.26       dmesg
-#K= 98caa2677e9070953a852b27ab57861e FT_grammar_errs.27       dmesg
-#K= 8d755baa707c7b3b67491bf84708ef08 FT_grammar_errs.28       dmesg
-#K= 5dd0accf9be37ce2f4bf697e9bdebe30 FT_grammar_errs.29       dmesg
-#K= 2e37642dc8aee3d04b8a54a76b3b891c FT_grammar_errs.30       dmesg
-#K= 593c8b4c41932e3bde564a0008627ced FT_grammar_errs.31       dmesg
-#K= 85a2a0bee8d0cd10f883aa5477d62efb FT_grammar_errs.32       dmesg
-#K= f3f088fa7d276981bf2898c048087f76 FT_grammar_errs.33       dmesg
-#K= 629f6a7e379e02f38c543cdb48e3b84f FT_grammar_errs.34       dmesg
-#K= d9f0cffb0898c54690735a71b0d4f3bf FT_grammar_errs.35       dmesg
-#K= 4cf728b6a32043ea5336a14d0c435312 FT_grammar_errs.36       dmesg
-#K= a11ae3f86f4e5f539fd6168d318f74b4 FT_grammar_errs.37       dmesg
-#K= c7d3830b0391f6a773205066b64e15f9 FT_grammar_errs.38       dmesg
-#K= 5c506ea2bfd050439b580b91543e9be7 FT_grammar_errs.39       dmesg
-#K= a257660007408f7bb0cb43c99b1c7bb8 FT_grammar_errs.40       dmesg
-#K= 0082939f100300a7b327b143cf40cb43 FT_grammar_errs.41       dmesg
-#K= 657ac4360f978687ad25a705b2bb89f1 FT_grammar_errs.42       dmesg
+# --- Unregistered Baselines ---
+#K= f3dbd5afb9aa1750f93275b634499e22 FT_grammar_errs.1        dmesg
+#K= 200c01632c52a63f6d186da1c6460740 FT_grammar_errs.2        dmesg
+#K= 7d7141900ce6e32f15c99202309c63a4 FT_grammar_errs.3        dmesg
+#K= 1bb798a5831d0119789d424ef6cb55c4 FT_grammar_errs.4        dmesg
+#K= 5edd66e308b2792d5694df86c07a3eaf FT_grammar_errs.5        dmesg
+#K= 6f87d92ffe0812550f43287127c6f2b9 FT_grammar_errs.6        dmesg
+#K= c0eb05b58a008c722e091e1ae74440ec FT_grammar_errs.7        dmesg
+#K= 911929ec0e2ffc1f13822b479dec6805 FT_grammar_errs.8        dmesg
+#K= c1407512376369d2e591a4b25a4b607a FT_grammar_errs.9        dmesg
+#K= 2046abda72725ea06fe339d5f364f1c9 FT_grammar_errs.10       dmesg
+#K= b72f7fccf76f8a5bee47a05d7bb545fb FT_grammar_errs.11       dmesg
+#K= 98e2bd3e4f3da58536496a38ec3e6238 FT_grammar_errs.12       dmesg
+#K= b371c6ba52503d037dbc43da788af8be FT_grammar_errs.13       dmesg
+#K= cb8288d607b0c5282125852f3ab05107 FT_grammar_errs.14       dmesg
+#K= 9346a310c4ad57cc3746afbace702c3e FT_grammar_errs.15       dmesg
+#K= 533d27af85eed3c0fd2eaec961982a36 FT_grammar_errs.16       dmesg
+#K= 114e0632585e205a3347c82bac7d79f2 FT_grammar_errs.17       dmesg
+#K= 73f5c173bafdfb9674b5ecce77db3354 FT_grammar_errs.18       dmesg
+#K= 0fc110d078f60eacdd389e5975ba18d9 FT_grammar_errs.19       dmesg
+#K= 815a1c52f365510c644450bb80c07e72 FT_grammar_errs.20       dmesg
+#K= 621e3cd81b553973cb40a935bb9298f1 FT_grammar_errs.21       dmesg
+#K= 581222901232344ade18bbda58302c48 FT_grammar_errs.22       dmesg
+#K= ea0aae3e01b3bb22eb8ad7acd327b371 FT_grammar_errs.23       dmesg
+#K= 8f28189bff62a3d5ed16f537d41a725a FT_grammar_errs.24       dmesg
+#K= 19c425e5d3a645b5dc5e23758ba0f4a1 FT_grammar_errs.25       dmesg
+#K= 75415542333f2250f0e060a54dae50f8 FT_grammar_errs.26       dmesg
+#K= 0955815c0e595ab2206e25aa31fe1ef2 FT_grammar_errs.27       dmesg
+#K= 3ff4c0b60db33e44c3cd6f0e14f81e3e FT_grammar_errs.28       dmesg
+#K= 9346a310c4ad57cc3746afbace702c3e FT_grammar_errs.29       dmesg
+#K= 7aaf0a16c287e66b62e11298ee160b34 FT_grammar_errs.30       dmesg
+#K= 06350c62105b537cdd0c67736b29727d FT_grammar_errs.31       dmesg
+#K= 6ef0ec01805c8719d828553098f95377 FT_grammar_errs.32       dmesg
+#K= 0fc110d078f60eacdd389e5975ba18d9 FT_grammar_errs.33       dmesg
+#K= 72203b2d88d0617cd5c659d3b80e26f9 FT_grammar_errs.34       dmesg
+#K= 6ecb03736d5cddb7ab2aaff49d561be9 FT_grammar_errs.35       dmesg
+#K= eaa989336cb7c96c13ef4a3964fc6898 FT_grammar_errs.36       dmesg
+#K= 5b624d9c133d7bb4f5370c3ce06929ed FT_grammar_errs.37       dmesg
+#K= 127275739b1fe04c84eedad28ec154f6 FT_grammar_errs.38       dmesg
+#K= 3e2fd15a7e8c0583bc5066524bc50508 FT_grammar_errs.39       dmesg
+#K= 781995971d28f732a792522f3c56cdd3 FT_grammar_errs.40       dmesg
+#K= 6614a677d9f9ac09d9825b4e989d2c42 FT_grammar_errs.41       dmesg
+#K= 70de9afed457a6be9f9c3c81cbd6d4d5 FT_grammar_errs.42       dmesg
 #K= 9a7aaed40738f1c5203af2e421a20bc2 FT_basic_queries.1       "kernel/params.c"
 #K= 2a57a9e283a3912de3fa5e006fb330cc FT_basic_queries.2       "kernel/params.c"
 #K= fed3186684428b2f05bcf5df960c639c FT_basic_queries.3       "kernel/params.c"
 #K= 551f9801b6008553661453021ae6dfd3 FT_basic_queries.4       "kernel/params.c"
 #K= 33f7162ac85020894fab9752ef07b89c FT_basic_queries.5       "kernel/params.c"
 #K= 544d955c3bb9d3c78704f780d91396e0 FT_basic_queries.6       "kernel/params.c"
+# ------------------------------
 EOF
         # Read the K-recs and skip those for tests that can't run
         while read -r line; do

-- 
2.55.0

