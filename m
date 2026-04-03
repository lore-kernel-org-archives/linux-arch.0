Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA8B3D330C
	for <linux-arch@vger.kernel.org>; Fri,  3 Apr 2026 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775236170; cv=none; b=pFRdz6HvVZnF4hq+bZhyWq393rxhjVAZv2twV6PAXvRcBsZZI40AIoxmP/5b6VBvTskfLlJ0P9nRpBh/x5E2JJSjTel1BQWArii12e7RZ94PVNNDGSFwx4xZTz41lN1pJONMGCdzH9CthcNLs2j08Y0gOqOiYrUlZYPK9U3h3kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775236170; c=relaxed/simple;
	bh=YV0H1OIRQFWecV0RAMdeB/Vr7/EKptHz5t7I4hL40o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsTKXZcbiOAqFZbqHIQEiAn71D9hwTHQ2nxOHVPaWfiuvd0iaHjZqL4cZXcs8zZOAp+n57bX3XXQqhQldSea6gcp09Vo2uSk+JIqzPX30D71XN+Lbu6OY8NQXyXtp2IwepwBnAgcFyAMD+zZzT+8qXIMc36qOykmIMW3L2O2ycY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcrqeV24; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcrqeV24"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c766a95a72dso1235388a12.1
        for <linux-arch@vger.kernel.org>; Fri, 03 Apr 2026 10:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775236167; x=1775840967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgB/7sbIITxQzaqZfKog+6ffi0K4+F5epifQK0T0cqA=;
        b=LcrqeV24Is9lYmJuG2tURk9L0kKtJvimGPmI9lq6bHoGWOLvycW4sA1QBFUytHnzif
         YC9vXuPIZRgOQpech9hfieP0T+9sELaridTxOgT+AnEw0vhB2bZyRw3LfUpLxpt9PH06
         K+seAAQsHKIv/HTzsKgPiGUXANnua2x2lPhsk6pta0Ey8xaFFE6Bi2V6mdKLWH9QuI93
         MravyiVXacVMVTs5Kj5a2mwVNUlv1AVUYBVcoKIMyKUSvvudhqp+iKTsuoziy+8MO9rI
         gsoidjdDjLT+rNuCWaUTO3n/Y7PCWnMojV9nqoDrKa39wbXXux1cFz6SaKV3nQeZAb5V
         FkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775236167; x=1775840967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SgB/7sbIITxQzaqZfKog+6ffi0K4+F5epifQK0T0cqA=;
        b=N7YVjFMGsYcNbHSIcVB58qMyxjcTQJh2wTswKY7TYv9UOEoQ52+VeBAvsqsnH4cDvw
         xEsVmFt5DhM4OCZwQLMpsaLY6pdh4GkstoIkNAwM4eSQ/ET/ztF/73C//I3FZUb76EDR
         tsufqnTMcZSMNj/7pRdeHouNh/3XQ2N4FM59XFWV5RdgBivR7GoDrNdaNgliXGnPa2+w
         PLVZysa6yHWDa4Sf7dTbgUnxJwbHli1tvjhrxuUVhOssqvxgy5zG0OhtbWxPnwolCIYn
         Trvo257juireNaNDjTfW6rDL7MMOBfgE2hO+UCmupsuLZ2hCqvRS7+A9HwUdldoVaLHr
         5gjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrNWMUvRQzwQ8FQhjVpcjIUmSTWwKTFZqdmYqEB9ZBGzhcD9dx3wZoNXVO6gvekv3g97wAbKjraY7J@vger.kernel.org
X-Gm-Message-State: AOJu0YzEjLHd1jLslXHmXVtzbA3fOFcXxlvzrJglJcSdNjVmutrQqQZv
	tQzshirg/nxvD0kI4LKhouoq8sa31zcyB/Saeti6w+oCns5ko/5XU/mc
X-Gm-Gg: AeBDietdNgd7xY2Q5naJPkQf0iUwlG2VJVgrEPx5pESphXNRN2pT3Cb3Co/Rem1Vkwg
	8pcoJpqJ96S2ib5KwDheiO+oChhR3Ei3/oYdLcHubr72UzyBBMpijkSoS5PcCP1pz13qCQmdXNX
	BIUYOMdUXKwamVn+Yq0bM3CYpgBKWvWNjwSwIdO9LUp5bc1luamGikpubX1y2ZltvbtDDg0t3Js
	ImOozoXHx/kzMzBPOC9i6SDUW0hVw792kiDfqcFKVmRHCnIb+FdSFcoRXRKh2FMfljrnnxeodel
	m0sqkjVaVxvSkzS/TFQ2ta/scltWi/fycuSIrsDyjFeZPmrBHCWmur1ojlGGXBgnxZmiy/KFVll
	1JzxZ9SIdSc6KkKS8QEUYfvTlfjzABoOY+dAwf6KwKIhvDiGPyBvOL6IXT1o/1OOH1BtiXe1DC1
	4Na7Afu5bYQmzp7yBnnvllFE5jS9k/w1TYdvAQlPiTzBxodEJy19bvTg==
