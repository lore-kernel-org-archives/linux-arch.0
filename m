Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel12.hp.com ([156.153.255.237]:7628 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S267899AbUGWTDv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 Jul 2004 15:03:51 -0400
Received: from hplms2.hpl.hp.com (hplms2.hpl.hp.com [15.0.152.33])
	by palrel12.hp.com (Postfix) with ESMTP id CE24C4004DC
	for <linux-arch@vger.kernel.org>; Fri, 23 Jul 2004 12:03:50 -0700 (PDT)
Received: from napali.hpl.hp.com (napali.hpl.hp.com [15.4.89.123])
	by hplms2.hpl.hp.com (8.12.10/8.12.10/HPL-PA Hub) with ESMTP id i6NJ3msf028792
	for <linux-arch@vger.kernel.org>; Fri, 23 Jul 2004 12:03:49 -0700 (PDT)
Received: from napali.hpl.hp.com (napali [127.0.0.1])
	by napali.hpl.hp.com (8.12.11/8.12.11/Debian-3) with ESMTP id i6NJ3m13009180
	for <linux-arch@vger.kernel.org>; Fri, 23 Jul 2004 12:03:48 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16641.24851.933837.18126@napali.hpl.hp.com>
Date: Fri, 23 Jul 2004 12:03:47 -0700
Subject: heads-up: may want to define elf_read_implies_exec_binary()
Reply-To: davidm@hpl.hp.com
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Linus just checked in this patch:

  http://linux.bkbits.net:8080/linux-2.5/cset@1.1865

   [PATCH] NX: allow architectures to select legacy mode dynamically

If your architecture wants execute-permission implicitly turned on for
memory regions that have read-permission, you'll need to add:

#define elf_read_implies_exec_binary(ex, have_pt_gnu_stack)	(!(have_pt_gnu_stack))

to asm-ARCH/elf.h (see asm-i386/elf.h for an example).  Of course, if
the binary has a PT_GNU_STACK header, then that will take precedence.

	--david
