Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB9E3E122C
	for <linux-arch@vger.kernel.org>; Thu,  5 Mar 2026 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729731; cv=none; b=o+JQ0ViJZyQF0JVgpzCVYZslQvEwUBD2yPuIW6NhIp8F2ySu5Z+/A8/xq+Q7p65WrMfZQ+3DwOxtEgaies8lEJlz0+V1a13eWHaJoqBsnG9jCFiSZZRcGMmAoYZ6fcGTQva0pgWwTN5TkyYCF8wzj4KkWoQxGy0OSm4mwuuu7Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729731; c=relaxed/simple;
	bh=fv1wHWnKrIC2PSslQ9gqnuOdMd+GSazSWOsjMOvnx5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cchplV2ZxcM0ejq9dB5RGZvSTqX9DDR70fVPCDUwSKI+JuLQCwHXigColmbbbzDRO0QfdslFz3twV0JBUojUi796uzAEmWG5QG6G2Is2ae176YLhbqYSNWKqSYBQI7ojH0V105Ea9cNc3ITZMTLGm6c5NlZX+PaM0UEj6TQ5YVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h+KzQpxu; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h+KzQpxu"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4836cc0b38eso83087705e9.2
        for <linux-arch@vger.kernel.org>; Thu, 05 Mar 2026 08:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772729727; x=1773334527; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=muhQDYogzWAVYxF2N4rIVwEM0kh3toD1kcsqgk5RsDc=;
        b=h+KzQpxuMW2hdY1geiExI9nO+cN3usfbFEX04hnp5DY940MAbHBOBvvG6dtaGuJXmf
         VKcd4Cyw5gsKlhb4+vguDfcrdny9zQTKJPK3LPGPvXWy5caN4Z5NX82EldXa4deU5NHo
         TGl0+LStVdfGy9sS6ItueplZ2CqWpEVMDAmwFZDq38rn6y+PCIIJzc2K4Fg0bYTPBvke
         ScsmSloro0MBxJ7mLPFxXr2DOwTcluWBs2sYfBFuT4yk/CKMZqOdpmpa6lAzdC6suQT6
         7Ix/YggyzQ6Kzsk0iNO/+UjKnVg/Zddw+bZjFB0aN1m3Sgv7Z2lKD6f0uN66JpYISgRS
         3zMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772729727; x=1773334527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=muhQDYogzWAVYxF2N4rIVwEM0kh3toD1kcsqgk5RsDc=;
        b=Gxlqi16l36qS1e1cXnysCbIX4u0zstuY1e1J2S3S0zI8D2j8SkK+A1Nlwc+3AumwR4
         3BCMcynoWoexzk4h95aMYWfF/g8BTHJzElDKDLF92WXEvf8csK5bJ6PSEHsHvWPrComW
         5FVO3gLfJPj4lfnzsJIBD0CtNyeyUeUPiC5WebST7ZXJKtxlaA3XIO5dMMxdRYvaW6q6
         MA9jYpTFqglLQhVKzHsCxXt0ucla/8IBlrP7HZyd3S6d4oyiwKkf1ukaWbbD9coWiuzd
         XBY+Y0FJhZrPOVVh0lCweYhqMzcCB7ROsU3u6UGj5cHLQH2MT2m/QuHf0qlWy5SO62qN
         iNbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU31fEpWMxkGRyBIy1o6/FAL3EtKtpiApfYTex1wudcNGSYAbF+He34O8fvlSewy5T37aTl8nleiHIJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwpUpJndXlrjX2ObrJ0M4Ew6qhwHLXogZ7ANMi8xg228qVk3L8X
	9ksM/CSH6PsZUWDJ53gjJjs5UzAdxNmT4YwZtuilTFeA2cCZRRVwdIrDzFusyyHpfSlqLjcDoGE
	8SoDfb4t7OpfGvyBBlg==
X-Received: from wmsk22-n1.prod.google.com ([2002:a05:600d:8496:10b0:47e:e4f5:36ca])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6388:b0:47a:7fd0:9eea with SMTP id 5b1f17b1804b1-4852359313emr2434565e9.3.1772729727147;
 Thu, 05 Mar 2026 08:55:27 -0800 (PST)
Date: Thu, 05 Mar 2026 16:55:22 +0000
In-Reply-To: <20260305-kflagstab-v4-0-6a76bf8b83c7@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305-kflagstab-v4-0-6a76bf8b83c7@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260305-kflagstab-v4-6-6a76bf8b83c7@google.com>
Subject: [PATCH v4 6/8] module loader: deprecate usage of *_gpl sections
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

