Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5716343208
	for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 07:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520493; cv=none; b=tEwzT4+TSzNNqXsOlJJ7DAqfrEOPQPGx1zTI0bpewayXmXKP9UQREtKh36pa9wjUZscQdtyTuODof8TDIDD1/QV0LRTnmk5jDM8nCw8E8+csiL+4tPzLRqsUAxK5QJJcpmsbeVZ3KCVtoJpwJ7NLTm78F5YCQ5v77IOshRVBIvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520493; c=relaxed/simple;
	bh=/BEze5uZvE97vkdxdEKscGQmmLTlvHt75B8/b2suPbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GJdLOb1uEYhd6uYMJktmdZodv2UCMmBHCJod4zpnrFxFtQsukbMQQGT9VuMjXa/SQz0u4Mj0MyTxLp5W7xbtWdB3ndRNHry4PBE8RtwYisC8CdCJZYHDj1/fzkyAPsdI7kAdPQ0xsZ+lKs88Uq6k15p4axTWFA85cDgT2pTrgkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THlgXCAl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THlgXCAl"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-452169ae568so5244895f8f.3
        for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 00:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520490; x=1780125290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CwPLhLRZkxVDbJ+XZfxPTCPSMzzunTFiSNGj95FvoLA=;
        b=THlgXCAlOECqGp3gfU7FqF1cecNGxTcXzN7FUn0YrMtUOLz2qrrIGsHNvppD+WVXHc
         9q681FnNNwGjw9a/9xvsI3SSKGGXuldmNE1OaNtBxy6gCONvZIIMMeSLpRemJcx9GsTi
         1wSeTcaZ02jAjR38ImuCH6D/hOadqna2tmUidwb23TVmSiJLr+c59QD65yq1oC9m1nZJ
         9zrHslTamzg67Sq/Js+sLUkUy613NZM7V8/aT8JNCI7Z7XxbmTRxvw5rgcHfBE6To0MQ
         t1ZxvdzT2WStcUowbvIvqSwfed0zkEV8pEPFGWA/UnzHg4moZk4OUoXFFYy6mMJ1ohzW
         IUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520490; x=1780125290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CwPLhLRZkxVDbJ+XZfxPTCPSMzzunTFiSNGj95FvoLA=;
        b=Su7Jx0uU46TxepEW6YZEh+dzQzPwyjn9ZYbl84hlUWkhIZGw1riuoAYLZQ6A2kZRrL
         aqbD/ubP/8ACrJWTKA+3b5vTHG0/GsX6t9QpII3FcW1A+6kmaJpB8QkOpbH2gI13AWpZ
         Ml7k1FJjGxXZabNacnse58d3V6rn+1T+KQ1BpimNwXt+4LJYSGc8lb4MCE35WN7PzEWx
         76SDIx8Lu3sYCoMcFQBhrwQXtQH9uoPuK75YUqAUvZxiprAn+dob75J6kIoEMgMvGa9W
         eAqTvPBeDiFQhw6LQjFAGbTTeHxdSohmk0OeUMmPyXT5xjQMnRgVbr8Mcq9uHDVpOyrQ
         JgqA==
X-Forwarded-Encrypted: i=1; AFNElJ9S8GkCJlrVuANdSNZERuxiCqXssSEwnr8lzZN4BmziuKrR4Nsjf4rEZACE5r8VAp+oYsSdYeFNrCk4@vger.kernel.org
X-Gm-Message-State: AOJu0Yygg0R0A8ZmhyuOl//9P+vXYMZCjQX8H8peaqP1fJQn3Th6Gr1E
	nmYxIRj5oTOZrcpnxTeRuwLYuEvfXaxYytjMSRnnSpsj6DgElAdF4vsP
X-Gm-Gg: Acq92OFnSUXVi3/Qj4WivppLWSFT4BVxEndcUC4zquTVsVVHPAvCDXoz8BJOw6uDApa
	9Wbl6k4nMKjoZjR+Cd6qv850BMaXTRfxi53Rf696weYg0q4Tsaj/zabXIwkIRTfOMCoRDbmcA7j
	lG09Yr9kYAzNzdLLO106nLVcoPBDGnBwtXgvLtpQD1NCTD+zk1WFQTwrnVPAUXMQY3EukXtb4wp
	pDmfmsu0u3S7qNpuUtainDaeadkySXe4V0socLKgddlFiHC8Q7G2GVTsdVER6oDGLhn7lMSnodq
	9cn3GgLiuUiGqQlNVW5SVVv83V3Jexk0R5mXOUynwkHon2cEy5TYGxgryNviG6ArYitdhZtSpJ5
	BAJRQXBMf+tgjVAYj7E+3rpd28mbW2ot5tIwymspcPWSomH60sniB1+mNwApsuOGrjXUnU5Xgfr
	4a2OglJ8sL2Hdr0UKNUe4zWNRaObZ+
X-Received: by 2002:a05:6000:4283:b0:44d:261:54c5 with SMTP id ffacd0b85a97d-45eb38b7934mr10255969f8f.30.1779520490103;
        Sat, 23 May 2026 00:14:50 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:14:49 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 23 May 2026 01:14:34 -0600
Subject: [PATCH v2 01/24] docs/dyndbg: update examples \012 to \n
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dd-maint-2-v2-1-b937312aa083@gmail.com>
References: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
In-Reply-To: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=2677;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=/BEze5uZvE97vkdxdEKscGQmmLTlvHt75B8/b2suPbI=;
 b=m4w5/JAevLLITYZXnWyLdNY/RNTDCpivVD8sWcmKmyXvw9E1IQYdDwsomaowr+2kpLJ+htivv
 h8ApCZJGep1AvCpisr3LF1/KMS84s8UihdsPJQdS4plwDlhoFbiHBfL
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

