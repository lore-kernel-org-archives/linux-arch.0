Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AA73976B8
	for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2026 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010494; cv=none; b=ghSiyQ4M8VeGdMlhGj/WcFo71KcY4vWi5yVeq/ZV5z/Pv3G7Eu5ITKesxwEj0hqaDbpVuIlP24yPd3lw/tQgZszk7y8WtOYVT7WJkO5B37GFKiL9GIT9mXVxSyl8TJtMEDdZjwPSM1vr6m1ZeGp1aUDz8sPYTiBtRvZpbYKKTDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010494; c=relaxed/simple;
	bh=yIjUo04fS9hFhZVQqd7QNfMx8c7rakFHpoauTbqrYcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VN/Dph0wAY9rhL5DxTxANDiesfyHQBk1wNs8UpjXafufKjKJTNxNPo+4INfrpkknVMvHBEr0Tuk6H+UNsjjjgxKlrOiTbt+ZV93bnAlo1Pcmmnz+Hv6abP31M5mAHoL3134sJMp4seyqHEgaFBU3v0UBwqe2xjYRRZV1UAv/4Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdUEjCqs; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdUEjCqs"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6a308736a36so1113092eaf.3
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2026 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010485; x=1783615285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kg5EcJIb7/NbC+BTLvTpewRkCYpge7iehUzwDyOw0vo=;
        b=XdUEjCqslRr90GK2Kc3MReHZT/j65Y7fTdToko0510+9DiVsE80IJZNdg+kHlEmGf+
         dfNhcWYJut22VYmDs6k7PhqgWbpUZZVgU3RvM+bzeTRYeBE2xwnaEa2yo/vg1yZb1Cgk
         lOwCMqFAr0lWQYX3AcelafajOz7eQd7utOZP3aD5Crf1/MiaAQWiyDPMUGtVhSlYL0aL
         2wZtX0n/SLYuc1j8h5PJnkEv0RFQbUjezCViVEH9PxrujG/x9DCtTOBSnwxw4x0dGqDp
         zYNDCHLDESlMaNZxtve2BbSGljF59QBE67EoGFExCjcRAw2YOEyzHUbVtHDr6H0xhTT0
         THQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010485; x=1783615285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kg5EcJIb7/NbC+BTLvTpewRkCYpge7iehUzwDyOw0vo=;
        b=aldRTtH02uULyXuTOvWuVn+HKtmiEO3y7fp5Ci/nRy+KkD4EdSEzGTxL1y9FVasM3Q
         7Ksa/8T+Hw3MsxgojsLop13KqdZif2kEBamHAJPknbIZJmCJgkiBzOKd5DrEKFqK/CJH
         2UlvD6ByKxYvhqNBtG8rnR7/4RWBHxaYOby44+HCMq+0oHCZjFAdsU4sfNSSKq0BNJ8c
         U6b9sSUpvhKz7IrZ/aIgXnYIbGijSbFyY0muUTkQeElpY548xF5YOom3zix+w1V5lvtr
         tQ8uvkzSR6YVQRHnN6MndpuSWweCv6V7ktERdJK09hpELiq42z7LKh08fApEXwOR+hbv
         O+4w==
X-Forwarded-Encrypted: i=1; AFNElJ/fcZRXELdrMJYq0CPOuYaV62TxPdW1EZ2+TpIL+YDV9rmcMI3pq+xOE4D2sYd/nVPqQ5OYCeq7oLnJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxgUtjn0V4DeEI/D3pkIAdDX0+0/FpWmA3o0KIdVPqQ8sCF65xw
	yWYMU1rZaO9lbVbWvLWpQ7PKJDYgRNxbM3oaINPEbh7UmH1y0pj5SlJs
X-Gm-Gg: AfdE7clvtsims5Xcz5L5ovhyI3L/5+/GVze+kRK0mYrQC7980v68368EcV2PnSpIv/h
	qErsIsxTD+k5Qr8Bg3SHNv35w3bUvskTyopO3gUxCXu//0qkU3QMNgSUvSmddZz0zPVCvzNoX8g
	qPd/cKPYeRfFbk6uJXvvB0h4VxEVuu087U47Yhsv3wYfU/6WmLh1PrcLCijUKh0rI/nu1/XeD/3
	A7VvAs4s3SpRFpc/MuCUz2bM3nomoYtMjK1qiLR6F5tESrCP5ktXlkiDDUXu2CnzesMsjjLsikX
	VXmxDFK5UpMvnGHFpoIgqaZogTx6vNYf7kyjQMvqTtFRR88VL0Nh2/OKP56UXcWTOpan1gKhC0t
	w3fAyc320vXYKea4QaoUPphKkmlspDr7EqjaF7Ds2ldDd8EyLamipTEY2oat8wW3ytmJPtdMzs4
	PN1e5H10tDEqp0pnb3dY/tLoxWZmBopk8+331OnKdzlrhIJoftuL4=
X-Received: by 2002:a05:6820:199b:b0:6a1:5847:3dda with SMTP id 006d021491bc7-6a30d8ac0c4mr3660257eaf.48.1783010485438;
        Thu, 02 Jul 2026 09:41:25 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:41:25 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:40:59 -0600
Subject: [PATCH v5 07/18] dyndbg: reduce verbose/debug clutter
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-7-24f22b052bf2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=5280;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=yIjUo04fS9hFhZVQqd7QNfMx8c7rakFHpoauTbqrYcM=;
 b=7XTGzlwc+qQjDmQhNpjyATyUsQF5hxsmAXqfHagY5YutP/SAIko8Y0nf1YEus2ocx5lasClDz
 IvHgRcyfvh+CxmkXlsh2+poPVCyXyPLinEqHzFcsXWzhHTNxYCP1byo
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
2.54.0

