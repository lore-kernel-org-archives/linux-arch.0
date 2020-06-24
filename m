From: Fangrui Song <maskray@google.com>
Subject: Re: [PATCH v3 3/9] efi/libstub: Remove .note.gnu.property
Date: Tue, 23 Jun 2020 20:31:42 -0700
Message-ID: <20200624033142.cinvg6rbg252j46d@google.com>
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-4-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200624014940.1204448-4-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
