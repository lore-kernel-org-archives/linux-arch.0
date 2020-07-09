From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Add and use a generic version of devmem_is_allowed()
Date: Thu,  9 Jul 2020 13:05:47 -0700
Message-ID: <20200709200552.1910298-1-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgGIUIM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 16:08:12 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA27EC08C5CE
        for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2020 13:08:12 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id k27so1454915pgm.2
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 13:08:12 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-riscv@lists.infradead.org, zong.li@sifive.com
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu, gxt@pku.edu.cn, Arnd Bergmann <arnd@arndb.de>, akpm@linux-foundation.org, linus.walleij@linaro.org, rppt@linux.ibm.com, mchehab+samsung@kernel.org, gregory.0xf0@gmail.com, masahiroy@kernel.org, Nick Desaulniers <ndesaulniers@google.com>, bgolaszewski@baylibre.com, tglx@linutronix.de, steve@sk2.org, keescook@chromium.org, mcgrof@kernel.org, alex@ghiti.fr, mark.rutland@arm.com, james.morse@arm.com, andriy.shevchenko@linux.intel.com, alex.shi@linux.alibaba.com, davem@davemloft.net, rdunlap@infradead.org, broonie@kernel.org, uwe@kleine-koenig.org, rostedt@goodmis.org, dan.j.williams@intel.com, mhiramat@kernel.org

As part of adding STRICT_DEVMEM support to the RISC-V port, Zong provided an
implementation of devmem_is_allowed() that's exactly the same as the version in
a handful of other ports.  Rather than duplicate code, I've put a generic
version of this in lib/ and used it for the RISC-V port.

I've put those first two patches on riscv/for-next, which I'm targeting for 5.9
(though this is the first version, so they're unreviewed).  The other three
obviously depend on the first one going on, but I'm not putting them in the
RISC-V tree as I don't want to step on anyone's toes.  If you want me to take
yours along with the others then please say something, as otherwise I'll
probably forget.

I've put the whole thing at
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git -b
generic-devmem .
