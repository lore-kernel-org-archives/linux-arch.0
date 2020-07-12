Return-Path: <SRS0=hqH0=AX=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgGLSkq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Jul 2020 14:40:46 -0400
Date: Sun, 12 Jul 2020 11:40:41 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Message-ID: <20200712184041.GA1838@Ryzen-9-3900X.localdomain>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <671d8923-ed43-4600-2628-33ae7cb82ccb@molgen.mpg.de>
 <CA+icZUXPB_C1bjA13zi3OLFCpiZh+GsgHT0y6kumzVRavs4LkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+icZUXPB_C1bjA13zi3OLFCpiZh+GsgHT0y6kumzVRavs4LkQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, Clang-Built-Linux ML <clang-built-linux@googlegroups.com>, kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
Message-ID: <20200712184041.nxV2u7NmTemh79e0yP9ELNboUkPOluqOXd3KKiTAFis@z>

On Sun, Jul 12, 2020 at 10:59:17AM +0200, Sedat Dilek wrote:
> On Sat, Jul 11, 2020 at 6:32 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> >
> > Dear Sami,
> >
> >
> > Am 24.06.20 um 22:31 schrieb Sami Tolvanen:
> > > This patch series adds support for building x86_64 and arm64 kernels
> > > with Clang's Link Time Optimization (LTO).
> > >
> > > In addition to performance, the primary motivation for LTO is to allow
> > > Clang's Control-Flow Integrity (CFI) to be used in the kernel. Google's
> > > Pixel devices have shipped with LTO+CFI kernels since 2018.
> > >
> > > Most of the patches are build system changes for handling LLVM bitcode,
> > > which Clang produces with LTO instead of ELF object files, postponing
> > > ELF processing until a later stage, and ensuring initcall ordering.
> > >
> > > Note that first objtool patch in the series is already in linux-next,
> > > but as it's needed with LTO, I'm including it also here to make testing
> > > easier.
> >
> > […]
> >
> > Thank you very much for sending these changes.
> >
> > Do you have a branch, where your current work can be pulled from? Your
> > branch on GitHub [1] seems 15 months old.
> >
> 
> Agreed it's easier to git-pull.
> I have seen [1] - not sure if this is the latest version.
> Alternatively, you can check patchwork LKML by searching for $submitter.
> ( You can open patch 01/22 and download the whole patch-series by
> following the link "series", see [3]. )
> 
> - Sedat -
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/log/?h=lto
> [2] https://lore.kernel.org/patchwork/project/lkml/list/?series=&submitter=19676
> [3] https://lore.kernel.org/patchwork/series/450026/mbox/
> 

Sami tagged this series on his GitHub:

https://github.com/samitolvanen/linux/releases/tag/lto-v1

git pull https://github.com/samitolvanen/linux lto-v1

Otherwise, he is updating the clang-cfi branch that includes both the
LTO and CFI patchsets. You can pull that and just turn on
CONFIG_LTO_CLANG.

Lastly, for the future, I would recommend grabbing b4 to easily apply
patches (specifically full series) from lore.kernel.org.

https://git.kernel.org/pub/scm/utils/b4/b4.git/
https://git.kernel.org/pub/scm/utils/b4/b4.git/tree/README.rst

You could grab this series and apply it easily by either downloading the
mbox file and following the instructions it gives for applying the mbox
file:

$ b4 am 20200624203200.78870-1-samitolvanen@google.com

or I prefer piping so that I don't have to clean up later:

$ b4 am -o - 20200624203200.78870-1-samitolvanen@google.com | git am

Cheers,
Nathan
