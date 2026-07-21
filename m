Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC2E47605B
	for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667462; cv=none; b=u9BnFFJeKZzjKYUMexQeXlonclHLq0E8Z/FeR0FiYSKwgY+0yaWQ/CQDOW/PYANX5v/uEW6tBW6GPT1N85XfWs+0K9J5YoGp4ecXAvVmHkDLgPV90DckMQd3NQ56QVh53I5ICGAI1f2oSHq7mNwlhJK515ZVFjTpZxW2UohvQE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667462; c=relaxed/simple;
	bh=vCopXpS5A+0vqa65Xr7hPuZt6GKzyDjwpQ2PFX7VP+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RHQdXiLrQ5ngi+nz0UPHBY7vDKttNJpoVcBCmvP4MOJtzMbcjXlqHLj7E4J+lypV+Kgywg0BCqLLmew1lF5+JJorasGwWmbH07uLMTDJ1zKmKRxni/Y5/Wn+DEmWwULiUqjrU61zwWaKMv09bL6G5DZlLHQHsfZoOhNV0aZXhJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+fIjx4f; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+fIjx4f"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e9d7464b71so4196336a34.0
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 13:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667457; x=1785272257; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GcxmLO0X4fD/rjCQxJy9THFKb1UhZCTTFFY7ow+im5M=;
        b=f+fIjx4fNCbxqAo/njsvDS0HcR+N2fx4Z9zBxbM6jvtvMv2REKjRRZWzVUlS90aCv6
         lOybUlUZ05uuUWT9bh2n2FNVmHwmB3Ji0lDopVQgGsMbngbb0Ohg9RszL9o+xv/lqOge
         CfIKQ3gkncMADaCZdSBD7Ge8Icp5C4zhmZjGfS1Wr24s03sCy/jjFFeEaX4EgFldTkQp
         7UCazSFxOncOaao/p8UTi9XBkQVnGqisG2qFnsRg5vtW/R4nxfRnpSgqqNQ/Bu0ZnYri
         2JTCXKjmS0KnKlJhwNzC02bv7j0jHmG7xaw8+yhXGTmUi6YgxpybWwWFBVcWDUcM+AsX
         7kRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667457; x=1785272257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GcxmLO0X4fD/rjCQxJy9THFKb1UhZCTTFFY7ow+im5M=;
        b=mdmCQJQFX7WrnUiPUyqtC6sTMaYCty3ZIPJMNI868eI3hl11FSbb/uturL/swpavi6
         UzI8joSr7hEw8KJScgTAV78p61e58e11ZJXpN7NYcSZ3/8BANNlRyPU1VhauDua1miXE
         IhyeGoYajaw6bWFaeXggbCyGp/pq2J7xhmjhavtl+jZwHl8Da5r0cKTqd5vPhsGe28u5
         zuum3BuMKKCkCcqMbTXCChWCqQIkp7g/q7qI2S4DzHlphB7vfOCLYRSWulTYtf0uJSMb
         YBTEuGo1qLqa2hBR4qcDz2vW3ZdBxYaU0GZKDzQHXVxnb1w7De/bNOgivLWrmwUu1LKR
         UuCQ==
X-Forwarded-Encrypted: i=1; AHgh+RqsDNtE9uM231xVAR3912kgzEn2a1b9REplVTGDAZL8E1IaHjo+ukM05T88u88nDfiOlL+cASjPBRmY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8MaSOqH020aDVdKVkwn+9t3iKwJM9QfN23iS5Jbnd2XU90F3t
	CcTsuUCmGuYkE1UIm3BNu3xjANP6OmyZ+tLuL2QJcL9tPJKTaJpwGvQj
X-Gm-Gg: AfdE7cmnlZfsohVi7s3Dv3YyaRCQGEpU8/UFPOqLzmQZs2xiNK96sksPdfqeHtED+ql
	2jzQ0Lx4Vdfh6xj9AzfrLybVotdYG9BlXnWBzaXNsl7TVu1S8IG78Ymq52xeAtINK4o9m8Uep/z
	eKMJjRoxrUnuUrXzNfhZLYRzgh+IS/JR0hDPiqSVE7GbzjgClKiB+s8vq66wJWajaN9vNfp2vqR
	B+Xw3jM2ywFV6vvTC7UJwMlppV5OMfbA8gGxnePfbLorx4+zzi5eJN8oEjD8NkIWMW662jzX9Md
	3kMkwlgpb3kfVP9PgQ9GRu3lM4pR/kSeBmUv7YohZjnFEfcj5NgLNzaKBHwxWANiCvxzN0yliyE
	mmWFIP9Z9U4omtVxxenw+MB/tBMEDAUFi+rrCsUItxkoUp7lIf9ZzU+rKzxIVHgoyweBCY0dejV
	F0bh5XqBBsU/vjbUfS4JzJezWSsKWDN05J+MQ8EFpAglxfthL9ro/7CZk44mp30xh/Lln8schzz
	bN9boZWArtqMZoanXSu1GgG6g==
X-Received: by 2002:a05:6830:64c8:b0:7e9:9e6d:2e2 with SMTP id 46e09a7af769-7eda09465c7mr9134654a34.20.1784667456701;
        Tue, 21 Jul 2026 13:57:36 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:36 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:10 -0600
Subject: [PATCH v7 21/29] dyndbg: tighten fn-sig of
 ddebug_apply_class_bitmap
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-21-010fbe73b311@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=2913;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=vCopXpS5A+0vqa65Xr7hPuZt6GKzyDjwpQ2PFX7VP+Q=;
 b=czh1EfKT5RalhVAtXzYlnQgEplQjMG6WdxIUWtEMin6k1ovGoPBlCCL0JHcEYTnSi3EjGomuo
 h7SvBRMagkHDcxuNUD21k8cPmwjlqwFtrohmn/pin09/8049fPMLTi3
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
index a619cefd801f..364a55fc9447 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -617,7 +617,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits,
+				     const unsigned long *new_bits,
+				     const unsigned long old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -626,12 +627,12 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
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
@@ -643,9 +644,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
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
@@ -694,7 +695,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, mod_name);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -707,7 +708,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, mod_name);
 		*dcp->lvl = inrep;
 		break;
 	default:

-- 
2.55.0

