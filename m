From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] Removal of CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
Date: Sat, 5 May 2018 17:55:23 +0200
Message-ID: <20180505155523.GA17349@ravnborg.org>
References: <CAK7LNAR59KjaJdDNwJaSR_79s84hBj_MqMQ=PaFqJqzBKLUsJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNAR59KjaJdDNwJaSR_79s84hBj_MqMQ=PaFqJqzBKLUsJA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Miao <realmz6@gmail.com>, James Hogan <jhogan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-arch.vger.kernel.org

On Sat, May 05, 2018 at 07:16:13PM +0900, Masahiro Yamada wrote:
> Hi.
> 
> 
> CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX was selected
> by BLACKFIN and METAG.
> 
> Now that both architectures removed in the previous
> merge window, there is no more user of this CONFIG option.

No need to keep this around, just in case someone steps up
to add support for these archs again.
There is no users so it will bit-rot over time anyway,
and will confuse new readers.
And if an arch shows up there is now a good incentive to
do what everyone else does, rather than having
special handling in the kernel.

Removing the symbol has the extra benefit that the kbuild
files becomes a little more readable, something we should
always welcome.

In other words - drop the symbol.
And well spotted!

	Sam
