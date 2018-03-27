Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:37904 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752177AbeC0Chu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Mar 2018 22:37:50 -0400
Subject: Re: [RFC] new SYSCALL_DEFINE/COMPAT_SYSCALL_DEFINE wrappers
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net>
 <20180318174014.GR30522@ZenIV.linux.org.uk>
 <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
 <20180318181848.GU30522@ZenIV.linux.org.uk>
 <20180319042300.GW30522@ZenIV.linux.org.uk>
 <20180319092920.tbh2xwkruegshzqe@gmail.com>
 <20180319232342.GX30522@ZenIV.linux.org.uk>
 <20180322001532.GA18399@ZenIV.linux.org.uk>
 <20180326004017.GA2211@ZenIV.linux.org.uk>
 <20180326034750.GN30522@ZenIV.linux.org.uk>
 <CA+55aFw8VGnVgaWHVFP-LChMNaoANOwT18jJEWzSCRLFeRGcmA@mail.gmail.com>
 <428751c8-6920-096b-8694-a3f1b8990bdf@physik.fu-berlin.de>
 <CA+55aFwp-T-WFN95j7u5nn2BExxviJCx1-RgD3Mnu1AN_GYD3w@mail.gmail.com>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <8a8ee344-fb19-3ed9-f7dc-db63f703e6d3@physik.fu-berlin.de>
Date: Tue, 27 Mar 2018 11:37:26 +0900
MIME-Version: 1.0
In-Reply-To: <CA+55aFwp-T-WFN95j7u5nn2BExxviJCx1-RgD3Mnu1AN_GYD3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Ingo Molnar <mingo@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips <linux-mips@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, the arch/x86 maintainers <x86@kernel.org>
Message-ID: <20180327023726.ei-OFPdIEFn_vTTv_lZK080FAg9NKV94h33wZE8tmto@z>

On 03/27/2018 10:03 AM, Linus Torvalds wrote:
> Hmm. Do you have a few statically built binaries that could be tested
> without installing a whole distribution? Something real and meaningful
> enough that it actually exercised a few real system calls, but not
> something that needs to bring in 50 different shared libraries?
> 
> Something in /sbin, perhaps, that is still runnable by a regular user
> and doesn't require some distro-specific /etc layout etc, so that it
> would work even if you don't run Debian at all? Maybe some shell
> binary or something?

What about a tarball with a minimal Debian x32 chroot? Then you can
install interesting packages you would like to test yourself.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
