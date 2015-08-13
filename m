Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38258 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbbHMJcx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 13 Aug 2015 05:32:53 -0400
Received: by wicja10 with SMTP id ja10so61831676wic.1
        for <linux-arch@vger.kernel.org>; Thu, 13 Aug 2015 02:32:52 -0700 (PDT)
From: David Drysdale <drysdale@google.com>
Subject: [PATCHv4 0/3] fs: add O_BENEATH flag to openat(2)
Date: Thu, 13 Aug 2015 10:32:43 +0100
Message-ID: <1439458366-8223-1-git-send-email-drysdale@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Meredydd Luff <meredydd@senatehouse.org>, Will Drewry <wad@chromium.org>, Jorge Lucangeli Obes <jorgelo@google.com>, Ricky Zhou <rickyz@google.com>, Lee Campbell <leecam@google.com>, Julien Tinnes <jln@google.com>, Mike Depinet <mdepinet@google.com>, James Morris <james.l.morris@oracle.com>, Andy Lutomirski <luto@amacapital.net>, Paolo Bonzini <pbonzini@redhat.com>, Paul Moore <paul@paul-moore.com>, Christoph Hellwig <hch@infradead.org>, Michael Kerrisk <mtk.manpages@gmail.com>, Dave Chinner <david@fromorbit.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org, David Drysdale <drysdale@google.com>
Message-ID: <20150813093243.F7gZKHjpowmarhMbPhpZk9mWxIbfLJ8M7gPXr5TLJwY@z>

A couple of questions with this iteration:
 - Should we create a new errno (say ENOTBENEATH) for this policing, to
   make it easier to distinguish this case from other EPERM failures?
   (The FreeBSD implementation is considering this approach.)
 - Al, does the code look OK for (in particular) integrating with the
   shiny new re-worked fs/namei.c code?
Thanks.


This change adds a new O_BENEATH flag for openat(2) which restricts the
provided path, rejecting (with -EPERM) paths that are not beneath
the provided dfd.

This functionality was originally implemented as part of the internals
of the Capsicum security framework, which is available in FreeBSD 10.x
and which has previously had a Linux kernel port proposed [1].

However, as this behaviour is potentially useful as an independent feature,
this change exposes it via an openat(2) flag.  (This variant was not
originally exposed in FreeBSD, but is currently being proposed there
too [2].)

Various folks from Chrome[OS] have indicated an interest in having this
functionality -- when combined with a seccomp filter it allows a directory
to be more safely accessed by a sandboxed process.  Other folk have also
expressed an interest [3].


[1] https://lkml.org/lkml/2014/7/25/426
[2] https://reviews.freebsd.org/D2808
[3] https://groups.google.com/d/msg/capnproto/sKpzanYNZmQ/T9IbJIB-rqQJ

Changes since v3:
 - Merge up to v4.2-rc6
 - Reinstate local selftests (I'll send xfstest changes separately
   if and when this is merged)
 - Pull in common selftests makefile

Changes since v2:
 - Move tests into xfstests [Dave Chinner, with thanks for feedback
   on initial version]
 - Merge up to v4.0-rc3 & latest man-pages

Changes since v1:
 - Don't needlessly duplicate flags [Al Viro]
 - Use EPERM rather than EACCES as error code [Paolo Bonzini]
 - Disallow nd_jump_link for O_BENEATH [Al Viro/Andy Lutomirski]
 - Add test of a jumped symlink (/proc/self/root)

Changes since the version included in the Capsicum v2 patchset:
 - Add tests of normal symlinks
 - Fix man-page typo
 - Update patch to 3.17

Changes from v1 to v2 of Capsicum patchset:
 - renamed O_BENEATH_ONLY to O_BENEATH [Christoph Hellwig]


David Drysdale (2):
  fs: add O_BENEATH flag to openat(2)
  selftests: Add test of O_BENEATH & openat(2)

 arch/alpha/include/uapi/asm/fcntl.h       |   1 +
 arch/parisc/include/uapi/asm/fcntl.h      |   1 +
 arch/sparc/include/uapi/asm/fcntl.h       |   1 +
 fs/fcntl.c                                |   4 +-
 fs/namei.c                                |  12 +-
 fs/open.c                                 |   4 +-
 fs/proc/base.c                            |   4 +-
 fs/proc/namespaces.c                      |   8 +-
 include/linux/namei.h                     |   3 +-
 include/uapi/asm-generic/fcntl.h          |   4 +
 tools/testing/selftests/Makefile          |   1 +
 tools/testing/selftests/openat/.gitignore |   4 +
 tools/testing/selftests/openat/Makefile   |  29 ++++
 tools/testing/selftests/openat/openat.c   | 258 ++++++++++++++++++++++++++++++
 14 files changed, 326 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/openat/.gitignore
 create mode 100644 tools/testing/selftests/openat/Makefile
 create mode 100644 tools/testing/selftests/openat/openat.c

--
1.9.1
