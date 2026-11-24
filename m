Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795483853;
	b=1jIbAHZPEKWnFaDlf8UzScoJmba/EhraAVeVYeAxUgi+t5Q2SURa9uGnP+tbDocriYP+
	 feJukesJBykVlydIeHyx2+SzZRcJaSWFitIzxusbFMSp+zzWN/Db9CJorbCizGTtjxmCt
	 /eMrtas8CXWU9AIPF8MYcV8ygZjZFBF8eDYvMRGUeEbiK2dL+CTbiUpjfU1aeVPXoj1Mw
	 PivQzeMyu9/OO3PAJBZBhz+8C1dK7vP9N75+HjJWEZgYgJEBr6GaYdFFSKi2BrKHxojE5
	 iwCRBq5apX/UT23aDyJ3UiqqypQ9xIss31VDQVzJXbWEKvnpZifBPBEpM2gHjcw28hQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795483853;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qMa7joQVOyf1QToMV3Uj1XmuRHuYOecZ1Uj6feFybDs=;
	b=x3Ubd8tNdqkpauDSx1xnhbjs6dwTxxLA0+zH5bE0PX9LjlCRBOk5MCBrDNNrrsg0CBpS
	 qSgpk686TaI8pKeLf6vynzUzdzG4cG6i/JMXyv1d0SXhL7nOeeMBLTiiMHLoBNnamBoUu
	 L7oYudg2e/Nf00FoyAOgAUkQHUsNJXbQkwr5MMir2qAt3RXS1MAklxgY42mR4IwF59kEF
	 7lz5RgKYqU/TDI5BiOaKqg6FlHtkjqckM+Swu0FgRGfXk3tyG38X9+hGvAuCAUw7NFIFm
	 Iq+y7BUoF3mxHViy+hykFReJzGSNWTi8RfnW9Ab9oN6tMq7UtqPBizDal3sQLpqrGIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxYgO0Or;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314B7606A689;
	Tue, 24 Nov 2026 01:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxYgO0Or
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795483852;
	b=JZJWY/qEC8PjxcT2eHmIy9h0P5qx/QwGVNvpxBo91GHoDCMLEoKMe7r74GIF7CVPgd98
	 Qzv4OA26HxDolkjmQg9RjDo3KDXrkkS0834PZX7Izyp74EGIy/blaUOlBTDZh1Gx1b4Mk
	 LPFvT+7eSdafTDcqSISt6mtVKOzaDibDOgSR0v4mcfel8Amnvj/fJRMP62KwWHu4sTdWh
	 K+aRLD+p/jDmh05Aja35KjC8IYYdNZOScmOf5ZZcMannhxkObSgAp+vZSwhIEa8wfYJr2
	 xmquc3p8GzyIrrziijziFa3zyGyiFo16oA6kRBN3xb/Qob2YKgg2MUtCkpwvb6b9OZg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795483852;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qMa7joQVOyf1QToMV3Uj1XmuRHuYOecZ1Uj6feFybDs=;
	b=ydvjJTAHq9zYbZR9+CRITKz767s8SEQQlD0K4ceMxP/lJkjP3akRcyLlYCA+Xf4VXTgq
	 +fhBUDAnb6VoCMSL+ciYISR/HBqAK7nEO2U8+5nNUFq6cL4w8LboHDWxms/4kA07NWgbY
	 /+9lpZtu60MIDzJXMTRG3qg1sMtOOf77LHCPLXsqhygFbTTycyo2lAJN1/y+wNTpWIKK8
	 NiwGx8++t/ailm1vjyqe3JmFaFs6M2PYQf0IuZWhNqE4xo68HveYjfBhEl6g5spUG1OK0
	 NNixrznLNNCM4UcNRAcOxq5ojX17XvyFn3Pe6bnh1qH3AxqRWWgA1YxEgCZTsnf2O4g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E791A1F000E6;
	Tue, 24 Nov 2026 01:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795483852;
	bh=qMa7joQVOyf1QToMV3Uj1XmuRHuYOecZ1Uj6feFybDs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GxYgO0OrSkCRcKZYLm1rfZlXkWqv1BDV9/joHxxzqY0DTGSg7IxWxfA+2sNqSHCLB
	 sT2qxa67RWJkS3UXHPr/hKwiqGgsJ0UKhfAPt3Bs2ZJPyPLibrn7fCOV/3EVBJey6y
	 hZCbiKR1888rrOpHl3eEvl1mjmJwJyTNZuba+LRgELO2UtZWQtbNyS+vlA9HdNktPK
	 qEAo6Ti/r2nLK5DIbaWnOYb3fYUoahaPDlGTjCYhd/EW4pciLzDTrnYa9iea04qGwQ
	 vyxJa4Tc4/O1FIx9z8kzUd53s38L8+UA6VgLdsBnwiQRtfYDAjsJV57h0zdNCVwH/H
	 nj4Z7FyUSszAA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 077474C82E;
	Tue, 24 Nov 2026 01:30:36 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 18:30:38 -0700
