Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132551;
	b=MzYACcPbZY5BNkeIZdFJQEOofQxtXs8a9rBqam7zppkZKfEwbUak/B2xUpCiGzUepDTg
	 UJA/QDD15wEwtYM1j9Z4YOw+LQbzcCZ+lWC7FQAWVI+r+VAUh0mWppJ/WVxt5lbHbhRG+
	 bcDTpNyNFqTPzJ0Sowhv/7NS7TGHrFkvSqAV+lP8RYfgXObdByuZfdDf0te6ZeSMBio21
	 nNwauzMy1QrBgKz+HcKvLBRVJSZKHhyuSfz88toiddHWNFqCfPbFg3lvkU6t1Z/jnSife
	 gyaZ9SpZLwgKacdVl1ArlcRPTV/K6EAgxqalFQZ0BxvfvKnCR8K2nPZf7Vsi9HL3tcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132551;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QFqpzviPc62m2+b1N8YCwl/uYJvBexNvvOd3y1LZQaE=;
	b=cYKwI4J7ZBiLtpbXZSuY2Z7fhO0DRKA6a7FmI1S/5woKv/DP8+8IbiBp5CYV+BTuSJnZ
	 OcdwCyxpHrwSPu/ieQ0M89MVK/ex6T+IvGJ6GvDedwOLU5/PdLnWHEzq/G9HtxYTJT+3f
	 3OOyJ9aad3hYHJpug6u8yYy2EWXDyqaLNujbPX9RYcLDU1id25S3RQMimSM+T5TiHJwiC
	 iofRYZiLBGTHN2Bi74kK2IQ4+9fWWVn5TmEVbI/UVr8gpJaMJkwx4t/OQF5H8oQCqk50f
	 fSn5CamCFD/el7ob17GcMNzvH+r1btT97Bgm3HRnfqWR0nEKaNatyl6hyGd2ep3xGOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YNjgLP15;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A099D606A911;
	Tue, 27 Oct 2026 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YNjgLP15
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132550;
	b=eVGO/CShdI8p8b3RHTZA/I8pgrJNB1y4xoRqbH2J5/0/fKZ8gYrWnHon6rE1M9P8ctn5
	 cAuvBPvvl+oy62GguoGEXLozPyhK7xCroex9bwA6Tq0HB91ZMv0XMoSQERnAmNQjW6Cyu
	 XvMlziiO7TM+VrKntN3+ldOKm/5iTUW9IjlfYOSHqtMDiMwnIHUisr4EBMhltmqQD2fUw
	 cyZCxvpyHDXuCvqbTHXLyw8z+OJa8XWOu0EsAf7vMEIdFgak/T+tjQXaVsO5MvMerx1Uj
	 AQDd47E3zxX8MYK5s1ouv9kwvo6oH83jBpO7vWuLlVZLpG1MIGic6ZzeON/Z782ISTA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132550;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QFqpzviPc62m2+b1N8YCwl/uYJvBexNvvOd3y1LZQaE=;
	b=1TCfyP7MpTMiiG0YJl7VYhgua1kf5J9sFusLhzFdlDYNTWFDKsGSGVpigD8k4vcqZHSE
	 lU99UYmnMoagav5mPbb4cYPUk+n6uHDNXdfmiojUN6bVYGts/fjvEg78q6fxlBPHl3Azx
	 89jjFI1ItJwVzYCMiBeaACIOVHLQaWTUcKVJxUugFjO9+sz7+ZqB/Pak2KGwYYQM+clHr
	 cDQHglwGFIm8Gq0qgx5deX0HzFnfrz1jtTJF9GoP4EMRCcE8x8iw5XuEOzMXpK9fPL0Vt
	 owZqwJvMSAnbNJKsXj+wVWE5WDHaUWPgxFlm+AsxoVyjgCwBHVuM94feX6yJV4npepg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 84AE31F0135F;
	Tue, 27 Oct 2026 20:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132550;
	bh=QFqpzviPc62m2+b1N8YCwl/uYJvBexNvvOd3y1LZQaE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YNjgLP15d7ARK+Z4Bda3ofnJn5CdcU4Oyxsilndn6k1YBeXXmpFiIXwGNYU7NOKmt
	 zOvufcxjl9Ns1LjzoZVMg4FCIeMiS5DAhHFMi/K89pZi44f+1XUCyymRqNFcRDtoZy
	 dgzyETMt68ldRtpRmadMwEcJGAgpF8E8Ur5UnKaEYsKrDsMq4sK8Y/jeRndtZr/X+l
	 V0CSaKHKMBSM1+mzAjae9YRO2KtAneKUVze/v3rumhfmnYiV0J10yLHy04iWG2KI1z
	 4bUoVsAd+RExqwgFzLt/KdAzev0OiJieIi0d3/5W0Rt/DeToSdcnR/93NMYk5xwc/t
	 wwfEaloTzm+Sw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0EA9245264;
	Tue, 27 Oct 2026 20:22:11 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:29 -0600
