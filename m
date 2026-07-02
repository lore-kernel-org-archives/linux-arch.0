Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0388E390CB4
	for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2026 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010494; cv=none; b=kDoNZZvQB/LZf2vskQagbORkgKdQW69XpJK6xaj6xh1qD9uxT3YrPjXWuIgq9qCEKkqnknJFFrk3CdQ2A/KC90xo10kzTV+leE4a53bxsVSg8+GZg0YuoTp/A34rc688XmXlxqKxkNJzDnWT6KHcv0wqIjg6dDl8ePxqx9av+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010494; c=relaxed/simple;
	bh=qZKCtfeZXgr9USX3+37WWDppizwZjEcqYLWdj0ZjKXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oDGk5jl82MVN4VuTieD81XT04Gnie8HJghqd4w+HEyAAEVxq1y4O+6E2KNtS+xmMb8/KR/JEh4ejDOT4SowFIots6vQ70XO4xncNSFKmZCes0iLG5+xb81dBVFpQkyXDUCdQ5XOjKFxFwMCoG5ZPvJDq5SUwa4pQtD5EqVj99UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BA3T4kgg; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BA3T4kgg"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-44cc65b0a7fso585170fac.0
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2026 09:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010487; x=1783615287; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qvzOPyUHO3fHuBhGDC3KudpInHlOoaoXrnpC0iw+NA=;
        b=BA3T4kggu3XkBpYCbmqYfFtPIc5EloBJw9hqIi7C9+q2U7QsGY4SqjIRkImKVsMxwR
         nxgBPf2zP4QhnkwJBZatpvOKQ9iqpVmNV3v4sucaLcfFk1PRsMABsJDd+Mz99ySKAM2D
         lB4SFGxkOAaTBNJeUPy5aBLMjNunrsMHeI75W+wOdlZJyetImdKpN5WXYvpVokum2ZI7
         mZCJ4fqjLYOfeZfPboc2Wc14XbKJGMP9TvIbg5omlE8SZc6LN+QYHrcD4HqQN618zzca
         sXlFh8WoeajNhyCRchEGUA+mre59k2OmQoVfW+kqWJRBij5IoQGeH05opGtohGa/FDqo
         YiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010487; x=1783615287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+qvzOPyUHO3fHuBhGDC3KudpInHlOoaoXrnpC0iw+NA=;
        b=gOJ8IxU4gKZoGHMEQbNLD4t3u0aYieQ1bw0WD3W6G6qpWDJF5CHEL+/0p4wjSf6d8R
         e1k7aBw2udhJjLPTLBzZxz7wpwC2mwMDBUa8aREcWq5QXJYpPmu1ZubOcffvDiECgFTJ
         q/3p03wWYTQrSOz9R1+Vi/S/9Gi0hEUCKwdjpEFUMsKjw5A07V0Xxu5hd5ak3ZT5UdYH
         fnPdpJin2P2E5kDSNQQG6ikoepz6sSHT0vdT+c63q0hKO1vuARgrLUT+JyIPgcG0nSjC
         mYg8MIy3ave4VzY4xDfwMZepp673/v7GI+zxfIpyOgj+alEbD9AboVcpNdog8jrGjqn+
         q2Bw==
X-Forwarded-Encrypted: i=1; AHgh+RpJvVEoW5CYgszsf07Q6TyTHTnG4n4zcvcB4cFtA1/E7aRaTzyx5vkQR7nhtKFgpokwGzn1bRuJF7X+@vger.kernel.org
X-Gm-Message-State: AOJu0YzmLJFNanpMPwUlvFk63Eo+GCJsf8X8icwe21TBVpBhCy8zsJT5
	H6eM6eykwcHYE8Ny+5ETR8eeKtLBWPz/riRnr1LOZdyCBgYkP01qDfLS
X-Gm-Gg: AfdE7ck2ZR9bsw9qHxF8bOiNnQMxqqXooMXKLuuM4MeDA1DUXVDbS2zpbqRMYM4Z5DH
	BGsGPSz8IKO5reJzypxuy0eApDnwRi+GKr0VzCv5zYo1XChfay1QtHcVin+Zkp4qFKpw2mtNhjq
	iExtwXG156HwlUBYkHi8obKrinA4F8s9omaQTxvKJXpBCEn6TNaGHGlxmxiHm8GoyaqbJRqBpMF
	wwMxKP7/C8Al3B5KOdYRUH8Y7pO7Vy49RxPvAi/52ZEfXrlcbVfvspCiJp2smMDQ6ji7hyZa4af
	/spube0szh7oCnPhYDSO6nuNWuEAsOBRyPZD9k/tKxSjxqsBda+GX8xY5qDKXdz10hj8vc6yZeA
	aHkyx8QxyVai6Pzhp7dFBQ8O/AcdC8Nhq3eca/W6MuB5Xm2y5fquINUBwu6Ec1B3koZ771f1rR1
	Gad8idToYXLIvwMRqgz1NGUltN1MZnOcH0tTW5XrgAaioY2NoXhrjLZ1TMOotzpg==