X-Received: by 2002:a05:6a00:2348:b0:81a:b183:44fc with SMTP id d2e1a72fcca58-82d0daa3f36mr3834556b3a.23.1775236166989;
        Fri, 03 Apr 2026 10:09:26 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3c930sm6588725b3a.17.2026.04.03.10.09.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 Apr 2026 10:09:26 -0700 (PDT)
From: Chengkaitao <pilgrimtao@gmail.com>
To: arnd@arndb.de,
	ast@kernel.org,
	ihor.solodrai@linux.dev,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	pengdonglin@xiaomi.com
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	bpf@vger.kernel.org,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH bpf-next 2/3] bpf: Introduce BTF_SET/ID_SUB and BPF_VERIF_KFUNC_DEF
Date: Sat,  4 Apr 2026 01:08:56 +0800
Message-ID: <20260403170900.58659-3-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260403170900.58659-1-pilgrimtao@gmail.com>
References: <20260403170900.58659-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Use BTF_SET_SUB to provide the same kind of grouping as BTF_SET_START/END,
so BTF_ID_SUB no longer has to follow the strict sequence (BTF_SET_START,
BTF_ID, BTF_SET_END). That lets us scatter BTF_ID_SUB definitions across
the file and collect entries with similar properties together, which
reduces maintenance overhead.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 include/linux/btf_ids.h       | 92 +++++++++++++++++++++++++++++++----
 tools/include/linux/btf_ids.h | 83 +++++++++++++++++++++++++++----
 2 files changed, 156 insertions(+), 19 deletions(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index af011db39ab3..c45275c88649 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -40,9 +40,9 @@ struct btf_id_set8 {
 
 #define BTF_IDS_SECTION ".BTF_ids"
 
-#define ____BTF_ID(symbol, word)			\
+#define ____BTF_ID(symbol, word, sec)			\
 asm(							\
-".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
+".pushsection " sec ",\"a\";                   \n"	\
 ".local " #symbol " ;                          \n"	\
 ".type  " #symbol ", STT_OBJECT;               \n"	\
 ".size  " #symbol ", 4;                        \n"	\
@@ -52,7 +52,7 @@ word							\
 ".popsection;                                  \n");
 
 #define __BTF_ID(symbol, word) \
-	____BTF_ID(symbol, word)
+	____BTF_ID(symbol, word, BTF_IDS_SECTION)
 
 #define __ID(prefix) \
 	__PASTE(__PASTE(prefix, __COUNTER__), __LINE__)
@@ -86,19 +86,19 @@ word							\
  * .zero 4
  *
  */
-#define __BTF_ID_LIST(name, scope)			\
+#define __BTF_ID_LIST(name, scope, sec)			\
 asm(							\
-".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
+".pushsection " sec ",\"a\";                   \n"	\
 "." #scope " " #name ";                        \n"	\
 #name ":;                                      \n"	\
 ".popsection;                                  \n");
 
 #define BTF_ID_LIST(name)				\
-__BTF_ID_LIST(name, local)				\
+__BTF_ID_LIST(name, local, BTF_IDS_SECTION)		\
 extern u32 name[];
 
 #define BTF_ID_LIST_GLOBAL(name, n)			\
-__BTF_ID_LIST(name, globl)
+__BTF_ID_LIST(name, globl, BTF_IDS_SECTION)
 
 /* The BTF_ID_LIST_SINGLE macro defines a BTF_ID_LIST with
  * a single entry.
@@ -154,11 +154,11 @@ asm(							\
 ".popsection;                                  \n");
 
 #define BTF_SET_START(name)				\
-__BTF_ID_LIST(name, local)				\
+__BTF_ID_LIST(name, local, BTF_IDS_SECTION)		\
 __BTF_SET_START(name, local)
 
 #define BTF_SET_START_GLOBAL(name)			\
-__BTF_ID_LIST(name, globl)				\
+__BTF_ID_LIST(name, globl, BTF_IDS_SECTION)		\
 __BTF_SET_START(name, globl)
 
 #define BTF_SET_END(name)				\
@@ -168,6 +168,75 @@ asm(							\
 ".popsection;                                 \n");	\
 extern struct btf_id_set name;
 
+/*
+ * BTF_SET_SUB — place a set in .BTF_ids.<name> so vmlinux.lds.h can merge
+ * multiple input sections into one output .BTF_ids in a fixed order.
+ * <name> must be a single preprocessor token (e.g. bpf_verif_kfunc_arena).
+ *
+ * Member count: begin is __BTF_ID__setsc__<name> (first in .BTF_ids.<name>);
+ * end is linker symbol __BTF_ids_seg_end_<name> (see btf_ids.lds.h). resolve_btfids
+ * uses cnt = (end - begin) / 4 - 1.  <name> must not contain "__seg__".
+ *
+ * extern struct btf_id_set name is emitted by BTF_SET_SUB.  BTF_ID_SUB(name, ...)
+ * must use the same <name> as the subsection token.
+ */
+#define __BTF_IDS_SUBSEC(sub) ".BTF_ids." #sub
+
+/* Indirection so __ID() expands before ____BTF_ID() stringifies its symbol arg. */
+#define __BTF_ID_SUB(sym, sec)	____BTF_ID(sym, "", sec)
+
+#define BTF_ID_SUB(sub, prefix, name)				\
+	__BTF_ID_SUB(__ID(__BTF_ID__##prefix##__##name##__), __BTF_IDS_SUBSEC(sub))
+
+#define __BTF_ID_LIST_SUB(name, scope)				\
+	__BTF_ID_LIST(name, scope, __BTF_IDS_SUBSEC(name))
+
+#define __BTF_SET_SUB(name, scope)				\
+asm(								\
+".pushsection " __BTF_IDS_SUBSEC(name) ",\"a\";       \n"	\
+"." #scope " __BTF_ID__setsc__" #name ";              \n"	\
+"__BTF_ID__setsc__" #name ":;                         \n"	\
+".zero 4                                              \n"	\
+".popsection;                                         \n");
+
+#define BTF_SET_SUB(name)					\
+extern struct btf_id_set name;					\
+__BTF_ID_LIST_SUB(name, local)					\
+__BTF_SET_SUB(name, local)
+
+#include <linux/args.h> /* CONCATENATE, COUNT_ARGS */
+
+/* bpf_verif_kfunc_<sub> (e.g. rbtree_add → bpf_verif_kfunc_rbtree_add) */
+#define __BPF_VERIF_KFUNC_SUB(sub) bpf_verif_kfunc_##sub
+
+/* Cascade: emit first subsection, recurse on the rest (same kfunc @name). Up to 6 subs. */
+#define __BPF_VERIF_KFUNC_DEF_1(name, s1)				\
+	BTF_ID_SUB(__BPF_VERIF_KFUNC_SUB(s1), func, name)
+
+#define __BPF_VERIF_KFUNC_DEF_2(name, s1, s2)				\
+	BTF_ID_SUB(__BPF_VERIF_KFUNC_SUB(s1), func, name)		\
+	__BPF_VERIF_KFUNC_DEF_1(name, s2)
+
+#define __BPF_VERIF_KFUNC_DEF_3(name, s1, s2, s3)			\
+	BTF_ID_SUB(__BPF_VERIF_KFUNC_SUB(s1), func, name)		\
+	__BPF_VERIF_KFUNC_DEF_2(name, s2, s3)
+
+#define __BPF_VERIF_KFUNC_DEF_4(name, s1, s2, s3, s4)			\
+	BTF_ID_SUB(__BPF_VERIF_KFUNC_SUB(s1), func, name)		\
+	__BPF_VERIF_KFUNC_DEF_3(name, s2, s3, s4)
+
+#define __BPF_VERIF_KFUNC_DEF_5(name, s1, s2, s3, s4, s5)		\
+	BTF_ID_SUB(__BPF_VERIF_KFUNC_SUB(s1), func, name)		\
+	__BPF_VERIF_KFUNC_DEF_4(name, s2, s3, s4, s5)
+
+#define __BPF_VERIF_KFUNC_DEF_6(name, s1, s2, s3, s4, s5, s6)		\
+	BTF_ID_SUB(__BPF_VERIF_KFUNC_SUB(s1), func, name)		\
+	__BPF_VERIF_KFUNC_DEF_5(name, s2, s3, s4, s5, s6)
+
+/* First arg: kfunc symbol; rest: subsection suffix tokens matching bpf_verif_kfunc_<s>. */
+#define BPF_VERIF_KFUNC_DEF(name, ...)					\
+	CONCATENATE(__BPF_VERIF_KFUNC_DEF_, COUNT_ARGS(__VA_ARGS__))(name, __VA_ARGS__)
+
 /*
  * The BTF_SET8_START/END macros pair defines sorted list of
  * BTF IDs and their flags plus its members count, with the
@@ -190,7 +259,7 @@ extern struct btf_id_set name;
  *
  */
 #define __BTF_SET8_START(name, scope, flags)		\
-__BTF_ID_LIST(name, local)				\
+__BTF_ID_LIST(name, local, BTF_IDS_SECTION)		\
 asm(							\
 ".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
 "." #scope " __BTF_ID__set8__" #name ";        \n"	\
@@ -227,6 +296,9 @@ BTF_SET8_END(name)
 #define BTF_SET_START(name) static struct btf_id_set __maybe_unused name = { 0 };
 #define BTF_SET_START_GLOBAL(name) static struct btf_id_set __maybe_unused name = { 0 };
 #define BTF_SET_END(name)
+#define BTF_SET_SUB(name) static struct btf_id_set __maybe_unused name = { 0 };
+#define BTF_ID_SUB(sub, prefix, name)
+#define BPF_VERIF_KFUNC_DEF(name, ...)
 #define BTF_SET8_START(name) static struct btf_id_set8 __maybe_unused name = { 0 };
 #define BTF_SET8_END(name)
 #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 72ea363d434d..026fd5bfc6d5 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -35,9 +35,9 @@ struct btf_id_set8 {
 
 #define BTF_IDS_SECTION ".BTF_ids"
 
-#define ____BTF_ID(symbol)				\
+#define ____BTF_ID(symbol, sec)			\
 asm(							\
-".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
+".pushsection " sec ",\"a\";       \n"		\
 ".local " #symbol " ;                          \n"	\
 ".type  " #symbol ", STT_OBJECT;               \n"	\
 ".size  " #symbol ", 4;                        \n"	\
@@ -46,7 +46,7 @@ asm(							\
 ".popsection;                                  \n");
 
 #define __BTF_ID(symbol) \
-	____BTF_ID(symbol)
+	____BTF_ID(symbol, BTF_IDS_SECTION)
 
 #define __ID(prefix) \
 	__PASTE(__PASTE(prefix, __COUNTER__), __LINE__)
@@ -73,19 +73,19 @@ asm(							\
  * .zero 4
  *
  */
-#define __BTF_ID_LIST(name, scope)			\
+#define __BTF_ID_LIST(name, scope, sec)			\
 asm(							\
-".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
+".pushsection " sec ",\"a\";                   \n"	\
 "." #scope " " #name ";                        \n"	\
 #name ":;                                      \n"	\
 ".popsection;                                  \n");
 
 #define BTF_ID_LIST(name)				\
-__BTF_ID_LIST(name, local)				\
+__BTF_ID_LIST(name, local, BTF_IDS_SECTION)		\
 extern u32 name[];
 
 #define BTF_ID_LIST_GLOBAL(name, n)			\
-__BTF_ID_LIST(name, globl)
+__BTF_ID_LIST(name, globl, BTF_IDS_SECTION)
 
 /* The BTF_ID_LIST_SINGLE macro defines a BTF_ID_LIST with
  * a single entry.
@@ -141,11 +141,11 @@ asm(							\
 ".popsection;                                  \n");
 
 #define BTF_SET_START(name)				\
-__BTF_ID_LIST(name, local)				\
+__BTF_ID_LIST(name, local, BTF_IDS_SECTION)		\
 __BTF_SET_START(name, local)
 
 #define BTF_SET_START_GLOBAL(name)			\
-__BTF_ID_LIST(name, globl)				\
+__BTF_ID_LIST(name, globl, BTF_IDS_SECTION)		\
 __BTF_SET_START(name, globl)
 
 #define BTF_SET_END(name)				\
@@ -155,6 +155,68 @@ asm(							\
 ".popsection;                                 \n");	\
 extern struct btf_id_set name;
 
+/*
+ * See include/linux/btf_ids.h: BTF_SET_SUB uses __BTF_ids_seg_end_<name> in
+ * btf_ids.lds.h; begin is __BTF_ID__setsc__<name>.  extern struct btf_id_set name
+ * is in BTF_SET_SUB.
+ */
+#define __BTF_IDS_SUBSEC(sub) ".BTF_ids." #sub
+
+/* Indirection so __ID() expands before ____BTF_ID() stringifies its symbol arg. */
+#define __BTF_ID_SUB(sym, sec)	____BTF_ID(sym, sec)
+
+#define BTF_ID_SUB(sub, prefix, name)				\
+	__BTF_ID_SUB(__ID(__BTF_ID__##prefix##__##name##__), __BTF_IDS_SUBSEC(sub))
+
+#define __BTF_ID_LIST_SUB(name, scope)				\
+	__BTF_ID_LIST(name, scope, __BTF_IDS_SUBSEC(name))
+
+#define __BTF_SET_SUB(name, scope)				\
+asm(								\
+".pushsection " __BTF_IDS_SUBSEC(name) ",\"a\";       \n"	\
+"." #scope " __BTF_ID__setsc__" #name ";              \n"	\
+"__BTF_ID__setsc__" #name ":;                         \n"	\
+".zero 4                                              \n"	\
+".popsection;                                         \n");
+
+#define BTF_SET_SUB(name)					\
+extern struct btf_id_set name;					\
+__BTF_ID_LIST_SUB(name, local)					\
+__BTF_SET_SUB(name, local)
+
+#include <linux/args.h> /* CONCATENATE, COUNT_ARGS */
+
+/* bpf_verif_kfunc_<sub> (e.g. rbtree_add → bpf_verif_kfunc_rbtree_add) */
+#define __BPF_VERIF_KFUNC_SUB(sub) bpf_verif_kfunc_##sub
+
+/* Cascade: emit first subsection, recurse on the rest (same kfunc @name). Up to 6 subs. */
+#define __BPF_VERIF_KFUNC_DEF_1(name, s1)				\
+	BTF_ID_SUB(__BPF_VERIF_KFUNC_SUB(s1), func, name)
+
+#define __BPF_VERIF_KFUNC_DEF_2(name, s1, s2)				\
+	BTF_ID_SUB(__BPF_VERIF_KFUNC_SUB(s1), func, name)		\
+	__BPF_VERIF_KFUNC_DEF_1(name, s2)
+
+#define __BPF_VERIF_KFUNC_DEF_3(name, s1, s2, s3)			\
+	BTF_ID_SUB(__BPF_VERIF_KFUNC_SUB(s1), func, name)		\
+	__BPF_VERIF_KFUNC_DEF_2(name, s2, s3)
+
+#define __BPF_VERIF_KFUNC_DEF_4(name, s1, s2, s3, s4)			\
+	BTF_ID_SUB(__BPF_VERIF_KFUNC_SUB(s1), func, name)		\
+	__BPF_VERIF_KFUNC_DEF_3(name, s2, s3, s4)
+
+#define __BPF_VERIF_KFUNC_DEF_5(name, s1, s2, s3, s4, s5)		\
+	BTF_ID_SUB(__BPF_VERIF_KFUNC_SUB(s1), func, name)		\
+	__BPF_VERIF_KFUNC_DEF_4(name, s2, s3, s4, s5)
+
+#define __BPF_VERIF_KFUNC_DEF_6(name, s1, s2, s3, s4, s5, s6)		\
+	BTF_ID_SUB(__BPF_VERIF_KFUNC_SUB(s1), func, name)		\
+	__BPF_VERIF_KFUNC_DEF_5(name, s2, s3, s4, s5, s6)
+
+/* First arg: kfunc symbol; rest: subsection suffix tokens matching bpf_verif_kfunc_<s>. */
+#define BPF_VERIF_KFUNC_DEF(name, ...)					\
+	CONCATENATE(__BPF_VERIF_KFUNC_DEF_, COUNT_ARGS(__VA_ARGS__))(name, __VA_ARGS__)
+
 #else
 
 #define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
@@ -166,6 +228,9 @@ extern struct btf_id_set name;
 #define BTF_SET_START(name) static struct btf_id_set __maybe_unused name = { 0 };
 #define BTF_SET_START_GLOBAL(name) static struct btf_id_set __maybe_unused name = { 0 };
 #define BTF_SET_END(name)
+#define BTF_SET_SUB(name) static struct btf_id_set __maybe_unused name = { 0 };
+#define BTF_ID_SUB(sub, prefix, name)
+#define BPF_VERIF_KFUNC_DEF(name, ...)
 
 #endif /* CONFIG_DEBUG_INFO_BTF */
 
-- 
2.43.0

