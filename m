From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: jump_label: move 'asm goto' support test to Kconfig
Date: Wed, 2 Jan 2019 13:14:18 +0100
Message-ID: <CA+icZUU=1S0Xg3+zWNU-60eknfWyL2kjEPm2BNNTK8Eu-tkTEg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: masahiroy@kernel.org
Cc: linux-kbuild@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "David S . Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
List-Id: linux-arch.vger.kernel.org

Hi,

I was not aware that CONFIG_JUMP_LABEL Kconfig setting depends on the
support of asm-goto.

Currently, I am doing experiments with clang-7 and a snapshot of
clang-8 on Linux/x86.
These compilers have no asm-goto support.

What is your recommendation for Linux >= v4.20?
I am asking as it is possible to set CONFIG_JUMP_LABEL=y when
compiling with clang - which has no effect.
This is confusing.

Thanks, this patch makes things clearer and protects users from
setting "wrong" in the sense of non-functional settings.

I have tested this against recent Linus tree where kbuild/kconfig Git
pulls were latest commits.

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> [ x86 with LLVM/Clang
v7 and v8 (snapshot) ]

Thanks.

Regards,
- Sedat -
