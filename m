From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH/RFC] Move generated files to include/generated
Date: Tue, 21 Jul 2009 23:10:40 +0200
Message-ID: <20090721211040.GA7688@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kbuild-owner@vger.kernel.org
To: linux-kbuild <linux-kbuild@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

In 2.6.30 we introduced support for adding generated
files to a dedicated directory named "include/generated".

This had a number of benefits:

  - avoid mixing generated and normal files
  - allow us to finally kill the asm symlink
  - simpler .gitignore rules
  - simpler list of mrproper files

The following patchset introduces use of include/generated
in several places as documented by the shortlog:

Sam Ravnborg (10):
      kbuild: move bounds.h to include/generated
      kbuild: move asm-offsets.h to include/generated
      ia64: move nr-irqs.h to include/generated
      sh: move machtypes.h to include/generated
      arm: move mach-types to include/generated
      kbuild: drop asm symlink
      kbuild: move compile.h to include/generated
      drop unneeded include of autoconf.h
      kbuild: move autoconf.h to include/generated
      kbuild: move utsrelease.h to include/generated

We are left with version.h that is still generated in
include/linux.

And there may be a few architecture specific files I have missed.

This patch serie has a few shortcomings...

1)
After applying one _must_ do a "make clean" to get
a buildable kernel.
This is because we change the path of autoconf.h but
the patch does not include anything to force a new
autoconf.h to be created.
Another workaround is to use a simple "make oldconfig".

2)
All files will be rebuild.
We change an option to gcc due to path change of autoconf.h
so all files will be rebuild.

3)
If some files are left in include/asm/ we may still
pick them up.
This is relevant for asm-offsets.h where we have
a lot of "#include <asm/asm-offsets.h>".
And include/asm comes before arch/$ARCH/include/asm
in the search order.

4)
We loose the check if this is the correct ARCH we are
building for as we can no longer check the asm symlink.
This shortcoming is addressed by another patch that saves
ARCH and CROSS_COMPILE. But it is not part of this serie.

Individual patches will follow.
Patches are based on todays mainline.

It is also available at:

    git://git.kernel.org/pub/scm/linux/kernel/git/sam/generated.git

Comments welcome!

	Sam

