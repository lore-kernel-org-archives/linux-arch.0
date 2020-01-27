From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Date: Mon, 27 Jan 2020 08:26:03 +0100
Message-ID: <CAK8P3a2P41JjO8=GTSVL9WVEfjA_M+StH7Ons27SqSNK2JOrHg@mail.gmail.com>
References: <20200123153341.19947-1-will@kernel.org> <26ad7a8a975c4e06b44a3184d7c86e5f@AcuMS.aculab.com>
 <20200123171641.GC20126@willie-the-truck> <2bfe2be6da484f15b0d229dd02d16ae6@AcuMS.aculab.com>
 <CAKwvOdkFGTeVQPm8Z3Y7mQ-=6d5CFxmEJ+hBb8ns2r2H1cb0hQ@mail.gmail.com>
 <20200123190125.GA2683468@rani.riverdale.lan> <20200126010959.vhq7mg4esoq5w26j@e107158-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:37505 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgA0H0V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jan 2020 02:26:21 -0500
In-Reply-To: <20200126010959.vhq7mg4esoq5w26j@e107158-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Qais Yousef <qais.yousef@arm.com>
Cc: Arvind Sankar <nivedita@alum.mit.edu>, Nick Desaulniers <ndesaulniers@google.com>, David Laight <David.Laight@aculab.com>, Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "kernel-team@android.com" <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>

On Sun, Jan 26, 2020 at 2:10 AM Qais Yousef <qais.yousef@arm.com> wrote:
> On 01/23/20 14:01, Arvind Sankar wrote:
> > On Thu, Jan 23, 2020 at 10:45:08AM -0800, Nick Desaulniers wrote:
> > > On Thu, Jan 23, 2020 at 9:32 AM David Laight <David.Laight@aculab.com> wrote:
> >
> > Reposting Arnd's link
> > https://www.spinics.net/lists/linux-kbuild/msg23648.html
>
> This list seems to be x86 centric? I remember when the switch to GCC 4.6
> happened a couple or more archs had to be dropped because they lacked a newer
> compiler.

There are two architectures that already had problems last time:

- unicore32 never had any compiler that shipped with sources, only an ancient
  set of gcc binaries that already had problems building the kernel during the
  move to gcc-4.6. The maintainer said he'd work on providing support for
  modern gcc or clang, but I don't think anything came out of that.

- hexagon had an unmaintained gcc-4.5 port, but internally Qualcomm were
  already using clang to build their kernels, which should now work with the
  upstream version. I don't think there are any plans to have a more modern
  gcc.

Everything else works with mainline gcc now, openrisc and csky were the
last to get added in gcc-9.

Some of the older sub-targets (armv3, s390-g6, powerpcspe) are removed
in gcc-9, but these have a few more years before we need to worry about
them.

     Arnd
