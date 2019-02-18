Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay10.mail.gandi.net ([217.70.178.230]:50899 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730224AbfBRKxS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2019 05:53:18 -0500
Date: Mon, 18 Feb 2019 11:53:15 +0100
From: Hugo Lefeuvre <hle@owl.eu.com>
Subject: [PATCH 0/4] iomap: fix multiple consistency issues, interface cleanup
Message-ID: <cover.1550485787.git.hle@owl.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190218105315.ae73JdDKeS6f6wx9VBmc0kXWknqfUeOvxhRNPpCGFfY@z>

Hi,

This patch cleans up the iomap interface.

The first patch makes the include/asm-generic/iomap.h header compliant
with the kernel style guidelines by adding missing function args
identifier names.

The second and fourth patches address multiple compilation warnings due
to missing const qualifiers in mmio_ins* and ioread*/iowrite
definitions in include/asm-generic/iomap.h and lib/iomap.c.

The third patch modifies io*_rep definitions from asm-generic/io.h to
take unsigned long count parameter instead of unsigned int which is
inconsistent with other definitions in the kernel.

Hugo Lefeuvre (4):
  iomap: add missing function args identifier names
  iomap: add missing const to ioread*/iowrite addr arg
  io: change io*_rep definitions to take ulong count
  lib/iomap: add missing const to mmio_ins* addr arg

 include/asm-generic/io.h    | 16 ++++++++--------
 include/asm-generic/iomap.h | 38 ++++++++++++++++++-------------------
 lib/iomap.c                 | 22 ++++++++++-----------
 3 files changed, 38 insertions(+), 38 deletions(-)

-- 
2.20.1
