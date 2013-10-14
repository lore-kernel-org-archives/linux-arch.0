From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/2] xtensa queue 2013/10/15 for 3.12
Date: Tue, 15 Oct 2013 02:22:41 +0400
Message-ID: <1381789363-2411-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:63728 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756557Ab3JNWXL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Oct 2013 18:23:11 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so6328680lbh.0
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2013 15:23:10 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, Baruch Siach <baruch@tkos.co.il>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Hi Chris,

could you please push these two fixes to the 3.12?
One fixes the regression introduced by the a3/excsave conversion in 3.12-rc1,
and the other fixes use of nonexistent alternative signal stack by threads.

You can pull these changes from my git tree,
the following changes since commit 61e6cfa80de5760bbe406f4e815b7739205754d2:

  Linux 3.12-rc5 (2013-10-13 15:41:28 -0700)

are available in the git repository at:
  git://github.com/jcmvbkbc/linux-xtensa.git xtensa-fixes-for-upstream

Baruch Siach (1):
      xtensa: don't use alternate signal stack on threads

Max Filippov (1):
      xtensa: fix fast_syscall_spill_registers_fixup

 arch/xtensa/kernel/entry.S  |   49 ++++++++++++++++++++++++++----------------
 arch/xtensa/kernel/signal.c |    2 +-
 2 files changed, 31 insertions(+), 20 deletions(-)

-- 
1.7.7.6
