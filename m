Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E0B595759
	for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 22:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202966; cv=none; b=L4q6ladbci87Zm8cwmUSB2eTZ562i4G7o/JXiQUAtfpQ9pqEnkFa1DV120ayeGa2yY628SFNKicqkYjKaJlhevIV0XTPjphne7KVdj25epm5qcYnXWA0wBsChIVP/zVWzVFvdeQ1jmGmMhE7nKboOGU/yCPz3eD2emWYEX4bpoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202966; c=relaxed/simple;
	bh=g8I4qY5hCU/6qkdjn+fr1d7SBrYoQikgoaGXvUlG+W8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AdA4ICZiNZ79QiZ+e/vawczd92eoRwVkswJXi2ekQMQe6STCvdw2vWgeiZpFnWzNC9m6GLuRJ/S5fEP3zd1NhX+9Y4aKaGjmvScdlwFeOypH8XXKua6YqMKl3uo0mqHvSGxMEN4uSGvEO0920KNzfgrqxtF1SnOpAgSG5buRe4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjTXR2Ee; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjTXR2Ee"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6b1ae736c64so1128936eaf.2
        for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 15:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202959; x=1790807759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PbzqrnjzKAFhQJbhVTbeWbKw4m89KGxEej/0OysEvUY=;
        b=ZjTXR2Ee8+GynLeCwRrT8ZVs4jp5BzAFkQDMwQyHBIRsGqRMdsz3HAqmm/6c7BArTF
         euoJX0DvMdW/YZsMmynFRAncEoAv0pUeYPmFE9NQM5t0XSz+ZygsOJ/71zSetbCHqGGu
         yuVSt4dwszx3cDfy3eLT+32mbMSnjm23vD5EppVXlboA/Ks2KYRAryzvxj7eBcvU3ROO
         IV+6olbTxb02aaRKE7HZ3Y1ip4Sw9UILZDjAOSIleW58fFmxDebGjj+1urq+cK5V1qHr
         Iy6vFyy+QTsYaR3c1FX11a2jA6aBrdD2Um3r8t2v7mgVo/Z/KJYsS7iQ2xNZXLAEzMZg
         eFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202959; x=1790807759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PbzqrnjzKAFhQJbhVTbeWbKw4m89KGxEej/0OysEvUY=;
        b=e10ksoE32/A6LjQVokiYtfCJLLlQgQ4vc3XgmeiuUwQ/+BiVa7M+pA0kffn+srehli
         Oc7uezsR7FAGo5ixhRHtUW1kWsWAKLOCbNCP2Gtf9L79Ft+joblhKWETGDYR1/fvG/6a
         VUU+EvRZ+8Fe3ySX01isX65LeagnkPb5ep65/AcDlkMjpXAgm/tEnn9ySV9wlupztM+n
         cmCcZtL/i3JHQpyydYSZM43rrGqeZ6RXotnLDmyTZ0qpCItyqjnOqUPScxyax7BuwLYH
         CMUd3yLBP4fg4ouWmlfRFUXkswQkwy7NBEmVoCcH594hXAYTdDLd9xrH5DMJwuSs5xWP
         UUvw==
X-Forwarded-Encrypted: i=1; AKwUvBxVh/aCsKiViNKBh0M8jcfRz/Wcxg5tfXtNs5Rt/KJ4P2SB3qQAcXH+Ih8r35icZm3jBibx975hiD0R@vger.kernel.org
X-Gm-Message-State: AFuF++legcoGvo4MDSRoTSBtfnxHoOrV2lxsG6xg0ff5dFYcoWIU5eJ+
	+AgjsUde5enQBMhFarkVbBShUWFt+7FdrI5yP/S7DQfCufmvW2KzfCBx
X-Gm-Gg: AYBFou2JpYp7WDAEZ2n445qZKqWw6azFJXpADFjSM2OaSgurYXIqbQ8cS2o6X1jUl56
	Loe/u0QKLgB4MOsAPfQhcDxBGPSvhPOpOaaHsU6XQP7OcVo4o5UFqBHK7F94u+f1144/xtbeDGj
	wd06nuUfGKp938cSv7aFxbubbd4aCyOQk8X1BOvlRrC0zc4EAk7nzQx77jua0CiFsYcI7k+NTTU
	XJ6lFpqiqhspY5Nr+929F1Y0aGe8o7Tw/nKENdUldoV5ErT9K4/7SZAerN4pJFzwBTSSNa9CW71
	DPO/75WyUj+yR4eGBi/vsgyqZtnRypzxE/fQWWlFWSXjsu+hqnzEIo1P43qG4mgWmB/sc9S4m4I
	HTdAmqp7E/PqZPpK1MKoTMGf/XiDqzdjHkWm14zFpx0KWioNZtsVXcOh1fuL5yyAuUQ5Gj+zaA6
	sHA+nyzaWJyDwlArzdLRznsdN0KAFZRgNNVi/GknysrAFRLEwbnFMGZ5nGBLjwVGYFPORNUhs6K
	5vZb9N8lY/oUamDYO12TCquzmiD1YUwlZfF/lrxlDVJTZVuTk46PErEn55HcEv0OuFPr23J8JI7
	sNFd+6YCxBhUEHtbQr50BGzkyR1z+g==
