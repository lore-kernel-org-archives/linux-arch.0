Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S261685AbULBRtu@vger.kernel.org>
Received: from palrel12.hp.com ([156.153.255.237]:10443 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261684AbULBRtu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Dec 2004 12:49:50 -0500
Received: from hplms2.hpl.hp.com (hplms2.hpl.hp.com [15.0.152.33])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by palrel12.hp.com (Postfix) with ESMTP id 37C5E40A725
	for <linux-arch@vger.kernel.org>; Thu,  2 Dec 2004 09:49:45 -0800 (PST)
Received: from napali.hpl.hp.com (napali.hpl.hp.com [15.4.89.123])
	by hplms2.hpl.hp.com (8.13.1/8.13.1/HPL-PA Hub) with ESMTP id iB2Hnhjr011893
	for <linux-arch@vger.kernel.org>; Thu, 2 Dec 2004 09:49:44 -0800 (PST)
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16815.21943.55627.572012@napali.hpl.hp.com>
Date: Thu, 2 Dec 2004 09:49:43 -0800
Subject: other platforms interested in in-kernel unwinder?
Reply-To: davidm@hpl.hp.com
To: linux-arch@vger.kernel.org
Cc: davidm@napali.hpl.hp.com
List-ID: <linux-arch.vger.kernel.org>

Soon I'd like to start work on replacing the existing ia64
stack-unwinder with something based on libunwind [1].  I can obviously
do this for ia64 only, but given the per-annual bug reports about
broken backtraces on various platforms, I thought perhaps other arch
maintainers would be interested in having an in-kernel unwinder, too.

libunwind already has a DWARF2 unwinder and works, in addition to
ia64, on x86 and x86-64.  I hope to add PA-RISC and Alpha soon, too.

Given this, it might make sense to add a libunwind-based unwinder not
just for ia64, but other platforms, too.  IIRC, there may be
plans/code for in-kernel unwinder for PPC{,64} already?

The upside of using an in-kernel unwinder would primarily be reliable
stack-traces, at the expense of a somewhat increased kernel-size (for
x86-64, the core of the user-level unwinder adds up to about 60KB of
code (compiled with -O) and about 32KB of data.  Most of the code-size
is due to the actual DWARF2 expression interpreter, so there is
probably not much hope of getting a _really_ tiny DWARF2 unwinder, but
certainly for workstation/server-type machines, it's probably worth
spending <128KB of memory in return for reliable stack traces.

So, how does this sound?  Any interest from say, x86{-64}, PPC, SPARC,
or any other arch maintainer?

Thanks,

	--david

[1] http://www.hpl.hp.com/research/linux/libunwind/
