Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1969566C43
	for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202920; cv=none; b=JPCk6xGQhjbEHZ2xttjcf8SlMAYmdOAud9DAAgxalMtgeNOfjiMNqflNmCmkKDgz5Dk4h/wDRrGGCei0pJ7PjTfN+DJprcYyfLsNGYnO74YDXvH+4U8w4SZvpn1ejO55e5Ri6uSA82pECVtFKs9SfPexxfM6/Bwr2S8NdCsasEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202920; c=relaxed/simple;
	bh=4cPDF74uOTh8cYJJIZjBbCuC9sfRIaYWwiE1nN9E9C0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aazvFjBOehMwbIX0nr+6Ao+U5J84siLU+Fg7UqD0HdzBs9gbSN/cnD+8yBeC+WXmmef2nI+IyIW0BzbQuxNdTf0TRlF7Xq7NoVVL1g0OAyOLbirfbcy1znnh4O7KqQQHM6QrTi1nPcR6TrA8Qg4nk8jlMIEyberrP4EfaGW10Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2fXbzBy; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2fXbzBy"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b37a3ed714so1020235b6e.0
        for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 15:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202915; x=1790807715; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nkNAt1DhrZGGdf2x0u/TLTqqqm1yS1gyvZGd21ceXy4=;
        b=n2fXbzBy/EEI/C8TbJFGW0kSWzV4Y/zCfw2WhME/w94EEujtNf7Xer+McyoXlS1L9N
         R/ZfEAlvaMlqtVBZkQug2V74B5FNLAjILbjytAgqRNVtcZXrYHknDrMrWmWRy0PKcX1D
         FWDHurpF34JXeoJ7h7fbaLIyo1sLUj55q3mNIdYJGdJEznUInl8C21UVH2jhrkJgfc7G
         P+vj+hUAMJgllxPX1Jy2d3f2o2ZOlWeqzBhJEcNaDf5e9R/8ILjCZDD6Sm6SjwvrhDhG
         a45zLkBeD544VKjijHxhDuywviwIstueMWTumcPe4oA03Qnd5IBbNCVn41S15xAfOMcJ
         GIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202915; x=1790807715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nkNAt1DhrZGGdf2x0u/TLTqqqm1yS1gyvZGd21ceXy4=;
        b=dMxPxTFf3O455WcowbbBibJCqmwnfeYw+sfzzWsVYLmhT0fOWL+EAD4Fd9yWBVDVEX
         uRP8bwefxHIKJb3Ly0oNXalk5LDSx2K4XwTNcNEM6IZUAn9AULAKOG88fHBXX6cp65zT
         yb9CCg/e9Es/fR8p7l4OXMvcLvWoAsxKKAZ/OWKt9EMlJPbJRQu2+TACr6PlRMr1mjsj
         HaVGOJCweFaIjYpKDRfpP2Cbpg0T0TbNS3V3POj1n9X1IpCbcs7GufiDpn5cD3YFhuWG
         357l1zNcnog9XP89gOhm8+bdLvY7YIQNMZKq2VdefQ3z42wilAvPB5aKQ2DFKS606dZ7
         K+9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzyKlWURnq4sf7dknQ5EunfaPTedwG63mxPnSm1k1djIJVD3v/ANW/9Oo8GQWn+5xPWyfEEv6VkK/Xn@vger.kernel.org
X-Gm-Message-State: AFuF++nAVWaoSO8zJ8bU266SW1YBCPALsDPwYTHyxYrZY3NLghqs3OnC
	B+9wnHQ0sIBmNHoZhkHW4T28mhYluPMkBU+eXIa08HHl8I47EC+Jt5kP
X-Gm-Gg: AYBFou16X3uJcEFJtnQDs0W2Bu/MW4mC2oHCwIIYyTtDn0OfW7r0xYDY/XeTJAl2CP+
	jQxgpTvrVpWp139ylCHgoINxmyK36YyRWXyy1uj/3uQyhf14EWx8EARpC8XJCF5kb0endVHhjpi
	jV0EpOJf+Wt2gZuZG8T82Vl/cW7i3mnGMQJzBavgzKLlFy/ZZop2n5g9QVBWjXC4XI8KgZjBxFj
	WAVb2mTf+UvAWJS2WhA8BxdADKOZsTHElmv30hyiGdt4L3VX9FkDsfRLh6cUuHASj4r+EWl0NyI
	wUCw2tv14/UIrMrcAnVIP2oTdXIkSb+LMuxi0uv5PaPTBRNYAsaLdPwrjLvNYnJWU9v76Qkt5cM
	FrqQgngqtOur1GTp8hrsPXW3v4wVXmQcjyqOgAqA06wO/LkgHv71Vsf4m9ub2YloympD2Z1gLpT
	YBbtaYbuR1TvC3TPnkIXp3E6p6P6l9cSaUf4QRZ08WDjq5qCIrVxu//x1vrbnhZ851UNnga4NGd
	KN5FmoctXF0riG2ZLegrGK58iRcRC/JHvQs8jHYYd0VrrPzro3N1MmIxhisdrQierqdjtsbV/tW
	vYaFqjdpy+39oaprOp3F
X-Received: by 2002:a05:6808:15a0:b0:4d6:9252:4644 with SMTP id 5614622812f47-4d72ea60fb1mr765056b6e.56.1790202915346;
        Wed, 23 Sep 2026 15:35:15 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:35:14 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:40 -0600
Subject: [PATCH v11 16/38] dyndbg: tighten fn-sig of
 ddebug_apply_class_bitmap
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-16-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=2921;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=4cPDF74uOTh8cYJJIZjBbCuC9sfRIaYWwiE1nN9E9C0=;
 b=NdUjfPZHrk8JLNf8jv2A22Pgy2aHnQl1B+XBp+Nta+zkRjS8Vz4S7yx13vlYiDV2b3eubCIw2
 aMZRGrTIoLcBlZRhOi8JWmEBIrT337ezVBtIT3C6QaKGDG6HOUEOp6P
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

old_bits arg is currently a pointer to the input bits, but this could
allow inadvertent changes to the input by the fn.  Disallow this.
And constify new_bits while here.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: move RvB after SoB
---
 lib/dynamic_debug.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index bbe32fab74e8..474df0dbedc1 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -620,7 +620,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits,
+				     const unsigned long *new_bits,
+				     const unsigned long old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -629,12 +630,12 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	if (*new_bits != *old_bits)
+	if (*new_bits != old_bits)
 		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
-			  *old_bits, query_modname ?: "'*'");
+			  old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
-		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
+		if (test_bit(bi, new_bits) == test_bit(bi, &old_bits))
 			continue;
 
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
@@ -646,9 +647,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
-	if (*new_bits != *old_bits)
+	if (*new_bits != old_bits)
 		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
-			  *old_bits, query_modname ?: "'*'");
+			  old_bits, query_modname ?: "'*'");
 
 	return matches;
 }
@@ -690,7 +691,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 		}
 		old_val = READ_ONCE(*dcp->bits);
 		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, &old_val, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, old_val, mod_name);
 		WRITE_ONCE(*dcp->bits, inrep);
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -704,7 +705,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 		old_bits = CLASSMAP_BITMASK(old_val);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, mod_name);
 		WRITE_ONCE(*dcp->lvl, inrep);
 		break;
 	default:

-- 
2.55.0

