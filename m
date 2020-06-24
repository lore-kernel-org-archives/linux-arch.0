Return-Path: <SRS0=MbEv=AF=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388700AbgFXDbr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2020 23:31:47 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82704C0613ED
        for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2020 20:31:46 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i4so507972pjd.0
        for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2020 20:31:46 -0700 (PDT)
Date: Tue, 23 Jun 2020 20:31:42 -0700
From: Fangrui Song <maskray@google.com>
Subject: Re: [PATCH v3 3/9] efi/libstub: Remove .note.gnu.property
Message-ID: <20200624033142.cinvg6rbg252j46d@google.com>
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-4-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200624014940.1204448-4-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <20200624033142.qITlU5YkMUNDscG8_cLrg-Y5VHBPWf1nAOc31fKtdwg@z>

On 2020-06-23, Kees Cook wrote:
>In preparation for adding --orphan-handling=warn to more architectures,
>make sure unwanted sections don't end up appearing under the .init
>section prefix that libstub adds to itself during objcopy.
>
>Signed-off-by: Kees Cook <keescook@chromium.org>
>---
> drivers/firmware/efi/libstub/Makefile | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
>index 75daaf20374e..9d2d2e784bca 100644
>--- a/drivers/firmware/efi/libstub/Makefile
>+++ b/drivers/firmware/efi/libstub/Makefile
>@@ -66,6 +66,9 @@ lib-$(CONFIG_X86)		+= x86-stub.o
> CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
> CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
>
>+# Remove unwanted sections first.
>+STUBCOPY_FLAGS-y		+= --remove-section=.note.gnu.property
>+
> #
> # For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
> # .bss section, so the .bss section of the EFI stub needs to be included in the

arch/arm64/Kconfig enables ARM64_PTR_AUTH by default. When the config is on

ifeq ($(CONFIG_ARM64_BTI_KERNEL),y)
branch-prot-flags-$(CONFIG_CC_HAS_BRANCH_PROT_PAC_RET_BTI) := -mbranch-protection=pac-ret+leaf+bti
else
branch-prot-flags-$(CONFIG_CC_HAS_BRANCH_PROT_PAC_RET) := -mbranch-protection=pac-ret+leaf
endif

This option creates .note.gnu.property:

% readelf -n drivers/firmware/efi/libstub/efi-stub.o

Displaying notes found in: .note.gnu.property
   Owner                Data size        Description
   GNU                  0x00000010       NT_GNU_PROPERTY_TYPE_0
       Properties: AArch64 feature: PAC

If .note.gnu.property is not desired in drivers/firmware/efi/libstub, specifying
-mbranch-protection=none can override -mbranch-protection=pac-ret+leaf
