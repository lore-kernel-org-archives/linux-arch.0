Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:28893 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932582AbWHHMXV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Aug 2006 08:23:21 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 0/13] Generic ioremap_page_range: introduction
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 08 Aug 2006 14:23:02 +0200
Message-Id: <11550397951750-git-send-email-hskinnemoen@atmel.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
List-ID: <linux-arch.vger.kernel.org>

Since no one seemed to have any serious objections, here's a complete
patchset with an updated ioremap_page_range() based on suggestions from
Dave Hansen, Paul Mackerras and David Miller.

This also updates all architectures that were relatively trivial to
convert. Most of remaining architectures implement ioremap() as a
no-op or something close. Exceptions are m68k, powerpc and sparc.

m68k has some CPU-dependent logic in the middle of the loop.

powerpc could probably use generic ioremap_page_range(), but doing so
would probably increase the code size, as the map_page() functions
have other users in addition to ioremap().

sparc seems to do something completely different than everyone else.

I'll post the implementation as well as one patch per architecture
conversion right after this. I haven't compile-tested most of the
architecture changes, but it compiles and runs on AVR32.

Overall diffstat below.

Haavard

 arch/alpha/kernel/proto.h |   15 +++++-
 arch/alpha/mm/Makefile    |    2 -
 arch/alpha/mm/remap.c     |   86 --------------------------------
 arch/arm/mm/ioremap.c     |   95 ++----------------------------------
 arch/avr32/mm/ioremap.c   |  120 ++-------------------------------------------
 arch/cris/mm/ioremap.c    |   88 +--------------------------------
 arch/i386/mm/ioremap.c    |   85 ++------------------------------
 arch/m32r/mm/ioremap.c    |   93 +++--------------------------------
 arch/mips/mm/ioremap.c    |   95 +++---------------------------------
 arch/parisc/mm/ioremap.c  |  111 +++---------------------------------------
 arch/s390/mm/ioremap.c    |   84 +-------------------------------
 arch/sh/mm/ioremap.c      |   97 +++---------------------------------
 arch/sh64/mm/ioremap.c    |  100 +++-----------------------------------
 arch/x86_64/mm/ioremap.c  |  110 ++---------------------------------------
 include/linux/io.h        |    4 ++
 lib/Makefile              |    2 -
 lib/ioremap.c             |   91 ++++++++++++++++++++++++++++++++++
 17 files changed, 174 insertions(+), 1104 deletions(-)
