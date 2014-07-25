From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 0/2] mm/highmem: make kmap cache coloring aware
Date: Fri, 25 Jul 2014 23:43:45 +0400
Message-ID: <1406317427-10215-1-git-send-email-jcmvbkbc__21151.3774739162$1406317481$gmane$org@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-xtensa@linux-xtensa.org
Cc: Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@cadence.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, Steven Hill <Steven.Hill@imgtec.com>, Max Filippov <jcmvbkbc@gmail.com>
List-Id: linux-arch.vger.kernel.org

Hi,

this series adds mapping color control to the generic kmap code, allowing
architectures with aliasing VIPT cache to use high memory. There's also
use example of this new interface by xtensa.

Max Filippov (2):
  mm/highmem: make kmap cache coloring aware
  xtensa: support aliasing cache in kmap

 arch/xtensa/include/asm/highmem.h | 40 +++++++++++++++++-
 arch/xtensa/mm/highmem.c          | 18 ++++++++
 mm/highmem.c                      | 89 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 134 insertions(+), 13 deletions(-)

-- 
1.8.1.4
