Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40319 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfKGSn6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Nov 2019 13:43:58 -0500
Received: by mail-ot1-f68.google.com with SMTP id m15so2904916otq.7
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 10:43:57 -0800 (PST)
MIME-Version: 1.0
References: <20191104142745.14722-2-elver@google.com> <201911070445.vRUSVUAX%lkp@intel.com>
In-Reply-To: <201911070445.vRUSVUAX%lkp@intel.com>
From: Marco Elver <elver@google.com>
Date: Thu, 7 Nov 2019 19:43:45 +0100
Message-ID: <CANpmjNNWeM91Jmoh8aujpBA9YVfL6LSqH-taQO-6BJQwUZfCkw@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] kcsan: Add Kernel Concurrency Sanitizer infrastructure
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@lists.01.org, LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Alexander Potapenko <glider@google.com>, Andrea Parri <parri.andrea@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>, Daniel Lustig <dlustig@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Howells <dhowells@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@redhat.com>, Luc Maranget <luc.maranget@inria.fr>, Mark Rutland <mark.rutland@arm.com>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-arch <linux-arch@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-efi@vger.kernel.org, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, the arch/x86 maintainers <x86@kernel.org>
Message-ID: <20191107184345.rd48vBj8GpZiYQEqkg2AmY7dNfN_v8JLEEhvh-gP57M@z>

On Wed, 6 Nov 2019 at 21:35, kbuild test robot <lkp@intel.com> wrote:
>
> Hi Marco,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.4-rc6]
> [cannot apply to next-20191106]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Marco-Elver/Add-Kernel-Concurrency-Sanitizer-KCSAN/20191105-002542
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git a99d8080aaf358d5d23581244e5da23b35e340b9
> config: x86_64-randconfig-a004-201944 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.2-10+deb8u1) 4.9.2
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>

Thanks! Will send v4 with a fix.

> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/compiler_types.h:59:0,
>                     from <command-line>:0:
> >> include/linux/compiler_attributes.h:35:29: warning: "__GCC4_has_attribute___no_sanitize_thread__" is not defined [-Wundef]
>     # define __has_attribute(x) __GCC4_has_attribute_##x
>                                 ^
> >> include/linux/compiler-gcc.h:148:5: note: in expansion of macro '__has_attribute'
>     #if __has_attribute(__no_sanitize_thread__) && defined(__SANITIZE_THREAD__)
>         ^
> --
>    In file included from include/linux/compiler_types.h:59:0,
>                     from <command-line>:0:
> >> include/linux/compiler_attributes.h:35:29: warning: "__GCC4_has_attribute___no_sanitize_thread__" is not defined [-Wundef]
>     # define __has_attribute(x) __GCC4_has_attribute_##x
>                                 ^
> >> include/linux/compiler-gcc.h:148:5: note: in expansion of macro '__has_attribute'
>     #if __has_attribute(__no_sanitize_thread__) && defined(__SANITIZE_THREAD__)
>         ^
>    fs/afs/dynroot.c: In function 'afs_dynroot_lookup':
>    fs/afs/dynroot.c:117:6: warning: 'len' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      ret = lookup_one_len(name, dentry->d_parent, len);
>          ^
>    fs/afs/dynroot.c:91:6: note: 'len' was declared here
>      int len;
>          ^
> --
>    In file included from include/linux/compiler_types.h:59:0,
>                     from <command-line>:0:
> >> include/linux/compiler_attributes.h:35:29: warning: "__GCC4_has_attribute___no_sanitize_thread__" is not defined [-Wundef]
>     # define __has_attribute(x) __GCC4_has_attribute_##x
>                                 ^
> >> include/linux/compiler-gcc.h:148:5: note: in expansion of macro '__has_attribute'
>     #if __has_attribute(__no_sanitize_thread__) && defined(__SANITIZE_THREAD__)
>         ^
>    7 real  2 user  5 sys  107.26% cpu   make modules_prepare
> --
>    In file included from include/linux/compiler_types.h:59:0,
>                     from <command-line>:0:
> >> include/linux/compiler_attributes.h:35:29: warning: "__GCC4_has_attribute___no_sanitize_thread__" is not defined [-Wundef]
>     # define __has_attribute(x) __GCC4_has_attribute_##x
>                                 ^
> >> include/linux/compiler-gcc.h:148:5: note: in expansion of macro '__has_attribute'
>     #if __has_attribute(__no_sanitize_thread__) && defined(__SANITIZE_THREAD__)
>         ^
>    In file included from include/linux/compiler_types.h:59:0,
>                     from <command-line>:0:
> >> include/linux/compiler_attributes.h:35:29: warning: "__GCC4_has_attribute___no_sanitize_thread__" is not defined [-Wundef]
>     # define __has_attribute(x) __GCC4_has_attribute_##x
>                                 ^
> >> include/linux/compiler-gcc.h:148:5: note: in expansion of macro '__has_attribute'
>     #if __has_attribute(__no_sanitize_thread__) && defined(__SANITIZE_THREAD__)
>         ^
>    In file included from include/linux/compiler_types.h:59:0,
>                     from <command-line>:0:
> >> include/linux/compiler_attributes.h:35:29: warning: "__GCC4_has_attribute___no_sanitize_thread__" is not defined [-Wundef]
>     # define __has_attribute(x) __GCC4_has_attribute_##x
>                                 ^
> >> include/linux/compiler-gcc.h:148:5: note: in expansion of macro '__has_attribute'
>     #if __has_attribute(__no_sanitize_thread__) && defined(__SANITIZE_THREAD__)
>         ^
>    In file included from include/linux/compiler_types.h:59:0,
>                     from <command-line>:0:
> >> include/linux/compiler_attributes.h:35:29: warning: "__GCC4_has_attribute___no_sanitize_thread__" is not defined [-Wundef]
>     # define __has_attribute(x) __GCC4_has_attribute_##x
>                                 ^
> >> include/linux/compiler-gcc.h:148:5: note: in expansion of macro '__has_attribute'
>     #if __has_attribute(__no_sanitize_thread__) && defined(__SANITIZE_THREAD__)
>         ^
>    In file included from include/linux/compiler_types.h:59:0,
>                     from <command-line>:0:
> >> include/linux/compiler_attributes.h:35:29: warning: "__GCC4_has_attribute___no_sanitize_thread__" is not defined [-Wundef]
>     # define __has_attribute(x) __GCC4_has_attribute_##x
>                                 ^
> >> include/linux/compiler-gcc.h:148:5: note: in expansion of macro '__has_attribute'
>     #if __has_attribute(__no_sanitize_thread__) && defined(__SANITIZE_THREAD__)
>         ^
>    8 real  24 user  10 sys  405.87% cpu         make prepare
>
> vim +/__has_attribute +148 include/linux/compiler-gcc.h
>
>    147
>  > 148  #if __has_attribute(__no_sanitize_thread__) && defined(__SANITIZE_THREAD__)
>    149  #define __no_sanitize_thread                                                   \
>    150          __attribute__((__noinline__)) __attribute__((no_sanitize_thread))
>    151  #else
>    152  #define __no_sanitize_thread
>    153  #endif
>    154
>
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/201911070445.vRUSVUAX%25lkp%40intel.com.
