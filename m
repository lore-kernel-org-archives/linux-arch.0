From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 19/19] arm64: vdso32: Enable Clang Compilation
Date: Mon, 17 Feb 2020 16:46:09 +0000
Message-ID: <20200217164608.GA2708@willie-the-truck>
References: <20200213161614.23246-1-vincenzo.frascino@arm.com>
 <20200213161614.23246-20-vincenzo.frascino@arm.com>
 <20200213184454.GA4663@ubuntu-m2-xlarge-x86>
 <0cee3707-d526-3766-3dde-543c8dbd8e68@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0cee3707-d526-3766-3dde-543c8dbd8e68@arm.com>
Sender: linux-mips-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>, linux-arch@vger.kernel.org, ndesaulniers@google.com, 0x7f454c46@gmail.com, avagin@openvz.org, arnd@arndb.de, sboyd@kernel.org, catalin.marinas@arm.com, x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com, paul.burton@mips.com, mingo@redhat.com, bp@alien8.de, luto@kernel.org, linux@armlinux.org.uk, tglx@linutronix.de, salyzyn@android.com, pcc@google.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 17, 2020 at 12:26:16PM +0000, Vincenzo Frascino wrote:
> On 13/02/2020 18:44, Nathan Chancellor wrote:
> > On Thu, Feb 13, 2020 at 04:16:14PM +0000, Vincenzo Frascino wrote:
> >> Enable Clang Compilation for the vdso32 library.
> 
> [...]
> 
> >> +LD_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
> > 
> > Well this is unfortunate :/
> > 
> > It looks like adding the --target flag to VDSO_LDFLAGS allows
> > clang to link the vDSO just fine although it does warn that -nostdinc
> > is unused:
> > 
> > clang-11: warning: argument unused during compilation: '-nostdinc'
> > [-Wunused-command-line-argument]
> >
> 
> This is why ended up in this "unfortunate" situation :) I wanted to avoid the
> warning.
> 
> > It would be nice if the logic of commit fe00e50b2db8 ("ARM: 8858/1:
> > vdso: use $(LD) instead of $(CC) to link VDSO") could be adopted here
> > but I get that this Makefile is its own beast :) at the very least, I
> > think that the --target flag should be added to VDSO_LDFLAGS so that gcc
> > is not a requirement for this but I am curious if you tried that already
> > and noticed any issues with it.
> > 
> 
> --target is my preferred way as well, I can try to play another little bit with
> the flags and see what I can come up with in the next version.

Yes, please. I'd even prefer the warning rather than silently assuming that
a cross gcc is kicking around on the path.

Will
