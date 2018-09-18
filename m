Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:42195 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbeIRXPC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 19:15:02 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 18 Sep 2018 19:41:09 +0200
Message-ID: <878t3yitze.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [REVIEW][PATCH 0/9] signal/powerpc: siginfo cleanups
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <20180918174109.i9uRxMoACEHnlgfwGe7Vbe7UoAPxpyEt5K-bbTN6M1A@z>


This is the continuation of my work to sort out signaling of exceptions
with siginfo.  The old functions by passing siginfo resulted in many
cases of fields of siginfo that were not initialized and then passed to
userspace, and also resulted in callers getting confused and
initializing the wrong fields.  My remedy is to have specific functions
for sending each different kind of signal with siginfo.  Those functions
take the information needed to fill in siginfo and do the work
themselves.

This is my set of changes to update powerpc to use those functions.
Along with some refactoring so those functions can be cleanly used.

Folks please review and double check me.  I think I have kept these
changes simple and obviously correct but I am human and mess up
sometimes.

After these patches have had a chance to be reviewed I plan to merge
them by my siginfo tree.  If you would rather take them in the powerpc
tree let me know.   All of the prerequisites should have been merged
through Linus's tree several releases ago.

Eric W. Biederman (9):
      signal/powerpc: Use force_sig_mceerr as appropriate
      signal/powerpc: Remove pkey parameter from __bad_area
      signal/powerpc: Call _exception_pkey directly from bad_key_fault_exception
      signal/powerpc: Remove pkey parameter from __bad_area_nosemaphore
      signal/powerpc: Factor the common exception code into exception_common
      signal/powerpc: Call force_sig_fault from _exception
      signal/poewrpc: Specialize _exception_pkey for handling pkey exceptions
      signal/powerpc: Simplify _exception_pkey by using force_sig_pkuerr
      signal/powerpc: Use force_sig_fault where appropriate

 arch/powerpc/include/asm/bug.h            |  2 +-
 arch/powerpc/kernel/process.c             |  9 +----
 arch/powerpc/kernel/traps.c               | 27 ++++++++-------
 arch/powerpc/mm/fault.c                   | 55 +++++++++++++++++--------------
 arch/powerpc/platforms/cell/spu_base.c    |  4 +--
 arch/powerpc/platforms/cell/spufs/fault.c | 26 +++++----------
 6 files changed, 57 insertions(+), 66 deletions(-)

Eric
