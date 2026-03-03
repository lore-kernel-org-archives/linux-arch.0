Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E2E370D42;
	Tue,  3 Mar 2026 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560401; cv=none; b=Hy12YWFXc+4GFoKPB4VnHfHNslb7Te+0Ggj5QzaZzRJm+vEhdzD18UhFxJXEFo+QWBOB8j0z6Pci2yUivHho8f6zqstn0mFFsHof4DvT3FosOaSNNImQT6Pmg197grnk6WHH/0/7kGfdl6zEy+sizOw/npUeREumUMrPCfSCXao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560401; c=relaxed/simple;
	bh=dduxJCgHweVxYiNvudg2ZsGjXC2SsrE2dgbU9AwUCbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gAz8RUVk06IdUZVelvI/DatePrnY/TeS/WN12jaaioe0tRZIxcVvItXtfxy/gDnfJKwUZ1AAKyIj/xvkstJTS4SBpeF8fw3awc4MrG34mHhjRkDrxSUrGzqe9oJawVo/dihT2HzQ+9nP/evBLXY4YyD5GGrhBCi+WSoHI4JZQqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=o84OkAdb; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="o84OkAdb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1772560398;
	bh=dduxJCgHweVxYiNvudg2ZsGjXC2SsrE2dgbU9AwUCbA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o84OkAdb9vx4VQSS/Tcf6If0vWV/9Dhby2XG3OSExr1AF9C84wczQtxjQPss/4nEj
	 m9gXJ/3S7Xibe/p1Mskkb3A1dmAjgryzNXceOczkhhlyPXJvjspCZWqHjMMbgLiDbz
	 2npTTQgdd8PUp5OUwEPsJI2CXFGUFQ8O/j9aNWEg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 03 Mar 2026 18:53:13 +0100
Subject: [PATCH 2/3] checksyscalls: only run when necessary
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260303-kbuild-missing-syscalls-v1-2-3b4d69b68c75@weissschuh.net>
References: <20260303-kbuild-missing-syscalls-v1-0-3b4d69b68c75@weissschuh.net>
In-Reply-To: <20260303-kbuild-missing-syscalls-v1-0-3b4d69b68c75@weissschuh.net>
To: Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772560397; l=1897;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=dduxJCgHweVxYiNvudg2ZsGjXC2SsrE2dgbU9AwUCbA=;
 b=i1vpDrFMelbgPAQkwxb587YM6eBfGuE9YnAqlmSAnQcifyPWvcheHUPQ4fio5IjNZk9m3rGOY
 WaDAFCzsYFWD5YYNDdDnn1Z4uE2zfCYrQdKDLU+TaDaUxVB1BShTyar
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Currently checksyscalls.sh is unconditionally executed during each build.
Most of these executions are unnecessary.

Only run checksyscalls.sh if one of its inputs have changed.

This new logic does not work for the multiple invocations done for MIPS.
The effect is that checksyscalls.sh is still executed unconditionally.
However this is not worse than before.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Kbuild                   | 12 +++++++++---
 scripts/checksyscalls.sh |  5 +++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Kbuild b/Kbuild
index 13324b4bbe23..515cc6a27477 100644
--- a/Kbuild
+++ b/Kbuild
@@ -47,12 +47,18 @@ $(rq-offsets-file): kernel/sched/rq-offsets.s FORCE
 
 # Check for missing system calls
 
+missing-syscalls-file := .tmp_missing-syscalls
+
+targets += $(missing-syscalls-file)
+
 quiet_cmd_syscalls = CALL    $<
-      cmd_syscalls = $(CONFIG_SHELL) $< $(CC) $(c_flags) $(missing_syscalls_flags)
+      cmd_syscalls = DEPFILE=$(depfile) $(CONFIG_SHELL) $< $(CC) $(c_flags) $(missing_syscalls_flags); touch $@
+
+$(missing-syscalls-file): scripts/checksyscalls.sh $(rq-offsets-file) FORCE
+	$(call if_changed_dep,syscalls)
 
 PHONY += missing-syscalls
-missing-syscalls: scripts/checksyscalls.sh $(rq-offsets-file)
-	$(call cmd,syscalls)
+missing-syscalls: $(missing-syscalls-file)
 
 # Check the manual modification of atomic headers
 
diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index 9becaf8d7b78..a6d0882f07e1 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -273,3 +273,8 @@ syscall_list() {
 
 (ignore_list && syscall_list ${reference_table}) | \
 $* -Wno-error -Wno-unused-macros -E -x c - > /dev/null
+
+# For fixdep
+if [ -n "${DEPFILE}" ]; then
+	echo "${0}: ${0} ${reference_table}" >> "${DEPFILE}"
+fi

-- 
2.53.0

