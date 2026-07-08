Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745043B71A0
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 02:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477134; cv=none; b=FOpd9qptwv5WU/wWoMQ8ktJZw4Oq0QFSWLVlQCX1wrmmI/ogf5EwH9fdB5H+6p4YA9d568/xuUJ1gYKWzBYFwJEROEV3M6Yj2vuXT14ajeK6B70lHlz2RHDPNDeAE4hbRnuTzl6rl9F2mdCcOGxO5l+H/Fb0XppojuxEvkssxNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477134; c=relaxed/simple;
	bh=cOvO6sx3YqLFd3U+lr49fTx42/CUMz8iaG20o06tc/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=imY9SKXyeLAHZfCkKTnR0t4Rhl6LSTOlW6BHk2R8KTzf8iqJRGzLc5i6DRD9zF80ukIHa5CJMDzPXzqUDhCEXEr50rvwUh4x9SrOjzxngYvy5K1W+Hmly0/LjYUStBFXbVRO8UL31hpUye7eUrCR8UPxg3Ww1K/fmKCC9yfcHxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rKBQhxlS; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKBQhxlS"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-49fa951b2c6so164278b6e.1
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 19:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477129; x=1784081929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l/mBb0fGCUwSIYa5j0WOJP7wxrKLNvtiy/Z40bYPFTI=;
        b=rKBQhxlSZsCCIYPy4cXSy9IvRV6WsF8ApUKiNTBn6LiX9ASXPTYFezer2qFdLHu0mc
         4PTZWnZsQyIVbFOuJ12y5VDQJS4KhPJkxsAMGQX2mx8I7v2bmljaKmNrRuNf2wH/XN86
         iIuZO28J3/NZXa0+iiOZuK+RaPHZXrbSj9Bo8HqZwLIcjRZywxLMWhtxdrm9A8nrbca0
         SLJqFXQ7UWHeHikArbj8w9YWnwv8vH7tcb9elnSxOv8KcEj9gn4XaNbTBgnYo3LFki/M
         xC6vdWHj+RvF3q3ZhcxoI6qqL16Rqy+iChjZJCXz0SE2SrS9hmtBa+S/bA4kQx07Lyiz
         Ii7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477129; x=1784081929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l/mBb0fGCUwSIYa5j0WOJP7wxrKLNvtiy/Z40bYPFTI=;
        b=MpKML6jVLqC4V6kU60YBA4vaFOfLfQpUFrD4YN/3Z0YlK3/2wRXAxGmgN1/RseSOed
         aJTPI+DpkGNveuckS9Cvt/4QJCa/tZ+lhTg4lP8+uAwXX8fM8c+EGJq0axb9950mHFr7
         CiZ5P697y/HjVtFBRcLd2IG0XW85I3nIP/yZu23SilbDg/StaF1atvGEpeMTMEbAc+VX
         5h5skIpeRb9fqUkIDb29KUakUTWagO5bkyg9avpb47/XqQQy9xdbR3QxOMQpzxkO4I7v
         NlKPx0KAqfXFNjq7hkX+ya8xWMPC7yMGKabK7/+YFOUHxryEwMOELE27uDWRAXr/dqd+
         Mgww==
X-Forwarded-Encrypted: i=1; AFNElJ+sATjQSgTpYqkON/X4fqqzxNE6LaPotr/ITzNn0H6GqOBOhnTuBf+2vBqsg173YyQyB/jr7xuoGkM4@vger.kernel.org
X-Gm-Message-State: AOJu0YzRmxq/0iFeb5yp1hBM5qPM0jupoCWW3uI1CNyoBUG6PN0opiJ2
	JX3AZahqr0jf25l5sZ6L04/OHnEX6b7+CH5L9ZyGVEva6N+DG+Hx8ah4
X-Gm-Gg: AfdE7cnBX+LUUW+UKjMTfTVST2EUWK+COMWT7ENZ0/zngY9rPLwwef1sUIfg298emjh
	nNLnNIwOWuB62T09W7hDlnU1vmLhbsvMxFvPu2iKWnW8YB4RIfdzu9ByD1jrfFgt7TSOwiz3yc0
	vjRxhbUH43pzy0RrpB0ZDrI/LV3/nGyVkFFQ7Kgb0863ndmIJUGlI3/X8qjKVlVx+ILE+HszNxm
	jPKc9mHupbRhPMe8jhC8Sy7vGLa/bBJkr54SMthO61plwS1rDjqNO6cKUALFb6PriQnBlkODNyF
	Vpr+8fDQjcHmPVsSQaUksYchTreq4qmjrccdnt76OuqaqcI0g9Wh12M5svwfeal2vJBmV5fwpAs
	8/RgPPh8nrFp25eiHGaf+IekkLHxk3bNL4u6xi81bzSCTp2pmy4z7gpHsfKvxcV9+pr8nMjJ26b
	IMRteAw1q1OAEjK3w+sFIWseEdnXOmvxT9Duuem8oDs2v4yFh1Dmk=
X-Received: by 2002:a05:6808:690a:b0:491:3ade:8b9e with SMTP id 5614622812f47-4a204be6dafmr307849b6e.36.1783477128889;
        Tue, 07 Jul 2026 19:18:48 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:18:48 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:13 -0600
Subject: [PATCH v6 13/24] lib/parser: add match_wildcard_hyphen() for
 agnostic matching
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-13-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=4222;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=cOvO6sx3YqLFd3U+lr49fTx42/CUMz8iaG20o06tc/Q=;
 b=fH4cz7gW7gQleI3gjGUtJ+SY/4OyEbN39bNTdvRHLXKHHDuXqOnwRFYYoExs8ygRoRpHkgAe6
 ZV6Ju8DSs2hD4+zruFWjdvsTEtNVTmLSJGv4jSilNH7wWImQjGLOnL4
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
2.55.0

