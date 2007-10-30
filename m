Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.polymtl.ca ([132.207.4.11]:51140 "EHLO smtp.polymtl.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753373AbXJ3Tn4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 30 Oct 2007 15:43:56 -0400
Message-Id: <20071030191557.947156623@polymtl.ca>
Date: Tue, 30 Oct 2007 15:15:57 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: [patch 00/28] cmpxchg_local standardization across architectures
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org, penberg@cs.helsinki.fi, linux-mm@kvack.org, Christoph Lameter <clameter@sgi.com>
List-ID: <linux-arch.vger.kernel.org>

Hi,

Here is the patchset that performs cmpxchg_local and cmpxchg64_local
standardization across architectures. It uses interrupt save/restore to emulate
the atomic operation on architectures lacking such atomic op.

We have seen interesing performance gain in slub on architectures where the
local cmpxchg is faster than interrupt disable, namely x86 and amd64. It becomes
less interesting on architectures lacking atomic ops and where the only cmpxchg
primitive available is almost as fast as irq disable/enable (ia64); a small
performance hit can be expected, mostly due to the additionnal memory barriers
it adds to the code (and the fact that it is faster to disable interrupts once
for a longer time rather than multiple times).

It applies in this order on 2.6.23-mm1 :

add-cmpxchg-local-to-generic-for-up.patch
i386-cmpxchg64-80386-80486-fallback.patch
add-cmpxchg64-to-alpha.patch
add-cmpxchg64-to-mips.patch
add-cmpxchg64-to-powerpc.patch
add-cmpxchg64-to-x86_64.patch
#
add-cmpxchg-local-to-arm.patch
add-cmpxchg-local-to-avr32.patch
add-cmpxchg-local-to-blackfin.patch
add-cmpxchg-local-to-cris.patch
add-cmpxchg-local-to-frv.patch
add-cmpxchg-local-to-h8300.patch
add-cmpxchg-local-to-ia64.patch
add-cmpxchg-local-to-m32r.patch
fix-m32r-__xchg.patch
fix-m32r-include-sched-h-in-smpboot.patch
local_t_m32r_optimized.patch
add-cmpxchg-local-to-m68k.patch
add-cmpxchg-local-to-m68knommu.patch
add-cmpxchg-local-to-parisc.patch
add-cmpxchg-local-to-ppc.patch
add-cmpxchg-local-to-s390.patch
add-cmpxchg-local-to-sh.patch
add-cmpxchg-local-to-sh64.patch
add-cmpxchg-local-to-sparc.patch
add-cmpxchg-local-to-sparc64.patch
add-cmpxchg-local-to-v850.patch
add-cmpxchg-local-to-xtensa.patch

Mathieu

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
