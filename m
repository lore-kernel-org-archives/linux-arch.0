Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:33153 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbeIXV03 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2018 17:26:29 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 24 Sep 2018 17:23:35 +0200
Message-ID: <87lg7q2a2w.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [REVIEW][PATCH 0/3] signal/unicore32: siginfo cleanups
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Guan Xuetao <gxt@pku.edu.cn>
Message-ID: <20180924152335.qy3IL6zsBGNcdkVaXbOYax9SCpHEOVQvWUfPbdHNJ08@z>


I have been slowly cleaning up the architectues ever since I discovered
that the pattern of passing in struct siginfo is error prone, and
occassionally results in broken siginfo being sent to userspace.

I don't have a clue how to obtain a working unicore32 compiler so the
following changes have only been reviewed carefully and not compile
tested.  Still I believe they are simple and obviously correct.

Anyone who can review or test these changes please do and let me know
about any problems you find so that I can correct them.

My intention is to merge this through my siginfo tree.  If you feel it
should go through your arch tree let me know.   All of the prerequisites
should have been merged several releases ago.

Eric W. Biederman (3):
      signal/unicore32: Use send_sig_fault where appropriate
      signal/unicore32: Generate siginfo in ucs32_notify_die
      signal/unicore32: Use force_sig_fault where appropriate

 arch/unicore32/include/asm/bug.h  |  3 ++-
 arch/unicore32/kernel/fpu-ucf64.c | 12 +++---------
 arch/unicore32/kernel/traps.c     |  5 +++--
 arch/unicore32/mm/fault.c         | 27 +++++----------------------
 4 files changed, 13 insertions(+), 34 deletions(-)

Eric
