Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E232C433F5
	for <linux-arch@archiver.kernel.org>; Wed,  8 Dec 2021 20:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbhLHUVn (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 8 Dec 2021 15:21:43 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:38324 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbhLHUVm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Dec 2021 15:21:42 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:51438)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3OC-00GZa0-On; Wed, 08 Dec 2021 13:18:08 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39158 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3O9-007SGF-QD; Wed, 08 Dec 2021 13:18:08 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Date:   Wed, 08 Dec 2021 14:17:22 -0600
Message-ID: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mv3O9-007SGF-QD;;;mid=<87a6ha4zsd.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+3FWH/ytp2ZJTTsaTvzANvNSYQqitFkJE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 00/10] Removal of most do_exit calls
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


We have a lot of calls to do_exit that really don't want the semantics
of userspace calling pthread_exit, aka exit(2).  Instead the interesting
semantics are those of the current task exiting.

This set of changes removes a dead reference to do_exit on s390,
adds a function make_task_dead and changes all of the oops
implementations to use it, and adds function kthread_exit and
changes all of the kthread exits to use it.

The short term win of this set of changes is being able to move many
sanity checks out of do_exit that are only really interesting during an
oops.  Making it easier to see what do_exit is actually doing.

After this set of changes the number there are only about a big screen
full of do_exit calls left.  Making future changes much easier to
review.

s390 folks.  Can you please verify I read the s390 code correctly when
observing the reference to do_exit really is dead?  I would really
appreciate it.  I am not very familiar with s390.

This is on top of:
https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/ signal-for-v5.17

It is my plan that after these changes are reviewed to apply these
changes into my signal-for-v5.17 branch.  After that I can get to
cleaning up where signals, coredumps and the exit code meets.

Eric W. Biederman (10):
      exit/s390: Remove dead reference to do_exit from copy_thread
      exit: Add and use make_task_dead.
      exit: Move oops specific logic from do_exit into make_task_dead
      exit: Stop poorly open coding do_task_dead in make_task_dead
      exit: Stop exporting do_exit
      exit: Implement kthread_exit
      exit: Rename module_put_and_exit to module_put_and_kthread_exit
      exit: Rename complete_and_exit to kthread_complete_and_exit
      kthread: Ensure struct kthread is present for all kthreads
      exit/kthread: Move the exit code for kernel threads into struct kthread

 arch/alpha/kernel/traps.c                    |  6 +-
 arch/alpha/mm/fault.c                        |  2 +-
 arch/arm/kernel/traps.c                      |  2 +-
 arch/arm/mm/fault.c                          |  2 +-
 arch/arm64/kernel/traps.c                    |  2 +-
 arch/arm64/mm/fault.c                        |  2 +-
 arch/csky/abiv1/alignment.c                  |  2 +-
 arch/csky/kernel/traps.c                     |  2 +-
 arch/csky/mm/fault.c                         |  2 +-
 arch/h8300/kernel/traps.c                    |  2 +-
 arch/h8300/mm/fault.c                        |  2 +-
 arch/hexagon/kernel/traps.c                  |  2 +-
 arch/ia64/kernel/mca_drv.c                   |  2 +-
 arch/ia64/kernel/traps.c                     |  2 +-
 arch/ia64/mm/fault.c                         |  2 +-
 arch/m68k/kernel/traps.c                     |  2 +-
 arch/m68k/mm/fault.c                         |  2 +-
 arch/microblaze/kernel/exceptions.c          |  4 +-
 arch/mips/kernel/traps.c                     |  2 +-
 arch/nds32/kernel/fpu.c                      |  2 +-
 arch/nds32/kernel/traps.c                    |  8 +--
 arch/nios2/kernel/traps.c                    |  4 +-
 arch/openrisc/kernel/traps.c                 |  2 +-
 arch/parisc/kernel/traps.c                   |  2 +-
 arch/powerpc/kernel/traps.c                  |  8 +--
 arch/riscv/kernel/traps.c                    |  2 +-
 arch/riscv/mm/fault.c                        |  2 +-
 arch/s390/kernel/dumpstack.c                 |  2 +-
 arch/s390/kernel/nmi.c                       |  2 +-
 arch/s390/kernel/process.c                   |  1 -
 arch/sh/kernel/traps.c                       |  2 +-
 arch/sparc/kernel/traps_32.c                 |  4 +-
 arch/sparc/kernel/traps_64.c                 |  4 +-
 arch/x86/entry/entry_32.S                    |  6 +-
 arch/x86/entry/entry_64.S                    |  6 +-
 arch/x86/kernel/dumpstack.c                  |  4 +-
 arch/xtensa/kernel/traps.c                   |  2 +-
 crypto/algboss.c                             |  4 +-
 drivers/net/wireless/rsi/rsi_91x_coex.c      |  2 +-
 drivers/net/wireless/rsi/rsi_91x_main.c      |  2 +-
 drivers/net/wireless/rsi/rsi_91x_sdio_ops.c  |  2 +-
 drivers/net/wireless/rsi/rsi_91x_usb_ops.c   |  2 +-
 drivers/pnp/pnpbios/core.c                   |  6 +-
 drivers/staging/rts5208/rtsx.c               | 16 ++---
 drivers/usb/atm/usbatm.c                     |  2 +-
 drivers/usb/gadget/function/f_mass_storage.c |  2 +-
 fs/cifs/connect.c                            |  2 +-
 fs/exec.c                                    |  2 +
 fs/jffs2/background.c                        |  2 +-
 fs/nfs/callback.c                            |  4 +-
 fs/nfs/nfs4state.c                           |  2 +-
 fs/nfsd/nfssvc.c                             |  2 +-
 include/linux/kernel.h                       |  1 -
 include/linux/kthread.h                      |  4 +-
 include/linux/module.h                       |  6 +-
 include/linux/sched/task.h                   |  1 +
 kernel/exit.c                                | 88 ++++++++++++++--------------
 kernel/fork.c                                |  4 ++
 kernel/futex/core.c                          |  2 +-
 kernel/kexec_core.c                          |  2 +-
 kernel/kthread.c                             | 78 +++++++++++++++++-------
 kernel/module.c                              |  6 +-
 kernel/sched/core.c                          | 16 ++---
 lib/kunit/try-catch.c                        |  4 +-
 net/bluetooth/bnep/core.c                    |  2 +-
 net/bluetooth/cmtp/core.c                    |  2 +-
 net/bluetooth/hidp/core.c                    |  2 +-
 tools/objtool/check.c                        |  8 ++-
 68 files changed, 212 insertions(+), 173 deletions(-)

Eric
