Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8C6442139
	for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667449; cv=none; b=mb7Uen6JyxZxmTXdFG2NE7ooTxANSOLJip7HmX3hkWdo1NX9IhRsg1Og0Md9vLdkJTfHOs4dL3BPU+KqIshkMHAOkjc7oHZ8C4CS7dYar9CO/Wvk8yrJkwLIaO9c7GRu/Ml+7498o4DzTJxq/ZL7ojqs6XyWjOBYgd05PSrx2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667449; c=relaxed/simple;
	bh=c5WIgaUW86zxkVqcui5pvUWjMpEd0rPqQJs9nD03Rho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=peRxSk1cHep5Zt0O3iw2l1DCic74ScRnC+PGMWTPEm0zGKpvp1xtUXFEfdTk5VdBjkwyaqYQsWxzlF+E9cN2g7hIVXZjopVtCBDDqYMGQo2z+s3ZJ+T5NGoCNdQubzu7VykobaIoBW+LvlphOO0cVflpQHNKLiLmTeS266oDIKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5mUViyz; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5mUViyz"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so6475454a34.2
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 13:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667445; x=1785272245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mMbFBVb+54AdS6XN7q8pHuRmeyLjOD33H8GcCbRh278=;
        b=W5mUViyzIShxIyJExuTvcDokQWqH8/hX6Uu0Qi6lsBnDJvi1IHlbzVwJY2ebjuy1jv
         UG/nSLYT2HN/4ohCFxlf117asTJ3m8RrMK+auo7T2pa0fgQVlxPEzkz8pLmevIfLnaT2
         +97Bg0NW5yV6RtOhJRT0q5u//WVItYvV+7lxYWg/K31I1yPZLvXSZ4oxLpGvfuBSk8x+
         k3nQzsy7eKTmLSJ29NmFs5IR10yrOVJQy5CEvIzCh59Z0ahJ2J3Fl7dyQb+iMbD59Up5
         260yxqm40OlGJsQMzX7ea8M2hEEAI0gU4+Nn/x0LHJnG8phEAm1kVYR668iU1By5B8d4
         jCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667445; x=1785272245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mMbFBVb+54AdS6XN7q8pHuRmeyLjOD33H8GcCbRh278=;
        b=aj9YHOZwn3z+RTkWmZVt9bS3CooXrUUAOhVBK/Y0J4CESi2qTl7Za8fBZwvfkHOl+5
         6HaeRgg5Q0veIyOoz09PhN02kQfi79W8E67ZDqgaZlFZEJPA66368vKortAs+0RHqnqE
         nAouDyvgob0cRN6TcNp6xtDLQ7AZSETHCpfxJPqPNbnANsZv0CXmRhtO1o8+v3iLR9Me
         mpFXgOn1YZtYvo60dMWTsY6EUdKCYCUdT4HOswXV+FRjen+F22p7BhnzyaChTdYEEPIb
         ZLZV6DrbAyBWoy9HXwUJFl8fijU/WTwhHM1YZ8rKjcnzwZpKAYTzttE/qq366wUzKBno
         6I/g==
X-Forwarded-Encrypted: i=1; AHgh+RpJ2hwlyrzK43P729olWnD+9IUBkXb5MOkD8+O5xKG1szwGyZgx8PrZEFW2Mkl0UpiBpBGJfqL+dhC3@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqdu+IPZKgKyHM24t5PTDTLyShtjH/jHqREo+g2T/q4O3HVsCK
	Ke5NYxd4fnArLpl7kc/WKIzVWUFw2x9I3h1xAuVOH/HALu3DW0CVMT1O
X-Gm-Gg: AfdE7ck2x5L3+arTokiLVY38vVMI5ez5VE815LSW9T0lz/sLpCNcRIkPj5FdKDrsFEz
	etZingTZBBlI87jV8c8N+IxqmDZeK5y74F1Vk0ugfx4TR+lki1EaXjpvyDw5uM+xPLSaKWwHeKM
	pEkSEJhD9Cjae53jMc1nro4j/UsFfNzjeSeYAQ3WvKUe0pWDIxkhkbug555pnmRM6V4+XTSeyMD
	H92q4DS8dT9ieF/9ymA6YI3V6sAJKUawuzLoH0REeVeynybqBbNKrFIsO8SzaRFxTqlstblu8ue
	XR1MhbEmsJurU7Llayvh6EAxbkqy+5OtDZYiMpR/BbSGX4GUgFWwGNvqTEnTOBqlgzr69CHEJWW
	tVNR7eOtNopFY4TkLNbPlRuCLFvFGnPGYZK89T0l71gnhZary9KqOpGfOjXC2FFwDI1DmQ02j1M
	UofQHvCTcMZUWJ3J1UF6tanVlXoD2MENacB/HVCbSjmCzdXuAM/TP1Hr0KNvYdtNTCuKqb/Mpf4
	Ipxr63H4qHmfqHp0PZXW1U2I7XXBKyoywGT
X-Received: by 2002:a05:6830:210f:b0:7e9:cd7a:7c34 with SMTP id 46e09a7af769-7ed9aa2704dmr10974468a34.10.1784667444956;
        Tue, 21 Jul 2026 13:57:24 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:24 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:00 -0600
Subject: [PATCH v7 11/29] dyndbg: factor ddebug_match_desc out from
 ddebug_change
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-11-010fbe73b311@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=4529;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=c5WIgaUW86zxkVqcui5pvUWjMpEd0rPqQJs9nD03Rho=;
 b=2XzxbK4At2mhCtWlDgUBewmM96HOIsSDXExdTJnlSiRicQ7UHFWSgn/VLr8QVNpxM7l+fgvKD
 oMYVGG1pNqlAHlEDdHhtjwJVkr7ZMz8SuBiYDkJcn6YDkhh/KneVxGV
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
2.55.0

