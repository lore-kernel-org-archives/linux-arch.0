Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39976 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbeLJWNr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Dec 2018 17:13:47 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so6056041pfo.7
        for <linux-arch@vger.kernel.org>; Mon, 10 Dec 2018 14:13:46 -0800 (PST)
Subject: Re: [PATCH v2 24/28] arm: Add support for generic vDSO
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-25-vincenzo.frascino@arm.com>
From: Mark Salyzyn <salyzyn@android.com>
Message-ID: <1f5de1a7-04f0-152f-03ad-e581b0ec1b17@android.com>
Date: Mon, 10 Dec 2018 14:13:43 -0800
MIME-Version: 1.0
In-Reply-To: <20181129170530.37789-25-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181210221343.eVhtggVTl8jTuYIduHlYod-1BoAUzoPM3U0SH7yIBl8@z>

On 11/29/2018 09:05 AM, Vincenzo Frascino wrote:
> The arm vDSO library requires some adaptations to use to take advantage
> of the newly introduced generic vDSO library.
Tested-by? Would like to note that this patch series up to 24/28 was 
back-ported to android-4.9 and worked successfully on a Hikey arm64 device.

Only significant change was to add back support for clang in 
arch/arm64/Makefile (pseudo patch):

  ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
    CROSS_COMPILE_ARM32 ?= $(CONFIG_CROSS_COMPILE_COMPAT_VDSO:"%"=%)

    ifeq ($(CROSS_COMPILE_ARM32),)
      $(error CROSS_COMPILE_ARM32 not defined or empty, the compat vDSO 
will not be built)
+   else ifeq ($(cc-name),clang)
+     export CLANG_TRIPLE_ARM32 ?= $(CROSS_COMPILE_ARM32)
+     export CLANG_TARGET_ARM32 := --target=$(notdir 
$(CLANG_TRIPLE_ARM32:%-=%))
+     export CONFIG_COMPAT_VDSO := y
+     compat_vdso := -DCONFIG_COMPAT_VDSO=1
-+   else ifeq ($(shell which $(CROSS_COMPILE_ARM32)$(cc-name) 2> 
/dev/null),)
-+     $(error $(CROSS_COMPILE_ARM32)$(cc-name) not found, check 
CROSS_COMPILE_ARM32)
    else
      export CROSS_COMPILE_ARM32
      export CONFIG_COMPAT_VDSO := y
      compat_vdso := -DCONFIG_COMPAT_VDSO=1
    endif
  endif

-- Mark
