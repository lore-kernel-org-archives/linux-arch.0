From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 0/2] mm/highmem: make kmap cache coloring aware
Date: Sat,  2 Aug 2014 05:11:37 +0400
Message-ID: <1406941899-19932-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:61967 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbaHBBMH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Aug 2014 21:12:07 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-xtensa@linux-xtensa.org
Cc: Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@cadence.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, Steven Hill <Steven.Hill@imgtec.com>, Max Filippov <jcmvbkbc@gmail.com>

Hi,

this series adds mapping color control to the generic kmap code, allowing
architectures with aliasing VIPT cache to use high memory. There's also
use example of this new interface by xtensa.

Changes since v3:
- drop #include <asm/highmem.h> from mm/highmem.c as it's done in
  linux/highmem.h;
- add 'User-visible effect' section to changelog.

Max Filippov (2):
  mm/highmem: make kmap cache coloring aware
  xtensa: support aliasing cache in kmap

 arch/xtensa/include/asm/highmem.h | 40 +++++++++++++++++-
 arch/xtensa/mm/highmem.c          | 18 ++++++++
 mm/highmem.c                      | 86 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 131 insertions(+), 13 deletions(-)

-- 
1.8.1.4
