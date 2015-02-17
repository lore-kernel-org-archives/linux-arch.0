Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:51407 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755028AbbBQNuo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Feb 2015 08:50:44 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [GIT PULL] asm-generic: uaccess.h cleanup
Date: Tue, 17 Feb 2015 14:50:38 +0100
Message-ID: <3437717.WY1JNmCCRA@wuerfel>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20150217135038.0a5uQXcpd94CEIjwnSdp7IJJoyTdW8JlzYdYNe38B7Q@z>

The following changes since commit eaa27f34e91a14cdceed26ed6c6793ec1d186115:

  linux 3.19-rc4 (2015-01-11 12:44:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-for-linus

for you to fetch changes up to 643165c8bbc8617d8222cb50c89e34fe64d226cf:

  Merge tag 'uaccess_for_upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost into asm-generic (2015-01-14 23:17:49 +0100)

----------------------------------------------------------------
asm-generic: uaccess.h cleanup

Like in 3.19, I once more have a multi-stage cleanup for one asm-generic
header file, this time the work was done by Michael Tsirkin and cleans
up the uaccess.h file in asm-generic, as well as all architectures for
which the respective maintainers did not pick up his patches directly.

----------------------------------------------------------------

Original pull request, merged as 643165c8bbc86:

    uaccess: fix sparse warning on get/put_user for bitwise types
    
    At the moment, if p and x are both tagged as bitwise types,
    some of get_user(x, p), put_user(x, p), __get_user(x, p), __put_user(x, p)
    might produce a sparse warning on many architectures.
    This is a false positive: *p on these architectures is loaded into long
    (typically using asm), then cast back to typeof(*p).
    
    When typeof(*p) is a bitwise type (which is uncommon), such a cast needs
    __force, otherwise sparse produces a warning.
    
    Some architectures already have the __force tag, add it
    where it's missing.
    
    I verified that adding these __force casts does not supress any useful warnings.
    
    Specifically, vhost wants to read/write bitwise types in userspace memory
    using get_user/put_user.
    At the moment this triggers sparse errors, since the value is passed through an
    integer.
    
    For example:
        __le32 __user *p;
        __u32 x;
    
    both
        put_user(x, p);
    and
        get_user(x, p);
    should be safe, but produce warnings on some architectures.
    
    While there, I noticed that a bunch of architectures violated
    coding style rules within uaccess macros.
    Included patches to fix them up.
    
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

Arnd Bergmann (1):
      Merge tag 'uaccess_for_upstream' of git://git.kernel.org/.../mst/vhost into asm-generic

Michael S. Tsirkin (37):
      x86/uaccess: fix sparse errors
      alpha/uaccess: fix sparse errors
      arm64/uaccess: fix sparse errors
      avr32/uaccess: fix sparse errors
      blackfin/uaccess: fix sparse errors
      cris/uaccess: fix sparse errors
      ia64/uaccess: fix sparse errors
      m32r/uaccess: fix sparse errors
      metag/uaccess: fix sparse errors
      openrisc/uaccess: fix sparse errors
      parisc/uaccess: fix sparse errors
      sh/uaccess: fix sparse errors
      sparc32/uaccess: fix sparse errors
      sparc64/uaccess: fix sparse errors
      m68k/uaccess: fix sparse errors
      arm: fix put_user sparse errors
      blackfin: fix put_user sparse errors
      ia64: fix put_user sparse errors
      metag: fix put_user sparse errors
      sh: fix put_user sparse errors
      avr32: whitespace fix
      sparc32: uaccess_32 macro whitespace fixes
      sparc64: uaccess_64 macro whitespace fixes
      blackfin: macro whitespace fixes
      alpha: macro whitespace fixes
      arm: macro whitespace fixes
      arm64: macro whitespace fixes
      avr32: macro whitespace fixes
      cris: macro whitespace fixes
      frv: macro whitespace fixes
      m32r: macro whitespace fixes
      m68k: macro whitespace fixes
      parisc: macro whitespace fixes
      sh: macro whitespace fixes
      xtensa: macro whitespace fixes
      sparc64: nocheck uaccess coding style tweaks
      sparc32: nocheck uaccess coding style tweaks

 arch/alpha/include/asm/uaccess.h    |  86 ++++-----
 arch/arm/include/asm/uaccess.h      |  96 +++++-----
 arch/arm64/include/asm/uaccess.h    |   4 +-
 arch/avr32/include/asm/uaccess.h    |  24 +--
 arch/blackfin/include/asm/uaccess.h |  32 ++--
 arch/cris/include/asm/uaccess.h     | 117 +++++++------
 arch/frv/include/asm/segment.h      |   2 +-
 arch/ia64/include/asm/uaccess.h     |  11 +-
 arch/m32r/include/asm/uaccess.h     |  88 +++++-----
 arch/m68k/include/asm/segment.h     |   2 +-
 arch/m68k/include/asm/uaccess_mm.h  |  40 ++---
 arch/metag/include/asm/uaccess.h    |  25 +--
 arch/openrisc/include/asm/uaccess.h |   4 +-
 arch/parisc/include/asm/uaccess.h   | 116 ++++++------
 arch/sh/include/asm/segment.h       |   2 +-
 arch/sh/include/asm/uaccess.h       |   4 +-
 arch/sh/include/asm/uaccess_64.h    |   8 +-
 arch/sparc/include/asm/uaccess_32.h | 339 +++++++++++++++++++++---------------
 arch/sparc/include/asm/uaccess_64.h | 222 ++++++++++++-----------
 arch/x86/include/asm/uaccess.h      |   2 +-
 arch/xtensa/include/asm/uaccess.h   |  90 +++++-----
 21 files changed, 700 insertions(+), 614 deletions(-)

