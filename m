Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F041858122C
	for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202897; cv=none; b=h53cJrs1uDzR//TS7xIvYUOoUW191TUL81sBnrWqGjFvAk0j7EU+0TlbLxgEmK2ehoJ59Cki3LG1QoNBKR1Q1a+3Rcc9APbWXJlvWiuovACjvRMSBYPo08+gyt7y+RJnXNMgp2RZn8P4yNOGhgWMNrdGHXyKIeqPOAFc3W/vBHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202897; c=relaxed/simple;
	bh=y3lSA8Y56umPh2HgV6WBl8hk1Eie/5gIm0L03MEj1o8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DEsPXoIMzX3+xAg/AqEObxN0V6Ggb0JJVsiD3n1QVkg1eK1bxyBbgvf37sCWqu18dg8DZYVzT1WnopqqfObA7ZRwrdiLGGq+tCFI7jja0/tJqcwX/RIzJyaYDdFFAFrj1P4/jwf1iniD/g0njURVDwozk+heQI7nIEtsHM/bEAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3CjLUhg; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3CjLUhg"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae6f5fc5so808920eaf.0
        for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 15:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202891; x=1790807691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HYBO1elgU02juqjocVCetj8tAPEOFrTtjQUE5YuJ7kQ=;
        b=f3CjLUhgnPn27p16v0DaPvaWzr6+CNMwpXgwnkXgxC4arik5aSQrrz19KrhHQHI8f8
         TIlZxoRddPU5elwpnv5jY19pU5JcyD5k2ku/2UpzQoQ8XINZNYl8sAExWQanSg+ECN29
         pNBPT1Stnd84ClJYBVydUZePwuDsf6udBCBWLjjhkLRHqtP+GwzXnGPwkIN8seb1h6dl
         AGM/c00IekubPcdBOaZ6h/uxWMZNC83H4jaTSpMp7bobPtgisNLixu/sxpfIW3nNMh+n
         88ev+M19WV8XSIfDkIZNHnsIMqUmObDjMVrrrZayX5DO7F3Gr5KcUCHBZ5VTkzxwasYh
         9WVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202891; x=1790807691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HYBO1elgU02juqjocVCetj8tAPEOFrTtjQUE5YuJ7kQ=;
        b=Zmdloh8inPpHqdQNCkh0uBpVSIQUl8WhXQd18TvaxBmZPHdV1WKQL6rZhDzbK5bIKl
         Xf+Bdt1Ohj1Hp20xj1Z7MbkihfGESAlEbx0NAoCldBbWbGYV+pakVecOeyj0KVf4Ls7d
         p9uemhbY+/NYeFCy+FUNfGf7r/MQa50AepaKBn6cK7f3S0i7raGIlM/0eWWXjwa9MQeo
         VCjD20TnD00uEnLRHLQOSCTd5xlaRy4O/tXVS6LMPryu828tIKElJOagx8OV3Weie95G
         +QbrTPN98UFlV70WuOubc2EiYzupWjgsbT6C2SbWiJIrtBimwPjeQO3E74Lpg27k7K2o
         KpDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQkaDylnHIG0yvdRJ5KX4jPsz7ar3qynWJIvq4yVYrYnwRz820kv3CGFRz+ZpwJKz1YHohnIipjsg4@vger.kernel.org
X-Gm-Message-State: AFuF++k1ly5iZf+HfDw+y4uwnp5L9sKPpkUCY4KTtCAHgNVdZRmOPuMd
	dx858PdeGlahHdWteSsmSthOcqMnql/efjMAnLGiGJzT8iChiILWazHV
X-Gm-Gg: AYBFou0MTUIsjKkfXCs7y/t4XxPWh3Gg7zoulx8dsZmAnA1cHKVSOjXmICFNO84VIl0
	TZwKfDASV2r74wDZwt7WqHaNa9tTn9KozmsT6FaNVdEkPIBS/Mf726OcOGFHzBrX6nOkZtRWPNk
	GM6+ORI2z0WpE70dfY6DwqtuBrnhis2NZ2E1ecBxsWPMHT2Ar/BToT/g2UQe2I4Gl65e3yFn6vn
	zdGg7Bp2PjjrPgeXeNaIftBJv0lhlI7s1xk7fN6tqyK++EE10qvQozfmNShe2cCgUIsPI/SEf5T
	2a+q+n1wLrtdKORNaWAuQfm7JTHQXvmlOMjHvY5IRxAov8cLf6C9sF6c7eQyKM9NCYkz0DYUUu9
	1B+toL89IqYpT/xBvCbhZZbiGFi8F3wbK08jSdjW4QCxOfa/NAd25Yiqs2SeChzJfkwZvyhxc2W
	WYWYPOP4j86ClThRZjmukfz+BfIKdO9egrBnRg2wnkD6gOrzoFrWLZLm0Pf+AN2W4djKXXakrk7
	UvGSnCTR4H+XMnEkgOZ6M6ayOBOZQd9VPc1UCjKgC2EemTz/T0N67IigzvEcom/M9Y7Zxa4Dun5
	yMP6m7KLb+g/zLBFdJg=
X-Received: by 2002:a05:6820:823:b0:6cd:3fdb:fa5e with SMTP id 006d021491bc7-6d44179fef3mr638299eaf.73.1790202891371;
        Wed, 23 Sep 2026 15:34:51 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:34:50 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:30 -0600
