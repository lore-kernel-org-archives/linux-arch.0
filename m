Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:36297 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593AbaENMw7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 May 2014 08:52:59 -0400
From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v4 0/4] metag,parisc: Stack limit patches
Date: Wed, 14 May 2014 13:52:44 +0100
Message-ID: <1400071968-21581-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: James Hogan <james.hogan@imgtec.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Arnd Bergmann <arnd@arndb.de>, John David Anglin <dave.anglin@bell.net>, linux-arch@vger.kernel.org, linux-metag@vger.kernel.org, linux-parisc@vger.kernel.org
Message-ID: <20140514125244.ZEnTJIgCYNnDF6IxFjZHIolnBo4YDUvV7DzpCmajTbU@z>

Patch 1 is a metag bug fix for v3.15 & stable.

Patch 2 depends on patch 1, and makes the stack limit configurable.
Helge: I don't object if you want to take this patch yourself since it
was originally yours, so long as it goes after patch 1 (which I'll try
and get into v3.15-rc6).

Patch 3 depends on patch 1, and removes the RLIMIT_STACK default value
for metag. I'll take this through metag tree for v3.16.

Patch 4 depends on patch 3 and the corresponding parisc patch and
removes the ability to override the default hard RLIMIT_STACK. Depending
on when the parisc patch reaches mainline I'll try and get this in for
v3.16.

Helge Deller (1):
  parisc,metag: Do not hardcode maximum userspace stack size

James Hogan (3):
  metag: Reduce maximum stack size to 256MB
  metag: Remove _STK_LIM_MAX override
  asm-generic: remove _STK_LIM_MAX

 arch/metag/include/asm/processor.h     |  2 ++
 arch/metag/include/uapi/asm/Kbuild     |  2 +-
 arch/metag/include/uapi/asm/resource.h |  7 -------
 arch/parisc/include/asm/processor.h    |  5 +++++
 arch/parisc/kernel/sys_parisc.c        |  6 +++---
 fs/exec.c                              |  6 +++---
 include/asm-generic/resource.h         |  2 +-
 include/uapi/asm-generic/resource.h    |  7 -------
 mm/Kconfig                             | 15 +++++++++++++++
 9 files changed, 30 insertions(+), 22 deletions(-)
 delete mode 100644 arch/metag/include/uapi/asm/resource.h

Cc: Helge Deller <deller@gmx.de>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: John David Anglin <dave.anglin@bell.net>
Cc: linux-arch@vger.kernel.org
Cc: linux-metag@vger.kernel.org
Cc: linux-parisc@vger.kernel.org

-- 
1.9.3

