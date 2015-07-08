From: Chris Metcalf <cmetcalf@ezchip.com>
Subject: [PATCH v2 0/3] add new strscpy() API for string copy
Date: Wed, 8 Jul 2015 16:20:42 -0400
Message-ID: <1436386845-11989-1-git-send-email-cmetcalf@ezchip.com>
References: <1430409677-13284-1-git-send-email-cmetcalf@ezchip.com> <CA+55aFwokKo9X4=wwZ1sKLmLfye=a65KPzMhe-QzuHT6Prp0tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFwokKo9X4=wwZ1sKLmLfye=a65KPzMhe-QzuHT6Prp0tA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Chris Metcalf <cmetcalf@ezchip.com>, Al Viro <viro@zeniv.linux.org.uk>, Fabian Frederick <fabf@skynet.be>, Randy Dunlap <rdunlap@infradead.org>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, gregkh@linuxfoundation.org, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>, Grant Likely <grant.likely@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Ellerman <mpe@ellerman.id.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

v2: eliminate strscpy_truncate(); the single strscpy() API in v2
  just tolerates a truncated string (while returning an error value)
  Also, improve some of the comparison language with strlcpy/strncpy.

This patch series addresses limitations in strncpy() and strlcpy();
both the old APIs are unpleasant, as Linus nicely summarized here:

  https://lkml.org/lkml/2015/4/28/570

and of course as other folks (Greg K-H and Linus again) said last year:

  https://plus.google.com/+gregkroahhartman/posts/1amLbuhWbh5

The proposed new API (strscpy(), for "s"afe string copy) has an
easy-to-use API for detecting buffer overflow, doesn't walk past the
requested copy size on the source string, and isn't subject to
thread-safety attacks like the current strlcpy implementation.  See
patch 2/3 for more on why strscpy() is a good thing.

To make strscpy() work more efficiently I did the minimum tweaking
necessary to allow <asm/word-at-a-time.h> to work on all architectures,
though of course individual maintainers can still make their versions
more efficient as needed.

It's likely not necessary for per-architecture implementations of
strscpy() to be written, but I stuck with the standard __HAVE_ARCH_XXX
model just for consistency with the rest of <linux/string.h>.

I tested the implementation with a simple user-space harness, so I
believe it is correct for the corner cases I could think of.  In
particular I pairwise-tested all the unaligned values of source and
dest, and tested the restriction on src page-crossing at all
unaligned offsets approaching the page boundary.

The patch series is available to be pulled from

  git://git.kernel.org/pub/scm/linux/kernel/git/cmetcalf/linux-tile.git strscpy

Chris Metcalf (3):
  Make asm/word-at-a-time.h available on all architectures
  string: provide strscpy()
  tile: use global strscpy() rather than private copy

 arch/arc/include/asm/Kbuild          |  1 +
 arch/avr32/include/asm/Kbuild        |  1 +
 arch/blackfin/include/asm/Kbuild     |  1 +
 arch/c6x/include/asm/Kbuild          |  1 +
 arch/cris/include/asm/Kbuild         |  1 +
 arch/frv/include/asm/Kbuild          |  1 +
 arch/hexagon/include/asm/Kbuild      |  1 +
 arch/ia64/include/asm/Kbuild         |  1 +
 arch/m32r/include/asm/Kbuild         |  1 +
 arch/metag/include/asm/Kbuild        |  1 +
 arch/microblaze/include/asm/Kbuild   |  1 +
 arch/mips/include/asm/Kbuild         |  1 +
 arch/mn10300/include/asm/Kbuild      |  1 +
 arch/nios2/include/asm/Kbuild        |  1 +
 arch/powerpc/include/asm/Kbuild      |  1 +
 arch/s390/include/asm/Kbuild         |  1 +
 arch/score/include/asm/Kbuild        |  1 +
 arch/tile/gxio/mpipe.c               | 33 ++------------
 arch/tile/include/asm/Kbuild         |  1 +
 arch/um/include/asm/Kbuild           |  1 +
 arch/unicore32/include/asm/Kbuild    |  1 +
 arch/xtensa/include/asm/Kbuild       |  1 +
 include/asm-generic/word-at-a-time.h | 80 ++++++++++++++++++++++++++++----
 include/linux/string.h               |  3 ++
 lib/string.c                         | 88 ++++++++++++++++++++++++++++++++++++
 25 files changed, 188 insertions(+), 37 deletions(-)

-- 
2.1.2
