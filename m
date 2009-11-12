From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v2 0/5] ptrace: syscall-exit && stepping fixes
Date: Thu, 12 Nov 2009 18:38:40 +0100
Message-ID: <20091112173840.GA12260@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22437 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753813AbZKLRn6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 Nov 2009 12:43:58 -0500
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Roland McGrath <roland@redhat.com>, Srinivasa Ds <srinivasa@in.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Changes: added x86 maintainers + linux-arch, otherwise unchanged.


Currently PTRACE_SINGLESTEP after syscall_exit stop is not consistent
across different machines, and we have different problems depending
on arch/.

As Roland suggests, we should move the arch-dependent logic into the
tracehook_report_syscall_exit() and unify/fix the behaviour.

Oleg.
