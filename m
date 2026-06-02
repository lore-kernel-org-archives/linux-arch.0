Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C9A3D8105
	for <linux-arch@vger.kernel.org>; Tue,  2 Jun 2026 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440561; cv=none; b=Gyz+xdnJwelnNDDTnNSngziLSlAvMdGghrm6CJ4jUJEJQK55juZwA9LsPjCI29jASFcJA+75RZrl2m8DrgcgHSH5B96HTyun0WdgI6tLm1V15J9UNmKcvR0LJ1OYhyaAEiz1foe586oju92vzyfLF0nYO1IaZMWvLS6tQ7yx3JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440561; c=relaxed/simple;
	bh=mS8zYCuPveoKc7T4Im/jzVvP1HCLKypYVHp0g2j6Skw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQn2keFmziB97RsDhtMexvHz0pF8nqha/gaiJLE6B5ZY61jwHCwSF738bQbE9I0UKxpXjuNGzPIekqepGU6D5Qd7+aZ7O8wy6gw8WvjUoKeidPOjepg5YqEJUR0qKK+IwlpT/B6Sqn1TPUjjh5mn6fYyKzB9KJAyX6ihQyXF7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFsqdD53; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFsqdD53"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ef616daf6so4553591f8f.3
        for <linux-arch@vger.kernel.org>; Tue, 02 Jun 2026 15:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440558; x=1781045358; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNu2VyRhrQI8zsAEpIkLCzKPvvxJoe9LgPS0NWOwvYU=;
        b=qFsqdD53t5NGf40QWrX0VJm44bJkQvgEQrlqBu6+91KE8LYiZoTL8Yn34JnWaSU4qv
         zeanv5V4qQkF3qQyYXPwmmiN4bHaUkDBxeBQKl/E6npWCLzbOC4ZP+JSj3cEgXLOy/Zx
         XraVuDxKJlCIQ7415hlry2sG9FFqXvdikpdDbeELfUfwWMotTG0nMlDWYARIt+4KWFMt
         qlWYN3VFI2jXusrcncPe5oLwAK0fos9EGax4TBEP5YhlFTAhimLJxQXzDA7Ez06Av8Yf
         kYR/tW0RK94QluNL2LPgSkTrpZ7WyfQ/Cth9hDCpUp/OvLJ+m2lE0W2LxOBkOFf5smyv
         QI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440558; x=1781045358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FNu2VyRhrQI8zsAEpIkLCzKPvvxJoe9LgPS0NWOwvYU=;
        b=OErsOAK2sbQGj6KirNUGhDPX39v32no+Sn0Ls79q8vYap4As6ZzTUapkKrpqvcF0+e
         0SSTMDeJKh01RStTgLYMt5F4Yd/HnxCEb8riS6r7nop2bYGc+3JO9JFF9EbBIFbbZPLo
         qOI2MQShu5ng/mvMiY4LROS1/Q91emX5ZwzGDh5gmxsq5dHMZg1ZLrhjoeE+lfl4yAn5
         gcQBY4Fvkq++mtxt/NbYXoPEhavuorzG8A1RPCsjl31JNlyyGv28RpdGvUhilY9RtbX/
         lJiXkvt1PojuWJkkZZlLUumImkqN5en+ea+h++yoJ5MdDN4VIhOt7urqF9phtmeqQQpu
         14Kg==
X-Forwarded-Encrypted: i=1; AFNElJ9hyYbOVSNmkikw9n/TZt2orJ+E4g5prBtcitM8aHMO/Duw95nuWSryo1+4sTRFQy8t9ipBvUPzTlxR@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm3xln1ywIGyPyBFWtpnQvwGxTf/kIFJgsO0hHIirIDqmuFf3G
	LgSeqxgP2yoKqbJDwhHVNBey0e7bWtaZ/R3DOja90cM6RxxWgnH6Q5HN
X-Gm-Gg: Acq92OHzoYQhvzpTdfj1sU6ubifSox2Nt+GHEtx1J5wofKEeBYjoqQ9CocK8cgz8C/k
	UUWaZvFNXvDWdWA7qPrpGHL0egH3copTz8KaIkeMQSOmeFoFzI5sP8TaZhc5Z1s1qStbKcaHujM
	Avy9RgVOahiYGbFzAGKbczVOi8kMXW01U3Hk64wtbWD0afh+aAYyp9ksgRuP5cpSEejOUQuYUgE
	RE/2vAPsUAmDiSB668fKCzfEUWiQNNBRYkD1imKiJEQPJpkj2dDM7T6OoB66Or+T0vbjjb20loB
	HvDNODo7wwmxFM47tNEfA0aoh0Mqf4t9mtZ/fpNTtP9esZrPLHGeQ1SZGZ5xtqA8Xmp81PNjLrB
	effMgSMHdKuxjMaFTRw7yzmECMF3CPAfUIwiJthPRdXpNY1LU0NFa9PEbjzPsq+NWQGUcVDnvdA
	oUAsSvO4bCLgZI+hgCKf0K/f31AXLnc+SrMoPBl4i3Kw==
X-Received: by 2002:a5d:44d2:0:b0:45e:651c:47bb with SMTP id ffacd0b85a97d-460218513b2mr497138f8f.28.1780440558379;
        Tue, 02 Jun 2026 15:49:18 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:49:17 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:21 +0000
Subject: [PATCH v4 24/25] lib/parser: add match_wildcard_hyphen() for
 agnostic matching
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-24-19a1445585a8@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=4121;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=mS8zYCuPveoKc7T4Im/jzVvP1HCLKypYVHp0g2j6Skw=;
 b=VXb9s6BILwbRYg9yQV7eipRGBEsG95GCuf6QT72hEVacy+qZBYi7X8O5FuSb5Iz5M4W1FDq67
 p9yjueJ/OsVCVSt5ROCmYhB9K2zwhc/6uV7MVoRWpT2QeQ8U6P+qRVG
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