X-Received: by 2002:a05:6820:308d:b0:6c6:c098:ef02 with SMTP id 006d021491bc7-6d4416aaaadmr692907eaf.62.1790202959287;
        Wed, 23 Sep 2026 15:35:59 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:35:58 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:59 -0600
Subject: [PATCH v11 35/38] dyndbg: Ignore additional arguments from pr_fmt
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-35-9b6c217fdf2f@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>, Philipp Hahn <phahn-oss@avm.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=7362;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=sb5nCjjrIibpgdLQnqeF7S++ij+NJzKv3uYGW3XCW5U=;
 b=Tbq+HZ9TUIxM2hUZr7Ey3Fz/NAVfDnI5XBD2AWCpbqgIZK74qzZyIivfn1m5gI+T4MVAzm2XO
 A5aDYo9EIiRAoeV/jBa4DYD7aVBUKKQeOQw6vPjFXhpEiH6YnXuW4P/
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

From: Philipp Hahn <phahn-oss@avm.de>

pr_fmt can be used to add a common prefix to any output from a module:
	#define pr_fmt(fmt) KBUILD_MODNAME ".%s " fmt, __func__

But adding additional arguments breaks dynamic debug:
> error: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" passed 4 arguments, but takes just 3
> |         pr_debug_ratelimited("%s", "Hello world!");
> |                                                  ^
> note: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" defined here
> | #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)       \
> |
> error: ‘DEFINE_DYNAMIC_DEBUG_METADATA_CLS’ undeclared (first use in this function)
> |         DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt)
> |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> note: in expansion of macro ‘DEFINE_DYNAMIC_DEBUG_METADATA’
> |         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));         \
> |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> note: in expansion of macro ‘pr_debug_ratelimited’
> |         pr_debug_ratelimited("%s", "Hello world!");
> |         ^~~~~~~~~~~~~~~~~~~~

Add an additional ', ...' to DEFINE_DYNAMIC_DEBUG_METADATA_CLS to slurp
any additional argument, which `pr_fmt` might add.

Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
[pr_fmt change on test_dynamic_debug_submod instead of parent]
Reviewed-by: Jim Cromie <jim.cromie@gmail.com>
---
v11:
. update golden record hashes for FT_modprobe_w_param tests after
  comma-token and native classmap attachment fixes.

v10:
. pass raw fmt to DEFINE_DYNAMIC_DEBUG_METADATA in pr_debug_ratelimited().
---
 include/linux/dynamic_debug.h                      |  2 +-
 include/linux/printk.h                             |  2 +-
 lib/test_dynamic_debug.c                           |  4 ++--
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 26 +++++++++++-----------
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 5b5f5bb31c48..f411a7636cf1 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -359,7 +359,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 		dump_stack();					\
 }
 
-#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
+#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)	\
 	static struct _ddebug  __aligned(8)			\
 	__section("__dyndbg_descs") name = {			\
 		.modname = DDEBUG_MODNAME,			\
diff --git a/include/linux/printk.h b/include/linux/printk.h
index f594c1266bfd..5d701952e739 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -742,7 +742,7 @@ do {									\
 	static DEFINE_RATELIMIT_STATE(_rs,				\
 				      DEFAULT_RATELIMIT_INTERVAL,	\
 				      DEFAULT_RATELIMIT_BURST);		\
-	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));		\
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);		\
 	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&				\
 	    __ratelimit(&_rs))						\
 		__dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);	\
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 666b447b3740..aaf8aad481a0 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -23,7 +23,7 @@
  * the usage clearer.
  */
 #if defined(TEST_DYNAMIC_DEBUG_SUBMOD)
