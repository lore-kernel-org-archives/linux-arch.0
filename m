From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC] Restartable sequences tree tag v4.14-rseq-20171113
Date: Mon, 13 Nov 2017 22:10:25 +0000 (UTC)
Message-ID: <1490606675.14256.1510611025772.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.142.141]:44381 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752906AbdKMWJp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Nov 2017 17:09:45 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, maged michael <maged.michael@gmail.com>, Dave Watson <davejwatson@fb.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrea Parri <parri.andrea@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Orion Hodson <oth@google.com>, Hans Boehm <hboehm@google.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Paul Turner <pjt@google.com>, Andrew Hunter <ahh@google.com>

Hi,

As RFC (still), the new Restartable sequence tree tag <v4.14-rseq-20171113>
can be found at:

https://git.kernel.org/pub/scm/linux/kernel/git/rseq/linux-rseq.git/

It includes the new rseq and cpu_opv system calls implemented on
x86 32/64, powerpc 32/64, and arm 32. It also includes the following
improvements to the membarrier system call:

* new expedited membarrier command and registration command for
  shared mappings: all architectures implementing membarrier.
* new core serializing membarrier command and registration command
  for JITs (private mappings): x86 32/64, and arm 64.

Regarding the membarrier helper for JIT, I'm still uneasy about sending
it as a PR for this merge window, given that I have not received any
user feedback on real-life JIT integration yet. I have moved those commits
to the end of the patchset to they can be easily removed and delayed to
4.16 if needed. Orion Hodson at Google promised to try it out in the next
few days. He has reproducers of JIT issues on ARM64, so I have ported this
feature to arm64 to allow him to do some tests.

Linus, this is _not_ the PR yet, but should be pretty close to its
final form. I'm mainly waiting for feedback on from Orion Hodson before
I decide whether to leave the core serializing membarrier commits in
there, or delay them to 4.16.

Feedback is welcome,

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
