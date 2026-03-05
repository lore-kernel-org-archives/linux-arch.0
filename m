Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C253DEAC5
	for <linux-arch@vger.kernel.org>; Thu,  5 Mar 2026 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729694; cv=none; b=NrmBsu44CKqZAtedOQANDFC/NalQsGoGR67rBc0BdwENuWme0tWfDOfKR5V8TIRjmS+C7ECktZcfcmGEOffwkfcp1DHDiBIAc5BXJ2MTfidsyiDspGVbmGZTxqZ9DrYWMR4LSYKYw1jDZLo2s7e48gsZrtvACQJelgn86Wg5gmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729694; c=relaxed/simple;
	bh=8wThas+yx6VNeitZlqkk+kXKQX1pW5KK15IT5W2pzHQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tzO+/6w5bsvhSOZDb6Km2KZJsZsB0RbLcvUehCvMac9muNrKkknS2oqpaTyFkP0LMi8/NvzobrB3P13eC0XC2++Rs9pkmAs22Jg9uagDRx93wuY8lkfH1i67hvJiSNZl+alxc7WZnKNZUsY4+bilXAxrAQdPvd7UMouwsbLyHpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zvmx1IpI; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zvmx1IpI"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4836c819456so62216275e9.3
        for <linux-arch@vger.kernel.org>; Thu, 05 Mar 2026 08:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772729674; x=1773334474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SFGOKKmdozaG9322AXfBKix4rJQP+3sKTD6zVfi8C3I=;
        b=zvmx1IpI7nado72UsjjXdZvSHZfw4yt+2GZdT6YaJK3IPas3AXd3nWACJQmvMIN60R
         rj1fv2aMSshDBQ3/72gu0bHwjQfoYMTS6hFblTdKTAW3w5ZhiRR2rNHatBoXip9njWY+
         /2hVbHFDGaQ0lRc2IeLom1c1DqtafCzl2VVvKky4oZCbdtij775/NUOU2RwVr22Q1Z4n
         0qN5JAkcikrJxK7u0gs2LtCnMrRGa1hhnatCXYXs85ZsjentBTV3T+jIr/mcMoGwJHFw
         WDhPIRu0p2eq5Jandckz7yWdxEr3o8prGwx/kacYUg+kBh1It9fGRAwNYRb2XbylKwQn
         H4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772729674; x=1773334474;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFGOKKmdozaG9322AXfBKix4rJQP+3sKTD6zVfi8C3I=;
        b=t5CFtqMqmZFfpzPm4gqg3ofy6y+tcAewWfLCIu9Nwdz9yDtuHlvMo6Sj82utsGiTd8
         WLgG5Isw9EY01iuFkIQMEaGnr8Xi6579EDIu/7tFrcUHbrjF8B5+bI3QC0C3R4d3+77P
         u0F2Mo5oDDYy21xljPL1WVjKDGjgEKVlLmx3aQn5DVlUuoxIKp/mA7o3A/hGC8AamDpR
         X4SXL9+yRjowiG0ya0gdjGT+dmLJXeTeNY6Rek6iAvmoHs0nrvvUhHlMdZp3r/tuTtVR
         0eF4VRQjgrfWLoOjjP4DxKHYnFOeK1gSSQJTLrCH2YNskKbX+d1Xmun0g/8sdYlcXJRb
         puvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpaRxXMsUbyNm9TtMURVBJwDDh7BRKD9lKj5f01RenOutyaFKO1+V+pJE43STSxK+CR1mK7MFUabkB@vger.kernel.org
X-Gm-Message-State: AOJu0YzDfPhPibcoJvILoNk1y8lOJNtPUz9Y6ggaO95Nd+N6yZIEYis9
	lNXVLjbCmAbd/G11hi4o2KV6R2YT9C7FUAw0vVQeSfPuDiYzYNpkR/d6qwlpwIyMF1phh3CN09O
	5Acdo72bKhsCsGt+kSw==
X-Received: from wmat14.prod.google.com ([2002:a05:600c:6d0e:b0:480:2e46:31e1])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b67:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-4851989ca05mr112546655e9.24.1772729674165;
 Thu, 05 Mar 2026 08:54:34 -0800 (PST)
