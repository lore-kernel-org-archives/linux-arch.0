Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45251 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932942AbeBVPpI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Feb 2018 10:45:08 -0500
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 22 Feb 2018 16:45:06 +0100
Message-ID: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
Subject: Removing architectures without upstream gcc support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>

While building the cross-toolchains, I noticed that overall, we can build almost
all linux target architectures with upstream binutils and gcc these days,
however there are still some exceptions, and I'd like to find out if anyone
has objections to removing the ones that do not have upstream support.
This are the four architectures I found:

* score (s+core, sunplus core) was a proprietary RISC architecture
  made by sunplus. It is unclear if they still ship any products based on
  this architecture, all they list is either ARM Cortex-A9 or an unspecified
  RISC core that could be any of arm, mips, nds32, arc, xtensa or
  something completely different. The two maintainers have both left the
  company many years ago and have not contributed any patches in
  at least five years. There was an upstream gcc port, which was marked
  'obsolete' in 2013 and got removed in gcc-5.0.
  I conclude that this is dead in Linux and can be removed

* unicore32 was a research project at Peking University with a SoC
  based on the Intel PXA design. No gcc source code has ever been
  published, the only toolchain available is a set of binaries that include
  a gcc-4.4 compiler. The project page at
  http://mprc.pku.edu.cn/~guanxuetao/linux/ has a TODO list that has
  not been modified since 2011. The maintainer still Acks patches
  and has last sent a pull request in 2014 and last sent a patch of
  his own in 2012 when the project appears to have stalled.
  I would suggest removing this one.

* Hexagon is Qualcomm's DSP architecture. It is being actively used
  in all Snapdragon ARM SoCs, but the kernel code appears to be
  the result of a failed research project to make a standalone Hexagon
  SoC without an ARM core. There is some information about the
  project at https://wiki.codeaurora.org/xwiki/bin/Hexagon/ and
  https://unix.stackexchange.com/questions/246243/what-is-was-the-qualcomm-hexagon-comet-board
  There is a port to gcc-4.5 on the project page, which is evidently
  abandoned, but there is an active upstream LLVM port that is
  apparently used to build non-Linux programs.
  I would consider this one a candidate for removal as well, given that
  there were never any machines outside of Qualcomm that used this,
  and they are no longer interested themselves.

* Meta was ImgTec's own architecture and they upstreamed the kernel
  port just before they acquired MIPS. Apparently Meta was abandoned
  shortly afterwards and disappeared from imgtec's website in 2014.
  The maintainer is still fixing bugs in the port, but I could not find
  any toolchain more recent than
  https://github.com/img-meta/metag-buildroot/tree/metag-core/toolchain/gcc/4.2.4
  Not sure about this one, I'd be interested in more background
  from James Hogan, who probably has an opinion and might have
  newer toolchain sources.

* OpenRISC is a RISC architecture with a free license and an
  active community. It seems to have lost a bit of steam after RISC-V
  is rapidly taking over that niche, but there are chips out there and
  the design isn't going away. Listing it here for completeness only
  because there is no upstream gcc port yet, but this will hopefully
  change in the future based on
  https://lists.librecores.org/pipermail/openrisc/2018-January/000958.html
  and I had no problems locating the gcc-7.x tree for building my
  toolchains. The port is actively being maintained.

There are also a couple of architectures that are more or less
unmaintained but do have working gcc support: FR-V and M32R
have been orphaned for a while and are not getting updated
MN10300 is still maintained officially by David Howells but doesn't
seem any more active than the other two, the last real updates were
in 2013.

       Arnd
