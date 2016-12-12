From: Ian Campbell <ijc@hellion.org.uk>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported
 from asm
Date: Mon, 12 Dec 2016 09:08:17 +0000
Message-ID: <1481533697.3883.24.camel@hellion.org.uk>
References: <CA+55aFzMTrLMrr69ipdaKhz+RJhUu3BxB+kg0689qq_470qEcw@mail.gmail.com>
         <1480541581.16599.78.camel@decadent.org.uk>
         <20161201125545.406d092c@roar.ozlabs.ibm.com>
         <1480559754.16599.92.camel@decadent.org.uk>
         <20161201143928.07a08348@roar.ozlabs.ibm.com>
         <6e8cf20b-2d2f-ba1f-e02c-c757d5a25db7@suse.com>
         <20161209133308.0acbb57a@roar.ozlabs.ibm.com>
         <1481296893.4509.135.camel@hellion.org.uk>
         <20161210021529.4a6e684f@roar.ozlabs.ibm.com> <86vaus3eld.fsf@seketeli.org>
         <20161210124103.GD21421@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20161210124103.GD21421@kroah.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dodji Seketeli <dodji@seketeli.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Michal Marek <mmarek@suse.com>, Ben Hutchings <ben@decadent.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Adam Borowski <kilobyte@angband.pl>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Sat, 2016-12-10 at 13:41 +0100, Greg Kroah-Hartman wrote:
> Now I don't work on a distro anymore, but I would think that something
> like this would be really useful, pointing out exactly what changed is
> very important for distro maintainers to determine what they want to do

The .symvers produced by the current scheme aren't completely useless
from this PoV, although they aren't ideal since you need both before an
d after trees and if the changes are large or far reaching the diff can
get a bit unwieldy, so better tooling which points directly to the
actual relevant change would be no bad thing.

Ian.
