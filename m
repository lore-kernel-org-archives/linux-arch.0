From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] kbuild: provide THIN_ARCHIVES option for all architectures
Date: Mon, 5 Jun 2017 08:17:26 +0900
Message-ID: <CAK7LNATyoCkDgywEdvR1z5kaTR+Uur1gg7-FT-0fV_HLb7AxMg@mail.gmail.com>
References: <20170529081103.29999-1-npiggin@gmail.com> <CAK8P3a2umsN_fTLbRmMofFYBzfOSdfFTqYcKdtesAdXk9Dbwvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:47142 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbdFDXRf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Jun 2017 19:17:35 -0400
In-Reply-To: <CAK8P3a2umsN_fTLbRmMofFYBzfOSdfFTqYcKdtesAdXk9Dbwvg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>

Hi.

2017-06-01 6:13 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, May 29, 2017 at 10:11 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>> Supporting two different intermediate-artifact packaging schemes
>> was only ever intended as a temporary transition.
>>
>> This has so far caused no problems for powerpc, after a small fix
>> for how the arch invoked ar. So now allow any arch to select the
>> option, continue defaulting to N.
>>
>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>> The next step will be to have archs always select THIN_ARCHIVES
>> when they are known to work. Then remove the option entirely.
>>
>> x86 has always just worked for me, so that should be easy.
>
> I have build-tested many thousand randconfig kernels on arm32 with
> this option enabled, and did not run into build-time regressions
> besides some initial problems from a broken binutils snapshot
> (all released binutils versions should be fine).
>


Please let me mention two advantages of using THIN_ARCHIVES.



[1]
By switching to CONFIG_THIN_ARCHIVES,
we can get back building allyesconfig on ARM.
(probably because the final link is given more flexibility
to insert veneers)

This is a much cleaner solution than the following patch:
https://patchwork.kernel.org/patch/6120441/



[2]
Thick archive does not work well with garbage collection
(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION).

CONFIG_LD_DEAD_CODE_DATA_ELIMINATION can not deal with
static functions with the same function name.


The following is the test code I played with.



diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3dcd7ec..a267145 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -13,6 +13,7 @@ config ARM64
        select ARCH_HAS_ELF_RANDOMIZE
        select ARCH_HAS_GCOV_PROFILE_ALL
        select ARCH_HAS_GIGANTIC_PAGE
+       select LD_DEAD_CODE_DATA_ELIMINATION
        select ARCH_HAS_KCOV
        select ARCH_HAS_SET_MEMORY
        select ARCH_HAS_SG_CHAIN
--- a/init/main.c
+++ b/init/main.c
@@ -485,6 +485,8 @@ static void __init mm_init(void)
        ioremap_huge_init();
 }

+void this_is_called(void);
+
 asmlinkage __visible void __init start_kernel(void)
 {
        char *command_line;
@@ -676,6 +678,9 @@ asmlinkage __visible void __init start_kernel(void)
        }

        /* Do the rest non-__init'ed, we're now alive */
+
+       this_is_called();
+
        rest_init();
 }

diff --git a/kernel/Makefile b/kernel/Makefile
index 72aa080..b938d4e 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -9,7 +9,8 @@ obj-y     = fork.o exec_domain.o panic.o \
            extable.o params.o \
            kthread.o sys_ni.o nsproxy.o \
            notifier.o ksysfs.o cred.o reboot.o \
-           async.o range.o smpboot.o ucount.o
+           async.o range.o smpboot.o ucount.o \
+           foo.o bar.o

 obj-$(CONFIG_MULTIUSER) += groups.o

diff --git a/kernel/bar.c b/kernel/bar.c
new file mode 100644
index 0000000..3b1431e
--- /dev/null
+++ b/kernel/bar.c
@@ -0,0 +1,31 @@
+#include <linux/printk.h>
+
+static void greeting(void)
+{
+       printk("hello world0\n");
+       printk("hello world1\n");
+       printk("hello world2\n");
+       printk("hello world3\n");
+       printk("hello world4\n");
+       printk("hello world5\n");
+       printk("hello world6\n");
+       printk("hello world7\n");
+       printk("hello world8\n");
+       printk("hello world9\n");
+}
+
+void this_is_not_called1(void)
+{
+       int i;
+
+       for (i = 0; i < 100; i++)
+               greeting();
+}
+
+void this_is_not_called2(void)
+{
+       int i;
+
+       for (i = 0; i < 1000; i++)
+               greeting();
+}
diff --git a/kernel/foo.c b/kernel/foo.c
new file mode 100644
index 0000000..10c8e8b
--- /dev/null
+++ b/kernel/foo.c
@@ -0,0 +1,31 @@
+#include <linux/printk.h>
+
+static void greeting(void)
+{
+       printk("goodbye world0\n");
+       printk("goodbye world1\n");
+       printk("goodbye world2\n");
+       printk("goodbye world3\n");
+       printk("goodbye world4\n");
+       printk("goodbye world5\n");
+       printk("goodbye world6\n");
+       printk("goodbye world7\n");
+       printk("goodbye world8\n");
+       printk("goodbye world9\n");
+}
+
+void this_is_called(void)
+{
+       int i;
+
+       for (i = 0; i < 100; i++)
+               greeting();
+}
+
+void this_is_not_called0(void)
+{
+       int i;
+
+       for (i = 0; i < 1000; i++)
+               greeting();
+}



The function greeting() in kernel/foo.c is called,
whereas greeting() in kernel/bar.c is not called.

The latter should be removed from the final binary,
but both are kept.


$ aarch64-linux-gnu-nm  vmlinux | grep 'greeting\|this_is_'
ffff0000080f7420 t greeting
ffff0000080f74a8 t greeting
ffff0000080f7530 T this_is_called





By selecting CONFIG_THIN_ARCHIVES, greeting()
in kernel/bar.c is removed correctly.


$ aarch64-linux-gnu-nm  vmlinux | grep 'greeting\|this_is_'
ffff0000080f2bf0 t greeting
ffff0000080f2c78 T this_is_called





-- 
Best Regards
Masahiro Yamada
