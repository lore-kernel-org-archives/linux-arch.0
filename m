From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [OpenRISC] Removing architectures without upstream gcc support
Date: Mon, 26 Feb 2018 09:00:22 +0100
Message-ID: <CAK8P3a1Pd5+mGocnpQyPNYEqqqwpDJAb+FnWS6OJxuO1d-R=2A@mail.gmail.com>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <155284c9-7fd4-2f2c-0216-1c43622f88c3@philipp-wagner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <155284c9-7fd4-2f2c-0216-1c43622f88c3@philipp-wagner.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Wagner <lists@philipp-wagner.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>, Chen Liqin <liqin.linux@gmail.com>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, David Howells <dhowells@redhat.com>, openrisc@lists.librecores.org, Lennox Wu <lennox.wu@gmail.com>, James Hogan <jhogan@kernel.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

On Sun, Feb 25, 2018 at 4:43 PM, Philipp Wagner
<lists@philipp-wagner.com> wrote:
> Am 22.02.2018 um 16:45 schrieb Arnd Bergmann:
>> While building the cross-toolchains, I noticed that overall, we can build almost
>> all linux target architectures with upstream binutils and gcc these days,
>> however there are still some exceptions, and I'd like to find out if anyone
>> has objections to removing the ones that do not have upstream support.
>> This are the four architectures I found:
>> [...]
>> * OpenRISC is a RISC architecture with a free license and an
>>   active community. It seems to have lost a bit of steam after RISC-V
>>   is rapidly taking over that niche, but there are chips out there and
>>   the design isn't going away. Listing it here for completeness only
>>   because there is no upstream gcc port yet, but this will hopefully
>>   change in the future based on
>>   https://lists.librecores.org/pipermail/openrisc/2018-January/000958.html
>>   and I had no problems locating the gcc-7.x tree for building my
>>   toolchains. The port is actively being maintained.
>
> It's mostly mentioned in the mailing list thread you linked to, but just
> for completeness in this thread:
>
> The OpenRISC GCC port is maintained and regularly updated to newer GCC
> versions. It is not, however, upstreamed to the FSF due to a single
> missing FSF copyright assignment from a developer who has written large
> parts of the initial port. All code which has copyright assignments in
> place (binutils, GDB, etc.) has been upstreamed lately.
>
> For GCC, Stafford Horne is actively working on rewriting the parts which
> we don't have the FSF copyright assignment for (and unless something
> very surprising happens, won't get). [If anyone wants to help, there's
> GSoC project for it as well:
> https://fossi-foundation.org/gsoc18-ideas#openrisc-gcc-port]
>
> So I'd be very sad if the openrisc port gets dropped from Linux upstream.

Yes, definitely. What I was really trying to say here is I consider openrisc
an obvious exception to the 'no more ports without upstream gcc' rule
because of the above.

On a related note, has anyone successfully built an openrisc kernel with
llvm/clang? As we discussed for arch/hexagon/, that architecture is unlikely
to ever get an upstream gcc port, but like openrisc does have an upstream
llvm port and they actually use that.

I know that x86 and arm64 mostly work with llvm, arm32 works in some of
the more common configurations at least (not big-endian or older CPUs
though) and some others probably work as well. I have already build both
gcc-5.5 and gcc-7.3 for openrisc and uploaded those to
https://www.kernel.org/pub/tools/crosstool/files/bin/, but if llvm works as
well, that could be one more reason to try to build a working set of
clang based cross toolchains.

     Arnd
