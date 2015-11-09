Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34797 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbbKIUni (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Nov 2015 15:43:38 -0500
MIME-Version: 1.0
In-Reply-To: <20151109154836.GA28486@akamai.com>
References: <1447064069-21469-1-git-send-email-geert@linux-m68k.org>
	<20151109154836.GA28486@akamai.com>
Date: Mon, 9 Nov 2015 21:43:37 +0100
Message-ID: <CAMuHMdV3cUafEh-_m199ta14RcM4FmyxXMHt_WiL75wtHfVO6g@mail.gmail.com>
Subject: Re: [PATCH 0/2] selftests/mlock2: Build warning fixes on Debian/m68k 4.0
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@akamai.com>
Cc: Thierry Reding <treding@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuahkh@osg.samsung.com>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20151109204337.bFdj8Nu_I6TaRKyd68lOznt_uWV_UPKOxoHR7IL9wSQ@z>

Hi Eric,

[CC linux-arch for more architecture-specific breakage]

On Mon, Nov 9, 2015 at 4:48 PM, Eric B Munson <emunson@akamai.com> wrote:
> On Mon, 09 Nov 2015, Geert Uytterhoeven wrote:
>> The following 2 patches are needed to fix build warnings on Debian/m68k
>> 4.0.
>>
>> However, after wiring up the mlock2 syscall, the test fails with:
>>
>> # ./mlock2-tests
>> fread kpageflags: Success
>> #
>>
>> as the fread() call returns 0, not 1.
>
> This would fail is the index into the kpageflags file is not being
> calculated properly.  This tests works on x86_64 (I am in the process of
> testing x86 incase this is a 32bit issue).  I am fairly sure that I
> tested it on x86, but it has been a while.

Found it: /proc/kpageflags is always empty, as m68k doesn't set up max_pfn.

After fixing that, the test is working fine.
Funny how we managed to survive that long without setting it ;-)

Note that several other architectures also don't set max_pfn. Some may
be nommu, and are thus not affected, but others probably are:

    hexagon
    mn10300
    nios2
    score

And a few of the others (e.g. avr32, didn't check all of them) assign to a
local max_pfn variable instead of the global one, so it won't work on those
neither.

>> The original commit description for the test said "Note that the limit
>> test needs to be run a normal user.". But running it as a non-root user
>> also fails:
>
> The original commit says that the on-fault-limit test needs to be run as
> a regular user becuase it relies on enforcing memory limits.
> mlock2-tests has to be run as root to get access to the various files
> under /proc it needs to verify things are working.

Ah, I just used "git log -p" on mlock2-tests.c, and didn't notice the commit
actually added two tests.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
