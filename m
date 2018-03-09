Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:44637 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751060AbeCIMzM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Mar 2018 07:55:12 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.85)
          for linux-arch@vger.kernel.org with esmtps (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id <1euHYF-003GRC-Cg>; Fri, 09 Mar 2018 13:55:11 +0100
Received: from suse-laptop.physik.fu-berlin.de ([160.45.32.140])
          by inpost2.zedat.fu-berlin.de (Exim 4.85)
          for linux-arch@vger.kernel.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id <1euHYF-002hRj-3I>; Fri, 09 Mar 2018 13:55:11 +0100
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Debian Ports architecture status (Re: Re: Removing architectures
 without upstream gcc support)
Message-ID: <fbfb535b-65ac-4b16-469a-9ccc9cb5e714@physik.fu-berlin.de>
Date: Fri, 9 Mar 2018 13:55:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch <linux-arch@vger.kernel.org>


Hi!

A quick follow up on the discussion started by Arnd regarding the removal of
old or unmaintained architectures from the mainline kernel [1].

Debian has unofficial releases for various old or exotic architectures like
alpha, m68k or sparc64. Fresh installation images are built on a regular basis
and allow the installation of Debian unstable on these architectures with
a recent kernel version [2].

We are running buildds - i.e machines building Debian packages - for all
the architectures that can be seen in [3]. The buildds are running a current
release of Debian with recent kernels. The cross-buildds for m68k, sh4
and x32 are currently running Debian Jessie, but they will be upgraded
soonish.

For m68k and sh4, we are using qemu-based buildds using qemu-user. However,
there are also real machines up and running which are used for testing,
development and also building packages. Those are running Debian unstable.

Some notes per architecture:

alpha
=====

There are two servers running which are hosting buildd instances to build
Debian unstable on alpha. Around 11600 source packages out of around 12900
packages (for x86_64) build fine. The port is stable and has only a few
issues here and there.

There is a QEMU target available, although I ran into issues from time
to time trying to build Debian packages for alpha using qemu-user, it
probably works better with qemu-system. One of the common problems on
qemu-user are atomics.

There is one active maintainer of the Debian Alpha port with several
other people from Debian Ports co-maintaining. Having an additional
fast Alpha machine available as a buildd would be desirable.

hppa
====

There are many machines running as buildds, the port is maintained by the
same people who are also the upstream kernel maintainers (Helge and Dave).

Around 11700 packages out of 12900 packages build fine. One of the issues
is that there is no support for hppa in OpenJDK at the moment due to the
unusual stack layout.

There is a QEMU target available that was just recently added. I have
played around it a bit and Helge wanted to set up a QEMU-based buildd
for hppa, so I assume QEMU for hppa is quite usable already.

ia64
====

ia64 was recently re-added as an unofficial port in Debian. Around 10000
packages out of 12900 packages build fine. There are still some toolchain
issues here and there and we haven't added ia64 support back to the
kernel source package in Debian yet.

We have two HP BL-860c Integrity blade servers running which are building
Debian packages. QEMU used to have KVM support for ia64 but that was
recently removed. Getting additional HP blades would be useful for the
port though.

There is one active maintainer of the Debian Itanium port with several
other people from Debian Ports co-maintaining.

There is no target support for ia64 in QEMU that I know of.

m68k
====

m68k has been revived some years ago by Thorsten Glaser. The port builds
around 11100 packages out of 12900 packages just fine. There are quite
a number of people working on the port in different areas, there is even
a work-in-progress port of LLVM and the list of packages that build fine
include even things like OpenJDK and LibreOffice. I am also working
on a Rust port which depends on the LLVM port, of course.

There is an out-of-tree QEMU version (qemu-m68k) by Laurent Vivier with
both qemu-user and qemu-system support. We are using the qemu-user variant
to operate four buildds to build packages. m68k target support is currently
being upstreamed in QEMU by Laurent Vivier.

Installing Debian's m68k port on qemu-m68k is a lot of fun. On a fast
Core i7, the kernel reports an emulated 68040 machine with 1.5 GHz
clock speed and 1 GiB.

There are also various new drivers for m68k hardware in development,
i.e. a driver for Amiga Zorro ESP SCSI host controllers or the
X-Surf100 network card by individual computers.

There is also a surprisingly large group of users of the port who are
running Debian m68k on accelerated Amigas and Ataris, I am one of them.

This port is maintained by the Debian Ports team.

powerpcspe
==========

This is a Debian port for the PowerPC e500v2 variant found in various
embedded systems. There are currently three buildds running with two
more being added soonish.

Two of the buildds are Tabor A1222 boards from A-EON technologies
which require an out-of-tree Linux kernel as lots of the necessary
changes were unfortunately never upstreamed by Freescale.

The primary concern of PowerPCSPE is LLVM which has target support
for it but the backend is unfortunately broken as it's missing
support for the actual ABI specialties of PowerPCSPE. The port
builds around 11000 packages out of 12900.

This port is maintained by the Debian Ports team.

There is also support for PowerPCSPE (PPC e500v2) in QEMU, both
user and system mode.

sh4
===

This port builds around 10500 packages out of 12900. There are
four qemu-user instances running as buildds plus one Renesas
SH-7785LCR board as an addtional buildd.

The main concern with the port is the lack of hardware. The evaluation
boards by Renesas are very hard to come by, but there are cheap
alternatives: The LANDISK NAS systems developed by IO-DATA (Japan)
which feature an SH7751 CPU clocked at 266 MHz with 64 MiB RAM.

A better alternative are Video-on-Demand devices from Taiwan
called "NextVoD" based on the ST-40 SoC clocked at 450 MHz
with 256 MiB RAM. Those machines can be obtained for as little
as 5 US-Dollars. I have many of those available which I will
happily ship out for free to anyone who would like to work
on the Linux SuperH kernel port (or other projects like glibc,
gcc and so on).

The port was planned to be revived as the open source J-Core
architecture with two new maintainers. Unfortunately, after the
initial work on the port, the port seems to have gone into hiatus.

The Debian port for sh4 is mostly usable with some open gcc issues
that have all reported upstream. However, since there is only one
active SH maintainer left in gcc, progress is a bit slow.

QEMU has both usable system and user support.

sparc64
=======

This port was restarted around early 2016 by me after it went into
hiatus after Debian's 32-bit sparc port was removed in 2015. The
sparc64 port was never an official release architecture of Debian
although we have had plans for that for at least two years now.

Unfortunately, Debian has been unable to find any sponsor for
modern SPARC hardware which could be used to set up a buildd
and porterbox infrastructure. While we have several SPARC machines
up and running as buildds and porterboxes, all of these machines
are old (the newest one being a SPARC T5) and without support.
Having in-warranty hardware at redundant hosting locations is one
of the release criteria for a Debian port though.

If Debian managed to find a sponsor for new and in-warranty SPARC
servers (e.g. Oracle SPARC Sonoma S7), we would be able to add
sparc64 as a release architecture in Debian. There was some
interest from one large vendor's side to send out hardware, but
that project eventually died down in the end.

The port itself is in very good shape with around 11400 out of
12900 packages building fine. The biggest concerns are missing
support for sparc64 in the Go compiler (gccgo is available,
however and there is an incomplete out-of-tree port from Oracle)
and the fact that some JIT compilers like they are found
in Javascript engines are stumbling over the 52-bit virtual address
space as it is found on sparc64 systems. The problem are tagged
pointers used in the JIT compilers which assume that only 48 bits
are used for addressing physical memory (as found on x86_64).

QEMU target support is there and usable with QEMU upstream
actively working on SPARC target support.

To conclude, if anyone is interested to work on any of Debian's
port architectures as mentioned above, be it the kernel support
or any of the userland or toolchain pieces, please get in touch
with the Debian Ports team as we have porterboxes available for
which we can hand out accounts.

And if there are potential sponsors for Alpha, Itanium or SPARC
hardware, we would be interested as well.

Thanks,
Adrian

> [1] https://marc.info/?l=linux-arch&m=151931431107183&w=2
> [2] https://cdimage.debian.org/cdimage/ports/
> [3] https://buildd.debian.org/status/package.php?p=linux&suite=sid

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
