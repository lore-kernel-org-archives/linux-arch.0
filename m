Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132537;
	b=x2qOBW5+BmstH78lwaA50pYUwvRhaZ3I1QdtqpG/0cP9Ffhdr87Hzz0Fzi7pnxmhA/oW
	 nDYSVzk9u+H3zAUDCm26ACegZp2UqCXu89zJWBW7tZJHh421qplQLCXbQvEXDU5wn9gPw
	 p52H0cP4Fvuh5blcwHB3OXn7m0HjPL6bHvgjSF8EysAbtr4CP7ju1V2ZBN9qc1y2WAQog
	 Wq8oUC9e+ONyJYCuUNA6q8+2zy8f/QSCukuDya1d4QV1vm4UgKGKj4a5GD9psAakwNCAH
	 Y/c6FgtXpZRPylVZF7mwtb3Z/32scyUjBEREcTVm9K6Nm/vOQ77D2aOsyU3j8iYCTow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132537;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DjUqwwg/6H1VCZmUcd6Vj/N8zfhZJvg5LLqYUZ/uGqU=;
	b=yhrX1+bbPBSDmrV2WLmZlFoNOw2jWgTasAi2qm1861iSdoZdw+4E7kdqqtvToj30xibV
	 AKfinZFJLIKyKA3NsfHf3JxrktachJ8iw/Z2hG8aK77KgsqIadrFj2ZSj5WzrCrwZH1lz
	 nuGNI+WtalBDsnJ/kfHCaJzPrMaaIxjIYu3ooxzCDq7AcHXmBEa8LYFw+h/96Ly5riXZn
	 v08Z+DkiIDmSRlY25RxWgRBvfR1+GT1+OUAPiQ8J4KwFlZLLxCg8Nxo8uDopzqvjdN8DZ
	 tIAuJ/Wo2t1LLS+nXYsMnZkRGqA5px4wZnbClQHV7eoKkRJz0ExVLelNRpP1smVb4bQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nh9+N96I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E211606A331;
	Tue, 27 Oct 2026 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nh9+N96I
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132537;
	b=kJDE0s8e0udPdsdBUtEHsZdh2J+KlGL/O06vnVgBof+K1HCKH9iwdq3TUVX1EHs4g0r4
	 ZsynOVSLRwugXN1eoezfad0aiDaSkXBaVn1Ysmiz4jaXoJRtNGKN744RoZwmfUTBTHjf7
	 2p7vfLUrxhxL66pguyHmYPmnEW/K/UUU3vJ64UOZwCcL1zLKkiGcFxMuahjIQEJuB+kQa
	 oaEORZal6dRSSX3H1OkBT0MtmepMXc7MFAJ0Pul0DJRk9ogilc8/RtHcTuBSa4YFfTVlb
	 dtz7yr83g8s5LXlFnshPCZHUY7NTAIuVEp69Km0gAyjPLzeWK32vskEdqKUSvqf8RFQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132537;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DjUqwwg/6H1VCZmUcd6Vj/N8zfhZJvg5LLqYUZ/uGqU=;
	b=cgmSFcttpvP46b2ES8JVFc8dKcXMNYwJa+UMpIO1EZVIlsSQrASIQVBmNuBokTvb7Cx9
	 4QeUefAkJHCOhbb3dnv/1q01I8HVogDpdU5e5VighctZ9cpDtBoEg5EdiMUIFGRtlXAws
	 Kjl5/ve8S67O3XA3+y4921G7mqlq76zroJtjmwDHanr5ClNy0IArl59gU/X4/05NrD6QV
	 eyZTgyWazX8fcwA+6kWz1sKRV5bBnu3b2GZGADl7kV+Keylhlv65vsP2gEIgcsa16GOLd
	 SO5QFDVPiEWHc+IdtmJKy7UTtGi1Gohb0NX2wYFTkMGrlplYsqEdtapYD993fiIvpvg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 126C81F01825;
	Tue, 27 Oct 2026 20:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132537;
	bh=DjUqwwg/6H1VCZmUcd6Vj/N8zfhZJvg5LLqYUZ/uGqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Nh9+N96I5FyTfincOTfkoSWyYRhdacFkEq5Z8rgAwDFfBIRMCf9HDvRuMbIq7HMLz
	 l6yXp0S9NdzRCUFZKmJt20ijbCWVCg23S/qJOsceNWoG/TaC5BvX4NEbRUUlONHqq2
	 wsUrs1PLDVMXi1CuYMBM1iIDHTDOYrtgg7/BsQZcbLiyqWQzFqmTzoknXoAokEEDG1
	 7kyMEwNCfEZ4qn3iXVhGC3S6CGkyyDhiYNkwafhDLyCgmk2ULV2HwG0bdQw8XBTtZT
	 tj7RJXroL3xguEf9HmJl3HW55ru1gAaPK877dzrSoNHfr+HoI6QYmQWGrygW0EYT4w
	 rXeomoINCd1EQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 54D204522D;
	Tue, 27 Oct 2026 20:22:10 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:15 -0600
Subject: [PATCH v13 15/39] dyndbg: tighten fn-sig of
 ddebug_apply_class_bitmap
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261027-dd-cmap-part2-clean-v13-15-9267923be612@gmail.com>
References: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
In-Reply-To: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
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
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jason Baron <jbaron@redhat.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=2921;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=/ldqEzrdqv/2hMCb93qXE9vZgTc7aNl6mn82Odto4jg=;
 b=Naivmj7iHff3W9xlYHYhUfepZztBzB/dwidid1c5ax/g1RujYJqnm4PXRiXapL5NWsjyRpSFl
 k20hhpyh85NBXXnLyCvoIFSuvB42l8RJWMRLDfFp/miCjidzX+jcMJP
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

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
2.56.0


