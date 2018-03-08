From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: RFC: remove the "tile" architecture from glibc
Date: Thu, 8 Mar 2018 17:06:24 +0100
Message-ID: <9a60ac70-21e4-3f48-5cd7-ffd3aabc5c21@physik.fu-berlin.de>
References: <1a57be83-3349-5450-ee4f-d2a33569a728@mellanox.com>
 <d6c8e425-a6b6-6594-05e3-965536f06da3@physik.fu-berlin.de>
 <abce89d0-6798-069a-1a54-06e664665b78@mellanox.com>
 <dc3c52ce-f082-0da0-7828-0d4e6751e2a5@physik.fu-berlin.de>
 <CAK8P3a3itR8i2ayG7e4ku7kz+CQU7qHhptdmtmgTz+CzFGmCiw@mail.gmail.com>
 <20180307181407.GA24350@alf.mars>
 <CAK8P3a2VuYxzy6RmL_w_5f2qHepVRhfVR5P4x9nCUYav1s5n7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2VuYxzy6RmL_w_5f2qHepVRhfVR5P4x9nCUYav1s5n7g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Helmut Grohne <helmut@subdivi.de>, GNU C Library <libc-alpha@sourceware.org>, linux-arch <linux-arch@vger.kernel.org>, metcalf@alum.mit.edu, Henrik Grindal Bakken <hgb@ifi.uio.no>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 03/08/2018 04:55 PM, Arnd Bergmann wrote:
> I originally helped get tile, blackfin, metag, unicore32 and score into
> the kernel, and it's always sad to see them go away after all the work
> that was put into making them work. Out of the above, tile was
> probably the best supported, and the most ambitious architecture
> design, but in the end it seems it is just as dead as the others, so
> I'll now add a patch to remove it along with the others in linux-4.17.

Out of curiosity: Is there any reason why the removal of tilegx is now
being rushed? Did any of the policies regarding architectures in the
kernel change? I had the impression that architectures could previously
stay unmaintained for a while before being removed.

> - sh3/sh4 looked like they would get revived a few years ago
>    for the j-core project. The 2015 roadmap on
>    http://j-core.org/roadmap.html had ambitious plans for
>    an sh3 compatible core in 2017 and an sh4 compatible one
>    in 2018. However, not much has happened  at all since 2016,
>    and now the website is down as well. You might want to
>    contact the j-core developers for clarification.
>    I suspect this has also become a victim of the RISC-V
>    success.

Well, that's quite a bummer. I don't know what Rich Felker's and
Rob Landley's plans now are. Rich told that he would be doing paid
SH work again in the upcoming weeks. I even sent him and Rob SH4
hardware to support their efforts.

I have personally invested a lot of work into the SH port over the
past three years in Debian and I was involved fixing many bugs
and as a result, the port is quite usable. It would be really
disappointing to see it being removed all of a sudden :(.

I will get in touch with Rich and Rob to figure out what's going
on.

Adrian

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
