Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267333DEAF5
	for <linux-arch@vger.kernel.org>; Thu,  5 Mar 2026 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729674; cv=none; b=VJ/b+OBQvjHLkiDmSGAmz0cxyoVCERdrlQWzrmKFCHAjpqosu8jsw+u+ECoPCCvdGgXSrhkzWkucc8j+ZpBFTSw+lEPVFy4g+Md+NIQ+uVA44qU2z1N1QQRS3EmWzjYkX0yU6efRGb6Irkff+rEX1Do+Ncf3jVRg4GnQouB7glk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729674; c=relaxed/simple;
	bh=A4U/FoOHtW+MFUPt0VllbbGZtdckI6pJiFlzK0SEzrc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U15ZsEeONqEHV20GH9z8y4hyHqcWh629G2CTlZ1QMW8kcqgbtPOhzQcii3AMRjOnYM6Rg3VpByzIEEA5VKiLqbd7aH1Um/E4oFc9Uv+63KXeTnKCnDdv6BIiGnnS2Kzne0oNpaj1rir5gd//wp9UMJqhOs1UY24mYTClY90MkHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4HMD/CGE; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4HMD/CGE"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4836cd6dfe6so68843505e9.2
        for <linux-arch@vger.kernel.org>; Thu, 05 Mar 2026 08:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772729671; x=1773334471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V+WoAPEi01xLPG9zvw+lWYQpkS4zZIu+aKoCdLedeNs=;
        b=4HMD/CGE6dbg/CK+yImdBeNbWOOeE2skBGvhrTrV+0Z2H8NvDeODh9DowVcyCKtywL
         mh8Kw7YXzusDb/8brKi+mGqX6BdWeJB2THRPDTf4/nXtCdvxXuIWdFRqR3i4493VPfu3
         3uP6GTgJWcbKPSJ47PM+HCEr7Co/PuMfqjtiuSXrfCvVyCXhVJoLpEGME/7YKXL3hPeK
         cusZ+CsT3CTDfbwgLgm7uXAI457I1N0mXH/2BB3cZ3NvQuLNXkADTCX+eCUsqNPbovWp
         EbneL3eu6P8TRCXUKXrgrR4xbatDPWc3Rq1JHMdRKRU8Jm/1H5zK51FNph/9TTa/gpdW
         aSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772729671; x=1773334471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+WoAPEi01xLPG9zvw+lWYQpkS4zZIu+aKoCdLedeNs=;
        b=VHGuu9YgWaPdHkHLgwIQPBcEsj3DmXhmCm+zmrRfsX46M4pSACvgaaspXPPkSVM0fU
         i/oKjNezXFXn+NwOgAyzOwRB5ZzJoI5OsbGB5G/aFJMTR9LCh/JnzXomNww/JxlQZq02
         lDA1idRYfi/rN+hxuxHZjiN/f9KOKQcSQfR1JwJD/obH+fMP/72kzTPBeXaSUm0e7bEx
         MuoPdJfkH+dwypSkKb+gi1PcmEh5eiRqK4LkdhG+Hp3+Q7gNZfEkN/ek+UA6szPpez7V
         0f6qsgkmzTBEoBJrEwqdak8A5j/ICfsCa7PORdWEBrJZJzLqMHYuorlwRzqksRREVXgS
         /SkA==
X-Forwarded-Encrypted: i=1; AJvYcCWEr+r+7zu/tVErCVd/fA+TvFSPyhM5VKEgjgWxvFN7+4AWeXvnoVYETmSbcQEtBRHlcxd0T2KBbHQE@vger.kernel.org
X-Gm-Message-State: AOJu0YzCmSDu8Dbnnf3wEKH80Pndz8jK1QBg9YSzH5DigzJxDxJSzAh4
	9+xFdGbNKRLELo5e7MAwaMJkpTWvM9piGhJqEdz4S1kXvSygsKhRSt1xF+0eG+CluY6gBw7U8B6
	JJ+wX6wvILuAph20Xwg==
X-Received: from wmbjv25.prod.google.com ([2002:a05:600c:5719:b0:480:6a27:9ec2])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:529b:b0:47d:25ac:3a94 with SMTP id 5b1f17b1804b1-485198840ddmr115115695e9.17.1772729671507;
 Thu, 05 Mar 2026 08:54:31 -0800 (PST)
Date: Thu, 05 Mar 2026 16:54:23 +0000
In-Reply-To: <20260305-kflagstab-v4-0-4fe6eea27e30@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305-kflagstab-v4-0-4fe6eea27e30@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260305-kflagstab-v4-3-4fe6eea27e30@google.com>
Subject: [PATCH v4 3/8] modpost: populate kflagstab
From: Siddharth Nayyar <sidnayyar@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-doc@vger.kernel.org, Siddharth Nayyar <sidnayyar@google.com>, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="utf-8"

This patch adds the ability to create entries for kernel symbol flag
bitsets in kflagstab. Modpost populates only the GPL-only flag for now.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 include/linux/export-internal.h | 7 +++++++
 scripts/mod/modpost.c           | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
index d445705ac13c..4123c7592404 100644
--- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -69,4 +69,11 @@
 	    ".long " #crc					"\n" \
 	    ".previous"						"\n")
 
+#define SYMBOL_FLAGS(sym, flags)					\
+	asm("	.section \"___kflagstab+" #sym "\",\"a\""	"\n"	\
+	    "__flags_" #sym ":"					"\n"	\
+	    "	.byte " #flags					"\n"	\
+	    "	.previous"					"\n"	\
+	)
+
 #endif /* __LINUX_EXPORT_INTERNAL_H__ */
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0c25b5ad497b..1d721fe67caf 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -244,6 +244,11 @@ static struct symbol *alloc_symbol(const char *name)
 	return s;
 }
 
+static uint8_t get_symbol_flags(const struct symbol *sym)
+{
+	return sym->is_gpl_only ? KSYM_FLAG_GPL_ONLY : 0;
+}
+
 /* For the hash of exported symbols */
 static void hash_add_symbol(struct symbol *sym)
 {
@@ -1874,6 +1879,9 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
 		buf_printf(buf, "KSYMTAB_%s(%s, \"%s\", \"%s\");\n",
 			   sym->is_func ? "FUNC" : "DATA", sym->name,
 			   sym->is_gpl_only ? "_gpl" : "", sym->namespace);
+
+		buf_printf(buf, "SYMBOL_FLAGS(%s, 0x%02x);\n",
+			   sym->name, get_symbol_flags(sym));
 	}
 
 	if (!modversions)

-- 
2.53.0.473.g4a7958ca14-goog

