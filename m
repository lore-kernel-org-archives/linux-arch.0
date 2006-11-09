Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:59776 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932426AbWKIEEX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2006 23:04:23 -0500
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with SMTP id kA96lSIe005320
	for <@external-mail-relay.sgi.com:linux-arch@vger.kernel.org>; Wed, 8 Nov 2006 22:47:30 -0800
From: Keith Owens <kaos@sgi.com>
Date: Thu, 09 Nov 2006 15:04:18 +1100
Message-Id: <20061109040418.17391.16362.sendpatchset@chook.melbourne.sgi.com>
Subject: [patch 2.6.19-rc5 0/12] crash_stop: Summary
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Keith Owens <kaos@sgi.com>
List-ID: <linux-arch.vger.kernel.org>

All the kernel debug style tools (kdb, kgdb, nlkd, netdump, lkcd,
crash, kdump etc.) have a common requirement, they need to do a crash
stop of the systems.  This means stopping all the cpus, even if some of
the cpus are spinning disabled.  In addition, each cpu has to save
enough state to start the diagnosis of the problem.

* Each debug style tool has written its own code for interrupting the
  other cpus and for saving cpu state.

* Some tools try a normal IPI first then send a non-maskable interrupt
  after a delay.

* Some tools always send a NMI first, which can result in incomplete or
  wrong machine state if NMI arrives at the wrong time.

* Most of the tools do not know how to cope with the IA64 architecture
  defined rendezvous algorithm, which interferes with an OS driven
  rendezvous.

* Needless to say, every single patch set conflicts with all the
  others, which makes it very difficult to install more than one of the
  tools at a time.

The solution is to define a common crash_stop API that can be used by
_all_ of the debug style tools, without reinventing the wheel each
time.  The following crash_stop patches implement this API for i386,
x86_64 and ia64.  It correctly handles the complicated ia64 algorithm
for MCA and INIT, unlike almost every current debug style tool.

Adding other architectures is a fairly simple matter, define
the IPI and NMI routines (the crash_stop_$(ARCH)_handlers patch),
intercept the events that indicate that the system is dying (the
crash_stop_$(ARCH) patch), update the Kconfig entry for CRASH_STOP to
add the new $(ARCH).

Most of the design documentation is in the crash_stop_common patch.
Please read that before replying.

crash_stop_header               The architecture independent header.

crash_stop_common               The architecture independent code.

crash_stop_i386_handlers        i386 specific code to send and respond
                                to the crash_stop IPI and NMI.

crash_stop_i386                 i386 specific code to intercept events
                                that indicate that the system is dying.

crash_stop_x86_64_nmiwatchdog   i386 creates an event for NMI watchdog,
                                it is missing from x86_64.  Add
                                DIE_NMIWATCHDOG to x86_64.

crash_stop_x86_64_handlers      x86_64 specific code to send and
                                respond to the crash_stop IPI and NMI.

crash_stop_x86_64               x86_64 specific code to intercept
                                events that indicate that the system is
                                dying.

crash_stop_ia64_handlers        ia64 specific code to send and respond
                                to the crash_stop IPI and NMI.

crash_stop_ia64                 ia64 specific code to intercept events
                                that indicate that the system is dying.

crash_stop_common_Kconfig       Add crash_stop to the config system.
                                Only for i386, x86_64 and ia64 at the
                                moment, extend as new architectures are
                                added.

crash_stop_demo                 A demonstration of using crash_stop in
                                a debug style tool.  Not for inclusion
                                in the kernel.

crash_stop_test                 Test the crash_stop code.  Not for
                                inclusion in the kernel.
