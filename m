Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587370;
	b=YErQPUP9wrPTdFP5ZLOItZgXuXRTUzO+NPr3qc6f13NSXPFLmgsz7eb3XiiV7a4rLVjH
	 k52l5k4b8oiVFcYE8F+UrzT/1zg9U2kisfKs3Emu9GGDPUcLFuwLn783ruEiZlXQk/NGU
	 54WIq1B74ixDZjpnL11n/sCNnuxDfEyc1EWHy920LAfWopra0Y22gAnp7WAxkChQNYqkY
	 59cS8cTYLf+vbvgi80GKHNY3fLDVrZ52v+gPiHEPTUHQDYBDNIo26ppXW0woXwCrdZC8e
	 S3sEvXKQ80/TX1ShxrMXw6/aPSkXc2iRwLYKSc0KjUOiPz3hPUseKN0ZmCX7BwfHgNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ZvfWqaB0nFxucxNwNfxUIvrX7JKFCnM6p4UbWiRwSLk=;
	b=tLFOg5HUHjk5OSE5gFwI8RErMjUVsFn5BPakmLrAuouybeePbyeWb4G4CgwWNb6rEAFf
	 /odZws2zuk1qu/l7kUUVOuEMHq+3HyMcBfobfFd4gavbVVZ60GNPUUMa3Mx/Ev5RPh2Jd
	 UiYAiJMYn32zq0H1b14Gp2yKEsDSrrCQ+QxTqwlIRFgMbHO7U9IDJ8uvvOzz+tNgNY4U/
	 tGgv2veCMJ/vzap6FOuh8XOukFGk7t81Ue6j66cLWJlkIjBDs+pB6Qmyj9iR8QCvUZMDB
	 xlaTAzWl+DdmPicgAMi8XdxecyaXsYSSFFp76KcfU6DBbIEIxuyP0Q1/YN+b2lOjZ7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dqUm0cNE;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7F0606E978
	for <linux-arch@vger.kernel.org>; Wed, 25 Nov 2026 06:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC7F0606E978
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dqUm0cNE
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3846d5f54c1so6513479eec.1
        for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2026 22:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795587369; x=1796192169; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZvfWqaB0nFxucxNwNfxUIvrX7JKFCnM6p4UbWiRwSLk=;
        b=dqUm0cNErgaRAEUPYJQ+C2aQeBVECFULmkK7SyU1jw89xHBayxTsokr7FednalnuQl
         LF43lcFwo5l+qx62UerhTqZJ5kksYPoSwn+pbJD09YMY2Rgqs2aEuf0JLinvNoEsFbIU
         tMkdw3PvUDnaQ71k9tDeX8o1WZB48up/i04Sn3qtRx9Wzdge2XbmwICpSmwi6zvEKF5Y
         3Z+TVSg0w6scWjNRHOsPXW0WAJ5g5SdwfOvXFNNQjQZiw6ntchczB+2E2aMQZzsRS1bJ
         k+xDdsowoIN4qZcla7yehfclkvTvQOjwUuuHHKEGWUKmupVMGrrg2jXfw8lH9eqqmPSV
         aAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587369; x=1796192169;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZvfWqaB0nFxucxNwNfxUIvrX7JKFCnM6p4UbWiRwSLk=;
        b=TdBO5VahS6fd2SOQNgnpUfMUgDe07EpDpXNHd+rhmVStJDB4w7JXZz6+ylu5LRaULj
         OLXR737EdaeTixI00g5mGa0IPRadmO8p+wegRMNZycx0xwyp7VTCTetSSIMoJnNtDcgh
         1lVR4y637c//ul5x7hAwTVR1VdCJFFylpmycXmszn4SqOJUtUfDFYTarF56bfoPeLRWa
         vwrt13ySTnQ9H9md2PuCT2EpJjiInwW8AvvXVaZljxt6f5Q/3kPVI3hC4il2cYYVZM7h
         gO9h/LjMdm13Tq3+Jgl6XyCKed8AVpowM23LfdNYWPDLi1NtjawS0nkViJI/823rv+/u
         Li8A==
X-Forwarded-Encrypted: i=1; AL+hErEOSdd6p7qed35DW9KJY3RTgnSoHHtI5nxjJXH+U/2rNZRKZkw9vJau3Nx3VdNEQgQ5KTpJmICtSfyj@vger.kernel.org
X-Gm-Message-State: APuU4Z/dcrp11VsJ/HOef5QjNHyhZdh09UcmOfJudzxEt4VhzDVRV3o+
	EphrdJCKNb7llovPxmpPZeEyHdTiJ3L5bvO4ygQN54D0mVvTadV0wqRMQkvFnRryhk3JiSrDCjU
	QziaZcFF8xQ==
