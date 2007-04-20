Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:40394 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753394AbXDTK4V (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Apr 2007 06:56:21 -0400
From: Andi Kleen <ak@suse.de>
Subject: Better local_t implementation needed
Date: Fri, 20 Apr 2007 12:56:12 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704201256.13008.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Christoph Lameter <clameter@sgi.com>
List-ID: <linux-arch.vger.kernel.org>


Right now local_t falls back to atomic.h on a lot of architectures:

% grep generic include/asm*/local.h
include/asm-arm/local.h:#include <asm-generic/local.h>
include/asm-arm26/local.h:#include <asm-generic/local.h>
include/asm-avr32/local.h:#include <asm-generic/local.h>
include/asm-cris/local.h:#include <asm-generic/local.h>
include/asm-frv/local.h:#include <asm-generic/local.h>
include/asm-h8300/local.h:#include <asm-generic/local.h>
include/asm-m32r/local.h:#include <asm-generic/local.h>
include/asm-m68k/local.h:#include <asm-generic/local.h>
include/asm-m68knommu/local.h:#include <asm-generic/local.h>
include/asm-powerpc/local.h:#include <asm-generic/local.h>
include/asm-s390/local.h:#include <asm-generic/local.h>
include/asm-sh/local.h:#include <asm-generic/local.h>
include/asm-sh64/local.h:#include <asm-generic/local.h>
include/asm-sparc/local.h:#include <asm-generic/local.h>
include/asm-v850/local.h:#include <asm-generic/local.h>
include/asm-xtensa/local.h:#include <asm-generic/local.h>

and asm-generic.h/local.h falls back to atomic_t

This is unfortunate because if one wants to use local_t for 
per CPU counters it will be a full atomic operation which is probably
slow at least on all architectures that support MP.
Using local_t for per cpu counters is nice because then
one can use cpu_local_add() etc. and that generates very good 
code at least on x86 and a few other architectures. That would
then allow very cheap per CPU statistics, which are useful
in a number of subsystems (like networking or MM code)

e.g. on x86 with some of the pending per cpu patches we could
in the end implement cpu_local_add as a single non atomic instruction.
This would compare very favourably to the complicated
code sequences that right now are generated for some of the
statistics counters.

There used to be a portable implementation of local.h 
that instead defines local_t as a two value array 
indexed by in_interrupt(). I'm considering to add that back.

Drawback will be larger code. 

Architectures that have cheap atomic_t can just use the atomic_t 
fallback. That should be all architectures that are not MP capable?

If you have cheap save_flags/cli/restore_flags that could be also used.

Or some other architecture specific implementation. For example x86
which has atomic on a CPU read/modify/write instructions can just use those.

I would urge you that if it's  easy to do a better local_t to implement it.

Comments?

-Andi
