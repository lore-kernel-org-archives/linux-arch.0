From: =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Subject: Re: [PATCH v2 1/3] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Date: Mon, 22 Jun 2020 16:04:40 -0700
Message-ID: <CAFP8O3KdGc9TtziFX7UzmxA-=wfPzm5oi6NCEwRiyyrp+JD3Xg@mail.gmail.com>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-2-keescook@chromium.org> <20200622220043.6j3vl6v7udmk2ppp@google.com>
 <202006221524.CEB86E036B@keescook> <20200622225237.ybol4qmz4mhkmlqc@google.com>
 <202006221555.45BB6412F@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <202006221555.45BB6412F@keescook>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, clang-built-linux <clang-built-linux@googlegroups.com>, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jun 22, 2020 at 3:57 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 22, 2020 at 03:52:37PM -0700, Fangrui Song wrote:
> > > And it's not in the output:
> > >
> > > $ readelf -Vs arch/x86/boot/compressed/vmlinux | grep version
> > > No version information found in this file.
> > >
> > > So... for the kernel we need to silence it right now.
> >
> > Re-link with -M (or -Map file) to check where .gnu.version{,_d,_r} input
> > sections come from?
>
> It's not reporting it correctly:
>
> .gnu.version_d  0x00000000008966b0        0x0
>  .gnu.version_d
>                 0x00000000008966b0        0x0 arch/x86/boot/compressed/kernel_info.o
>
> .gnu.version    0x00000000008966b0        0x0
>  .gnu.version   0x00000000008966b0        0x0 arch/x86/boot/compressed/kernel_info.o
>
> .gnu.version_r  0x00000000008966b0        0x0
>  .gnu.version_r
>                 0x00000000008966b0        0x0 arch/x86/boot/compressed/kernel_info.o
>
> it just reports whatever file is listed on the link command line first.
>
> > If it is a bug, we should probably figure out which version of binutils
> > has fixed the bug.
>
> I see this with binutils 2.34...
>
> --
> Kees Cook

:( It deserves a binutils bug
(https://sourceware.org/bugzilla/enter_bug.cgi?product=binutils ) and
a comment..

With the description adjusted to say that this works around a bug

Reviewed-by: Fangrui Song <maskray@google.com>
