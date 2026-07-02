Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5211394E93
	for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2026 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010490; cv=none; b=c6XhhOWsIkQe1VwF2Asr674ztE2fERHl8i0EqB1KnbM63NrakNF/gtV/qS6aHoCfOGTgRVE0KbhRhWHoo2M0Gw5v7OIVZC6E/2RaZuhMYSRXExYkZKm5grLTm6tdPUQ1zTemPsCUVo2yQxPVW2SVixo2deo/a2rnIOrNqiSGP9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010490; c=relaxed/simple;
	bh=q0cqBNsjJhq7nt/Fn+0S0PJoYMLQXTHQFLMuKicG1os=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IUV+pzVYfqbneS9WDvPD8Vlkv64sh/3Ap0E/EtXosfcttrVR71qAfwjtZXspgfC2NNneqw3RZcOTD6iB+MORZFYJyVT4QAQij7QXjfSQUBP7kC3i8gJIoD74SGcwPQSilGAr0dAAxrHrlGQvXYfWimG1OG+ytl+dROZGwhCJFGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atsL514O; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atsL514O"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6a190528769so835398eaf.0
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2026 09:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010484; x=1783615284; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlBJo/XQdbEERc9HqMtCgmiWWOZLjFLBFuIKGxMZvw8=;
        b=atsL514OJm6iUJrq1eOS1lfbUoJgX5q53eoN8jr1JnyFbm4qWXlmNBq0UwYOcfTUgC
         e3o8mbauKXvjLvu3TQ10qmL5ZcZNuSrqT16LO+eDGGPa6AUyoybAr9IHTa0AaIfbkkHu
         Yok6AMMCX7upzsGTdW0RB9nUQSO7ubdxW+tpjYkw5Bet5H4JhSLZnuhOOfUS4hPhBYrO
         GHfRYSj3tOhHOXNqKXWCeZEW4Nr7BD6KBJaWuaYayQQ9ZNcWyjYZKPDstedpD4XYh7BP
         5lLwGjNnXvsX+KSSViFI/YC4l9zPIzUHBRddmj3nTf1HLs2ch0vs1PXGxol9ppsof6X4
         HHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010484; x=1783615284;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MlBJo/XQdbEERc9HqMtCgmiWWOZLjFLBFuIKGxMZvw8=;
        b=mnF7rdHhGIWrK8AmPxSjdmPVsIUZFqYubJ7473YsBiZ4E0hFyl5DrmulwQ/ibQfBld
         8Kju1UwaJumVAHKUx4D2UWokLhjXHK3PAQgCseO6q25hXREvdEB2FtKf2M3sbR6HopHG
         FnJzx9hL1zyAuc9Qn+S9tRbK/ThDa6oi/whgqSmOGaBzw9xtIyNeT19OqwY8g/f0nHI9
         Wn9i0KnFAceG9UW38G2f8xqTn8FVWssMl+yoapmrQPU0GESeAs1FbqfCZ5g6JIAhK4rb
         n6aHO7U0/UVcz0sNdTWE/IC1D0rc5viWpZXZchPsEXuU5JM0moh6WvCGeKNnb5stvZXw
         NlSw==
X-Forwarded-Encrypted: i=1; AFNElJ+5LR0/24tviKKYyWB1PASy82vSOrRBi4Zah7h1vNh0i/nL/3LRq6dRQCId6zBh+1OR3NJYNXKi8LfA@vger.kernel.org
X-Gm-Message-State: AOJu0YxYV5edBiWhEp17rv+xu2LqL5COInVaQQLLHBgZEek7cEf9aacN
	LF8urCKsM8Z3NpzVkKlfcl89mIz810fy2emczpH/XFRcPbKhMPZ0Sqwc
X-Gm-Gg: AfdE7clXT5JRpXwSxqkDqBwgjApvnrIj96nOQK7HHeaER8onLwXOgpvyAZ2Abo+/wX5
	vPHnk+ef3Oe6vK18FrEtWHtb1k17fpjwZKYZLTucvC9+6PwLE0sKDGGLHUAq/uBGBHa5vx3cTv7
	KfkGZ7wpQAN0wiWtuCS2D0E6BkkEtS+/skNg99SivvExZ8J+50G3zaZfw7LIuUeQW05RvEV0+Kh
	J7WxP6Qey0GApR6d+qNqNmMbDr1qluJl7g/8JQI/n/F6hEZPBxTHXpJroWmQ+osSOw7PJ+NYJyv
	atDJT9HgkXgtD05c56nnXiNA0XjMcX7JDSb7LTaHQ9Xm7Qr0Es1rAr7Wn3Zh6Gbh7+nv7KgZ3P+
	Hv1Te71Uj4qO4Hd9oE9QMZYd2GRS/NAsJ4+O8TOhfmFbbO0XZFY9CWAtIhiQYQaX1uAipjWWnIM
	KGjkIR9A7OV0BzZumXGLdBFYbiyTxR5FbvWBnmtE82XCRsHSGcdMQ=
X-Received: by 2002:a05:6820:4d0c:b0:6a1:5b81:6165 with SMTP id 006d021491bc7-6a3099c63e7mr4036506eaf.29.1783010484044;
        Thu, 02 Jul 2026 09:41:24 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:41:23 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:40:58 -0600
Subject: [PATCH v5 06/18] dyndbg: bump num-tokens in a query-cmd from 9 to
 15
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-6-24f22b052bf2@gmail.com>
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
 linux-modules@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=798;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=q0cqBNsjJhq7nt/Fn+0S0PJoYMLQXTHQFLMuKicG1os=;
 b=VLBnJePQ24weqt6kvLJCsEsOmicQ3g1ZFfiRe6eE05Uhgx78JR5IBr9it+BePeR6QsuthgUuN
 7fOI7CzsJ3ZAfq80rD3F9Ah6iX8SU/RrmxXATowwFmINGCjT92n4xuL
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Current MAXWORDS in ddebug_exec_query() is too small to accept a legal
query-command using all 6 keywords.  We *need* 13, but this adds a few
extra to allow certain errors to fail on subsequent, more meaningful
grammar checks.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index cd6b6c710ee2..efe12fac6363 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -554,7 +554,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
-#define MAXWORDS 9
+#define MAXWORDS 15
 	int nwords, nfound;
 	char *words[MAXWORDS];
 

-- 
2.54.0

