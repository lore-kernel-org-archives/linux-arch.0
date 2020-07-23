From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 00/13] "Task_isolation" mode
Date: Thu, 23 Jul 2020 15:17:04 +0200
Message-ID: <87imeextf3.fsf@nanos.tec.linutronix.de>
References: <04be044c1bcd76b7438b7563edc35383417f12c8.camel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:57992 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbgGWNRG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 09:17:06 -0400
In-Reply-To: <04be044c1bcd76b7438b7563edc35383417f12c8.camel@marvell.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Belits <abelits@marvell.com>, "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc: Prasun Kapoor <pkapoor@marvell.com>, "mingo@kernel.org" <mingo@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>

Alex,

Alex Belits <abelits@marvell.com> writes:
> This is a new version of task isolation implementation. Previous version is at
> https://lore.kernel.org/lkml/07c25c246c55012981ec0296eee23e68c719333a.camel@marvell.com/
>
> Mostly this covers race conditions prevention on breaking isolation. Early after kernel entry,
> task_isolation_enter() is called to update flags visible to other CPU cores and to perform
> synchronization if necessary. Before this call only "safe" operations happen, as long as
> CONFIG_TRACE_IRQFLAGS is not enabled.

Without going into details of the individual patches, let me give you a
high level view of this series:

  1) Entry code handling:

     That's completely broken vs. the careful ordering and instrumentation
     protection of the entry code. You can't just slap stuff randomly
     into places which you think are safe w/o actually trying to understand
     why this code is ordered in the way it is.

     This clearly was never built and tested with any of the relevant
     debug options enabled. Both build and boot would have told you.

  2) Instruction synchronization

     Trying to do instruction synchronization delayed is a clear recipe
     for hard to diagnose failures. Just because it blew not up in your
     face does not make it correct in any way. It's broken by design and
     violates _all_ rules of safe instruction patching and introduces a
     complete trainwreck in x86 NMI processing.

     If you really think that this is correct, then please have at least
     the courtesy to come up with a detailed and precise argumentation
     why this is a valid approach.

     While writing that up you surely will find out why it is not.

  3) Debug calls

     Sprinkling debug calls around the codebase randomly is not going to
     happen. That's an unmaintainable mess.

     Aside of that none of these dmesg based debug things is necessary.
     This can simply be monitored with tracing.

  4) Tons of undocumented smp barriers

     See Documentation/process/submit-checklist.rst #25

  5) Signal on page fault

     Why is this a magic task isolation feature instead of making it
     something which can be used in general? There are other legit
     reasons why a task might want a notification about an unexpected
     (resolved) page fault.

  6) Coding style violations all over the place

     Using checkpatch.pl is mandatory

  7) Not Cc'ed maintainers

     While your Cc list is huge, you completely fail to Cc the relevant
     maintainers of various files and subsystems as requested in
     Documentation/process/*

  8) Changelogs

     Most of the changelogs have something along the lines:

     'task isolation does not want X, so do Y to make it not do X'

     without any single line of explanation why this approach was chosen
     and why it is correct under all circumstances and cannot have nasty
     side effects.

     It's not the job of the reviewers/maintainers to figure this out.

Please come up with a coherent design first and then address the
identified issues one by one in a way which is palatable and reviewable.

Throwing a big pile of completely undocumented 'works for me' mess over
the fence does not get you anywhere, not even to the point that people
are willing to review it in detail.

Thanks,

        tglx
