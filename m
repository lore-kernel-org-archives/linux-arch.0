Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01CA3E1208
	for <linux-arch@vger.kernel.org>; Thu,  5 Mar 2026 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729678; cv=none; b=h6MtfUqysJMA9+5U/GtN/w0qyIN6EvlF9T8GBPm+rXGYQxJJjT8o8xeNEiGPDIj3ZGfw6wsse/cgaLJ0KeI4qxWRkxuqgXKg3lGXsnwfuspAtUir2Svl/mVC6tLA5st9yGrfuy9bZD+jh1hWsqarousqJBFuidAQ4+CYOUI6XCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729678; c=relaxed/simple;
	bh=fv1wHWnKrIC2PSslQ9gqnuOdMd+GSazSWOsjMOvnx5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aWP2Zu+oSEdO1/J319fBSGbxZWNfaOS5vEIX1zo1lGDRTUwQKz6Qm3ZjLI3iRCkcHL3k1OfoVd5hVnUkbV6F/Os4CPEwmJiq+eZ0o5KPlHYvSXWvBgFCs6q7dVhrLYuBAu7VKBBy4jA/UlyIWJDxtWE6lVaFK+Gm1Ks65U9NcXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0y24uKFj; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0y24uKFj"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-483101623e9so78285635e9.3
        for <linux-arch@vger.kernel.org>; Thu, 05 Mar 2026 08:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772729675; x=1773334475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=muhQDYogzWAVYxF2N4rIVwEM0kh3toD1kcsqgk5RsDc=;
        b=0y24uKFjULkIa38q+zartyA+QMDPXKofAjo4QSS8Th0R02SBQk5OJG0rtzFjnv0jeF
         gisfTN7+Du0KsWjkO0YyvOXHvyUklfjjEv+2pGs/v0NP7CRbsa1mq7AhlEvJzIb4ouIK
         HDoGQva0vBWJ4HZa3SExbueHBGKorWOUi9Hj/oXBwjCloUiV1+AsKf9pQyAsH1GYrQEG
         z2Iqi/8RarScdmr/8+9VXQoss8ga/98yZwJDnPVGasCNmoQpOm6UisXhq/zri/ntuxRr
         n2puxmo8S3ZTX8byAqIBzZuX/3yQmbm8ImtbsYtu3F+rok6w8K8Ug9LvnIwazfkx1aNg
         d53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772729675; x=1773334475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=muhQDYogzWAVYxF2N4rIVwEM0kh3toD1kcsqgk5RsDc=;
        b=MkSwI3NlaHYo9EJVYpB4m613UnuVjdujRsIoU36n55BZY8X7Ravh1aegrDwFwzIFWI
         pJQCQqUJ4z7s2e1MOpZPP4D2A3+Kxbeb4GaI/jHYlwYitRpCu4gpFCvFOzzTE9Rvfq/I
         9IBFJBgogy/VsZ6DEWU3qLF8bBaSHwMhfIV49sWdKdCvwciZTgrX/xuOLn1MvT9MoWtV
         myZKCZeF8bjrOvfxVrW8c/Zwr88Adic6QsbvfQq+JVCD8PCHup7ntj0oQ7JMPhfG9lTW
         rpZ00E96OZt8i0VALQiYLGP7Uw3lGiFreKqSyYTsYpj8mAdzWx96CenpLkdxeFvwbuep
         Wsew==
X-Forwarded-Encrypted: i=1; AJvYcCUgnGVUt0fBDnjo0SzEoQpZOUx3xy9Y6N8fMZ9CtBuySDpIbc9RdecrxkKvjYysqNXBlWGmp8LSmjDY@vger.kernel.org
X-Gm-Message-State: AOJu0YwYyWcvIKV9vBehhcuJVTJVtDE1F2XOGaDFlHTONku7rWhgM46B
	xkps94QbS86JxvkGsmU/Xy3CTFNIjR34kNhf0gJTlnfgIFRPvKvW7R5gd2EbmMWEUM5VDfmE9JZ
	ceHU3bHkJrmWjJzsE3A==
X-Received: from wmpb29.prod.google.com ([2002:a05:600c:4a9d:b0:480:4be7:3f3a])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3ace:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-485235bb7admr2503055e9.10.1772729675271;
 Thu, 05 Mar 2026 08:54:35 -0800 (PST)
Date: Thu, 05 Mar 2026 16:54:26 +0000
In-Reply-To: <20260305-kflagstab-v4-0-4fe6eea27e30@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305-kflagstab-v4-0-4fe6eea27e30@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260305-kflagstab-v4-6-4fe6eea27e30@google.com>
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

