From: Helmut Grohne <helmut@subdivi.de>
Subject: Re: RFC: remove the "tile" architecture from glibc
Date: Wed, 7 Mar 2018 19:14:07 +0100
Message-ID: <20180307181407.GA24350@alf.mars>
References: <1a57be83-3349-5450-ee4f-d2a33569a728@mellanox.com>
 <d6c8e425-a6b6-6594-05e3-965536f06da3@physik.fu-berlin.de>
 <abce89d0-6798-069a-1a54-06e664665b78@mellanox.com>
 <dc3c52ce-f082-0da0-7828-0d4e6751e2a5@physik.fu-berlin.de>
 <CAK8P3a3itR8i2ayG7e4ku7kz+CQU7qHhptdmtmgTz+CzFGmCiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a3itR8i2ayG7e4ku7kz+CQU7qHhptdmtmgTz+CzFGmCiw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, GNU C Library <libc-alpha@sourceware.org>, linux-arch <linux-arch@vger.kernel.org>, metcalf@alum.mit.edu, Henrik Grindal Bakken <hgb@ifi.uio.no>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 07, 2018 at 04:39:47PM +0100, Arnd Bergmann wrote:
> - Helmut Grohne has done the work to add tile-gx to debian
>    rebootstrap, and send several patches, as seen in
>    https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=823167
>    However, I could find no information on this actually
>    being turned into a full port, or anyone still actively involved
>    in it. The Debian rebootstrap page at
>    https://wiki.debian.org/HelmutGrohne/rebootstrap
>    mentions lots of other architectures, but not this one.

I happened help tilegx, because Adrian found someone with hw and tilegx
appeared to be very well maintained upstream. Very little needed to be
done to make it work in Debian. The patches I sent were pretty generic
and addressed issues that most ports face. What is there allows
constructing most of an essential package set and (unlike a number of
other architectures) bootstrapping tilegx works fairly well.  Debian has
a number of source-only ports and tilegx is now one of them.

That said, nobody has taken up the work to proceed a native bootstrap.
Like with nios2, progress is stalled, because the tooling for fully
automating the native phase is missing.

In any case, I won't be able to fix binutils/gcc/glibc/linux issues with
tilegx. So unless someone steps up to do that work, I won't object to
dropping it. It would be sad to see tilegx go, but it certainly isn't my
core interest either.

I'd appreciate a note if it gets dropped from any of these, because I'd
clean up outstanding bug reports then.

The reverse is also true: If you want to see an new architecture in
Debian, I also appreciate an early conversation to avoid duplicating
work.

Hope this helps

Helmut
