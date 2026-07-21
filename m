Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC47443E44
	for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667457; cv=none; b=SYj7opDqz+I59/ZpedAozqvE713E152MokTpFvSdcReSz6UIcyKjXtkxxJM0Amoru343gH/0rjmZJjTGzGk7nQg6UKM02goMXnAtLFIen2NOT8XKcqviv7UO9NZ6/jYabXQAMKRu8Bl2WAG+JiDjTb9XvTbFRYG95BwzRok3p1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667457; c=relaxed/simple;
	bh=cOvO6sx3YqLFd3U+lr49fTx42/CUMz8iaG20o06tc/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=prQNFmN1cYg7IXavXyXnJeoE2/c/JHGQVMUV7X1JY0Hq2C+EAijhpz1BlXFNMfH3kHSiBLMDkJFKQ1KvlcmpzjdY/7OjcMzZWJ5jkANqcqBaRxKVgUdAZz6V0rVz94P846Fp8fLKxqbcSL70G1W21aM1HnnRET2kiVh7L3QCgNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsOTIsDz; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsOTIsDz"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7ec3b429a3aso822247a34.1
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667453; x=1785272253; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l/mBb0fGCUwSIYa5j0WOJP7wxrKLNvtiy/Z40bYPFTI=;
        b=OsOTIsDzgFVMM5MqVTmk9HPasb3PyfSYNnqanDBkL4qfoKrhGngxSvWK6IX+2jcFHc
         g6h1OZR7mXcHDXXU3ouQ+I82JF4XmQFFrVQop4aabWI0JD81GGGgbRxf8VVtesfiRPFr
         XcbP0NLvY23G+ilF+HEDVJ/I1J576yk69RFSSOmE0JXRt0PvX2x6Ex90fQi4gipR5BST
         mkmMuGrtbLXIlS86u4JHCzqqcZBFrBLHR6lhauSh/o186TYtNMzs6MxcXotWbNbwt/MV
         gqMhSIT0lTuh6aZFKRwJnW7iA9jac7MCQ3tCSj72PxuF6iD407ntfH4gZ+z3Kxy28hxP
         GUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667453; x=1785272253;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l/mBb0fGCUwSIYa5j0WOJP7wxrKLNvtiy/Z40bYPFTI=;
        b=qcQNhfp7UkOh7QjlF7u+nXVnFdaRbsCSn2t2RHYI1OBgKJmMPG/9ZJl7dTFLxOu/y4
         GUY4ZhNVNXJSXpnZ2+PhUc6EGN4cSq1pl3bPhvC2xUr0HYHJ4gTd0pPnc5w76Uus6iyq
         eRE5HEfrQ/8EbD6Hu0ZnXPpHNKTxiayhGshD4LsrSomtx4GSSCv9zTVyEAzuEW6y/yl0
         GZmsCxHdNEGvghNfErf3JTPIIbLMc6Qg8Wl6sqGcjbn4ZDW8teLdJRyruoqVZJeEcW2S
         7yMilvDbTmT3zLXpkLs1ZUqPsOs2s5TW8s3vLBSUW4hF7owzQUmgUuv+CSoA7mpSxUQg
         lv9g==
X-Forwarded-Encrypted: i=1; AHgh+RpHNeeJVX4LQabMaNqJpJ53aoWBFnWtm9c3/6mNIc23At48ALP9ASaepimSGtHTErWvAScnbth98+iR@vger.kernel.org
X-Gm-Message-State: AOJu0YwJqcz5540sQF/ZeGz26CFgpp9aoXMiFVtnv5B1/aFxgiBPwnC0
	K6+2xk2SKKqQm0Fzn5k7kMiBgF7FekHZOCMyaqmsrVW4FjXK7mDnnbIt
X-Gm-Gg: AfdE7ckIK9IZhaEKVui0RsUxQdz4rrxlLV/krUXuwuWW22IiHQz4pBh2cZFLcMI8Bis
	DbDPjTirLWR6Br4rh7V+XifT2zIxsgHeYYjvGaBMUtkc/ve1JjO5neMmmZlsqiaCR/JLombAXxy
	v8a5zu00SddpgWpK0vR1a1MLSwvy8RT6n3c8/1c8p/aeqdMeE6YVwsISJPVd2pcuhnYNjQ91nns
	J0WfUbhXP7EwuCqJC9OV0rf/QTUmLmqzzA3gWJW4XKldqiX3OU8Tfvn/RUvXbwjFw8ihOiwnUOK
	ommDZyWEKB4OS+Rm/XcZaZ2IDSOJ0mvmLqMtVo/BEO8Dw5m0HWl4zcXO/K2DT5hmH65w0n1HmQR
	sBhkVYShXetyN+Ds0IgIkG/+3LTVh2FfKN15SU03zScnCYrybXzY5YOydsBBDSddWNlkfXCfu2r
	DRUuEwU/FA3d5hfT4GG5kf8NzE4ayQJuTGtXfjDno6cSVjCaVB24HmM4ResCHR2b484BtuLeZVK
	DnBi5H8ShWNHmgbikq6eyhoKA==
X-Received: by 2002:a05:6830:7002:b0:7e9:e82e:e683 with SMTP id 46e09a7af769-7eda08ab141mr11477690a34.7.1784667453210;
        Tue, 21 Jul 2026 13:57:33 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:32 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:07 -0600
Subject: [PATCH v7 18/29] lib/parser: add match_wildcard_hyphen() for
 agnostic matching
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-18-010fbe73b311@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=4222;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=cOvO6sx3YqLFd3U+lr49fTx42/CUMz8iaG20o06tc/Q=;
 b=omQ27F1Lj0I+8IXmB8JTu88Ef5LiDN+J0UVCbq+/MPKcMkHoSyEhHezbJpnSU+hYg3ip/fEgR
 mO3/oDXWNBOCjLYtJlHFX2MGwd1O38pZNZduH0FaAyqjqod07vIJjkT
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

