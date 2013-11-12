Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63093 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755239Ab3KLNYd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Nov 2013 08:24:33 -0500
From: Mark Salter <msalter@redhat.com>
Subject: [PATCH 00/11] Consolidate asm/fixmap.h files
Date: Tue, 12 Nov 2013 08:22:14 -0500
Message-ID: <1384262545-20875-1-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Mark Salter <msalter@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20131112132214.hz3Ok16EWZLbs_93fxKTl9-mrK4iTcc59zG7_Bspn58@z>

Many architectures provide an asm/fixmap.h which defines support for
compile-time 'special' virtual mappings which need to be made before
paging_init() has run. This suport is also used for early ioremap
on x86. Much of this support is identical across the architectures.
This patch consolidates all of the common bits into asm-generic/fixmap.h
which is intended to be included from arch/*/include/asm/fixmap.h.

This has been compiled on x86, arm, powerpc, and sh, but tested
on x86 only.

Mark Salter (11):
  Add generic fixmap.h
  x86: use generic fixmap.h
  arm: use generic fixmap.h
  hexagon: use generic fixmap.h
  metag: use generic fixmap.h
  microblaze: use generic fixmap.h
  mips: use generic fixmap.h
  powerpc: use generic fixmap.h
  sh: use generic fixmap.h
  tile: use generic fixmap.h
  um: use generic fixmap.h

 arch/arm/include/asm/fixmap.h        |  25 ++------
 arch/hexagon/include/asm/fixmap.h    |  40 +------------
 arch/metag/include/asm/fixmap.h      |  32 +----------
 arch/microblaze/include/asm/fixmap.h |  44 +-------------
 arch/mips/include/asm/fixmap.h       |  33 +----------
 arch/powerpc/include/asm/fixmap.h    |  44 +-------------
 arch/sh/include/asm/fixmap.h         |  39 +------------
 arch/tile/include/asm/fixmap.h       |  33 +----------
 arch/um/include/asm/fixmap.h         |  40 +------------
 arch/x86/include/asm/fixmap.h        |  59 +------------------
 include/asm-generic/fixmap.h         | 107 +++++++++++++++++++++++++++++++++++
 11 files changed, 125 insertions(+), 371 deletions(-)
 create mode 100644 include/asm-generic/fixmap.h

-- 
1.8.3.1

