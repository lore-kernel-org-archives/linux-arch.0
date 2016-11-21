From: Adam Borowski <kilobyte@angband.pl>
Subject: [PATCH resend] kbuild: provide include/asm/asm-prototypes.h for x86
Date: Mon, 21 Nov 2016 07:39:45 +0100
Message-ID: <20161121063945.6586-1-kilobyte@angband.pl>
References: <20161121164940.33b555ea@roar.ozlabs.ibm.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20161121164940.33b555ea@roar.ozlabs.ibm.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>, Peter Wu <peter@lekensteyn.nl>, Vince Weaver <vincent.weaver@maine.edu>, Michal Marek <mmarek@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, regressions@leemhuis.info, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: Adam Borowski <kilobyte@angband.pl>
List-Id: linux-arch.vger.kernel.org

Nicholas Piggin wrote:
> Architectures will need to have an include/asm/asm-prototypes.h that
> defines or #include<>s C-style prototypes for exported asm functions.
> We can do an asm-generic version for the common ones like memset so
> there's not a lot of pointless duplication there.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
Tested-by: Kalle Valo <kvalo@codeaurora.org>
---
 arch/x86/include/asm/asm-prototypes.h | 12 ++++++++++++
 include/asm-generic/asm-prototypes.h  |  7 +++++++
 2 files changed, 19 insertions(+)
 create mode 100644 arch/x86/include/asm/asm-prototypes.h
 create mode 100644 include/asm-generic/asm-prototypes.h

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
new file mode 100644
index 0000000..ae87224
--- /dev/null
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -0,0 +1,12 @@
+#include <asm/ftrace.h>
+#include <asm/uaccess.h>
+#include <asm/string.h>
+#include <asm/page.h>
+#include <asm/checksum.h>
+
+#include <asm-generic/asm-prototypes.h>
+
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/special_insns.h>
+#include <asm/preempt.h>
diff --git a/include/asm-generic/asm-prototypes.h b/include/asm-generic/asm-prototypes.h
new file mode 100644
index 0000000..df13637
--- /dev/null
+++ b/include/asm-generic/asm-prototypes.h
@@ -0,0 +1,7 @@
+#include <linux/bitops.h>
+extern void *__memset(void *, int, __kernel_size_t);
+extern void *__memcpy(void *, const void *, __kernel_size_t);
+extern void *__memmove(void *, const void *, __kernel_size_t);
+extern void *memset(void *, int, __kernel_size_t);
+extern void *memcpy(void *, const void *, __kernel_size_t);
+extern void *memmove(void *, const void *, __kernel_size_t);
-- 
2.10.2

Nicholas Piggin wrote:
> On Sun, 20 Nov 2016 19:26:23 +0100 Peter Wu <peter@lekensteyn.nl> wrote:
>
>> Current git master (v4.9-rc5-364-g77079b1) with the latest kbuild fixes
>> is still failing to load modules when built with CONFIG_MODVERSIONS=y on
>> x86_64 using GCC 6.2.1.
>>
>> It can still be reproduced with make defconfig, then enabling
>> CONFIG_MODVERSIONS=y. The build output contains:
>>
>>     WARNING: "memcpy" [net/netfilter/nf_nat.ko] has no CRC!
>>     WARNING: "memmove" [net/netfilter/nf_nat.ko] has no CRC!
>>     WARNING: "_copy_to_user" [fs/efivarfs/efivarfs.ko] has no CRC!
>>     WARNING: "memcpy" [fs/efivarfs/efivarfs.ko] has no CRC!
>>     WARNING: "_copy_from_user" [fs/efivarfs/efivarfs.ko] has no CRC!
>
> Sorry it's taken some time, bear with us. The arch specific patches need
> to be merged now. Adam, what is the status of your patch? Please submit
> to x86 maintainers if you haven't already.

I've re-checked against 4.9-rc6.

It'd probably fit better with kbuild parts, but it's up to you to decide;
I'm sending to x86 guys as you wish.


Meow!
