Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795483846;
	b=eX91P6hkSb6Hnme3KipAc04l4pSlQ8V9G/sa8UO4lfAEC12NQWJbD2d7ovKsjNA/M+6l
	 g8qbvQxmpzkWgdgOleoHXvZ28XehHLnDzq0gdSr0E7RFTHj9fWt4y2hnIgoFluwraQU+U
	 kHzOPA+EZSHKGVPNHqPBSfBd00mxbJan/nMW8HIqoptwbyCRogW+rRGdHPISDtOienfW9
	 kCiKhEuXGIed9E/2ZYSuKJZlF92jnhq6KmA66/ZY49Vlg9w/PkxzAb56QrJ6+1k3dSdqD
	 yuJglrXnJUB0L3tJuxkgE5jmeYUCnVLmP2tjbolxHgEISh0scxA04eG22XIdwQ3tmMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795483846;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UZbB55PEyzF66HpeCrFvjRWl/AIlRye0/yFUMkachrM=;
	b=aSukecpMY3xgQUTBEJpuskRh8km6Yru99ZET6tNxqxqVRZMYuW3uKe0D8kxLQMWi+M7x
	 ojqg3Oy1p8RjaPVkK94pOnfuwIja/Wb9vra9RW82ow7j8V3sIbMulwj5vDiTZWPZf4ZDi
	 FHAy179lH/PmicJ5/WAgcrqnsuqGbfbInNu6rf7gHj6MC3r2CD4t8/JnN+5Xh3faklo1E
	 hudqBHkNSk8DuopLYmQF7+UCXr4AYQFLCv4MOX5yom4+3MQuHJHip5Pf1tW4CXtZ8/XCy
	 +2RC4JdJfTCHH7s74lkJGxTKpPkT7kuO5WqGKhH75Kw4/E1bel6LSWvuwULtXbNZIyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDyz+UJB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BD6606A32A;
	Tue, 24 Nov 2026 01:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDyz+UJB
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795483846;
	b=QS+wbZteBZpBqwP/OLA2C1IubWd3JSL78/W7VWGEVSgcbTZT5ZRnAlMVKY267ITmvDnb
	 VTkBgHxUCwj1OoEy9lifhJmFnqmAfbQIcSSXYV0uJd6RMmxibQBtvLBVHOmgJJphnYzQi
	 1gqIOkYRabxRKxqqooMgbBXBkJdXMJZMFioqYPl0NxWqTrzaO6iEy7V0kI8xR08ARG0Gd
	 +l23EJVx1xkvh9NTTqjr9fPSSP12rIw5Y0Hwpf9XPK1xZy2By8tnvl2dHDdxez7HEmrBP
	 OdmkB191tAYyhAtDFQZYpd3/9KYedHqtv3twXKD2KopRk5wBS5SwoNKgCHD7oGSSICQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795483846;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UZbB55PEyzF66HpeCrFvjRWl/AIlRye0/yFUMkachrM=;
	b=mQxjO9eJKyc/U+UBGQzoOW59bDEsPRBoHFh+mYlX62ZoAq6V+BJkldM6QksG+xoOYecZ
	 IAYGToSqfOhKI5iS1664bFbdQN7fM80qVN5kkpoHwtEANyAGd9C0+2hCXh4lmsNNW3Lgf
	 6rTnSeUhP49wDfMXiVqHCjYr+FpigYnHJXv9307OSByTg34BUaww7H1R16S1NTAtWijSS
	 HWzJLaJ0F4374dcqAnIeCLacVqpHYyPhdQ+uEdaVsWhJD9d0/GK8cCDNAwpk93UgoK5hB
	 uS4G28Tg2REHiuO0yolNshQnBsjenG/BkhiHsTbH5/zo5xe1KQVpl8nkcTk2vrILNvg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E0B651F000D0;
	Tue, 24 Nov 2026 01:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795483846;
	bh=UZbB55PEyzF66HpeCrFvjRWl/AIlRye0/yFUMkachrM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=oDyz+UJBncaUnk/d0ujJF7xe5+F3nvZIELusG8ycerr68fCwqEh+V46uiMTyobQV9
	 ynLHXT+JWaUvjxUC7b+4hFfSc+ti9EHWjOCqqptO4ETJfvwR2yXretlRX2VGvFoUme
	 LOCEd2Yft5o83hjIB/EEjTTSeedzKgEPfGlJaER1KAHNtcx3kiaO1pk2BrpFkdzZrB
	 3SwrxqCj4zezFGPPuH7ffE+gSoNuZjvsyYfYpMIgV5RNfbkFC9GSBA2IRaFLD9Tugo
	 TmM+c33oH5tXYtChZjevib2u5qElvTS0EJTRtkUdVaSSg7eA9PKlvrE5MPzGHpkSuW
	 WGe824gB162ww==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6A9004C818;
	Tue, 24 Nov 2026 01:30:35 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 18:30:33 -0700
Subject: [PATCH v2 1/6] vmlinux.lds.h: drop unused HEADERED_SECTION* macros
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
Message-Id: <20261123-vmlinux-lds-v2-1-6f608abfa042@gmail.com>
References: <20261123-vmlinux-lds-v2-0-6f608abfa042@gmail.com>
In-Reply-To: <20261123-vmlinux-lds-v2-0-6f608abfa042@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795483834; l=1326;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=r1dUyd/GOk4emgp2lEgzstB+XZAgmG/k0LwDJ33Tzlo=;
 b=XcfDf8vMztEhdf2HTQOhdE1ZtFUAGMqfXPY9KU8Ij75MN/+QowdC2Xqj1tSM4YvzVo9dU/slY
 FpMqGyi6kYUA4lCJV2+lT8uWlq1pkV7VKOI8xpKB0doWAYVMSBXs2fS
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

No callers of HEADERED_SECTION* remain in the tree; drop them before
refactoring BOUNDED_SECTION_*.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3eb732942d69..67aa59f67442 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -226,21 +226,6 @@
 
 #define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
 
-#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_HDR_##_label_	= .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_label_##_HDR_ = .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_BY(_sec_, _label_)				\
-	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
-
-#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
-
 #ifdef CONFIG_TRACE_BRANCH_PROFILING
 #define LIKELY_PROFILE()						\
 	BOUNDED_SECTION_BY(_ftrace_annotated_branch, _annotated_branch_profile)

-- 
2.56.1


