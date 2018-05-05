From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Removal of CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
Date: Sat, 05 May 2018 15:50:35 +0000
Message-ID: <CA+55aFzX9CeRr3HZtVN5XKK2Ema5TjXo4FCgD8ukWz6Waz=pZw@mail.gmail.com>
References: <CAK7LNAR59KjaJdDNwJaSR_79s84hBj_MqMQ=PaFqJqzBKLUsJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNAR59KjaJdDNwJaSR_79s84hBj_MqMQ=PaFqJqzBKLUsJA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Steven Miao (Steven Miao)" <realmz6@gmail.com>, James Hogan <jhogan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-arch.vger.kernel.org

On Sat, May 5, 2018 at 12:17 AM Masahiro Yamada <
yamada.masahiro@socionext.com> wrote:

> My question is,
> is it OK to remove CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX entirely?

Absolutely. Let's not keep legacy stuff that complicates things around
unless necessary.

Even if there might be some unlikely future reason why it might be revived
some day, let's not use "what if" as an argument to keep unused code around.

              Linus
