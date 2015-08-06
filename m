From: Mark Salter <msalter@redhat.com>
Subject: [PATCH V2 0/3] mm: Add generic copy from early unmapped RAM
Date: Thu,  6 Aug 2015 17:41:36 -0400
Message-ID: <1438897299-2266-1-git-send-email-msalter@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40091 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780AbbHFVlv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 6 Aug 2015 17:41:51 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Mark Salter <msalter@redhat.com>

When booting an arm64 kernel w/initrd using UEFI/grub, use of mem= will likely
cut off part or all of the initrd. This leaves it outside the kernel linear
map which leads to failure when unpacking. The x86 code has a similar need to
relocate an initrd outside of mapped memory in some cases.

The current x86 code uses early_memremap() to copy the original initrd from
unmapped to mapped RAM. This patchset creates a generic copy_from_early_mem()
utility based on that x86 code and has arm64 and x86 share it in their
respective initrd relocation code.

Changes from V1:

  * Change cover letter subject to highlight the added generic code

  * Add patch for x86 to use common copy_from_early_mem()

Mark Salter (3):
  mm: add utility for early copy from unmapped ram
  arm64: support initrd outside kernel linear map
  x86: use generic early mem copy

 arch/arm64/kernel/setup.c           | 55 +++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/setup.c             | 21 +-------------
 include/asm-generic/early_ioremap.h |  6 ++++
 mm/early_ioremap.c                  | 22 +++++++++++++++
 4 files changed, 84 insertions(+), 20 deletions(-)

-- 
2.4.3
