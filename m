From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [GIT PULL] OpenRISC architecture
Date: Sun, 24 Jul 2011 22:06:47 +0930
Message-ID: <87tyabyhwg.fsf@rustcorp.com.au>
References: <1311408223.3499.13.camel@localhost> <CA+55aFwy-oWnJ1Mp_7m-Myrfm_W3cysacirRhjXohxzQyTgK8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFwy-oWnJ1Mp_7m-Myrfm_W3cysacirRhjXohxzQyTgK8Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jonas Bonn <jonas@southpole.se>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat, 23 Jul 2011 14:17:00 -0700, Linus Torvalds <torvalds@linux-foun=
dation.org> wrote:
> On Sat, Jul 23, 2011 at 1:03 AM, Jonas Bonn <jonas@southpole.se> wrot=
e:
> >
> > NOTE: =C2=A0This pull depends on a patch "modules: add default load=
er hook
> > implementations" in Rusty's tree... without that, the OpenRISC arch=
 will
> > not build. =C2=A0Note also that there are a couple of patches that =
touch
> > asm-generic bits at the base of the branch, including a patch from
> > Andrew that was moved to this branch to avoid a merge conflict.
>=20
> So I don't want to pull this if it doesn't build. Rusty, what's the
> status of your module tree?

Wires crossed?  I said I would fix up after his was merged (it's trivia=
l
that way).  I was waiting....

OK, here's the module (and param) tree pull request:

The following changes since commit 6d6be43d4dfdb167ef72f4aa665c1607db79=
9be4:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel=
/git/vapier/blackfin (2011-07-23 14:05:44 -0700)

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-=
linus.git master

Alessio Igor Bogani (1):
      modpost: Fix modpost's license checking V3

Jonas Bonn (2):
      modules: add default loader hook implementations
      modules: make arch's use default loader hooks

Kay Sievers (2):
      module: change attr callbacks to take struct module_kobject
      module: add /sys/module/<name>/uevent files

Satoru Moriya (1):
      param: fix return value handling in param_set_*

 arch/alpha/kernel/module.c      |   34 ----------------
 arch/arm/kernel/module.c        |   29 +-------------
 arch/avr32/kernel/module.c      |   20 ----------
 arch/blackfin/kernel/module.c   |   21 ----------
 arch/cris/kernel/module.c       |   43 +-------------------
 arch/frv/kernel/module.c        |   57 +--------------------------
 arch/h8300/kernel/module.c      |   45 ----------------------
 arch/ia64/kernel/module.c       |   16 --------
 arch/m32r/kernel/module.c       |   38 ------------------
 arch/m68k/kernel/module_mm.c    |   27 -------------
 arch/m68k/kernel/module_no.c    |   34 ----------------
 arch/microblaze/kernel/module.c |   35 -----------------
 arch/mips/kernel/module.c       |   20 +---------
 arch/mn10300/kernel/module.c    |   61 -----------------------------
 arch/parisc/kernel/module.c     |   12 ------
 arch/powerpc/kernel/module.c    |   18 ---------
 arch/powerpc/kernel/module_32.c |   11 -----
 arch/powerpc/kernel/module_64.c |   10 -----
 arch/s390/kernel/module.c       |   20 ----------
 arch/score/kernel/module.c      |   29 +-------------
 arch/sh/kernel/module.c         |   35 -----------------
 arch/sparc/kernel/module.c      |   28 -------------
 arch/tile/kernel/module.c       |   31 ---------------
 arch/unicore32/kernel/module.c  |   35 -----------------
 arch/x86/kernel/module.c        |   37 ------------------
 arch/xtensa/kernel/module.c     |   43 ---------------------
 include/linux/module.h          |   24 ++++++-----
 include/linux/moduleloader.h    |    7 +++-
 kernel/module.c                 |   80 +++++++++++++++++++++++++++++++=
++++---
 kernel/params.c                 |   18 +++++---
 scripts/mod/modpost.c           |   29 +++++++++++++-
 31 files changed, 143 insertions(+), 804 deletions(-)
