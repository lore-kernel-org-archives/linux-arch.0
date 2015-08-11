From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 00/11] test_user_copy improvements
Date: Mon, 10 Aug 2015 21:08:04 -0700 (PDT)
Message-ID: <20150810.210804.1413406155445559341.davem@davemloft.net>
References: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
	<20150810.152938.1076489414700359615.davem@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150810.152938.1076489414700359615.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: james.hogan@imgtec.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, keescook@chromium.org, akpm@linux-foundation.org, monstr@monstr.eu, lftan@altera.com, jonas@southpole.se, chris@zankel.net, jcmvbkbc@gmail.com, nios2-dev@lists.rocketboards.org, linux@lists.openrisc.net, linux-xtensa@linux-xtensa.org
List-Id: linux-arch.vger.kernel.org

From: David Miller <davem@redhat.com>
Date: Mon, 10 Aug 2015 15:29:38 -0700 (PDT)

> Also, I think the tests you added and protected with MIPS ifdefs could
> equally be enabled on sparc64.

James, as per this issue, I was thinking we could do something like this
so that the tests don't get messy:

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cee5f93..48d20c8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1922,6 +1922,7 @@ config CPU_MIPSR6
 
 config EVA
 	bool
+	select ARCH_SPLIT_VA_SPACE
 
 config XPA
 	bool
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 56442d2..4001d04 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -80,6 +80,7 @@ config SPARC64
 	select NO_BOOTMEM
 	select HAVE_ARCH_AUDITSYSCALL
 	select ARCH_SUPPORTS_ATOMIC_RMW
+	select ARCH_SPLIT_VA_SPACE
 
 config ARCH_DEFCONFIG
 	string
diff --git a/lib/Kconfig b/lib/Kconfig
index 3a2ef67..149eb29 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -62,6 +62,9 @@ config ARCH_USE_CMPXCHG_LOCKREF
 config ARCH_HAS_FAST_MULTIPLIER
 	bool
 
+config ARCH_SPLIT_VA_SPACE
+       def_bool n
+
 config CRC_CCITT
 	tristate "CRC-CCITT functions"
 	help
