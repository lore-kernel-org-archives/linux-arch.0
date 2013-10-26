From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCHv2 0/2] xtensa fixes for 3.12
Date: Sat, 26 Oct 2013 05:03:03 +0400
Message-ID: <1382749385-29062-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:47579 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697Ab3JZBDZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 Oct 2013 21:03:25 -0400
Received: by mail-we0-f172.google.com with SMTP id q58so4617914wes.3
        for <linux-arch@vger.kernel.org>; Fri, 25 Oct 2013 18:03:23 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Hi Chris,

This is the second version of late 3.12 fixes, changes v1->v2:
  xtensa: fix fast_syscall_spill_registers_fixup: set windowstart bit for
    the current register frame in the fast_syscall_spill_registers_fixup;
    expand comments, add FIXME mark.
  xtensa: don't use alternate signal stack on threads: no changes.

I can post the third version if using a1 instead of a2 in the
_spill_registers .Lc12 is fine.

You can pull these changes from my git tree,
the following changes since commit 61e6cfa80de5760bbe406f4e815b7739205754d2:

  Linux 3.12-rc5 (2013-10-13 15:41:28 -0700)

are available in the git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git xtensa-fixes-for-upstream

for you to fetch changes up to cbcc64e11437f701121e71ca55ff0eb9815af530:

  xtensa: don't use alternate signal stack on threads (2013-10-26 04:39:13 +0400)

----------------------------------------------------------------
Baruch Siach (1):
      xtensa: don't use alternate signal stack on threads

Max Filippov (1):
      xtensa: fix fast_syscall_spill_registers_fixup

 arch/xtensa/kernel/entry.S  | 64 +++++++++++++++++++++++++++++++--------------
 arch/xtensa/kernel/signal.c |  2 +-
 2 files changed, 46 insertions(+), 20 deletions(-)

-- 
1.8.1.4
