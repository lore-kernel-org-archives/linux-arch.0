From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from asm
Date: Wed, 30 Nov 2016 10:40:02 -0800
Message-ID: <CA+55aFzMTrLMrr69ipdaKhz+RJhUu3BxB+kg0689qq_470qEcw@mail.gmail.com>
References: <20161129131922.GA31466@angband.pl> <20161129135118.24696-1-kilobyte@angband.pl>
 <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
 <30bb2db4-47bd-0c35-8328-ef032b551f06@suse.com> <CA+55aFxOGw57Gm-QiNs13kfy5k=aRrn3+98415V0g73eGc66mg@mail.gmail.com>
 <20161129195721.GI2697@decadent.org.uk> <CA+55aFyQko0t8oMZjhnwhWHrmBUyWjGhsnT=oUOU-W7_04xdzw@mail.gmail.com>
 <20161201051852.28dc335f@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20161201051852.28dc335f@roar.ozlabs.ibm.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Ben Hutchings <ben@decadent.org.uk>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 30, 2016 at 10:18 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Here's an initial rough hack at removing modversions. It gives an idea
> of the complexity we're carrying for this feature (keeping in mind most
> of the lines removed are generated parser).

You definitely don't have to try to convince me. We've had many issues
with modversions over the years. This was just the "last drop" as far
as I'm concerned, we've had random odd crc generation failures due to
some build races too.

> In its place I just added a simple config option to override vermagic
> so distros can manage it entirely themselves.

So at least Fedora doesn't even enable CONFIG_MODVERSIONS as-is. I'm
_hoping_ it's just Debian that wants this, and we'd need to get some
input from the Debian people whether that "control vermagic" is
sufficient? I suspect it isn't, but I can't come up with any simple
alternate model either..

I'm also somewhat surprised that it's Debian that has this problem,
considering how Debian is usually the distro that is _least_ receptive
to various non-free binaries.

            Linus
