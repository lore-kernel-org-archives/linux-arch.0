From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 1/9] scripts/link-vmlinux.sh: Delay orphan handling warnings until final link
Date: Thu, 27 Feb 2020 16:22:36 -0800
Message-ID: <20200228002244.15240-2-keescook@chromium.org>
References: <20200228002244.15240-1-keescook@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46531 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730115AbgB1AWv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 19:22:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id y8so474763pll.13
        for <linux-arch@vger.kernel.org>; Thu, 27 Feb 2020 16:22:50 -0800 (PST)
In-Reply-To: <20200228002244.15240-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@suse.de>
Cc: Kees Cook <keescook@chromium.org>, "H.J. Lu" <hjl.tools@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org

Right now, powerpc adds "--orphan-handling=warn" to LD_FLAGS_vmlinux
to detect when there are unexpected sections getting added to the kernel
image. There is no need to report these warnings more than once, so it
can be removed until the final link stage.

This helps pave the way for other architectures to enable this, with the
end goal of enabling this warning by default for vmlinux for all
architectures.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/link-vmlinux.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 1919c311c149..416968fea685 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -255,6 +255,11 @@ info GEN modules.builtin
 tr '\0' '\n' < modules.builtin.modinfo | sed -n 's/^[[:alnum:]:_]*\.file=//p' |
 	tr ' ' '\n' | uniq | sed -e 's:^:kernel/:' -e 's/$/.ko/' > modules.builtin
 
+
+# Do not warn about orphan sections until the final link stage.
+saved_LDFLAGS_vmlinux="${LDFLAGS_vmlinux}"
+LDFLAGS_vmlinux="$(echo "${LDFLAGS_vmlinux}" | sed -E 's/ --orphan-handling=warn( |$)/ /g')"
+
 btf_vmlinux_bin_o=""
 if [ -n "${CONFIG_DEBUG_INFO_BTF}" ]; then
 	if gen_btf .tmp_vmlinux.btf .btf.vmlinux.bin.o ; then
@@ -306,6 +311,7 @@ if [ -n "${CONFIG_KALLSYMS}" ]; then
 	fi
 fi
 
+LDFLAGS_vmlinux="${saved_LDFLAGS_vmlinux}"
 vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o}
 
 if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
-- 
2.20.1
