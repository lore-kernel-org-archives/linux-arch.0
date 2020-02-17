From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 19/19] arm64: vdso32: Enable Clang Compilation
Date: Mon, 17 Feb 2020 23:39:53 +0100
Message-ID: <CAKv+Gu8Qh495twz-3UQrFiKfPq-Kt_o+JrCNwEcdMedV2DqPEA@mail.gmail.com>
References: <20200213161614.23246-1-vincenzo.frascino@arm.com>
 <20200213161614.23246-20-vincenzo.frascino@arm.com> <20200213184454.GA4663@ubuntu-m2-xlarge-x86>
 <0cee3707-d526-3766-3dde-543c8dbd8e68@arm.com> <20200217164608.GA2708@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200217164608.GA2708@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 0x7f454c46@gmail.com, linux-mips@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, clang-built-linux <clang-built-linux@googlegroups.com>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Nathan Chancellor <natechancellor@gmail.com>, pcc@google.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, avagin@openvz.org, Stephen Boyd <sboyd@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>Linux Kernel Mailing List <lin>
List-Id: linux-arch.vger.kernel.org

On Mon, 17 Feb 2020 at 17:46, Will Deacon <will@kernel.org> wrote:
>
> On Mon, Feb 17, 2020 at 12:26:16PM +0000, Vincenzo Frascino wrote:
> > On 13/02/2020 18:44, Nathan Chancellor wrote:
> > > On Thu, Feb 13, 2020 at 04:16:14PM +0000, Vincenzo Frascino wrote:
> > >> Enable Clang Compilation for the vdso32 library.
> >
> > [...]
> >
> > >> +LD_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
> > >
> > > Well this is unfortunate :/
> > >
> > > It looks like adding the --target flag to VDSO_LDFLAGS allows
> > > clang to link the vDSO just fine although it does warn that -nostdinc
> > > is unused:
> > >
> > > clang-11: warning: argument unused during compilation: '-nostdinc'
> > > [-Wunused-command-line-argument]
> > >
> >
> > This is why ended up in this "unfortunate" situation :) I wanted to avoid the
> > warning.
> >
> > > It would be nice if the logic of commit fe00e50b2db8 ("ARM: 8858/1:
> > > vdso: use $(LD) instead of $(CC) to link VDSO") could be adopted here
> > > but I get that this Makefile is its own beast :) at the very least, I
> > > think that the --target flag should be added to VDSO_LDFLAGS so that gcc
> > > is not a requirement for this but I am curious if you tried that already
> > > and noticed any issues with it.
> > >
> >
> > --target is my preferred way as well, I can try to play another little bit with
> > the flags and see what I can come up with in the next version.
>
> Yes, please. I'd even prefer the warning rather than silently assuming that
> a cross gcc is kicking around on the path.
>

Doesn't Clang have -Qunused-arguments for that?