X-Received: from dyblf45.prod.google.com ([2002:a05:7301:a2d:b0:375:861c:512e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8953:20b0:386:a70b:75dc
 with SMTP id 5a478bee46e88-386a70b7837mr10351275eec.11.1795587368701; Tue, 24
 Nov 2026 22:16:08 -0800 (PST)
Date: Tue, 24 Nov 2026 22:14:59 -0800
In-Reply-To: <20261125061523.1540234-1-irogers@google.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125061523.1540234-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125061523.1540234-7-irogers@google.com>
Subject: [RFC PATCH v2 06/30] kbuild: Wire up CONFIG_UNWINDER_DWARF_CFI_MINIFY
 object pass
From: Ian Rogers <irogers@google.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org
Cc: jpoimboe@kernel.org, rostedt@goodmis.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	nathan@kernel.org, llvm@lists.linux.dev, nsc@kernel.org, 
	linux-kbuild@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardb@kernel.org, linux-efi@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, indu.bhagat@oracle.com, jremus@linux.ibm.com, 
	wnliu@google.com, dylanbhatch@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Invoke scripts/min_eh_frame on standard kernel C, Rust, and post-LTO
composite .o objects when CONFIG_UNWINDER_DWARF_CFI_MINIFY is enabled,
recording scripts/min_eh_frame as a rebuild dependency in .*.cmd files.

Across full vmlinux builds on x86-64, ARM64, and RISC-V, minification
achieves 100.00% FDE coverage and reduces .eh_frame size 18%-28% below
SFrame v3 (.sframe).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 rust/Makefile              |  4 +++-
 scripts/Makefile.build     | 12 ++++++++++--
 scripts/Makefile.lib       | 13 +++++++++++--
 scripts/Makefile.vmlinux_o |  8 +++++++-
 4 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 0165626decbe..1238b4ac661d 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -668,7 +668,8 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
 		$(CC_FLAGS_RUST_INLINE_HELPERS) -Wno-override-module -c $(patsubst %.o,%.m.bc,$@) -o $@ \
 		$(cmd_ld_single)) \
 	$(if $(rustc_objcopy),;$(OBJCOPY) $(rustc_objcopy) $@) \
-	$(cmd_objtool)
+	$(cmd_objtool) \
+	$(cmd_min_eh_frame)
 
 rust-analyzer:
 	$(Q)MAKEFLAGS= $(srctree)/scripts/generate_rust_analyzer.py \
@@ -721,6 +722,7 @@ endif
 define rule_rustc_library
 	$(call cmd_and_fixdep,rustc_library)
 	$(call cmd,gen_objtooldep)
+	$(call cmd,gen_min_eh_framedep)
 	$(call cmd,gendwarfksyms)
 endef
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 6127feb970c6..ced0f630f566 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -281,6 +281,10 @@ ifdef CONFIG_OBJTOOL
 $(obj)/%.o: private objtool-enabled = $(if $(is-standard-object),$(if $(delay-objtool),$(is-single-obj-m),y))
 endif
 
+ifdef CONFIG_UNWINDER_DWARF_CFI_MINIFY
+$(obj)/%.o: private min-eh-frame-enabled = $(if $(filter-out scripts/mod/empty.o,$@),$(is-standard-object))
+endif
+
 ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
 cmd_warn_shared_object = $(if $(word 2, $(modname-multi)),$(warning $(kbuild-file): $*.o is added to multiple modules: $(modname-multi)))
 endif
@@ -371,11 +375,13 @@ quiet_cmd_rustc_o_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
 		$(CC) $(CLANG_FLAGS) $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS)) \
 		$(CC_FLAGS_RUST_INLINE_HELPERS) -Wno-override-module -c $(patsubst %.o,%.m.bc,$@) -o $@ \
 		$(cmd_ld_single)) \
-	$(cmd_objtool)
+	$(cmd_objtool) \
+	$(cmd_min_eh_frame)
 
 define rule_rustc_o_rs
 	$(call cmd_and_fixdep,rustc_o_rs)
 	$(call cmd,gen_objtooldep)
+	$(call cmd,gen_min_eh_framedep)
 endef
 
 $(obj)/%.o: $(obj)/%.rs FORCE