-  #define pr_fmt(fmt) "test_dd_submod: " fmt
+  #define pr_fmt(fmt) "test_dd_submod: %s " fmt, __func__
 #else
   #define pr_fmt(fmt) "test_dd: " fmt
 #endif
@@ -323,7 +323,7 @@ static int __init test_dynamic_debug_init(void)
 
 static void __exit test_dynamic_debug_exit(void)
 {
-	pr_debug("exited\n");
+	pr_debug_ratelimited("exited\n");
 }
 
 module_init(test_dynamic_debug_init);
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 5de726254d91..c06c16cacb70 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -581,40 +581,40 @@ function GOLDEN_RECORDS {
 #K= e11c22649735cedb6c30321378100e11 FT_classmap_inheritance.2
 #K= 5d0f3701517aa3a461c8887c332bdb42 FT_classmap_inheritance.3
 #K= d39188ded831453d90d77390546b314d FT_classmap_inheritance.4
-#K= f43e0aff8a4b38435b73d90ed8100d1b FT_classmap_inheritance.5
+#K= 62b6803edf43519186d6185bebf34352 FT_classmap_inheritance.5
 #K= d2e8b8c5a5b4e7b9bbe1a29460a3c07d FT_modprobe_w_param.1
 #K= d2e8b8c5a5b4e7b9bbe1a29460a3c07d FT_modprobe_w_param.2
-#K= 11032ef17569bd151c3806527a2428be FT_modprobe_w_param.3
+#K= 20d8a1fac0330f1b5cc582ce93792d58 FT_modprobe_w_param.3
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.4
-#K= 942e62ca24809cad666c5725aeb14376 FT_modprobe_w_param.5
+#K= 3c19dd83b330a9d59901281aaa3bacf8 FT_modprobe_w_param.5
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.6
-#K= fe1aadca4b2b4165d8d5c98e973f9e4b FT_modprobe_w_param.7
+#K= 86b7a18d7a692187aa0b7cc0b6886e77 FT_modprobe_w_param.7
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.8
 #K= 535ab526b24a7214de41d92e94bbd52c FT_modprobe_w_param.9
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.10
-#K= 7c02282dcfb73eb5ffb9629ce63360e5 FT_modprobe_w_param.11
+#K= 64f91218760ca86d28a4b9b2d23849fb FT_modprobe_w_param.11
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.12
-#K= b0942decc84dae237019bc2877ff02e7 FT_modprobe_w_param.13
+#K= 03bad8f76b3587c2e8bdb9df43110a5e FT_modprobe_w_param.13
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.14
-#K= efe8e3b8080c3310708b7505d60f7703 FT_modprobe_w_param.15
+#K= 04b59fe2db45bc6bb314e9102b92dd64 FT_modprobe_w_param.15
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.16
 #K= d682c98ced7d31f1555ab474a9ebe253 FT_modprobe_w_param.17
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.18
 #K= 362ab2e7e5f5e3ede8b69645c64fb987 FT_modprobe_w_param.19
 #K= 362ab2e7e5f5e3ede8b69645c64fb987 FT_modprobe_w_param.20
-#K= 4f539816f9cc9fb9dd4a032138e3abde FT_modprobe_w_param.21
+#K= 3377abfe07b0cdfbd4610a8f76f7efc3 FT_modprobe_w_param.21
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.22
-#K= 20659d16ffb5b18475e83602223216d1 FT_modprobe_w_param.23
+#K= 453ce2741d6e7343a272c71ed392f14c FT_modprobe_w_param.23
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.24
-#K= 0b24971fb1018c38353141f8fcb9cbdc FT_modprobe_w_param.25
+#K= 82d34927171a53fbef691cc84ff9e09f FT_modprobe_w_param.25
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.26
 #K= 66eb387a95512f679eb5cad4168b0992 FT_modprobe_w_param.27
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.28
-#K= 7df05523f4d61917fd7659357eeec1bc FT_modprobe_w_param.29
+#K= abbd3c12a631089b3df7b18f43c50b05 FT_modprobe_w_param.29
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.30
-#K= a75600ac4e129f4315c5a50ad3a3103c FT_modprobe_w_param.31
+#K= f099c58f5109edb80f53550664ba5bfc FT_modprobe_w_param.31
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.32
-#K= f43ccce73ac2b0e1529312af66a4ddfe FT_modprobe_w_param.33
+#K= 756aacc01af3b95f86404e7bc06ba9b6 FT_modprobe_w_param.33
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.34
 #K= 4819f715ba485c493afb455542f7ab8c FT_modprobe_w_param.35
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.36

-- 
2.55.0

