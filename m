Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6927C445AE5
	for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 20:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667453; cv=none; b=kKEN7hCwsdxKZNa+FJsoJbeIFwXtzNecSYOZFnZX3j+Bul6dlNhBNvCcrmV1IouUMAv10oJUsyjXeiCtcn6jOmCiipJmGboMCtYH7MgDBAy5rCbxppo3c8FwNDMAL5qKhp173//KX3MW2Kv50qCqcpadOzOMkUzGc9OjWlxZwF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667453; c=relaxed/simple;
	bh=xMZm/oO0FtfekjkxZIUS9OIoDKqTmliEkK4gwpH/mIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g05NcW9otRkM6PPQNSQH9B//9dtOWKdhYRVoy7hk73h7xOq8PN38+ZCNpM8Gwsl2NDb0vRdeB+PTBU+826ueczP75kwW3MP4fC55u8D+X22fkp3zDN0C03fu4B0mKPh74BC2QUeRzQQeC/nuPjL/FSLRfk5EVLQxr9NKCjM5enU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoGCrNfW; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoGCrNfW"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7eb4d8a21a8so5533959a34.2
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 13:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667450; x=1785272250; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2eu41/ydt/uEYD6twBRH38ATPyPlKojYjlAenMFyI8=;
        b=YoGCrNfWrqDAmmlaGYv7F01W+OJuf9b9QtC3hh3VJ54KpR9/h4CFp6FN0OicFc0Q8D
         LtTodknSbF7U9x5xzVhOeU6oct3P7L1h+VtJ2rzH9LlATlOZ9XCX9Cgee/1iHngH8l3F
         1xcGAll4H4XcyJT8RnfJufF3zVX8EctjJTPP+cSMaLza80yrLmyb8Ul8M6Ve6FwOIivd
         Do2v2xDQb6s51cqeEd0865Noz9yj8g7bxo6QRwpS5USqSNpa+GB1T8C5NubibRLqK/+1
         aESAc79Ws/QOCx5PQxLRMzvADeIoRZs/8PQ6XiE6mOZM80IzRFtjHslo3ivszsqfhLiu
         HLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667450; x=1785272250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2eu41/ydt/uEYD6twBRH38ATPyPlKojYjlAenMFyI8=;
        b=pATN7kQYzlo286w7igPwsn4QveoasdZz5uACVY0B7Y1EMW/VIaQ81SaDvoRmu1MACF
         qlRp0DhQD3HvxWJPTH3CmBIu09NnVpnYDB1BSvQxLgrv/CN7/dNefoN77DNCeaKSjejA
         LvvHyX/0Nu+5Sm7VopMr+DwOzClRKNCtCooT13kCtjUPnXj8fZtqvrdD2j7dqK+Xws3C
         7ZUr0DO7a7TBZQsopUOCK/GvS4VCK8MHjUPriwTRCJQywwjg1pDD9/ON9znX9VZRhdGK
         d1bib9EWgnUHnelNtW9p9QZTB84s/WNH4cKPytrZLTXIdpJNCy1wKEmLV+G48i1N08Qw
         IXPQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+JUcS4/NhPJkogHh0HgM6jmn7NrzPJYJbe9V8Ncko0BE/CQ166cl0dGSfwhwRVDvmk49NmA7UBLj3@vger.kernel.org
X-Gm-Message-State: AOJu0YzDq9Y7FkDZ3T6bSg0Mfimcpk8skNMqnG8TQ/h2xfsSLyVoZHrI
	NJ5MZTgEnRjVTcYOWIgA98Uli9KAoOt/O5TBlvT1H0RmtcAVNu26cYRm
X-Gm-Gg: AfdE7cmrazx0FIp0UGcV8mp9t/5LJN2nfMdJ/HFSjK5oD4DT8Jnga4qZjkHMpsbZ0UU
	VcgC+v2A5pWcuDqGgv7gvXOUSdJF2OX0QDGVbkQdIMuNw6D2MlNv/2kO9N7LR0oibYJtSzyZqs2
	Qndw8Luskd5E2Dh7L0sEdds0lVoijUvNENOqHTcP679iXWOUGTH54D56gFGSxKLUN4muTkrtZSy
	n98t0pGW9QG+23SfPW3QxrrH0ytqkBCACZzLSrUxhUAeZzRAmE4qU5v1d7uwHh+4yFLWmuUpFR+
	vsdV9IuXsKdCdQLa21M2gQs//PGqpbMX8veKGuT9+AUhK0MfjJmQRQALpSMMGfgwBEEFuKbZHMP
	Ai358RFTRIuRlmO0fBiRxyCcH2YO1LUsdI9lEdkz84jaR8ttEXerGA7nRC+7eenAoR479fQgxsZ
	kbG0h4/pgufU5a4ikxhLXG/uV7dKg1rd/sipsMSRvsaxQevuOIBd1KptqobnVp+Z3tzyWvrdUEU
	P52R5hKtAazNd3rJ/cyeUk0e4p6z2lDDBHC
X-Received: by 2002:a05:6830:349e:b0:7e6:fe3a:b777 with SMTP id 46e09a7af769-7ed9aa23f9bmr12810053a34.13.1784667449716;
        Tue, 21 Jul 2026 13:57:29 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:29 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:04 -0600
Subject: [PATCH v7 15/29] dyndbg: drop NUM_TYPE_ARGS
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-15-010fbe73b311@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=1542;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=xMZm/oO0FtfekjkxZIUS9OIoDKqTmliEkK4gwpH/mIw=;
 b=N77P9AtjJFwy7FzRMr8In7kiy43wJO+O2C4iqOk47TEdDfFmP812nSRahvaUv1gzRqFViN7n8
 qgDCrRgljrVB76lmYlUQv1NGsjwiR6T6qctOUDgUkjgZ+pHvjsdGWoP
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

ARRAY_SIZE almost works here, since array decl is complete.
But define it locally, named __DDEBUG_ARRAY_SIZE, to avoid
include conflicts with  boot/<something> on some arch.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v7: actually use macro
v5: drop include, it causes redefined probs in /boot/* for some arch.
v2: include linux/array_size.h, correct commit subject, review after sob
---
 include/linux/dynamic_debug.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 9607121c3072..baf5c0853f45 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -8,6 +8,8 @@
 
 #include <linux/build_bug.h>
 
+#define __DDEBUG_ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
 /*
  * An instance of this structure is created in a special
  * ELF section at every dynamic debug callsite.  At runtime,
@@ -122,11 +124,9 @@ struct ddebug_class_param {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
 		.class_names = _var##_classnames,			\
+		.length = __DDEBUG_ARRAY_SIZE(_var##_classnames),	\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);

-- 
2.55.0

