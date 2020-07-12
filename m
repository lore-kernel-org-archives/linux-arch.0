From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Date: Sun, 12 Jul 2020 10:59:17 +0200
Message-ID: <CA+icZUXPB_C1bjA13zi3OLFCpiZh+GsgHT0y6kumzVRavs4LkQ@mail.gmail.com>
References: <20200624203200.78870-1-samitolvanen@google.com> <671d8923-ed43-4600-2628-33ae7cb82ccb@molgen.mpg.de>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <671d8923-ed43-4600-2628-33ae7cb82ccb@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, Clang-Built-Linux ML <clang-built-linux@googlegroups.com>, kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat, Jul 11, 2020 at 6:32 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Sami,
>
>
> Am 24.06.20 um 22:31 schrieb Sami Tolvanen:
> > This patch series adds support for building x86_64 and arm64 kernels
> > with Clang's Link Time Optimization (LTO).
> >
> > In addition to performance, the primary motivation for LTO is to allow
> > Clang's Control-Flow Integrity (CFI) to be used in the kernel. Google's
> > Pixel devices have shipped with LTO+CFI kernels since 2018.
> >
> > Most of the patches are build system changes for handling LLVM bitcode,
> > which Clang produces with LTO instead of ELF object files, postponing
> > ELF processing until a later stage, and ensuring initcall ordering.
> >
> > Note that first objtool patch in the series is already in linux-next,
> > but as it's needed with LTO, I'm including it also here to make testing
> > easier.
>
> [=E2=80=A6]
>
> Thank you very much for sending these changes.
>
> Do you have a branch, where your current work can be pulled from? Your
> branch on GitHub [1] seems 15 months old.
>

Agreed it's easier to git-pull.
I have seen [1] - not sure if this is the latest version.
Alternatively, you can check patchwork LKML by searching for $submitter.
( You can open patch 01/22 and download the whole patch-series by
following the link "series", see [3]. )

- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.=
git/log/?h=3Dlto
[2] https://lore.kernel.org/patchwork/project/lkml/list/?series=3D&submitte=
r=3D19676
[3] https://lore.kernel.org/patchwork/series/450026/mbox/
