Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755372AbcJMRDY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Oct 2016 13:03:24 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u9DBrlU1016077
        for <linux-arch@vger.kernel.org>; Thu, 13 Oct 2016 07:57:20 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2625efdb9v-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 13 Oct 2016 07:57:19 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 13 Oct 2016 12:57:17 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 0/3] THREAD_INFO_IN_TASK_STRUCT vs generic preemption code
Date: Thu, 13 Oct 2016 13:57:09 +0200
Message-ID: <20161013115712.29517-1-heiko.carstens@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Message-ID: <20161013115709.xO2pultVGEzLWVayEmVCawGI73gEqdJ7yx-QrZXXONs@z>

Commit c65eacbe290b ("sched/core: Allow putting thread_info into
task_struct") made struct thread_info a generic struct with only a
single flags member if THREAD_INFO_IN_TASK_STRUCT is selected.

This change however seems to be quite x86 centric, since at least the
generic preemption code (asm-generic/preempt.h) assumes that struct
thread_info also has a preempt_count member, which apparently was not
true for x86.

We could add a bit more ifdefs to solve this problem too, but it seems
to be much simpler to make struct thread_info arch specific
again. This also makes the conversion to THREAD_INFO_IN_TASK_STRUCT a
bit easier for architectures that have a couple of arch specific stuff
in their thread_info definition.

The arch specific stuff _could_ be moved to thread_struct. However
keeping them in thread_info makes it easier: accessing thread_info
members is simple, since it is at the beginning of the task_struct,
while the thread_struct is at the end. At least on s390 the offsets
needed to access members of the thread_struct (with task_struct as
base) are too large for various asm instructions.  This is not a
problem when keeping these members within thread_info.

The above is actually the same as the description of the first
patch. The second patch is a simple compile fix and the third one the
s390 conversion to THREAD_INFO_IN_TASK_STRUCT.

Heiko Carstens (3):
  sched/core,x86: make struct thread_info arch specific again
  sched/preempt: include asm/current.h
  s390: move thread_info into task_struct

 arch/s390/Kconfig                   |  1 +
 arch/s390/include/asm/lowcore.h     |  2 +-
 arch/s390/include/asm/thread_info.h | 11 --------
 arch/s390/kernel/asm-offsets.c      | 17 +++++--------
 arch/s390/kernel/entry.S            | 51 ++++++++++++++++++-------------------
 arch/s390/kernel/head64.S           |  5 ++--
 arch/s390/kernel/setup.c            |  3 +--
 arch/s390/kernel/smp.c              |  1 -
 arch/x86/include/asm/thread_info.h  |  9 +++++++
 include/asm-generic/preempt.h       |  1 +
 include/linux/thread_info.h         | 11 --------
 11 files changed, 47 insertions(+), 65 deletions(-)

-- 
2.8.4

