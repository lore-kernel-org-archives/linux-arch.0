Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:38001 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbeIXUu2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2018 16:50:28 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 24 Sep 2018 16:47:44 +0200
Message-ID: <874lef2bqn.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [REVIEW][PATCH 0/2] signal/arc: siginfo cleanups
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupta@synopsys.com>
Message-ID: <20180924144744.YUBMFWsvzkA2GzIbcjRK-twZsedWLwl5JS9pvT1n9XQ@z>


I have been slowly cleaning up the architectues ever since I discovered
that the pattern of passing in struct siginfo is error prone, and
occassionally results in borken siginfo being sent to userspace.

What is happening on arc is pretty tame and I have compile tested
these changes, so I don't expect problems.

Still I would appreciate if people can look over the code and perhaps
test it and see if they can spot anything that has perhaps gone wrong.
appreciate it.

My intention is to merge this through my siginfo tree.  If you feel it
should go through your arch tree let me know.   All of the prerequisites
should have been merged several releases ago.

Eric W. Biederman (2):
      signal/arc: Push siginfo generation into unhandled_exception
      signal/arc: Use force_sig_fault where appropriate

 arch/arc/kernel/traps.c | 22 ++++++++--------------
 arch/arc/mm/fault.c     | 20 +++++---------------
 2 files changed, 13 insertions(+), 29 deletions(-)
