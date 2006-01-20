Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:16544 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750779AbWATKFW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Jan 2006 05:05:22 -0500
From: Andi Kleen <ak@suse.de>
Subject: Re: new syscalls
Date: Fri, 20 Jan 2006 11:04:50 +0100
References: <B8E391BBE9FE384DAA4C5C003888BE6F05737A9F@scsmsx401.amr.corp.intel.com> <20060118133629.1cda96fd.akpm@osdl.org> <1137621188.30084.67.camel@localhost.localdomain>
In-Reply-To: <1137621188.30084.67.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601201104.51398.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, "Luck, Tony" <tony.luck@intel.com>, linux-arch@vger.kernel.org, JANAK DESAI <janak@us.ibm.com>, Ulrich Drepper <drepper@redhat.com>, David Howells <dhowells@redhat.com>, Davide Libenzi <davidel@xmailserver.org>, Christoph Lameter <christoph@lameter.com>
List-ID: <linux-arch.vger.kernel.org>

On Wednesday 18 January 2006 22:53, David Woodhouse wrote:
> On Wed, 2006-01-18 at 13:36 -0800, Andrew Morton wrote:
> > That's an excellent point.
> > 
> > Guys, architecture maintainers need test suites to verify that the syscalls
> > actually work as they wire them up.  Please share.  A stable URL would be
> > preferred - something which can go into the changlog or conceivably into
> > the kernel source.
> 
> http://david.woodhou.se/sigmasking.c is a good one for testing
> sigsuspend after hooking up TIF_RESTORE_SIGMASK stuff and the generic
> sys_rt_sigsuspend(), although it's not actually my code. There were a
> bunch of other tests in a tarball with that (on linux-arch a year or two
> ago) which arch maintainers should also use occasionally when they play
> with signal or ptrace code.

Are you sure it's even working? I implemented TIF_RESTORE_SIGMASK
for x86-64 and the SEGV part of the test fails. But it even fails
without any of my patches applied, so if it's really broken
it was always like this. I suspect i would have heard if such
a fundamental thing was really broken on x86-64.

===== Test 2: signal SIGALRM while waiting in nanosleep() =====

Unblocking all signals
Calling alarm(2)
Calling nanosleep( 20s)
After return from nanosleep(), blocked all signals, saved returned mask
OK: nanosleep(): Interrupted system call
OK: sighandler for SIGALRM (14) didn't run (invalid stack)
OK: SIGSEGV is unmasked at end of test
ERROR: sighandler for SIGSEGV (11) didn't run
OK: SIGUSR1 is unmasked
OK: SIGUSR2 is unmasked
SIGSEGV is pending at end of test, unblocking it now ...
Signal 11 caught
... done

-Andi
