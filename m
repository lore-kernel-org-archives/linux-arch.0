From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] vsyscall: use __iter_div_u64_rem()
Date: Thu, 11 Jul 2019 22:55:16 +0200
Message-ID: <CAK8P3a3TfQnQsXzmktedsKaY7Tihue_PbLhLoD1z1jZBMTxWMg@mail.gmail.com>
References: <20190710130206.1670830-1-arnd@arndb.de> <33511b0e-6d7b-c156-c415-7a609b049567@arm.com>
 <CAK8P3a1EBaWdbAEzirFDSgHVJMtWjuNt2HGG8z+vpXeNHwETFQ@mail.gmail.com> <CAKwvOdkubvsRCnJKCaesB=PF=DgXfsBzwzR8kyE9NzWPU8Gehg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKwvOdkubvsRCnJKCaesB=PF=DgXfsBzwzR8kyE9NzWPU8Gehg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mips@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 11, 2019 at 7:14 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Thu, Jul 11, 2019 at 5:28 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > clang does not like an inline assembly with a "=q" contraint for
> > a 64-bit output:
>
> Seems like starting in GCC 7, GCC may not like it either:
> https://godbolt.org/z/UyBUfh
> it simply warns then proceeds with code gen.  Another difference may
> come from when GCC vs Clang perform dead code elimination (DCE) vs
> semantic analysis.

Right, I also had the idea to work around it with a set of
__builtin_choos_expr()
instead of the switch()/case but did not complete that patch as the percpu
code is rather complex and this would touch lots of code.

       Arnd
