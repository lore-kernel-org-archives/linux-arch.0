Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166733CBE8F
	for <linux-arch@vger.kernel.org>; Tue,  2 Jun 2026 22:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440531; cv=none; b=IvWBiqt4n1uMC5YOkCNew2hFg/qFRDnZgC9TJS431ybTg/oYHl2rLtj3NPRao+VaLEfSEoEesAatQqIHOFx3BSWfhOwmEgOWDuJtFDsuxVIthHGf51JJoejvFtrYKqix5Ohj2y+LJOMUaXiwhkdlxkTK/qqz/OrsHPUB4nopcXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440531; c=relaxed/simple;
	bh=weM4kXK4ZroqgxDMQCEUnSrZj0zxepbFA1mJkvW7x2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o2Fusaso8iWpddXpIP+V52QcS3zH+Jo5hP1X5RisVqeCgz4ulmAom5rChgn+6EhfjV9wKsjQLT8xjzfWLn22tkXI+A0gbS0Mclz0GxwvAYwlDdkvCmLQu5c4xv6RxPlPyOhvPC1Tu6yN2gQv5lQPnuclO/+njN8deG+ppSLYSA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMsE4eFA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMsE4eFA"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-46019edc13dso711323f8f.1
        for <linux-arch@vger.kernel.org>; Tue, 02 Jun 2026 15:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440527; x=1781045327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yhq+U5OSRDicP85+S9FaWBdLNaFdwOPlYIYghUJlarA=;
        b=IMsE4eFAOxL6QZOhdCvv3jdIV8PFafbKUfhDS+tPnA9vhxvzpWdfQTsIgHzphStKo5
         XAMahzsCzze3v2dUkiVXy5YTwibAi8aOE0L4GJFdRTHDZKpeaHc/snHMYhHz/91xIYjo
         NC7gEa4+nvSog1qufmOZsiKOno0F5ippviwBMisae1Rx4ZQG51SmAeGiYcAXjCepBS83
         IgUlohOBtgzO6IQJ0l1tbXMS6rD2Xia+9BsKuYN1t4xdwW5eVzeU7sIcZya+PEJjjLtj
         WLIYQ7WpOUWTxVI2mSeZR8xg61lR+hPXm5mP6gkEIkAbmKYTu4Weep19dllaFEQ9NzmX
         V8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440527; x=1781045327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yhq+U5OSRDicP85+S9FaWBdLNaFdwOPlYIYghUJlarA=;
        b=lkyC+e+STuUMOOhxRXY7YIxgsZ6KmxHl3MJ5Ed0SBAQJT1DasCAKiy3N/1mSshx/5i
         HRM8KimI90DaiiFtoRaCenMcoeDi9BkCh7z2Vs1v+fP3dvXlMx7DKUlxKqcAgdaPA6P6
         JD9qGLKsJOTgXX2K+lOwEoceBzMXoj1+lpqhWhRVHuSPNsfGHF0ZOarDaf2gkqEoBSFa
         /PE/iPsePMwhALnM+1SPN/J1PeY+vWD3tNF5I0PG1BbdsIiRUxhR70bPOxJyVQsTrOP4
         kgGnKxsk/CQuS3ZhBag10uoVlRykYy74SCxl3XsJKb+dj6Fhy4pDwdu9t+3o015anaKx
         79tA==
X-Forwarded-Encrypted: i=1; AFNElJ93fG7uN7vDelvih/whPnHChdcKrrYrBOt0h1Sye010yDrP9dH6NlfDv9Lc4ouoHGbUBNVczV+cE3fy@vger.kernel.org
X-Gm-Message-State: AOJu0YzwY+dAsKgEgfKtqZMGIfyhjblF/F376B4TuUJ0101d8Sqjvsw5
	757gNOxmBysy4ufXaBv85OCDzQTdzxQLmIR40iHkB1KsHVA98aVdj9Y7
X-Gm-Gg: Acq92OFHOFxZGnw7ViTuGIRilEVpK7uenabMXM6YHboFI1kAMqgb8b+3ADNpGDJl7AQ
	oqIlwyotP6Pr0o2DMWzcJxeaRD6zxoXurdfesvj1fGC4LFyOcXlYBrHS9vSWlrJ+4gsHqOvVxPo
	zbm7mQC6RPoJdoXY1bzVBctT0GKhmL2o2ovgOz7stlnFfxxrVtvZvU9EBh2L17PuKfRGO9OCBkW
	5umAYg6aY656X0BYNOj2S4UMeJUfpcIXd6uiko+7KGbJXN5Pcf/x3IZ+Ql3DNDWKZjiQs/UvtBV
	FbAgg7WEEN+LOxxC4FGvhtU8HFR0E0e2FbddhQwFQ0QOHpMSvp0fJu+JSJkNjgokf2qt5Cd1b5V
	yw08Sxs7pB7Uct8LSZXmblURwdKhmqqYJvQa0tnFm4Xw1Cw4F+Hr6QDxJTL9LfhB77XOh4VgyJj
	V3TqmdAmQ0NAM5pMQQfWiB0SUxwXlJzQAzStsWU7jQWKFTthil62TO
X-Received: by 2002:a05:6000:1cc8:b0:45e:ed7f:1d9 with SMTP id ffacd0b85a97d-460216e6c10mr535924f8f.17.1780440527095;
        Tue, 02 Jun 2026 15:48:47 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:48:46 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:10 +0000
Subject: [PATCH v4 13/25] dyndbg: reduce verbose/debug clutter
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-13-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
In-Reply-To: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=5056;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=weM4kXK4ZroqgxDMQCEUnSrZj0zxepbFA1mJkvW7x2I=;
 b=60JsmO3vGkvHB8Wbkptgdh59idXBHU6megWsjkTqaulbU6qXBQ5J81a4YTYlMRoJy6Y/7nNeR
 EmZCu3IAwOSDqEqibblfA4hs2wXiRSlGkqwoD/KbxNqiLScteYh5W8g
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
index 0377d9f8dcd1..a967e3ef1dbc 100644
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
@@ -276,9 +276,6 @@ static int ddebug_change(const struct ddebug_query *query,
 	}
 	mutex_unlock(&ddebug_lock);
 
-	if (!nfound && verbose)
-		pr_info("no matches for query\n");
-
 	return nfound;
 }
 
@@ -487,7 +484,6 @@ static int ddebug_parse_query(char *words[], int nwords,
 		 */
 		query->module = modname;
 
-	vpr_info_dq(query, "parsed");
 	return 0;
 }
 
@@ -511,7 +507,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	v3pr_info("op='%c'\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -525,7 +520,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x\n", modifiers->flags);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -541,7 +535,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+	v3pr_info("op='%c' flags=0x%x maskp=0x%x\n", op, modifiers->flags, modifiers->mask);
 
 	return 0;
 }
@@ -570,7 +564,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 	}
 	/* actually go and implement the change */
 	nfound = ddebug_change(&query, &modifiers);
-	vpr_info_dq(&query, nfound ? "applied" : "no-match");
+	v3pr_info_dq(&query, nfound ? "applied" : "no-match");
 
 	return nfound;
 }
@@ -593,7 +587,10 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (!query || !*query || *query == '#')
 			continue;
 
-		vpr_info("query %d: \"%s\" mod:%s\n", i, query, modname ?: "*");
+		if (modname)
+			v2pr_info("query %d: module %s \"%s\"\n", i, modname, query);
+		else
+			v2pr_info("query %d: \"%s\"\n", i, query);
 
 		rc = ddebug_exec_query(query, modname);
 		if (rc < 0) {
@@ -1159,11 +1156,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
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

