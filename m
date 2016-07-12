From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/2] arm/arm64: localise objcopy flags
Date: Tue, 12 Jul 2016 16:28:00 +0100
Message-ID: <1468337282-14527-1-git-send-email-mark.rutland@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60159 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962AbcGLP2U (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Jul 2016 11:28:20 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, catalin.marinas@arm.com, keescook@chromium.org, labbott@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com, will.deacon@arm.com

Hi,

Typically, architectures (including arm and arm64) define OBJCOPYFLAGS in their
top-level makefile, for the purpose of generating a raw binaries suitable for
booting, including Image, zImage, vmlinux.bin, etc.

As this top-level arch makefile is included by the top-level kernel makefile,
these flags are passed to other invocations of objcopy tree-wide. This can
result in unexpected and inconsistent behaviour across architectures (e.g.
generation of a raw binary rather than an ELF [1]).

Rather than force each new user of objcopy to specially clear OBJCOPYFLAGS,
this patch moves the existing OBJCOPYFLAGS variable definitions such that they
only affects the cases we require them for today, leaving the global namespace
clear.

Other architectures will likely need similar treatment.

Thanks,
Mark.

[1] http://www.openwall.com/lists/kernel-hardening/2016/06/08/2

Mark Rutland (2):
  arm64: localise Image objcopy flags
  arm: localise objcopy flags

 arch/arm/Makefile        | 1 -
 arch/arm/boot/Makefile   | 2 ++
 arch/arm64/Makefile      | 1 -
 arch/arm64/boot/Makefile | 2 ++
 4 files changed, 4 insertions(+), 2 deletions(-)

-- 
1.9.1
