Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795301380;
	b=01C8B8Uy3u3Jg2SaPrAP+Nlm2eIZWWHobbv/pPi65S8ofijIwwg65XDQk3RdkYI2pddc
	 8Aoo5FstfYjps6aNfUem6LkOsFCYG7N1T7qdMrSCvo8x17Dk0nXzGyHBsRhlPUYwC/b3y
	 T02vh9VJ3D0XlbaYdhi+0BS9DkHbdo+eQSFkjP7S4ijx5wSEDcYQqHo9FU2rfHPNo/nw5
	 60lsp0bxy1lD58uWjqivOcdWFt6wiyuRLuBZqHPU6siETaZILNt3NT3PnpyFAUjMxJdqg
	 bYowyUWLH3G733QXyJKmfmAyZgq4gF7b0h+j21o6feMbSzr6aH1+UK3IhqBOga4equg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795301380;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Yvk8G+eiIxLavWAH5Pq1LRcAcJ6Bn80Kp0La/YGdqsw=;
	b=jL6PkZKCYhmQidyvi+6NPGGAFMXIP8jh5CQxv+Yiq46OhWn0HZsr18YXLnQNAn9OJK9R
	 wO0RKbFnvHgp8HisTC4GjLUZgckQXi2HsAA70FtFsD64nZUY/30frKBxsH9NAA2EsqOoZ
	 aZaFAOvxwlWHifnDCvHUn2/xHj0/0pC+dJYKmF73WGwHdKg3FZLEqnwy/sWHNue8ezKXa
	 2pueEdIoAKqbf1nuahCS1q+GJffm8SG1hIDtI6ylhEgyYE3DGt9TX8PwFQ3N9ExPF1Xlc
	 igCtOm5StKZALE7bFVHljHD1G30x9R1V4zggLzNcIIPaiDm3Dkj7ST+6k9ncLm/PF9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NiTPaH6R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164A4606A332;
	Sat, 21 Nov 2026 22:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NiTPaH6R
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795301379;
	b=y8iY7lVS2IW2cgnEznNWnvDnzVKi2ar1AMq2iBPosbH6+9PvErzMmoWHVbNiu5NorrxI
	 eJdwP+uzRJMrrDrNqfYyngGecVod4546/b17FP5kwV8fG9MxxD6rsQvNwEpvA0udNWbJO
	 r+pXKm5Ohd6mbeUTsUEOMQ8P2H4zqTbDf1Zu5Og7rMZdqqV7jieOYRuCM+FiOUZG8ZMmM
	 g1bX/V12Z8HTSnaDRciKLiN3eBt6ArGcaqOWbPTuCINuaIAXfQlBKal2fKnI17RDByDSm
	 gX0JH22OFASLH+n2fnwDXJTHBJVb4I6/gkbwZ33HLzOpI7olqSe18yEZiJ0OjaI7BcQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795301379;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Yvk8G+eiIxLavWAH5Pq1LRcAcJ6Bn80Kp0La/YGdqsw=;
	b=hyEeIdGixQL8ZLbsqdmaaWYhTLKg7QOBzvme46hybJVNGc94GOFEBi0RtQPZnmstagzH
	 U1iEXJmAl/uckNqETii7jn5fAj34Tf+BRiM/h1hDL4gJ4gTsaGawWsA46L4WttwYFcLK7
	 ZEGj5LEbmpusjdWODLEFANuLiUWx8Hu10PGWEYtQT0gQMKnFuB1LeYassEflim8y21hl+
	 TxT8BysQyrpKPH5dO+vh6FX9nHWfStBBFPuGQhzYqx7Mf+xle0H4+3bj02idRP5aiL0Lm
	 daEqE2DzqFu5F+cimdEDxaNRWTysgT92E0ZErUC2wOaNC95zRSISkjI8oXSMowYzAYw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2D7B81F000D3;
	Sat, 21 Nov 2026 22:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795301379;
	bh=Yvk8G+eiIxLavWAH5Pq1LRcAcJ6Bn80Kp0La/YGdqsw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NiTPaH6RJ/P+wGhC/u7Ek+jTQSU+b+sl/mGS3Ksa1KJktP0C4+yW5jV1tKv/ln/0F
	 MQ03fdpJpYQXprgU9i4sMVq+5AWCv0/l/6DRfXpaRUkICjG9wo22poH6jAbE37WDQW
	 3mLgUeEOEhXomgfqXG/GujQX26Yu+FTkhDgEbnSfJ5VzxUEiPUVVNOEC1/wNHTEipl
	 C1FYmJ5IseSp6H1YLsHVD6BBZ2vaJEueKY5ghuSE/zedbKpzRI9m+YybMyLA+8Fvxe
	 OjtDqJja7YgdOb8cl+F/Y+S6N1030YAOt5V/+n99Vjsc46Kk7SeXhfNNiIS23cpYIq
	 d/h485GZ0FD8A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 197804BE66;
	Sat, 21 Nov 2026 22:49:37 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 15:49:24 -0700
Subject: [PATCH 6/6] checkpatch.pl: generalize linker script macro
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
Message-Id: <20261121-vmlinux-lds-v1-6-49818f3f5cc0@gmail.com>
References: <20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com>
In-Reply-To: <20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795301375; l=1707;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=xCW9O+AbKUBV4BIvimad+RBHO1OQaFVpJS/+K5VR+iI=;
 b=0VosmkYkQDOh1ZsR0s0Drc1tYC/PFQI9LCHx9Cf4c8dAjx0vQMsVNzfyClZpREyVYQImsWZnh
 kNWhjPL+PQdC+FS7xIoo9zNTPj0RDP3Kz5kYSu8iqHrjllNM12cdmuU
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

checkpatch skips macro-rule checks in linker scripts; 3 of them
explicitly check for vmlinux.lds.h, and 1 (the 1st) skips on any
*.lds.h.  Generalize the 3 to match the 1st, including the escapes on
the dots, so they're literal checks for '.'

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b8b64f720191..318e1f2577fd 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6016,7 +6016,7 @@ sub process {
 # Usually multi-statement macros should be enclosed in a do {} while
 # (0) loop.  Grab the first statement and ensure its the whole macro
 # if its not enclosed in a known good container
-		if ($realfile !~ m@/vmlinux.lds.h$@ &&
+		if ($realfile !~ m@/\.lds\.h$@ &&
 		    $line =~ /^.\s*\#\s*define\s*$Ident(\()?/) {
 			my $ln = $linenr;
 			my $cnt = $realcnt;
@@ -6175,7 +6175,7 @@ sub process {
 
 # check for line continuations outside of #defines, preprocessor #, and asm
 
-		} elsif ($realfile =~ m@/vmlinux.lds.h$@) {
+		} elsif ($realfile =~ m@/\.lds\.h$@) {
 		    $line =~ s/(\w+)/$maybe_linker_symbol{$1}++/ge;
 		    #print "REAL: $realfile\nln: $line\nkeys:", sort keys %maybe_linker_symbol;
 		} else {
@@ -6192,7 +6192,7 @@ sub process {
 # single-statement macros do not need to be enclosed in do while (0) loop,
 # macro should not end with a semicolon
 		if ($perl_version_ok &&
-		    $realfile !~ m@/vmlinux.lds.h$@ &&
+		    $realfile !~ m@/\.lds\.h$@ &&
 		    $line =~ /^.\s*\#\s*define\s+$Ident(\()?/) {
 			my $ln = $linenr;
 			my $cnt = $realcnt;

-- 
2.56.1