Subject: [PATCH v11 06/38] dyndbg.lds.S: fix lost dyndbg sections in
 modules
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-6-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=5098;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=y3lSA8Y56umPh2HgV6WBl8hk1Eie/5gIm0L03MEj1o8=;
 b=WcpmPX6A4hTWlUg2X3ONugbdk8SAN/6D/u3lSsJZ+nbEh6zbA/zDo/rbHg/QQkGuiXnzwOayV
 lz2oRKiazvqBU/t5jXfD9VYVFMp9M6ty4Gd27PRwT3Vi37djXrYr/g6
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

With CONFIG_DRM_USE_DYNAMIC_DEBUG=y, several build configs had
problems with __dyndbg* sections getting lost in drm drivers.  Fix
this by following the model demonstrated in codetag.lds.h.

Introduce include/asm-generic/dyndbg.lds.h, to bundle dynamic-debug's
multiple sections together, into 2 macros:

vmlinux.lds.h DATA_DATA: move the 2 BOUNDED_SECTION_BY(__dyndbg*)
calls into dyndbg.lds.h DYNDBG_SECTIONS(). vmlinux.lds.h now includes
the new file and calls the new macro.

MOD_DYNDBG_SECTIONS keeps the 2 sections by name, aligns them and sets
the output address to 0 when the sections are empty.

dyndbg.lds.h includes (reuses) bounded-section.lds.h

scripts/module.lds.S: now calls MOD_DYNDBG_SECTIONS right before the
CODETAG macro (consistent with their placements in vmlinux.lds.h), and
also includes dyndbg.lds.h

This isolates vmlinux.lds.h from further __dyndbg section additions.

CC: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
v3: move #includes to top, drop extra ALIGN(8) in DYNDBG_SECTIONS, add RvBy

v2: Address linker script review feedback for relocatable modules.

MOD_DYNDBG_SECTIONS() used the BOUNDED_SECTION_BY() macro, which
proved problematic for kernel modules for two reasons:

1. Unwanted Empty Sections:
   BOUNDED_SECTION_BY() automatically generates `__start` and `__stop`
   symbols. When applied to `MOD_DYNDBG_SECTIONS()`, the linker assumes
   the sections are populated due to the symbol definitions, forcing an
   empty `__dyndbg` and `__dyndbg_classes` output section in every
   compiled module, even those without dynamic debug configuration.
   Since the module loader uses `section_objs()` to locate data via
   ELF headers instead of relying on `__start`/`__stop` symbols, these
   assignments are completely unnecessary.

2. Non-zero Output Addresses:
   During relocatable linking (e.g., `ld.bfd -r`), omitting an explicit
   base address causes the section to inherit the current location
   counter. This results in non-zero sh_addr values in `.ko` files,
   which is confusing, degrades compressibility, and can cause issues
   with external tools parsing the ELF.

Fix both issues by dropping `BOUNDED_SECTION_BY()` in favor of a simple
`KEEP(*(...))` constraint and explicitly defining the sections with a `0`
base address: `__dyndbg 0 : ALIGN(8) { ... }`.

fixup-inc-vml
---
 MAINTAINERS                       |  1 +
 include/asm-generic/dyndbg.lds.h  | 18 ++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |  6 ++----
 scripts/module.lds.S              |  2 ++
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 74790be45d06..009d628417d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9257,6 +9257,7 @@ DYNAMIC DEBUG
 M:	Jason Baron <jbaron@akamai.com>
 M:	Jim Cromie <jim.cromie@gmail.com>
 S:	Maintained
+F:	include/asm-generic/dyndbg.lds.h
 F:	include/linux/dynamic_debug.h
 F:	lib/dynamic_debug.c
 F:	lib/test_dynamic_debug.c
diff --git a/include/asm-generic/dyndbg.lds.h b/include/asm-generic/dyndbg.lds.h
new file mode 100644
index 000000000000..9d8951bef688
--- /dev/null
+++ b/include/asm-generic/dyndbg.lds.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_GENERIC_DYNDBG_LDS_H
+#define __ASM_GENERIC_DYNDBG_LDS_H
+
+#include <asm-generic/bounded_sections.lds.h>
+#define DYNDBG_SECTIONS()					\
+	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)			\
+	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)
+
+#define MOD_DYNDBG_SECTIONS()						\
+	__dyndbg 0 : ALIGN(8) {						\
+		KEEP(*(__dyndbg))					\
+	}								\
+	__dyndbg_classes 0 : ALIGN(8) {					\
+		KEEP(*(__dyndbg_classes))				\
+	}
+
+#endif /* __ASM_GENERIC_DYNDBG_LDS_H */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 47586c6e9839..f5d508df84bf 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -52,6 +52,7 @@
 
 #include <asm-generic/bounded_sections.lds.h>
 #include <asm-generic/codetag.lds.h>
+#include <asm-generic/dyndbg.lds.h>
 
 #ifndef LOAD_OFFSET
 #define LOAD_OFFSET 0
@@ -344,10 +345,7 @@
 	*(.data..do_once)						\
 	STRUCT_ALIGN();							\
 	*(__tracepoints)						\
-	/* implement dynamic printk debug */				\
-	. = ALIGN(8);							\
-	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)		\
-	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)				\
+	DYNDBG_SECTIONS()						\
 	CODETAG_SECTIONS()						\
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index d0f200428957..5950ff8edc31 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -5,6 +5,7 @@
  */
 
 #include <asm-generic/codetag.lds.h>
+#include <asm-generic/dyndbg.lds.h>
 
 SECTIONS {
 	/DISCARD/ : {
@@ -56,6 +57,7 @@ SECTIONS {
 		*(.rodata..L*)
 	}
 
+	MOD_DYNDBG_SECTIONS()
 	MOD_SEPARATE_CODETAG_SECTIONS()
 }
 

-- 
2.55.0

