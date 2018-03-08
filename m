From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: RFC: remove the "tile" architecture from glibc
Date: Thu, 8 Mar 2018 16:55:33 +0100
Message-ID: <CAK8P3a2VuYxzy6RmL_w_5f2qHepVRhfVR5P4x9nCUYav1s5n7g@mail.gmail.com>
References: <1a57be83-3349-5450-ee4f-d2a33569a728@mellanox.com>
 <d6c8e425-a6b6-6594-05e3-965536f06da3@physik.fu-berlin.de>
 <abce89d0-6798-069a-1a54-06e664665b78@mellanox.com> <dc3c52ce-f082-0da0-7828-0d4e6751e2a5@physik.fu-berlin.de>
 <CAK8P3a3itR8i2ayG7e4ku7kz+CQU7qHhptdmtmgTz+CzFGmCiw@mail.gmail.com> <20180307181407.GA24350@alf.mars>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180307181407.GA24350@alf.mars>
Sender: linux-kernel-owner@vger.kernel.org
To: Helmut Grohne <helmut@subdivi.de>, Arnd Bergmann <arnd@arndb.de>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, GNU C Library <libc-alpha@sourceware.org>, linux-arch <linux-arch@vger.kernel.org>, metcalf@alum.mit.edu, Henrik Grindal Bakken <hgb@ifi.uio.no>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 7, 2018 at 7:14 PM, Helmut Grohne <helmut@subdivi.de> wrote:
> On Wed, Mar 07, 2018 at 04:39:47PM +0100, Arnd Bergmann wrote:
>> - Helmut Grohne has done the work to add tile-gx to debian
>>    rebootstrap, and send several patches, as seen in
>>    https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=823167
>>    However, I could find no information on this actually
>>    being turned into a full port, or anyone still actively involved
>>    in it. The Debian rebootstrap page at
>>    https://wiki.debian.org/HelmutGrohne/rebootstrap
>>    mentions lots of other architectures, but not this one.
>
> I happened help tilegx, because Adrian found someone with hw and tilegx
> appeared to be very well maintained upstream. Very little needed to be
> done to make it work in Debian. The patches I sent were pretty generic
> and addressed issues that most ports face. What is there allows
> constructing most of an essential package set and (unlike a number of
> other architectures) bootstrapping tilegx works fairly well.  Debian has
> a number of source-only ports and tilegx is now one of them.
>
> That said, nobody has taken up the work to proceed a native bootstrap.
> Like with nios2, progress is stalled, because the tooling for fully
> automating the native phase is missing.
>
> In any case, I won't be able to fix binutils/gcc/glibc/linux issues with
> tilegx. So unless someone steps up to do that work, I won't object to
> dropping it. It would be sad to see tilegx go, but it certainly isn't my
> core interest either.
>
> I'd appreciate a note if it gets dropped from any of these, because I'd
> clean up outstanding bug reports then.

I originally helped get tile, blackfin, metag, unicore32 and score into
the kernel, and it's always sad to see them go away after all the work
that was put into making them work. Out of the above, tile was
probably the best supported, and the most ambitious architecture
design, but in the end it seems it is just as dead as the others, so
I'll now add a patch to remove it along with the others in linux-4.17.

Thanks for providing some more background, that definitely helped
make the decision easier. The other point that I found is that the
Mikrotik CCR hardware is from 2012 when tilegx was still fairly
new, and if nobody has done a full port in the first six years of the
product life-cycle, it seems very unlikely to change before the CCR
itself becomes obsolete.

> The reverse is also true: If you want to see an new architecture in
> Debian, I also appreciate an early conversation to avoid duplicating
> work.

I checked the list of architectures in rebootstrap, and besides tile,
no other is currently in danger of being removed. There are however
a couple things I'd note:

- The openrisc debian port was "declared dead" a few years ago
  due to copyright issues. These are apparently getting addressed
  now at least for gcc (I know nothing about the glibc problems or
  any work on solutions). This might come back soon, but at
  the same time my impression is that the OpenRISC community
  is shrinking due to RISC-V replacing it in many new projects.

- The latest architecture to get merged into linux (also 4.17) is
  nds32. I'm meeting the maintainer (Greentime Hu) next week
  and will ask him about whether they are interested in a Debian
  port. nds32 is widely deployed in certain markets today, but the
  latest Andestech CPUs are RISC-V based, so it's also unclear
  whether this one has a long-term future.

- sh3/sh4 looked like they would get revived a few years ago
  for the j-core project. The 2015 roadmap on
  http://j-core.org/roadmap.html had ambitious plans for
  an sh3 compatible core in 2017 and an sh4 compatible one
  in 2018. However, not much has happened  at all since 2016,
  and now the website is down as well. You might want to
  contact the j-core developers for clarification.
  I suspect this has also become a victim of the RISC-V
  success.

- arm64be has some active users, and is supported in the toolchain
  and by most arm64 hardware (notably not those using UEFI to
  boot IIRC).

- riscv32 is not yet supported by Linux or glibc, but that seems
  very likely to come in the future, maybe one or two years from
  now.

       Arnd
