Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752113AbdBTSgM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Feb 2017 13:36:12 -0500
From: Waiman Long <longman@redhat.com>
Subject: [PATCH v5 0/2] x86/kvm: Reduce vcpu_is_preempted() overhead
Date: Mon, 20 Feb 2017 13:36:02 -0500
Message-ID: <1487615764-1343-1-git-send-email-longman@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Waiman Long <longman@redhat.com>
Message-ID: <20170220183602.42U61-LTPLAYBTbVe4SMd3zyXqQRUGALSU1GKLXEoBs@z>

 v4->v5:
  - As suggested by PeterZ, use the asm-offsets header file generation
    mechanism to get the offset of the preempted field in
    kvm_steal_time instead of hardcoding it.

 v3->v4:
  - Fix x86-32 build error.

 v2->v3:
  - Provide an optimized __raw_callee_save___kvm_vcpu_is_preempted()
    in assembly as suggested by PeterZ.
  - Add a new patch to change vcpu_is_preempted() argument type to long
    to ease the writing of the assembly code.

 v1->v2:
  - Rerun the fio test on a different system on both bare-metal and a
    KVM guest. Both sockets were utilized in this test.
  - The commit log was updated with new performance numbers, but the
    patch wasn't changed.
  - Drop patch 2.

As it was found that the overhead of callee-save vcpu_is_preempted()
can have some impact on system performance on a VM guest, especially
of x86-64 guest, this patch set intends to reduce this performance
overhead by replacing the C __kvm_vcpu_is_preempted() function by
an optimized version of __raw_callee_save___kvm_vcpu_is_preempted()
written in assembly.

Waiman Long (2):
  x86/paravirt: Change vcp_is_preempted() arg type to long
  x86/kvm: Provide optimized version of vcpu_is_preempted() for x86-64

 arch/x86/include/asm/paravirt.h      |  2 +-
 arch/x86/include/asm/qspinlock.h     |  2 +-
 arch/x86/kernel/asm-offsets_64.c     |  9 +++++++++
 arch/x86/kernel/kvm.c                | 26 +++++++++++++++++++++++++-
 arch/x86/kernel/paravirt-spinlocks.c |  2 +-
 5 files changed, 37 insertions(+), 4 deletions(-)

-- 
1.8.3.1
