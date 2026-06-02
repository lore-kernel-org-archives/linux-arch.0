Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3F93C4B94
	for <linux-arch@vger.kernel.org>; Tue,  2 Jun 2026 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440516; cv=none; b=s5Zh/WMm8Jovb/HALxWP0SfhGGeOnkpFe791pqp+BTpX21AO0KkeVzqbZFayKZNiF1Vou0fQ1JOHfW673/Kh5zenzI6SjWWWicnp6JpNU7rOVzZxD0vL7s6DA3UUwMorVgW+XbQ0qhsLwrLBx6x+O9MMXRWuzd5lNg6+K5Tu5RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440516; c=relaxed/simple;
	bh=ytc0P/UZw6i8hpySK2Au28vrT+KoK4/4tvvmOq28NjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UV0CtxzI859uizrAA4ltINIYz1a+ES0REaI+sq0BclcH5JsNsD8uqeZf6XA0vLvZrt++460PpgJL0vKALNr9Lg3sHR4RoVWVeeEncX22W/aISkRen0qBe+88aMlyS7zXRjCNjxsCm9WAz4/l+ZkUaFsY6IxD6ueT0YIaFHedNV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdm71sAh; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdm71sAh"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef616daf6so4553162f8f.3
        for <linux-arch@vger.kernel.org>; Tue, 02 Jun 2026 15:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440514; x=1781045314; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdDKIkZQT8kN6q6EUNEFoTcvXlPCpXkuxCaw1ETC1j0=;
        b=qdm71sAhQ3ko26Cw5K+WoH0aqzULaWlhIY52ZHndwnQkyWudXIXAm/7/0ZXkZzgABW
         a7hFn1agXWAt/CQZ6wzA4+pbX+iSrU2hCBd0a/LGJK84OpvrTak3KlpjMFkzO/PeBZJS
         mgAXNvxbx0Q0p9B8N5gngzrUXmse2Ih3uPOAY2AkQxIyW6qUc3Wwq9Cb/vFawO5+PHX1
         Lnu37mka0eYKXNUUM4MxLzAuPnMvcolpyL8X4yCjkB8FcsAgAlzF3YjjO5ALpnWF+e0J
         WLxNNSB5Jd9z2Y24+7qXm8TD6kAoy9MkPINGp0htPLW6DW6S31X2yI3Lz4dsz6jen/IQ
         57Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440514; x=1781045314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BdDKIkZQT8kN6q6EUNEFoTcvXlPCpXkuxCaw1ETC1j0=;
        b=DxuV41Qv2CXuFwPqKbEK5qzeD4dTNPO+FaD7Tcg7279ki76lCDwQlycYALvCpVPlWb
         gdpFkf0ZVXizASbGD+IdQvKQmCxnOhNbtY5InCLJaBXLPCwu1spN4o9+2kQo6QVPCzRE
         m2H1yVbwqGA2BHzIo76q7hljp9RvxaI8I2zr2f4fG/M0nqD8kfAuDHJ3N53HvZAM3DC/
         21RYLh2udD2efSWeDsT8peX1NMaUktlcGgXK5fSzYyOEkirBxLSXzV/s7C5doH/VN60+
         WLcCULty24HzjofIwGDKvXHBC6vte5RV8azkfupRP/KLHsiRayPkc1MSeYY7dSzNuVJ5
         l+1g==
X-Forwarded-Encrypted: i=1; AFNElJ/0Rf1mvr6LO708EffkdSAdeB/U5t4emataeVpln69A6HZdSLjrSvh8h4OxhiHUC6Lih0xvJBAxrG9k@vger.kernel.org
X-Gm-Message-State: AOJu0YziDw8RA2SX8LtnJkdAR1efyi+S+Kky4ifpIkULWy5574UrzRev
	AhCVG4Uzh3ThEr02YCePy2TQ2Hr1ZPNxxOnSCZLoloqj0m+2N0D5MCVy
X-Gm-Gg: Acq92OH2Sn6MvBsaxLBrFgtCDvr+0orDbeUjuO6Ryn+8fn6tZHsM9qq5cXilkXz77PJ
	0WUKlr16OLY1/wOVm6JvBDIJaYdnLxODg4MbbUcEtiuAXXonUbeuGc4iLq5M2spCQOxoqR8riDY
	6u7yvE+XUl+0eIzcXs97ctSsveAbUaX84esmOeyoaap42T1rwHpYAAQmYNrpzYpFcy18sHKpEOY
	iFWa3s91uNovVCsICqW/LHPi4K/HbQucVTuMGKSIrQKeZIIav2uxAsKoeQFFAmONvbNuzqpEnft
	S3uTW4uWioRuAKKzSo244vc+tNsrBFcT3y/zIUHe6tA+rbQptM333VhWHf18ssxd8DdpTjzx0oG
	y9jinjhWg6l3DrU1ZPuNwgVV3sCXaGa1qXdI2lmiFun5A/vfgHEsALBU60HiMiWjTANAVRj2DIu
	jxFKnFtuzo8W7SK8p1c2NAVomff/x9+6vmfK+Rf8yh/A==
X-Received: by 2002:a5d:624a:0:b0:45e:ce28:666a with SMTP id ffacd0b85a97d-46021781a64mr481587f8f.1.1780440513739;
        Tue, 02 Jun 2026 15:48:33 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:48:33 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:05 +0000
Subject: [PATCH v4 08/25] dyndbg: factor ddebug_match_desc out from
 ddebug_change
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-8-19a1445585a8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=4346;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ytc0P/UZw6i8hpySK2Au28vrT+KoK4/4tvvmOq28NjE=;
 b=5Nnx0wurAISA7XPWvLxIHjr9MiqVPJsdjQtzB3crXplmEx4Fh70GzBvOTm8YTKred1nIS6x5n
 Js4PINvk2WlBIWopr7o4sC+XOKirBZgfd5GHiAFVWak9zlb/tYYXGsy
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
 lib/dynamic_debug.c | 83 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 18a71a9108d3..6b1e983cfedc 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -172,6 +172,52 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
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
@@ -204,42 +250,7 @@ static int ddebug_change(const struct ddebug_query *query,
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