Subject: [PATCH v2 6/6] checkpatch: generalize linker script macro
 exceptions
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
Message-Id: <20261123-vmlinux-lds-v2-6-6f608abfa042@gmail.com>
References: <20261123-vmlinux-lds-v2-0-6f608abfa042@gmail.com>
In-Reply-To: <20261123-vmlinux-lds-v2-0-6f608abfa042@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Joe Perches <joe@perches.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795483834; l=2564;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=D+nyQSgsplW6kEBtvNiftnG6J4U1bswNBaff1Gx5wkc=;
 b=Ajrfl887GBG1JbFUQRjM689KZ3y2yDRv/hRwXl8ck9wWCI2QMeShNopH1FGv9G0PyIIck+kPl
 wt3Y3aXeMUwBah2/TcdnvRDDzWOXyW4E15mkxpy649OEp5yuGFGruR8
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

checkpatch skips macro-rule checks in linker scripts; 3 of them match
only /vmlinux.lds.h and 1 matches *.lds.h.  Introduce a single
$is_linker_file = '\.lds\.h$' regex and use it across all 4 checks.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 scripts/checkpatch.pl | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b8b64f720191..634cd7100474 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -80,7 +80,8 @@ my $git_command ='export LANGUAGE=en_US.UTF-8; git';
 my $tabsize = 8;
 my ${CONFIG_} = "CONFIG_";
 
-my %maybe_linker_symbol; # for externs in c exceptions, when seen in *vmlinux.lds.h
+my $is_linker_file = '\.lds\.h$';
+my %maybe_linker_symbol; # for externs in c exceptions, when seen in *.lds.h
 
 sub help {
 	my ($exitcode) = @_;
@@ -5416,7 +5417,7 @@ sub process {
 				# A colon needs no spaces before when it is
 				# terminating a case value or a label.
 				} elsif ($opv eq ':C' || $opv eq ':L') {
-					if ($ctx =~ /Wx./ and $realfile !~ m@.*\.lds\.h$@) {
+					if ($ctx =~ /Wx./ and $realfile !~ /$is_linker_file/) {
 						if (ERROR("SPACING",
 							  "space prohibited before that '$op' $at\n" . $hereptr)) {
 							$good = rtrim($fix_elements[$n]) . trim($fix_elements[$n + 1]);
@@ -6016,7 +6017,7 @@ sub process {
 # Usually multi-statement macros should be enclosed in a do {} while
 # (0) loop.  Grab the first statement and ensure its the whole macro
 # if its not enclosed in a known good container
-		if ($realfile !~ m@/vmlinux.lds.h$@ &&
+		if ($realfile !~ /$is_linker_file/ &&
 		    $line =~ /^.\s*\#\s*define\s*$Ident(\()?/) {
 			my $ln = $linenr;
 			my $cnt = $realcnt;
@@ -6175,7 +6176,7 @@ sub process {
 
 # check for line continuations outside of #defines, preprocessor #, and asm
 
-		} elsif ($realfile =~ m@/vmlinux.lds.h$@) {
+		} elsif ($realfile =~ /$is_linker_file/) {
 		    $line =~ s/(\w+)/$maybe_linker_symbol{$1}++/ge;
 		    #print "REAL: $realfile\nln: $line\nkeys:", sort keys %maybe_linker_symbol;
 		} else {
@@ -6192,7 +6193,7 @@ sub process {
 # single-statement macros do not need to be enclosed in do while (0) loop,
 # macro should not end with a semicolon
 		if ($perl_version_ok &&
-		    $realfile !~ m@/vmlinux.lds.h$@ &&
+		    $realfile !~ /$is_linker_file/ &&
 		    $line =~ /^.\s*\#\s*define\s+$Ident(\()?/) {
 			my $ln = $linenr;
 			my $cnt = $realcnt;

-- 
2.56.1


