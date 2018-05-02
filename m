Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41775 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeEBUaW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 May 2018 16:30:22 -0400
MIME-Version: 1.0
In-Reply-To: <1525179614-14571-5-git-send-email-changbin.du@intel.com>
References: <1525179614-14571-1-git-send-email-changbin.du@intel.com> <1525179614-14571-5-git-send-email-changbin.du@intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 2 May 2018 16:30:21 -0400
Message-ID: <CAK8P3a0c++Ti_39WPXwwjjmRx+EUozzCVY5Y2qicyEeLop6_6w@mail.gmail.com>
Subject: Re: [PATCH 4/5] kernel hacking: new config DEBUG_EXPERIENCE to apply
 GCC -Og optimization
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: changbin.du@intel.com
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20180502203021.ixLRmQEvmaRb5mUeXecWM3V6Wd4bz1HpzrgWQtC0Tno@z>

On Tue, May 1, 2018 at 9:00 AM,  <changbin.du@intel.com> wrote:
> From: Changbin Du <changbin.du@intel.com>
> +config DEBUG_EXPERIENCE
> +       bool "Optimize for better debugging experience (-Og)"
> +       default n
> +       select NO_AUTO_INLINE
> +       depends on !CC_OPTIMIZE_FOR_SIZE
> +       help

How about having this as another option alongside CC_OPTIMIZE_FOR_SIZE
and CC_OPTIMIZE_FOR_PERFORMANCE in the same choice statement?

We could also add another option for -Os (for faster compiles)  or possibly
for -O3 (if anyone cares) in there.

      Arnd
