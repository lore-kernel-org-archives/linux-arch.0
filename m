From: Hoeun Ryu <hoeun.ryu@gmail.com>
Subject: [RFC 2/3] arm: enable 64BIT_ATOMIC(_ALIGNED)_ACCESS on LPAE enabled machines
Date: Thu, 24 Aug 2017 14:42:56 +0900
Message-ID: <1503553377-3646-3-git-send-email-hoeun.ryu@gmail.com>
References: <1503553377-3646-1-git-send-email-hoeun.ryu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503553377-3646-1-git-send-email-hoeun.ryu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Nicholas Piggin <npiggin@gmail.com>, Ingo Molnar <mingo@kernel.org>, Michal Marek <mmarek@suse.com>, Laura Abbott <labbott@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, mic@digikod.net, Russell King <linux@armlinux.org.uk>, Vladimir Murzin <vladimir.murzin@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jonathan Austin <jonathan.austin@arm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hoeun.ryu@gmail.com, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

 'ldrd/strd' (load/store doublewords) instructions are 64bit atomic as
long as the address is 64-bit aligned on LPAE (Large Physical Address
Extension) enabled architectures. This feature is to guarantee atomic
accesses on newly introduced 64bit wide descriptors in the translation
tables.

 Making 64BIT_ATOMIC_ACCESS true, some kernel codes to access 64bit
variables can be optimized by omitting seqlock or the mimic of it.
 Also make 64BIT_ATOMIC_ALIGNED_ACCESS true, the 64bit atomic access is
guarnteed only when the address is 64bit algined.

Signed-off-by: Hoeun Ryu <hoeun.ryu@gmail.com>
---
 arch/arm/mm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 60cdfdc..3142572 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -660,6 +660,8 @@ config ARM_LPAE
 	bool "Support for the Large Physical Address Extension"
 	depends on MMU && CPU_32v7 && !CPU_32v6 && !CPU_32v5 && \
 		!CPU_32v4 && !CPU_32v3
+	select 64BIT_ATOMIC_ACCESS
+	select 64BIT_ATOMIC_ALIGNED_ACCESS
 	help
 	  Say Y if you have an ARMv7 processor supporting the LPAE page
 	  table format and you would like to access memory beyond the
-- 
2.7.4
