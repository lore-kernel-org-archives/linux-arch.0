From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [RFC] Removal of CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
Date: Sat, 5 May 2018 19:16:13 +0900
Message-ID: <CAK7LNAR59KjaJdDNwJaSR_79s84hBj_MqMQ=PaFqJqzBKLUsJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Miao <realmz6@gmail.com>, James Hogan <jhogan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-arch.vger.kernel.org

Hi.


CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX was selected
by BLACKFIN and METAG.

Now that both architectures removed in the previous
merge window, there is no more user of this CONFIG option.


My question is,
is it OK to remove CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX entirely?


In other words,
  - Is there possibility to revive Blackfin/Metag support?
  - Do future architectures need HAVE_UNDERSCORE_SYMBOL_PREFIX?

I guess (hope) they are unlikely to happen.



If we can remove CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX,
several tools (modpost, genksyms, adjust_autoksyms.sh, etc.)
will be simplified.

Also, VMLINUX_SYMBOL() in include/asm-generic/vmlinux.lds.h
can be removed.  So, the linker script will become more readable.


Is it OK to move forward the clean-ups?
Comments are appreciated.


-- 
Best Regards
Masahiro Yamada
