Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D0531A053;
	Tue,  3 Mar 2026 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560401; cv=none; b=fSTxgdrZQT+qycDoYNNIkvzADbnOrwjQqQDQjht9LBv2CjxrriVsdEk14NG3gx+ZjFn3TGCIK0xuENHRMZlqQjMKDud+DRpeLOnLjwRY5g4lTqkm78H5RqMjxsxCX3hCCAvkRwDSGsb46nq1pIF9S5PgHOm+74v5W00uJApwjx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560401; c=relaxed/simple;
	bh=AWPGSjlFGYCvM0Uf27Rjhu8lYH3auQ3CC8o4On5/Fg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/HFdTGY/w21W0LHp/ZhqdKpeaKXBuy7sz5S1x3Akn9zP3UPnlHXRmgBdcFF3YEK2tcHS9aeIx1wgYb06JgJ0+5Xqq509fnh0CZjcjs03H/+YtIBM8uKdL/sQ2gNGiMMHTZr4UEDQOVwFyM7S7rKcbytR4r9Zd+VjHE/HAEHBU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=p7yJoLvy; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="p7yJoLvy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1772560398;
	bh=AWPGSjlFGYCvM0Uf27Rjhu8lYH3auQ3CC8o4On5/Fg8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p7yJoLvyDWPub3EMiqd4JKUISc3h2PWgTRGaLkCr4AQnmYk23rPTglRNPaB0RkQLx
	 4hNL2vMEs3fN2NTn73uxEdt9l1d9yb+mXT72QRxIHpKnTzISck7qjE27IN9W1AWBsf
	 vA/e0jNtXWZBvwcCCkQL/EVEpGrU/LJ3nfsp2MT0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 03 Mar 2026 18:53:14 +0100
Subject: [PATCH 3/3] checksyscalls: move instance functionality into
 generic code
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260303-kbuild-missing-syscalls-v1-3-3b4d69b68c75@weissschuh.net>
References: <20260303-kbuild-missing-syscalls-v1-0-3b4d69b68c75@weissschuh.net>
In-Reply-To: <20260303-kbuild-missing-syscalls-v1-0-3b4d69b68c75@weissschuh.net>
To: Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772560397; l=1976;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=AWPGSjlFGYCvM0Uf27Rjhu8lYH3auQ3CC8o4On5/Fg8=;
 b=46aIxOK+uMDYJaJ3qyr4HAx3EkNfqgeB6K4h54PbKGJ6DK05YyqKNLvOvUUKL0JLTWBCGFT2E
 ueN0TLZFQ8bC04440XVHm8E31GVya6PKMJhmY43f/TQrzfBSYDJpxX6
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

On MIPS the checksyscalls.sh script may be executed multiple times.
Currently these multiple executions are executed on each build as kbuild
see that the commands have changed each time.

Use a dedicated stamp file for each different invocation to avoid the
spurious executions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Kbuild             | 4 ++--
 arch/mips/Makefile | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/Kbuild b/Kbuild
index 515cc6a27477..fb547bc5ff41 100644
--- a/Kbuild
+++ b/Kbuild
@@ -47,11 +47,11 @@ $(rq-offsets-file): kernel/sched/rq-offsets.s FORCE
 
 # Check for missing system calls
 
-missing-syscalls-file := .tmp_missing-syscalls
+missing-syscalls-file := .tmp_missing-syscalls$(missing_syscalls_instance)
 
 targets += $(missing-syscalls-file)
 
-quiet_cmd_syscalls = CALL    $<
+quiet_cmd_syscalls = CALL    $< $(if $(missing_syscalls_instance),for $(missing_syscalls_instance))
       cmd_syscalls = DEPFILE=$(depfile) $(CONFIG_SHELL) $< $(CC) $(c_flags) $(missing_syscalls_flags); touch $@
 
 $(missing-syscalls-file): scripts/checksyscalls.sh $(rq-offsets-file) FORCE
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index d9057e29bc62..6705fa5d9211 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -421,12 +421,10 @@ CLEAN_FILES += vmlinux.32 vmlinux.64
 
 archprepare:
 ifdef CONFIG_MIPS32_N32
-	@$(kecho) '  Checking missing-syscalls for N32'
-	$(Q)$(MAKE) $(build)=. missing-syscalls missing_syscalls_flags="-mabi=n32"
+	$(Q)$(MAKE) $(build)=. missing-syscalls missing_syscalls_instance="N32" missing_syscalls_flags="-mabi=n32"
 endif
 ifdef CONFIG_MIPS32_O32
-	@$(kecho) '  Checking missing-syscalls for O32'
-	$(Q)$(MAKE) $(build)=. missing-syscalls missing_syscalls_flags="-mabi=32"
+	$(Q)$(MAKE) $(build)=. missing-syscalls missing_syscalls_instance="O32" missing_syscalls_flags="-mabi=32"
 endif
 
 install:

-- 
2.53.0

