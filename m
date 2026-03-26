Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27EC34D910
	for <linux-arch@vger.kernel.org>; Thu, 26 Mar 2026 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560099; cv=none; b=EHk6XdHT2YRz1NBezE4wHymJ5I77M5Lg6fMMDMGJugImfciVsCoyN1Xzt+LjBVOfE/XxwSLsOYM8LAHo46WrwohfmdEAFcCjKZdsTv/60xOHAJhNIkowr+A+TTCtYvx5uqypLbdROv/NByVc9xHq7ODd6rg8O4ym7nfNGLSz+KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560099; c=relaxed/simple;
	bh=IMqZKd1uN1FnLrufR1Vtu+d5jfNCK7QjuAG3cXhKCg8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P4gLLQRgHUi8hfl6Lqoy1HN9Avtzg6fY7CQKS4NxFxupVP9k+cQl2XtOG0n/+eZdBge7eWoIudxIxsEYJZ09r4xeUbxiyMitu9D+eGRLFUK1dyZyc7xcYouhmQIJxt9FWhL9f0EyxnwuyN41YaocAJoVaeo1qbh4fdnBQOAC5oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YWEcxSo/; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWEcxSo/"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-439a85832c0so170975f8f.2
        for <linux-arch@vger.kernel.org>; Thu, 26 Mar 2026 14:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774560096; x=1775164896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=woqFHYkUrW1f2z9oyqhnpwQO2sR6jhXkFvm21NeDZng=;
        b=YWEcxSo/tPc9oj+YnbOhlWr1z0FwJQyLh02QsQ0r3w7o6I1/YTeC+L/0xHPPKh6D7T
         PWef0TPxfGOeBf0TKgRx0fWbM8GXXgAxuWF7MHuoZIcdRHALuVeJVU/jjRRa1NS0i82F
         oFuV7kFXQqRYkDBcQewLoDfEORopc3wY8cH7W5c+WnRW33TZCsNmWwO43OzyROx1P8oV
         /weYJSoMMEcjiTiMv5eVwN6z7BHzOGNFUW1Zjy3Sfy4I9ET8Zymib4v1RJG6+Vb1/umg
         8WUihadGguTBACOa4B85Eg+Vh+/la/5B2GxXiKYOJt8iCQbOJai7efSM/CqEkk0HuGUD
         7UXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774560096; x=1775164896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woqFHYkUrW1f2z9oyqhnpwQO2sR6jhXkFvm21NeDZng=;
        b=eTkz/U8bI4jHdiuiQKscvS2l9BAOx+CbT2JaViGNX6FDnTZsPyAtM8XKG10UKvOzWH
         IB9iZt8FdyQmsHGlUxif87PtaEnWTx05t5axuV/xldpS63fHiKOaLjF6FzFs/yzMr11B
         mCVu3GOfIezRkJUCbG3NAT8xjk8RFtfbGI4aW9YiItTprU7nBHoZZ+thOe0Zx1b8NmRi
         2tTMfODwDm+A3lU5zGX6pbYeiecgMEzKbz42fibmPuQwEWDbW+D94GjjhCbags398fIU
         NxuGTMPnFbC2OEfHjIYAHYganfbk9n8czMNptd9DYmYJtRE8x/3UyQLzNmmGnFpQnwj7
         Qmug==
X-Forwarded-Encrypted: i=1; AJvYcCU+sKerkSyluGUIuXX6nPLVF1yVK33k8Offk1HhEenUQITOIjzKqJLw4hctR9c8MhJgV/T/W3NpdNUd@vger.kernel.org
X-Gm-Message-State: AOJu0YxHdPGvouZibrKk69ylF1o36NWyP4cCCxTfwi9wxpgDwO+cYABH
	2LTQZ1zIV0O+rK0+5qCz1jervCKH4zD9+YLi221KlDSj/oSfNzfp6rXldZBOJM6UIP3eABytV0f
	CkuEgyGhwRuwVSQ1Ikg==
X-Received: from wmog14.prod.google.com ([2002:a05:600c:310e:b0:485:318b:96c6])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f53:b0:486:de04:5906 with SMTP id 5b1f17b1804b1-48727eda749mr2852285e9.19.1774560096155;
 Thu, 26 Mar 2026 14:21:36 -0700 (PDT)
Date: Thu, 26 Mar 2026 21:21:31 +0000
In-Reply-To: <20260326-kflagstab-v5-0-455cd723dddf@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-kflagstab-v5-0-455cd723dddf@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260326-kflagstab-v5-3-455cd723dddf@google.com>
Subject: [PATCH v5 3/7] module: populate kflagstab in modpost
From: Siddharth Nayyar <sidnayyar@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-doc@vger.kernel.org, Siddharth Nayyar <sidnayyar@google.com>, gprocida@google.com
Content-Type: text/plain; charset="utf-8"

This patch adds the ability to create entries for kernel symbol flag
bitsets in kflagstab. Modpost populates only the GPL-only flag for now.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
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
2.53.0.1018.g2bb0e51243-goog