Subject: [PATCH v13 29/39] selftests: enable comma-terminator tests
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261027-dd-cmap-part2-clean-v13-29-9267923be612@gmail.com>
References: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
In-Reply-To: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
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
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jason Baron <jbaron@redhat.com>, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=3975;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=NxQmKtv0eDJHiMhYB7Dsgkr2EoP7NbBP01ImDvAfxdw=;
 b=qbn/L3/n+uApxRkFQR7jbqsIdGX1ATWtKG8Pm04sW0nk8M66EbqdpedcS02w/6VJfKwmzxsj1
 ye2G4u900UzAbrsDfqBkQB1C3QDuD9LzhapimtIefqBuBECl5+nAffC
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

Enable the FT_comma_terminators test block in dyndbg_selftest.sh to
verify control query parsing when queries are terminated by commas.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v11:
. convert modprobe dyndbg parameters in FT_test_classes and
  FT_classmap_inheritance to use comma separators
  ("class,D2_CORE,+pf;...").
  Sashiko review complaint (patch 24):
  "Are these load-time parameters truncated during module load due to
  how the shell handles quotes? When bash evaluates and strips the
  double quotes before executing modprobe, modprobe constructs the
  kernel options string without adding quotes around the parameters.
  The kernel's parse_args() function (using next_arg() in lib/cmdline.c)
  splits module parameters at unquoted spaces... treats D2_CORE and +pf
  as separate unknown parameters."
---
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 29 ++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index d7681cdcd012..f4078ad112f0 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -340,6 +340,25 @@ function FT_basic_queries {
     ddcmd "file $f =_" "$f"
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
@@ -350,7 +369,7 @@ function FT_test_classes {
 
     # 1. Verify initial multi-query enablement state via file slice
     my_modprobe test_dynamic_debug \
-        dyndbg="class D2_CORE,+pf;class D2_KMS,+ps;class D2_ATOMIC +pm"
+        dyndbg="class,D2_CORE,+pf;class,D2_KMS,+ps;class,D2_ATOMIC,+pm"
     verify_control_slice '\[test_dynamic_debug\]'
 
     # 2. Verify state transition and live-printing end-to-end via ddcmd_load!
@@ -368,7 +387,7 @@ function FT_classmap_inheritance {
 
     # 1. Load submod directly (which auto-loads supermod with default parameters)
     my_modprobe test_dynamic_debug_submod \
-	"dyndbg=+p;class D2_CORE +pfs;class D2_KMS +pts;class D2_ATOMIC +pmf"
+	"dyndbg=+p;class,D2_CORE,+pfs;class,D2_KMS,+pts;class,D2_ATOMIC,+pmf"
     verify_control_slice 'test_dynamic_debug'
 
     # 2. Runtime parameter changes to supermod propagate to submod descriptors
@@ -447,6 +466,7 @@ builtin_tests=(
     FT_grammar_ok
     FT_grammar_errs
     FT_basic_queries
+    FT_comma_terminators
 )
 
 # Modular Feature Tests (Require CONFIG_MODULES=y and test_dynamic_debug*.ko available)
@@ -537,6 +557,11 @@ function GOLDEN_RECORDS {
 #K= 02e4fd94602e108cb89bfc70d47a5dad FT_basic_queries.5
 #K= f03a7ca7316e8db4c0e16523dc41e75d FT_basic_queries.6
 #K= c518a50ba30ba8099d0dc874a27ecf16 FT_basic_queries.7
+#K= c8bbbac639f244ed9088208ebb7d83a6 FT_comma_terminators.1
+#K= bed6350f058f600910837dae83a12f56 FT_comma_terminators.2
+#K= 6e8599556a312200fb6d484565b6c52f FT_comma_terminators.3
+#K= 68b329da9893e34099c7d8ad5cb9c940 FT_comma_terminators.4
+#K= adc1ef04304c861c87fe294a8ba4e402 FT_comma_terminators.5
 #K= 91838b4012c50a1dc1d9e210ba8d68f8 FT_test_classes.1
 #K= a15ec4843acd721fbdfddc0b512c8032 FT_test_classes.2
 #K= 2cee6842c9cdee5cb3bf50b2e3914813 FT_test_classes.3

-- 
2.56.0


