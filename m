Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA3E34C9A6
	for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2026 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010481; cv=none; b=btiXZaK66ID6Tpp28DfFh4Vb66vlIHrpY1sMN6v/sqS1VZkK5CuZci5yvf+TXiI4+YAjMIdfXJ7RyA4NqnLxKW1U33vdKOapVcBb2pgLbEp+9pb+KMJYH4fEa2HWhd3DhkzWi8oiAEnc6P2DXM00xdwjbx5VrDGtZhlaWKPBJ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010481; c=relaxed/simple;
	bh=rOK0DI4WBj/yprGM5lB4e5699JqPcU+lt1tA7vpH4gw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UJ71vGTTKnxWi43uUPZIVVTj5pFxu4cjO4Wb3rOnm5+nY+6MVJ1qJgkNIQbN6raqiyPLOMa0/vjEXB7+sW49eSqihWIf5sfyNw656YUimqFSrGy+keJzGmn2osq3VEAoh221qWfsJPFSmXnj9P+M8HQAAk3Gu57p3mGx0hN8uXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oU8R2hi5; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oU8R2hi5"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4896ae35be9so907756b6e.0
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2026 09:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010476; x=1783615276; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8fTbja1t6IaR2B1RPD8t4oUf19W7cXH/RnkuoJsAkA=;
        b=oU8R2hi51BcjWc1vV/mg5+GHZUtcJEGkfkB5OTFIEXEoVtJ+HA96VftA5I162ce+JQ
         8Vr/ycS4mIDZCIhz5bfY6g4IWyxGJlVNGvoS3fA7KlOmz86wu4uPCjbic4BhA/A3Wsui
         SomEDXSYtFQWnPMzfQRpWLhKEjy/5hXvU0g0cPziq41QMpB/pCnCB4ZSk4mFbNPsO9FM
         6YdMtr5Tk6BjNG8IAIZQcMCH+OOzUXH2Cat2+W54zKFZMOOf+00wVovH3LTDaZqDpXVF
         kW+v1wvLQeHXrYdBCidKSsHRhb7+7by8rL6FXHfJ5lAhI/ZqFcTn/bQnsPp/QK35HUVn
         RFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010476; x=1783615276;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P8fTbja1t6IaR2B1RPD8t4oUf19W7cXH/RnkuoJsAkA=;
        b=mEnnKPrQTSWFArhz94oIR0NGMVWCaVGOJBFvlsXmDMWrRrCwgjFqpZ9rygWoHKX4Bz
         6CvHavQTk2VTwdL70JOLio52YJ35sTlzD9cF/CjXDC6NAb+2nJ3nKqAY0+uH/Y8Z9ZLQ
         CmqUM+yVNjq562e7c0z3etkq7lxMdKGO/ereNDBf3MI98LuK9Bu2QQc2OLgDPH/i3bhD
         qVAISUl8ibeWFue8Qrf4ffgsV3RALo1FqLy9RBqU7BEOkRih5h60j7U3w1ZhrKZ3sEnO
         GNNRS5VdCT8wYus4sA3PIYS7PSpSiolWwYDJidjMTrqBH+5KP4bHmET3kHJJoE830leB
         FP4A==
X-Forwarded-Encrypted: i=1; AFNElJ+UxeXfCvsDg4KRs9hDaRX1MLHFYqBVcdG0qgsOOF/lGYHtC5d5eBsPH2oTqPZC1wAFtTkrv4LY6Uf3@vger.kernel.org
X-Gm-Message-State: AOJu0YyVRzDRTs21Bz30NIFUf6hsK+LlUi5UVZ6MlwAGGJ3gJKvWtHx1
	Ait1iQ32alGzg0SnqnZlrOuRqYeRyysLTtGf6AhPkGcov/pNyk7YJMGH
X-Gm-Gg: AfdE7cnkGBIOvGeGANWNmAIyHO8Ql+uD9C2JYvpGQe1U3X+6p6zdnOO2s+HWJhTyYHO
	fLbOlUQDxzvOeMlfD9XbnU3mxx5c/p10iMWvRkKC1MQhNXyZwQJ7Hr5zeOFLyR8MqbD6wleA772
	aPj3CwElxCt1Ahnx+0nMzr65KrEf9lHzxCl9yrLI7qHREHmbK+MZ51PIoLEPc0TdC9DUT0UHtTS
	xTr145oBNVdooMRs0itVyi+bTGr6s1ip6SS6zx373U8KxRGUwv5wrCeyxMRaQbtIC/HV54rNvzX
	77/s+JZkuSUzV8vr54SoblBThYV79eBrTXEMhZfmG1qdQS6xzTLIuMdwqM4ThGCkOJRgDtVpd9A
	0g1WS5uHMYG2Q8Ksm6FMkpkv+mYYKE61Ts4EH0Sd9LP6685/OWoEVKnSR0OuevRsPnC9hIJ2/I+
	xVub2QwarArNC1xC3tfWGXptKm0DM4K7Yz/YSqPkOf0Dokzx3boXk=
