Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:37112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390933AbfHWQhW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Aug 2019 12:37:22 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v10 0/1] arm64 tagged address ABI
Date: Fri, 23 Aug 2019 17:37:16 +0100
Message-ID: <20190823163717.19569-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, Andrey Konovalov <andreyknvl@google.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Dave P Martin <Dave.Martin@arm.com>, Dave Hansen <dave.hansen@intel.com>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190823163716.u-uic6-cmL4XWPpJ6FlvWX6oDTuuv1q03lFzNG23DEQ@z>

Hi,

Minor update to the arm64 tagged address ABI documentation since v9,
posted here:

http://lkml.kernel.org/r/20190821164730.47450-1-catalin.marinas@arm.com

The mmap/mremap/... patch (1/3) has been queued in the -mm tree and
removed from this series. The tagged-address-abi.rst patch (2/3) has
been queued in the arm64 for-next/core tree. There is only one patch
left in this series (keeping the cover letter for consistency).

Changes in v10:

- Remove the tag preservation paragraph since the new ABI does not
  change the behaviour we already have. The only difference is that now
  the kernel can access tagged addresses (e.g. delivering a signal on a
  tagged alternate stack).

Vincenzo Frascino (1):
  arm64: Relax Documentation/arm64/tagged-pointers.rst

 Documentation/arm64/tagged-pointers.rst | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)
