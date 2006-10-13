Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.ocs.com.au ([202.147.117.210]:24364 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750719AbWJMNXO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Oct 2006 09:23:14 -0400
From: Keith Owens <kaos@sgi.com>
Reply-To: linux-arch@vger.kernel.org
Subject: [RFC] Common API for bring the system to a crash_stop state
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 13 Oct 2006 23:23:35 +1000
Message-ID: <26656.1160745815@ocs3.ocs.com.au>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: kdb@oss.sgi.com, fastboot@lists.osdl.org, lkcd-devel.lists.sourceforge.net@ocs.com.au, info@linsyssoft.com, Jan Beulich <JBeulich@novell.com>, James.Bottomley@HansenPartnership.com, linux-visws-devel@lists.sf.ne
List-ID: <linux-arch.vger.kernel.org>

This initial mail is going to a wide distribution because there are
several different people and groups who are working on kernel debug
style tools.  These tools include debuggers such as kdb, kgdb, nlkd.
There are also kernel dump tools like netdump, lkcd, crash, kexec/kdump
and others.  To cut down the cross list noise, I have arbitrarily
designated linux-arch@vger.kernel.org as the only list to receive and
discuss the patches that follow this initial mail.

Reply-To is set to linux-arch@vger.kernel.org, please honour it and
trim the rest of the cc: list.

-------------------------------------------------------------------------------------

All the kernel debug style tools (kdb, kgdb, nlkd, netdump, lkcd,
crash, kdump etc.) have a common requirement, they need to do a crash
stop of the systems.  This means stopping all the cpus, even if some of
the cpus are spinning disabled.  In addition, each cpu has to save
enough state to start diagnosis of the problem.

* Each debug style tool has written its own code for interrupting the
  other cpus and for saving cpu state.

* Some tools try a normal IPI first then send a non-maskable interrupt
  after a delay.

* Some tools always send a NMI first, which can result in incomplete
  machine state if it arrives at the wrong time.

* Most of the tools do not know how to cope with the IA64 architecture
  defined rendezvous algorithm, which interferes with an OS driven
  rendezvous.

* Needless to say, every single patch set conflicts with all the
  others, which makes it very difficult to install more than one of the
  tools at a time.

The solution is to define a common crash_stop API that can be used by
_all_ of the debug style tools, without reinventing the wheel each
time.

The following crash_stop patches will only appear on linux-arch.

crash_stop_headers         The common and i386 crash_stop.h files

crash_stop_i386_handler    Add the crash_stop i386 interrupt handlers.
                           This patch changes existing i386 files.  It
                           needs testing on visw and updating for
                           voyager.

crash_stop_i386            I386 specific crash_stop code.

crash_stop_common          Architecture independent crash_stop code.

crash_stop_common_Kconfig  Kconfig change to activate crash_stop.

crash_stop_demo            A demo module to test crash_stop().

This is a work in progress, it does most of the job on i386.  x86_64
will be easy once i386 is working.  I have an incomplete patch for
ia64, coexxisting with the MCA/INIT rendezvous algorithm is
non-trivial.  At the moment, I am more interested in feedback on the
design of the API, to ensure that it suits everybody's requirements.

Most of the design documentation is in the crash_stop_common patch.
Please read that before replying.