X-Received: by 2002:a05:6808:191a:b0:494:984b:39d8 with SMTP id 5614622812f47-4960f10eff7mr4621385b6e.41.1783010476167;
        Thu, 02 Jul 2026 09:41:16 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:41:15 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:40:53 -0600
Subject: [PATCH v5 01/18] dyndbg: factor ddebug_match_desc out from
 ddebug_change
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-1-24f22b052bf2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=4529;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=rOK0DI4WBj/yprGM5lB4e5699JqPcU+lt1tA7vpH4gw=;
 b=4cq4LpmAWnIaECSyT0/8uVstFNieJpKyOUKVxbCp9RndYjBkK/Iz3OMfFaJU6r+qS84FiJqql
 JfQTr/W2CpQAIbleE3d3FC2GTjWzX+0o+dTr8CGNSfncjIR6GvSm0gT
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

ddebug_change() is a big (~100 lines) function with a nested for loop.

The outer loop walks the per-module ddebug_tables list, and does
module stuff: it filters on a query's "module FOO*" and "class BAR",
failures here skip the entire inner loop.

The inner loop (60 lines) scans a module's descriptors.  It starts
with a long block of filters on function, line, format, and the
validated "BAR" class (or the legacy/_DPRINTK_CLASS_DFLT).

These filters "continue" past pr_debugs that don't match the query
criteria, before it falls through the code below that counts matches,
then adjusts the flags and static-keys.  This is unnecessarily hard to
think about.

So move the per-descriptor filter-block into a boolean function:
ddebug_match_desc(desc), and change each "continue" to "return false".
This puts a clear interface in place, so any future changes are either
inside, outside, or across this interface.

also fix checkpatch complaints about spaces and braces.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v5: check for null format in callsite. shouldnt happen, but pr_debug() isnt illegal
---
 lib/dynamic_debug.c | 87 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 36 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 18a71a9108d3..577a07916072 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -172,6 +172,56 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
  * callsites, normally the same as number of changes.  If verbose,
  * logs the changes.  Takes ddebug_lock.
  */
+static bool ddebug_match_desc(const struct ddebug_query *query,
+			      struct _ddebug *dp,
+			      int valid_class)
+{
+	/* match site against query-class */
+	if (dp->class_id != valid_class)
+		return false;
+
+	/* match against the source filename */
+	if (query->filename &&
+	    !match_wildcard(query->filename, dp->filename) &&
+	    !match_wildcard(query->filename,
+			    kbasename(dp->filename)) &&
+	    !match_wildcard(query->filename,
+			    trim_prefix(dp->filename)))
+		return false;
+
+	/* match against the function */
+	if (query->function &&
+	    !match_wildcard(query->function, dp->function))
+		return false;
+
+	/* match against the format */
+	if (query->format) {
+		if (!dp->format) {
+			pr_info("encountered a NULL format\n");
+			return false;
+		}
+		if (*query->format == '^') {
+			char *p;
+			/* anchored search. match must be at beginning */
+			p = strstr(dp->format, query->format + 1);
+			if (p != dp->format)
+				return false;
+		} else if (!strstr(dp->format, query->format)) {
+			return false;
+		}
+	}
+
+	/* match against the line number range */
+	if (query->first_lineno &&
+	    dp->lineno < query->first_lineno)
+		return false;
+	if (query->last_lineno &&
+	    dp->lineno > query->last_lineno)
+		return false;
+
+	return true;
+}
+
 static int ddebug_change(const struct ddebug_query *query,
 			 struct flag_settings *modifiers)
 {
@@ -204,42 +254,7 @@ static int ddebug_change(const struct ddebug_query *query,
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
 
-			/* match site against query-class */
-			if (dp->class_id != valid_class)
-				continue;
-
-			/* match against the source filename */
-			if (query->filename &&
-			    !match_wildcard(query->filename, dp->filename) &&
-			    !match_wildcard(query->filename,
-					   kbasename(dp->filename)) &&
-			    !match_wildcard(query->filename,
-					   trim_prefix(dp->filename)))
-				continue;
-
-			/* match against the function */
-			if (query->function &&
-			    !match_wildcard(query->function, dp->function))
-				continue;
-
-			/* match against the format */
-			if (query->format) {
-				if (*query->format == '^') {
-					char *p;
-					/* anchored search. match must be at beginning */
-					p = strstr(dp->format, query->format+1);
-					if (p != dp->format)
-						continue;
-				} else if (!strstr(dp->format, query->format))
-					continue;
-			}
-
-			/* match against the line number range */
-			if (query->first_lineno &&
-			    dp->lineno < query->first_lineno)
-				continue;
-			if (query->last_lineno &&
-			    dp->lineno > query->last_lineno)
+			if (!ddebug_match_desc(query, dp, valid_class))
 				continue;
 
 			nfound++;

-- 
2.54.0

