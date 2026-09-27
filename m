Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76F93FBB4E;
	Sun, 27 Sep 2026 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790525559; cv=none; b=MVTxsTGDigF34+h0QDxLe1o9mPZwCBovN+2bZGRk56OM0GFyeS1/7+BSBofb3IYbi40sXX2iD7vm7391gR4a3RioXbiSXtYu4LREUXc8b8gOMLVnb7TX9K5Kd7vB/+BqFZpgnjx34p9nb5u/SmD031RcEIKgOORQ3yZmUREKgKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790525559; c=relaxed/simple;
	bh=C3THL3Iz046trd3juNqaE0PsDeKlQD2ZgH9xNJrC9EY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UMAlhPDKSkET8H8/RmaHoyx/L2AzudEmSezuMFxXxCdpvT42bzYUvktp89FsVj0Mh0bfVwgU8c869BmEnfKEmN9DWCodSQ73wr/WvyIfYvdhpRgDIdEZaRv6PBPChwnc6l5KZFUSuP7DNmBw5hgCwEDUSCSP+lINhPNp8dmpcUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UG9gkFmd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UG9gkFmd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBA01F000FF;
	Sun, 27 Sep 2026 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790525557;
	bh=kiNSYcUIUm9Q3qDLHPDm+UZix7J/g9csY2BVO2Z894k=;
	h=From:To:Cc:Subject:Date;
	b=UG9gkFmdePHNVQdcQmyTzppw0Ox/MtUpktvkAYb1FGK2AfqS3T1XmMcx85BhtY7L4
	 +skhj48wzOYhCuvEcAFU1jQ6MsXNi596RqKUMz3izLvwA9d1qZi85NG3nn3UvFaWWA
	 rFfXmIeipcLhEwHQ6cvvMlSV6NryzmEoxrooqZH/FhxUKkt+Q1MBLx2qKuIbj2OQzy
	 TDzlpfcQ9Y2GqHjypK5RaGROtnYsg9qWuWxVt7NRMg0iGO6s1xJaX5u1ffo4MWUbkW
	 mAyBwA2XJgTqEqKcgod2mWs9tO4UwDdim5TGwckfErFtD/5Ldk1tNIlcNZ7XY4u+mN
	 IpvAnYQmNlDNQ==
From: Sasha Levin <sashal@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Alexey Gladkov <legion@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] kbuild: keep .modinfo when vmlinux is linked with --gc-sections
Date: Sun, 27 Sep 2026 12:12:27 -0400
Message-ID: <20260927161227.1179863-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Builds with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y, such as arm
allmodconfig, now fail while extracting modules.builtin.modinfo:

  arm-linux-gnueabihf-objcopy: vmlinux.unstripped: can't dump section
  '.modinfo' - it does not exist: file format not recognized
  /bin/sh: 1: cannot open modules.builtin.modinfo: No such file

or, with LLVM:

  llvm-objcopy: error: 'vmlinux.unstripped': section '.modinfo' not
  found

Nothing references the MODULE_INFO() strings, so --gc-sections
discards every .modinfo input section and vmlinux.unstripped ends up
with no .modinfo data. This is not new: ever since
modules.builtin.modinfo started being extracted from
vmlinux.unstripped, these builds have silently produced an empty
file, losing the modinfo of every built-in module. An arm
multi_v7_defconfig build with LD_DEAD_CODE_DATA_ELIMINATION on current
mainline yields a 0 byte modules.builtin.modinfo. The switch to
--dump-section only turned that into a build error.

Wrap the input section in KEEP() so that the linker retains it. The
output section is still (INFO), so nothing is allocated for it. With
the same arm config, modules.builtin.modinfo now has 14119 entries,
and on x86_64 defconfig, where nothing is garbage collected, it is
byte-identical before and after this change.

Found by KernelCI builds of the linus-next tree.

Fixes: 39cfd5b12160 ("kbuild: extract modules.builtin.modinfo from vmlinux.unstripped")
Fixes: 5fe4dd596641 ("kbuild: do not allocate .modinfo in vmlinux")
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index a6730d34e8c67..7a3e9f00d6283 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -855,7 +855,7 @@
 		KLP_SYMID
 
 #define MODINFO								\
-		.modinfo (INFO) : { *(.modinfo) }
+		.modinfo (INFO) : { KEEP(*(.modinfo)) }
 
 #ifdef CONFIG_GENERIC_BUG
 #define BUG_TABLE							\
-- 
2.53.0

