Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C91343D7F;
	Wed,  9 Sep 2026 00:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788915304; cv=none; b=PeKZ6RJCcACgtYr9CEieyb/bDexVRSO/nqYK0jwvxVC2ggkAd6C0bHB9H4H50fuQVc0oqPtmZkXrBoCA7hgMzRBdCJMgG7c7F6YEePiuMQB0nv/5cGLFDspyOad95/tvkpjlKpAZNLW5XItJ8tmda2PQi6EAjTmWvKtLFsxs0CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788915304; c=relaxed/simple;
	bh=wuzNmGp+dZEqgdYXoZ6Nkfcce3dj7XCkIJgmn+X8cps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ovp33cIflG9iQ9XFJMAf/HCHjyiUUPbaVNnRnAv1xvE7VL2KEstw/3Kxn5g7t4OtISMuU8eQxj53bGcScNfN4tBzipvSahna1Zj/UQK7EMEXrRPAKvBIKJKfsHHy83c05NBKysvk7ZamtP6g20uEu6mTRTJnxS3uqk8zE5Xk27k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDpXXTp8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDpXXTp8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F657C2BCFF;
	Wed,  9 Sep 2026 00:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788915304;
	bh=wuzNmGp+dZEqgdYXoZ6Nkfcce3dj7XCkIJgmn+X8cps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nDpXXTp8Vu22TW7JeBDSjBJYn55DaQANcfRXgAdIP8RX5VEEvM1QvAe+WplQvSDQu
	 vW9UkRNleFlsWx9JOJ+opwGF/o4eYlVUkMSw51Ngpytm6WOE6mG+PZjq1Uekkl2tKN
	 B9KTFv5tor0JevH9rbByYwPBTYKH9nTaoC0bNvj9RyeT64XoJN6JyruZTB0oMUw9p1
	 THglSHAOjIDi8UcuOtVh2vb/C3/pVfFVFf2UBzNzJHomsI8DuhbNoomj+DV8oPbR6v
	 WRMb/o1sJ7kBdRgK5YozDN3j36eNTELUVm4GCtK1dKa+Fl5uBM8zVb2NnLlaLFpAas
	 JVvQcuZfOrnaA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8EEC79FB6;
	Wed,  9 Sep 2026 00:55:04 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 08 Sep 2026 18:55:27 -0600
Subject: [PATCH v9 31/39] selftests: enable comma-terminator tests
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-dd-cmap-part2-clean-v9-31-3a3f621f4a10@gmail.com>
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
In-Reply-To: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
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
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788915300; l=2399;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=rfqDgOxAFuigMrZav9h+NbKcp1pUHDIbRH1HUbEU0yw=;
 b=m/mwu807z1y73bfYbCgrQGnL3eev8n3d7m6R8HKHzB6c4cPlSI4v6QmOIHuM5KImdB55EKj4u
 4SGnoTokcPqD218RZydcVuBzFG8DOBg7uajiqpxbV25cOBfOn/wvbL7
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com

From: Jim Cromie <jim.cromie@gmail.com>

Enable the FT_comma_terminators test block in dyndbg_selftest.sh to
verify control query parsing when queries are terminated by commas.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 89c9cfa23d2c..70da3662a201 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -470,6 +470,25 @@ function FT_hyphen_underscore {
     ddcmd =_
 }
 
+# test parsing on spaces, commas. testing against builtin file kernel/params.c
+function FT_comma_terminators {
+    v_echo "${GREEN}# COMMA_TERMINATOR_TESTS ${NC}"
+    if [ $LACK_DD_BUILTIN -eq 1 ]; then
+	echo "SKIP - test requires dynamic_debug built into kernel"
+	return
+    fi
+    local f='kernel/params.c'
+    ddcmd =_
+    ddcmd "file $f +p" "$f"
+
+    ddcmd "file,$f,=_" "$f"
+    ddcmd "file,$f,+mf" "$f"
+    # ignore empty tokens
+    ddcmd ",file ,, ,  $f, -p" "$f"
+    ddcmd " , file ,,, ,  $f, -m" "$f"
+
+    ddcmd =_
+}
 # testing classmap-based query enablers and class configurations
 function FT_test_classes {
     v_echo "${GREEN}# TEST_CLASSES - classmap-based query enablers and class configs ${NC}"
@@ -581,6 +600,7 @@ builtin_tests=(
     FT_basic_queries
     FT_path_module_queries
     FT_hyphen_underscore
+    FT_comma_terminators
 )
 
 # Modular Feature Tests (Require CONFIG_MODULES=y and test_dynamic_debug*.ko available)
@@ -653,6 +673,11 @@ function GOLDEN_RECORDS {
 #K= f2b4f24fece9c55f5a5d28323c2019f8 FT_basic_queries.5
 #K= 8c2dd1164fbcefb721345ce62a864a37 FT_basic_queries.6
 #K= 4542e1e5e7eadcbe8f90a9c934635618 FT_basic_queries.7
+#K= 78ad5b168d9db27931dfe7dac93143bf FT_comma_terminators.1
+#K= 4a8d6e0468d14659030ef523c6e5a184 FT_comma_terminators.2
+#K= 3c445fb23d701041e920a2a6d2b022c7 FT_comma_terminators.3
+#K= 68b329da9893e34099c7d8ad5cb9c940 FT_comma_terminators.4
+#K= c745b8f58c0557edca58d5a224a09190 FT_comma_terminators.5
 #K= 8146f6f983c3a76783c89b78b892ed48 FT_test_classes.1
 #K= a15ec4843acd721fbdfddc0b512c8032 FT_test_classes.2
 #K= 20d4545f9753e677e72e3adf52527fd3 FT_test_classes.3

-- 
2.55.0


