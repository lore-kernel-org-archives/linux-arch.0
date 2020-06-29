From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v4 08/17] arm64/mm: Remove needless section quotes
Date: Mon, 29 Jun 2020 13:03:12 -0700
Message-ID: <9b7f9c3aed7223e49def6e775d3b250aa780e562.camel@perches.com>
References: <20200629061840.4065483-1-keescook@chromium.org>
         <20200629061840.4065483-9-keescook@chromium.org>
         <CAKwvOd=r6bsBfSZxVYrnbm1Utq==ApWBDjx+0Fxsm90Aq3Jghw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKwvOd=r6bsBfSZxVYrnbm1Utq==ApWBDjx+0Fxsm90Aq3Jghw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, linux-arch <linux-arch@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.in>
List-Id: linux-arch.vger.kernel.org

On Mon, 2020-06-29 at 12:53 -0700, Nick Desaulniers wrote:
> On Sun, Jun 28, 2020 at 11:18 PM Kees Cook <keescook@chromium.org> wrote:
> > Fix a case of needless quotes in __section(), which Clang doesn't like.
> > 
> > Acked-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Yep, I remember bugs from this.  Probably should scan the kernel for
> other instances of this.  +Joe for checkpatch.pl validation.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

$ git grep -P -n '__section\s*\(\s*\"'
arch/arm64/mm/mmu.c:45:u64 __section(".mmuoff.data.write") vabits_actual;
include/linux/compiler.h:211:   __section("___kentry" "+" #sym )                        \
include/linux/export.h:133:     static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
include/linux/srcutree.h:127:           __section("___srcu_struct_ptrs") = &name

My recollection is I submitted a patch
to _add_ quotes

https://lore.kernel.org/patchwork/patch/1125785/
