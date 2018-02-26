From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Removing architectures without upstream gcc support
Date: Mon, 26 Feb 2018 16:11:54 -0600
Message-ID: <877eqz1jv9.fsf@xmission.com>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
        <2d12dc77-16b9-417d-72e3-2b1ffa38803d@gmail.com>
        <CAK8P3a2GP8uQWe+DCD=p-JLHxXBUTBpx9nnpNzF_Hz49XA9a8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2GP8uQWe+DCD=p-JLHxXBUTBpx9nnpNzF_Hz49XA9a8A@mail.gmail.com>
        (Arnd Bergmann's message of "Mon, 26 Feb 2018 09:26:57 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Sat, Feb 24, 2018 at 1:15 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> On 02/22/2018 07:45 AM, Arnd Bergmann wrote:
>>
>> Add blackfin to that list, there have been no responses from the
>> maintainers last time I posted patches to remove DSA header files, so we
>> had to go these through the networking tree. Have not see a Blackfin
>> pull request since forever, Aaron himself seems to agree this should be
>> removed:
>>
>> http://lkml.iu.edu/hypermail/linux/kernel/1801.1/04345.html
>
> Peter Zijlstra also mentioned that one on IRC, I didn't have it on my radar
> before. Like Tile, it has only recently been marked as Orphaned in MAINTAINERS,
> so I'd be inclined to wait a little while to give possible users a
> chance to step
> up as new maintainers.
>
> My plan for v4.17 is now:
>
> - remove score, unicore and metag due to lack of toolchain
>   or interest from the maintainers.
> - keep hexagon, and try to build an llvm/clang toolchain
> - remove frv and m32r due to being abandoned for several years
> - mark tile and blackfin for pending removal later this year unless
>   a new maintainer steps up
> - mark mn10300 for pending removal unless it gets updated to
>   support chips that were made in the past 12 years and to build
>   properly.

My frustration says please please please remove blackfin with sugar on
top.   If you look at the new unified siginfo.h you will notice that
blackfin has the majority of conflicting si_code definitions.

Given that I have already dealt with the frustrating situations I can
wait a release or two.  But even though I found a cross compiler for
blackfin there is a real cost to keeping it in the tree.

Eric