The *_gpl section are not being used populated by modpost anymore. Hence
the module loader doesn't need to find and process these sections in
modules.

This patch also simplifies symbol finding logic in module loader since
*_gpl sections don't have to be searched anymore.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 include/linux/module.h   |  3 ---
 kernel/module/internal.h |  3 ---
 kernel/module/main.c     | 46 ++++++++++++++++++----------------------------
 3 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index aee3accba73c..a0ec1a9f97b4 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -434,9 +434,6 @@ struct module {
 	unsigned int num_kp;
 
 	/* GPL-only exported symbols. */
-	unsigned int num_gpl_syms;
-	const struct kernel_symbol *gpl_syms;
-	const u32 *gpl_crcs;
 	bool using_gplonly_symbols;
 
 #ifdef CONFIG_MODULE_SIG
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 69b84510e097..061161cc79d9 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -53,10 +53,7 @@ extern const size_t modinfo_attrs_count;
 /* Provided by the linker */
 extern const struct kernel_symbol __start___ksymtab[];
 extern const struct kernel_symbol __stop___ksymtab[];
-extern const struct kernel_symbol __start___ksymtab_gpl[];
-extern const struct kernel_symbol __stop___ksymtab_gpl[];
 extern const u32 __start___kcrctab[];
-extern const u32 __start___kcrctab_gpl[];
 extern const u8 __start___kflagstab[];
 
 #define KMOD_PATH_LEN 256
diff --git a/kernel/module/main.c b/kernel/module/main.c
index d237fa4e0737..189e18b8103d 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1464,29 +1464,17 @@ EXPORT_SYMBOL_GPL(__symbol_get);
  */
 static int verify_exported_symbols(struct module *mod)
 {
-	unsigned int i;
 	const struct kernel_symbol *s;
-	struct {
-		const struct kernel_symbol *sym;
-		unsigned int num;
-	} arr[] = {
-		{ mod->syms, mod->num_syms },
-		{ mod->gpl_syms, mod->num_gpl_syms },
-	};
-
-	for (i = 0; i < ARRAY_SIZE(arr); i++) {
-		for (s = arr[i].sym; s < arr[i].sym + arr[i].num; s++) {
-			struct find_symbol_arg fsa = {
-				.name	= kernel_symbol_name(s),
-				.gplok	= true,
-			};
-			if (find_symbol(&fsa)) {
-				pr_err("%s: exports duplicate symbol %s"
-				       " (owned by %s)\n",
-				       mod->name, kernel_symbol_name(s),
-				       module_name(fsa.owner));
-				return -ENOEXEC;
-			}
+	for (s = mod->syms; s < mod->syms + mod->num_syms; s++) {
+		struct find_symbol_arg fsa = {
+			.name	= kernel_symbol_name(s),
+			.gplok	= true,
+		};
+		if (find_symbol(&fsa)) {
+			pr_err("%s: exports duplicate symbol %s (owned by %s)\n",
+				mod->name, kernel_symbol_name(s),
+				module_name(fsa.owner));
+			return -ENOEXEC;
 		}
 	}
 	return 0;
@@ -2608,12 +2596,15 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	mod->syms = section_objs(info, "__ksymtab",
 				 sizeof(*mod->syms), &mod->num_syms);
 	mod->crcs = section_addr(info, "__kcrctab");
-	mod->gpl_syms = section_objs(info, "__ksymtab_gpl",
-				     sizeof(*mod->gpl_syms),
-				     &mod->num_gpl_syms);
-	mod->gpl_crcs = section_addr(info, "__kcrctab_gpl");
 	mod->flagstab = section_addr(info, "__kflagstab");
 
+	if (section_addr(info, "__ksymtab_gpl"))
+		pr_warn("%s: ignoring obsolete section __ksymtab_gpl\n",
+			mod->name);
+	if (section_addr(info, "__kcrctab_gpl"))
+		pr_warn("%s: ignoring obsolete section __kcrctab_gpl\n",
+			mod->name);
+
 #ifdef CONFIG_CONSTRUCTORS
 	mod->ctors = section_objs(info, ".ctors",
 				  sizeof(*mod->ctors), &mod->num_ctors);
@@ -2823,8 +2814,7 @@ static int check_export_symbol_sections(struct module *mod)
 		return -ENOEXEC;
 	}
 #ifdef CONFIG_MODVERSIONS
-	if ((mod->num_syms && !mod->crcs) ||
-	    (mod->num_gpl_syms && !mod->gpl_crcs)) {
+	if (mod->num_syms && !mod->crcs) {
 		return try_to_force_load(mod,
 					 "no versions for exported symbols");
 	}

-- 
2.53.0.473.g4a7958ca14-goog

