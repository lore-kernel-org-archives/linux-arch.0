Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B620C3769EE
	for <linux-arch@vger.kernel.org>; Mon,  1 Jun 2026 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315504; cv=none; b=WBeQo7GnsY0qa2gN31CxuO+T9YXopInBghPHWd9uIYISSOLULuf4MuBn1korznT0llol54Lv9lZMbuedNZg3W6TvsoJLcWRS9z2YMTMAExyQ+SpJ7xn7JVdFmrbavjOsPUcLONLWdUx/UEWFx1mw6u+mzd4G0ogZAZqEpGHmfU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315504; c=relaxed/simple;
	bh=/BEze5uZvE97vkdxdEKscGQmmLTlvHt75B8/b2suPbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y3JIJmgRPDRE3zVLLO2Cc1NRn5MBuzSKMl+nQpFLWSb2TDgBifDMAl2TFZfssy+0ofEbiJF2X43E5uEnDy3fiZtS2/kSk2Ypl0wPo9JhdL8cHPfBRK7VxhWE6RTnQHNB53Xgv0Rg4YGLwPKS0dyaeQdhxAU/xHTFS/B0bsbN1I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8ZaUJTl; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8ZaUJTl"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso2561705f8f.0
        for <linux-arch@vger.kernel.org>; Mon, 01 Jun 2026 05:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780315501; x=1780920301; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CwPLhLRZkxVDbJ+XZfxPTCPSMzzunTFiSNGj95FvoLA=;
        b=X8ZaUJTlJSmPN5Lp2+drVg+Y8VYUe7hHrC2s+iTm+6b4FkIO3e6P2MkXYFG1ec5KlY
         ax4/vFi6P0aGj3O8nnMSeex2hpAdOHlcrqHv3ZNuIoyK2/zhaeRHWAkasCfVhInfCFGJ
         Xj9BZ6YzVEawtEvRcUXbD9zF34F+Ck+RkNQRStqsHaVOCYdTjXS+6695GvJDdADA7YD/
         lDUVbLfNMcwbgBoLEw6LIXuqutA1Gjp5RmrMybocMbhC9NrhCNcNfvCjSEvykrrs7iAK
         WVSWuxl/WBD86kovAd6lMwp0DBI9Vc2itChVue2CNMo2htHRhaViBUSGYQdthbdgdCnm
         z2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780315501; x=1780920301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CwPLhLRZkxVDbJ+XZfxPTCPSMzzunTFiSNGj95FvoLA=;
        b=VFBg0tF3K4AfnQM2xqTf4u+MejejeSXRg7M4CgK8HJ4+i2QaAQl54tW1CiTi0w2KCs
         vicLJk/4jNZlhIVNcfS6R+/J86n4NvHt+6Kfr3BVweCM7HXnDfjZbA/B3A4RdGzp4X2X
         mIaIYR+zzf7wbhj3qLJxku8uu4bIgSHNjNgRHayksoS2iaE0tfPIJuBSUqDleTqjNMZM
         QtMXTqIM570loyItQYR1LWg8X0hg/CtBXGWf3RnKYocZl3KDCtybi+tNpjkhGcPyJlOc
         TIa6vWl/NVri8fUODtiUZ97Cj/sFhSof80jhsZ6SopQdoHfNCOsGroi8G+kYHqKHD4Lf
         SKoQ==
X-Forwarded-Encrypted: i=1; AFNElJ+NoWANGO2fxSyQWk4jCfuEJzNApv1CXrsMRAdxk3RKmkjoTBvvP3NodNWcAFTPjJW/bRHEKa6WGB5g@vger.kernel.org
X-Gm-Message-State: AOJu0YyEDG2czFJMPqFdF1L0fidUOijMpqvnrjcSmwpAM8AdKDqzUjyD
	H3Wz6DG1206v14XMIt5WlMsyEDIeQ2/rtMn0kKxGLGg+ctHjfG4peOjR
