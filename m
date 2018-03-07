From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: RFC: remove the "tile" architecture from glibc
Date: Wed, 7 Mar 2018 16:39:47 +0100
Message-ID: <CAK8P3a3itR8i2ayG7e4ku7kz+CQU7qHhptdmtmgTz+CzFGmCiw@mail.gmail.com>
References: <1a57be83-3349-5450-ee4f-d2a33569a728@mellanox.com>
 <d6c8e425-a6b6-6594-05e3-965536f06da3@physik.fu-berlin.de>
 <abce89d0-6798-069a-1a54-06e664665b78@mellanox.com> <dc3c52ce-f082-0da0-7828-0d4e6751e2a5@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dc3c52ce-f082-0da0-7828-0d4e6751e2a5@physik.fu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: GNU C Library <libc-alpha@sourceware.org>, linux-arch <linux-arch@vger.kernel.org>, metcalf@alum.mit.edu, Henrik Grindal Bakken <hgb@ifi.uio.no>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Helmut Grohne <helmutg@debian.org>
List-Id: linux-arch.vger.kernel.org

On Sat, Dec 2, 2017 at 4:16 PM, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 12/02/2017 02:14 AM, Chris Metcalf wrote:
>
>> I'd be very happy if someone from Debian (for example) wants to sign
>> up as maintainer.  Otherwise I will follow the sense of the community
>> in terms of whether deletion or just marking it as unmaintained feels
>> like the better way to go.
>
> I will ask around the Debian community what the current state of the
> Tilegx bootstrap is. Again, thanks for your help!

Do you have any updates on this? A related question has come up
for the kernel, as are in the process of removing a number of architectures,
https://lwn.net/SubscriberLink/748074/119aaf0d62b3e6c1/ or
see https://lwn.net/Articles/748074/ for a nice summary.

It looks like we might remove blackfin and/or mn10300 at the same
time as the others, which would leave tile as the one architecture
whose future still remains unclear.

This is what I understand from previous discussions:

- Mellanox has stopped all work on the architecture, both kernel
  and glibc
- Cisco are using a heavily patched older kernel and mainline
  toolchains, they would not care about the kernel dropping
  the port (based on Henrik's mail in this thread)
- Mikrotik are probably using a similar kernel (I found a large
  3.3.5 based patch for tile in their latest download sources),
  so I'm guessing they wouldn't care either.
- There was a minor effort back in 2014 to try to get OpenWRT
  to run on mikrotik tile-gx based devices, but that doesn't seem
  to have gone anywhere
  (see https://forum.mikrotik.com/viewtopic.php?t=85713,
   https://forum.openwrt.org/viewtopic.php?id=50897)
- Helmut Grohne has done the work to add tile-gx to debian
   rebootstrap, and send several patches, as seen in
   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=823167
   However, I could find no information on this actually
   being turned into a full port, or anyone still actively involved
   in it. The Debian rebootstrap page at
   https://wiki.debian.org/HelmutGrohne/rebootstrap
   mentions lots of other architectures, but not this one.

Does anyone have any additional information here? If there
is still active work on OpenWRT or Debian for TileGX, I don't
want to hurt that, but if the port is indeed as dead as it seems
based on my findings above, then it would be convenient to
remove it from the kernel together with the other architectures
rather than waiting a few more releases.

      Arnd