@@ -518,14 +524,16 @@ $(obj)/lib.a: $(lib-y) FORCE
 	$(call if_changed,ar)
 
 quiet_cmd_ld_multi_m = LD [M]  $@
-      cmd_ld_multi_m = $(LD) $(ld_flags) -r -o $@ @$< $(cmd_objtool)
+      cmd_ld_multi_m = $(LD) $(ld_flags) -r -o $@ @$< $(cmd_objtool) $(cmd_min_eh_frame)
 
 define rule_ld_multi_m
 	$(call cmd_and_savecmd,ld_multi_m)
 	$(call cmd,gen_objtooldep)
+	$(call cmd,gen_min_eh_framedep)
 endef
 
 $(multi-obj-m): private objtool-enabled := $(delay-objtool)
+$(multi-obj-m): private min-eh-frame-enabled := $(CONFIG_LTO_CLANG)
 $(multi-obj-m): private part-of-module := y
 $(multi-obj-m): %.o: %.mod FORCE
 	$(call if_changed_rule,ld_multi_m)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 19e96b30a122..b27bcd50daf7 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -222,6 +222,12 @@ objtool-enabled := y
 
 endif # CONFIG_OBJTOOL
 
+ifdef CONFIG_UNWINDER_DWARF_CFI_MINIFY
+min_eh_frame := $(objtree)/scripts/min_eh_frame
+cmd_min_eh_frame = $(if $(min-eh-frame-enabled), ; $(min_eh_frame) $@)
+cmd_gen_min_eh_framedep = $(if $(min-eh-frame-enabled), { echo ; echo '$@: $$(wildcard $(min_eh_frame))' ; } >> $(dot-target).cmd)
+endif
+
 # Useful for describing the dependency of composite objects
 # Usage:
 #   $(call multi_depend, multi_used_targets, suffix_to_remove, suffix_to_add)
@@ -265,7 +271,8 @@ endif
 quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
       cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $< \
 		$(cmd_ld_single) \
-		$(cmd_objtool)
+		$(cmd_objtool) \
+		$(cmd_min_eh_frame)
 
 define rule_cc_o_c
 	$(call cmd_and_fixdep,cc_o_c)
@@ -273,17 +280,19 @@ define rule_cc_o_c
 	$(call cmd,checksrc)
 	$(call cmd,checkdoc)
 	$(call cmd,gen_objtooldep)
+	$(call cmd,gen_min_eh_framedep)
 	$(call cmd,gen_symversions_c)
 	$(call cmd,record_mcount)
 	$(call cmd,warn_shared_object)
 endef
 
 quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
-      cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $< $(cmd_objtool)
+      cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $< $(cmd_objtool) $(cmd_min_eh_frame)
 
 define rule_as_o_S
 	$(call cmd_and_fixdep,as_o_S)
 	$(call cmd,gen_objtooldep)
+	$(call cmd,gen_min_eh_framedep)
 	$(call cmd,gen_symversions_S)
 	$(call cmd,warn_shared_object)
 endef
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 0b37bd5dc3a4..160d43fbb393 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -52,6 +52,10 @@ vmlinux-objtool-args-$(if $(KLP_SYMIDS),y)		+= --klp-symids
 
 objtool-args = $(vmlinux-objtool-args-y) --link
 
+ifdef CONFIG_UNWINDER_DWARF_CFI_MINIFY
+min-eh-frame-enabled := $(CONFIG_LTO_CLANG)
+endif
+
 # Link of vmlinux.o used for section mismatch analysis
 # ---------------------------------------------------------------------------
 
@@ -64,13 +68,15 @@ quiet_cmd_ld_vmlinux.o = LD      $@
 	$(addprefix -T , $(initcalls-lds)) \
 	--whole-archive vmlinux.a --no-whole-archive \
 	--start-group $(KBUILD_VMLINUX_LIBS) --end-group \
-	$(cmd_objtool)
+	$(cmd_objtool) \
+	$(cmd_min_eh_frame)
 
 cmd_check_function_names = $(srctree)/scripts/check-function-names.sh $@
 
 define rule_ld_vmlinux.o
 	$(call cmd_and_savecmd,ld_vmlinux.o)
 	$(call cmd,gen_objtooldep)
+	$(call cmd,gen_min_eh_framedep)
 	$(call cmd,check_function_names)
 endef
 
-- 
2.56.1.831.g720f3f5937-goog

