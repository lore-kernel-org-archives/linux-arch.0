Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.89.28.114]:19609 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbaDWKIh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Apr 2014 06:08:37 -0400
From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 0/3] asm-generic: Add renameat2, drop renameat by default
Date: Wed, 23 Apr 2014 11:08:04 +0100
Message-ID: <1398247687-13453-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, linux-c6x-dev@linux-c6x.org, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, linux@lists.openrisc.net, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Chris Metcalf <cmetcalf@tilera.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>
Message-ID: <20140423100804.Pfwke77JujugWAiFCR7iHt8fyXWjsadKG7AQtOttz_0@z>

A few patches relating to the renameat2 syscall added for v3.15 and the
asm-generic syscall list.

The first adds it to the generic syscall list. I'll send this upstream
for v3.15 (but acks still welcome).

The second and third patches make the renameat syscall optional, since
renameat2 provides a superset of its functionality, and removes renameat
from the generic syscall list by default. All existing users now define
__ARCH_WANT_RENAMEAT so that nothing breaks, but new architectures are
expected not to define it. Unless anybody requests otherwise I'll await
an Ack from Arnd for these two and queue them for v3.16.

James Hogan (3):
  asm-generic: Add renameat2 syscall
  scripts/checksyscalls.sh: Make renameat optional
  asm-generic: Drop renameat syscall from default list

 arch/arc/include/uapi/asm/unistd.h       | 1 +
 arch/arm64/include/uapi/asm/unistd.h     | 3 +++
 arch/c6x/include/uapi/asm/unistd.h       | 1 +
 arch/hexagon/include/uapi/asm/unistd.h   | 1 +
 arch/metag/include/uapi/asm/unistd.h     | 2 ++
 arch/openrisc/include/uapi/asm/unistd.h  | 1 +
 arch/score/include/uapi/asm/unistd.h     | 1 +
 arch/tile/include/uapi/asm/unistd.h      | 1 +
 arch/unicore32/include/uapi/asm/unistd.h | 2 ++
 include/uapi/asm-generic/unistd.h        | 7 ++++++-
 scripts/checksyscalls.sh                 | 5 ++++-
 11 files changed, 23 insertions(+), 2 deletions(-)

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
Cc: linux-c6x-dev@linux-c6x.org
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Cc: linux-metag@vger.kernel.org
Cc: Jonas Bonn <jonas@southpole.se>
Cc: linux@lists.openrisc.net
Cc: Chen Liqin <liqin.linux@gmail.com>
Cc: Lennox Wu <lennox.wu@gmail.com>
Cc: Chris Metcalf <cmetcalf@tilera.com>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>

-- 
1.8.1.2