Date: Thu, 05 Mar 2026 16:54:25 +0000
In-Reply-To: <20260305-kflagstab-v4-0-4fe6eea27e30@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305-kflagstab-v4-0-4fe6eea27e30@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260305-kflagstab-v4-5-4fe6eea27e30@google.com>
Subject: [PATCH v4 5/8] modpost: remove fragmentation of ksymtab and kcrctab sections
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

Since the modules loader determines whether an exported symbol is GPL
only from data in the kflagstab section, modpost can put all symbols in
the regular ksymtab and stop using the *_gpl versions of the ksymtab and
kcrctab.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 include/linux/export-internal.h | 21 +++++++++++----------
 scripts/mod/modpost.c           |  8 ++++----
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
index 4123c7592404..726054614752 100644
--- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -37,14 +37,14 @@
  * section flag requires it. Use '%progbits' instead of '@progbits' since the
  * former apparently works on all arches according to the binutils source.
  */
-#define __KSYMTAB(name, sym, sec, ns)						\
+#define __KSYMTAB(name, sym, ns)						\
 	asm("	.section \"__ksymtab_strings\",\"aMS\",%progbits,1"	"\n"	\
 	    "__kstrtab_" #name ":"					"\n"	\
 	    "	.asciz \"" #name "\""					"\n"	\
 	    "__kstrtabns_" #name ":"					"\n"	\
 	    "	.asciz \"" ns "\""					"\n"	\
 	    "	.previous"						"\n"	\
-	    "	.section \"___ksymtab" sec "+" #name "\", \"a\""	"\n"	\
+	    "	.section \"___ksymtab+" #name "\", \"a\""		"\n"	\
 		__KSYM_ALIGN						"\n"	\
 	    "__ksymtab_" #name ":"					"\n"	\
 		__KSYM_REF(sym)						"\n"	\
@@ -59,15 +59,16 @@
 #define KSYM_FUNC(name)		name
 #endif
 
-#define KSYMTAB_FUNC(name, sec, ns)	__KSYMTAB(name, KSYM_FUNC(name), sec, ns)
-#define KSYMTAB_DATA(name, sec, ns)	__KSYMTAB(name, name, sec, ns)
+#define KSYMTAB_FUNC(name, ns)	__KSYMTAB(name, KSYM_FUNC(name), ns)
+#define KSYMTAB_DATA(name, ns)	__KSYMTAB(name, name, ns)
 
-#define SYMBOL_CRC(sym, crc, sec)   \
-	asm(".section \"___kcrctab" sec "+" #sym "\",\"a\""	"\n" \
-	    ".balign 4"						"\n" \
-	    "__crc_" #sym ":"					"\n" \
-	    ".long " #crc					"\n" \
-	    ".previous"						"\n")
+#define SYMBOL_CRC(sym, crc)					\
+	asm("	.section \"___kcrctab+" #sym "\",\"a\""	"\n"	\
+	    "	.balign 4"				"\n"	\
+	    "__crc_" #sym ":"				"\n"	\
+	    "	.long " #crc				"\n"	\
+	    "	.previous"				"\n"	\
+	)
 
 #define SYMBOL_FLAGS(sym, flags)					\
 	asm("	.section \"___kflagstab+" #sym "\",\"a\""	"\n"	\
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 1d721fe67caf..9d96acce60a8 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1876,9 +1876,9 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
 		if (trim_unused_exports && !sym->used)
 			continue;
 
-		buf_printf(buf, "KSYMTAB_%s(%s, \"%s\", \"%s\");\n",
+		buf_printf(buf, "KSYMTAB_%s(%s, \"%s\");\n",
 			   sym->is_func ? "FUNC" : "DATA", sym->name,
-			   sym->is_gpl_only ? "_gpl" : "", sym->namespace);
+			   sym->namespace);
 
 		buf_printf(buf, "SYMBOL_FLAGS(%s, 0x%02x);\n",
 			   sym->name, get_symbol_flags(sym));
@@ -1899,8 +1899,8 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
 			     sym->name, mod->name, mod->is_vmlinux ? "" : ".ko",
 			     sym->name);
 
-		buf_printf(buf, "SYMBOL_CRC(%s, 0x%08x, \"%s\");\n",
-			   sym->name, sym->crc, sym->is_gpl_only ? "_gpl" : "");
+		buf_printf(buf, "SYMBOL_CRC(%s, 0x%08x);\n",
+			   sym->name, sym->crc);
 	}
 }
 

-- 
2.53.0.473.g4a7958ca14-goog