X-Gm-Gg: Acq92OEeUBOKefeoSzJTFB5NeVO0e34w2dqsrS0o0IF5Up8eB9iR7NNwp7clq48w89P
	X3g+RfPbtVCgbS1UfFXEYflSRQMey3uXA2/QEOjyQU2hW6ZjtdZCPSiEwjwgEu222uJg0QaieDI
	LoXN4/NKNTK4uNG1Udf2c3k8+eiM+CXM/lP6hOLZjjGAxIF+4wFSwzdgVIGiFDLSmwNIdPuRpCX
	T4eArhX8Hfr+4f5zGP0sA+jMOxsWMq0UY6DpM73psoTTz7PAETuiuHMtOJ1SGMlklLgLmJRlG7X
	bx1IxCALOqIKSVVwGN5Ycy5XmHfXN+4wPIdHto96oc1WB8ThT+zE9cmamDmKKjNDnQ8wR1uuwNx
	WJSCWyRBMoZLZ2ijK38Ou/hqbQy5Ja8yAd9m4F7pXAPQKxF2++caehpfavFgIQvfejE0cCFyJnD
	+59rYZiRRYPuQ+FIJva5WXOslKqadh3Hae/+lKqc3MdQ==
X-Received: by 2002:a05:600c:4715:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-490a2932381mr196252395e9.11.1780315501072;
        Mon, 01 Jun 2026 05:05:01 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:05:00 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:04:47 +0000
Subject: [PATCH v3 01/24] docs/dyndbg: update examples \012 to \n
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-1-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
In-Reply-To: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=2677;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=/BEze5uZvE97vkdxdEKscGQmmLTlvHt75B8/b2suPbI=;
 b=c8S96t+ZCXu5kmm15ytCexf2F+SACA7KqyLI8HX9Eb3WTFBQJJe/DEwNE9wWzQI9kMMtWSMe2
 BCeYdCPPvMcCqA4vhxh710sNmgly3GwhDZJllsv9yBgjcughOSsHbPp
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

commit 47ea6f99d06e ("dyndbg: use ESCAPE_SPACE for cat control")
changed the control-file to display format strings with "\n" rather
than "\012".  Update the docs to match the new reality.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Tested-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 095a63892257..4b14d9fd0300 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -38,12 +38,12 @@ You can view the currently configured behaviour in the *prdbg* catalog::
 
   :#> head -n7 /proc/dynamic_debug/control
   # filename:lineno [module]function flags format
-  init/main.c:1179 [main]initcall_blacklist =_ "blacklisting initcall %s\012
-  init/main.c:1218 [main]initcall_blacklisted =_ "initcall %s blacklisted\012"
-  init/main.c:1424 [main]run_init_process =_ "  with arguments:\012"
-  init/main.c:1426 [main]run_init_process =_ "    %s\012"
-  init/main.c:1427 [main]run_init_process =_ "  with environment:\012"
-  init/main.c:1429 [main]run_init_process =_ "    %s\012"
+  init/main.c:1179 [main]initcall_blacklist =_ "blacklisting initcall %s\n"
+  init/main.c:1218 [main]initcall_blacklisted =_ "initcall %s blacklisted\n"
+  init/main.c:1424 [main]run_init_process =_ "  with arguments:\n"
+  init/main.c:1426 [main]run_init_process =_ "    %s\n"
+  init/main.c:1427 [main]run_init_process =_ "  with environment:\n"
+  init/main.c:1429 [main]run_init_process =_ "    %s\n"
 
 The 3rd space-delimited column shows the current flags, preceded by
 a ``=`` for easy use with grep/cut. ``=p`` shows enabled callsites.
@@ -59,10 +59,10 @@ query/commands to the control file.  Example::
 
   :#> ddcmd '-p; module main func run* +p'
   :#> grep =p /proc/dynamic_debug/control
-  init/main.c:1424 [main]run_init_process =p "  with arguments:\012"
-  init/main.c:1426 [main]run_init_process =p "    %s\012"
-  init/main.c:1427 [main]run_init_process =p "  with environment:\012"
-  init/main.c:1429 [main]run_init_process =p "    %s\012"
+  init/main.c:1424 [main]run_init_process =p "  with arguments:\n"
+  init/main.c:1426 [main]run_init_process =p "    %s\n"
+  init/main.c:1427 [main]run_init_process =p "  with environment:\n"
+  init/main.c:1429 [main]run_init_process =p "    %s\n"
 
 Error messages go to console/syslog::
 

-- 
2.54.0