X-Received: by 2002:a05:6871:890:b0:448:558c:d8bf with SMTP id 586e51a60fabf-44cea4ec473mr416039fac.17.1783010486868;
        Thu, 02 Jul 2026 09:41:26 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:41:26 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:41:00 -0600
Subject: [PATCH v5 08/18] lib/parser: add match_wildcard_hyphen() for
 agnostic matching
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-8-24f22b052bf2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=4222;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=qZKCtfeZXgr9USX3+37WWDppizwZjEcqYLWdj0ZjKXQ=;
 b=HDabVOht9/LjgxGn9EUPsGTjVLA6SABPlrw+n+vplGk0ZZsVg/BaAE17NvzN4FDBlciWIe69k
 oC0z4UynkjQDC8xxlVvCE64H0VdKQuGpVqPudup+cHHcIckvCztnQby
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

This commit introduces match_wildcard_hyphen() as a variant of the
existing match_wildcard() function. It treats hyphens and underscores
as identical characters during the matching process.

This is necessary for subsystems like dynamic_debug that need to match
module names provided by users (who often use underscores) against
names stored in the kernel (which may use hyphens, especially when
using KBUILD_MODFILE for built-ins).

To avoid code duplication, the core logic is refactored into a private
__match_wildcard() function marked as __always_inline. This allows the
compiler to generate optimized versions for both the strict and agnostic
callsites with zero runtime overhead.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v5: move ahead of array-slice patch to silence sashiko complaint about it
v4: initial version
---
 include/linux/parser.h |  1 +
 lib/parser.c           | 58 +++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/include/linux/parser.h b/include/linux/parser.h
index dd79f45a37b8..a3cc7bc5fb93 100644
--- a/include/linux/parser.h
+++ b/include/linux/parser.h
@@ -34,6 +34,7 @@ int match_u64(substring_t *, u64 *result);
 int match_octal(substring_t *, int *result);
 int match_hex(substring_t *, int *result);
 bool match_wildcard(const char *pattern, const char *str);
+bool match_wildcard_hyphen(const char *pattern, const char *str);
 size_t match_strlcpy(char *, const substring_t *, size_t);
 char *match_strdup(const substring_t *);
 
diff --git a/lib/parser.c b/lib/parser.c
index 62da0ac0d438..d5be01fa9adf 100644
--- a/lib/parser.c
+++ b/lib/parser.c
@@ -268,20 +268,13 @@ int match_hex(substring_t *s, int *result)
 }
 EXPORT_SYMBOL(match_hex);
 
-/**
- * match_wildcard - parse if a string matches given wildcard pattern
- * @pattern: wildcard pattern
- * @str: the string to be parsed
- *
- * Description: Parse the string @str to check if matches wildcard
- * pattern @pattern. The pattern may contain two types of wildcards:
- *
- * * '*' - matches zero or more characters
- * * '?' - matches one character
- *
- * Return: If the @str matches the @pattern, return true, else return false.
- */
-bool match_wildcard(const char *pattern, const char *str)
+static inline char dash2underscore(char c)
+{
+	return (c == '-') ? '_' : c;
+}
+
+static __always_inline bool __match_wildcard(const char *pattern, const char *str,
+					     bool hyphen_agnostic)
 {
 	const char *s = str;
 	const char *p = pattern;
@@ -301,7 +294,9 @@ bool match_wildcard(const char *pattern, const char *str)
 			pattern = p;
 			break;
 		default:
-			if (*s == *p) {
+			if (hyphen_agnostic ?
+			    (dash2underscore(*s) == dash2underscore(*p)) :
+			    (*s == *p)) {
 				s++;
 				p++;
 			} else {
@@ -319,8 +314,41 @@ bool match_wildcard(const char *pattern, const char *str)
 		++p;
 	return !*p;
 }
+
+/**
+ * match_wildcard - parse if a string matches given wildcard pattern
+ * @pattern: wildcard pattern
+ * @str: the string to be parsed
+ *
+ * Description: Parse the string @str to check if matches wildcard
+ * pattern @pattern. The pattern may contain two types of wildcards:
+ *
+ * * '*' - matches zero or more characters
+ * * '?' - matches one character
+ *
+ * Return: If the @str matches the @pattern, return true, else return false.
+ */
+bool match_wildcard(const char *pattern, const char *str)
+{
+	return __match_wildcard(pattern, str, false);
+}
 EXPORT_SYMBOL(match_wildcard);
 
+/**
+ * match_wildcard_hyphen - parse if a string matches given wildcard pattern
+ * @pattern: wildcard pattern
+ * @str: the string to be parsed
+ *
+ * Description: Same as match_wildcard, but treats '-' and '_' as identical.
+ *
+ * Return: If the @str matches the @pattern, return true, else return false.
+ */
+bool match_wildcard_hyphen(const char *pattern, const char *str)
+{
+	return __match_wildcard(pattern, str, true);
+}
+EXPORT_SYMBOL(match_wildcard_hyphen);
+
 /**
  * match_strlcpy - Copy the characters from a substring_t to a sized buffer
  * @dest: where to copy to

-- 
2.54.0

