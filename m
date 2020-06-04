From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] linux/bits.h: fix unsigned less than zero warnings
Date: Thu, 04 Jun 2020 09:49:46 -0700
Message-ID: <28b33db24b1dbd15cd6711cd473f1c0e5f801e74.camel@perches.com>
References: <20200603215314.GA916134@rikard>
         <20200603220226.916269-1-rikard.falkeborn@gmail.com>
         <CAHp75VcNVOF6jHZ7gtpqskg9rDgwt3MmtGZJJOXE-GwvXRPOhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0196.hostedemail.com ([216.40.44.196]:39834 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729115AbgFDQtx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jun 2020 12:49:53 -0400
In-Reply-To: <CAHp75VcNVOF6jHZ7gtpqskg9rDgwt3MmtGZJJOXE-GwvXRPOhw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, emil.l.velikov@gmail.com, Kees Cook <keescook@chromium.org>, Linus Walleij <linus.walleij@linaro.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Syed Nayyar Waris <syednwaris@gmail.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, kbuild test robot <lkp@intel.com>

On Thu, 2020-06-04 at 09:41 +0300, Andy Shevchenko wrote:
> I think there is still a possibility to improve (as I mentioned there
> are test cases that are absent right now).
> What if we will have unsigned long value 0x100000001? Would it be 1
> after casting?
> 
> Maybe cast to (long) or (long long) more appropriate?

Another good mechanism would be to compile-time check the use
of constants in BITS and BITS_ULL and verify that:

range of BITS is:
	>= 0 && < (BITS_PER_BYTE * sizeof(unsigned int))
range of BITS_ULL is:
	>= 0 && < (BITS_PER_BYTE * sizeof(unsigned long long))

There would be duplication similar to the GENMASK_INPUT_CHECK
macros.
