Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:40684 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbeCNVW4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Mar 2018 17:22:56 -0400
Received: by mail-io0-f193.google.com with SMTP id v6so6056112iog.7
        for <linux-arch@vger.kernel.org>; Wed, 14 Mar 2018 14:22:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201803150509.5NWRa9LX%fengguang.wu@intel.com>
References: <201803150509.5NWRa9LX%fengguang.wu@intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 22:22:54 +0100
Message-ID: <CAK8P3a3d5WxquftmwYYR8LAbXGahyLEGW3Wy3QHxPK2MyCDgTQ@mail.gmail.com>
Subject: Re: [asm-generic:master 12/63] warning: (FAULT_INJECTION_STACKTRACE_FILTER
 && ..) selects FRAME_POINTER which has unmet direct dependencies
 (DEBUG_KERNEL && ..) || ..)
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-arch <linux-arch@vger.kernel.org>

On Wed, Mar 14, 2018 at 10:09 PM, kbuild test robot
<fengguang.wu@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
> head:   6f0b419290171f99f5d4d52d47920d24010b7744
> commit: 588020dcb92abfbea8163664220955b19beb3393 [12/63] treewide: simplify Kconfig dependencies for removed archs
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 588020dcb92abfbea8163664220955b19beb3393
>         # save the attached .config to linux build tree
>         make.cross ARCH=ia64
>
> All warnings (new ones prefixed by >>):
>
> warning: (FAULT_INJECTION_STACKTRACE_FILTER && LATENCYTOP && LOCKDEP) selects FRAME_POINTER which has unmet direct dependencies (DEBUG_KERNEL && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS)

Just checked this: the warning was preexisting, but my patch changed
the exact text. In mainline, the output is

warning: (FAULT_INJECTION_STACKTRACE_FILTER && LATENCYTOP && LOCKDEP)
selects FRAME_POINTER which has unmet direct dependencies
(DEBUG_KERNEL && (CRIS || M68K || FRV || UML || SUPERH || BLACKFIN) ||
ARCH_WANT_FRAME_POINTERS)

       Arnd
