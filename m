From: Jacek Luczak <difrost.kernel@gmail.com>
Subject: Re: (Short?) merge window reminder
Date: Tue, 24 May 2011 14:30:59 +0200
Message-ID: <BANLkTimCXVdVa6KLRG8GJR1gJY=7_5SkOA@mail.gmail.com>
References: <BANLkTi=PLuZhx1=rCfOtg=aOTuC1UbuPYg@mail.gmail.com>
	<20110523192056.GC23629@elte.hu>
	<BANLkTikdgM+kSvaEYuQkgCYJZELnvwfetg@mail.gmail.com>
	<20110523231721.GM10009@thunk.org>
	<4DDAEC68.30803@zytor.com>
	<BANLkTikGfVSAMY2a2yiXaNpvBVvF8YdMEA@mail.gmail.com>
	<alpine.LNX.2.01.1105241409280.15351@frira.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:63050 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003Ab1EXMa7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 May 2011 08:30:59 -0400
In-Reply-To: <alpine.LNX.2.01.1105241409280.15351@frira.zrqbmnf.qr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan Engelhardt <jengelh@medozas.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Ted Ts'o <tytso@mit.edu>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, DRI <dri-devel@lists.freedesktop.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "linux-mm <linux-mm"@kvack.medozas.de

2011/5/24 Jan Engelhardt <jengelh@medozas.de>:
> On Tuesday 2011-05-24 01:33, Linus Torvalds wrote:
>
>>Another advantage of switching numbering models (ie 3.0 instead of
>>2.8.x) would be that it would also make the "odd numbers are also
>>numbers" transition much more natural.
>>
>>Because of our historical even/odd model, I wouldn't do a 2.7.x -
>>there's just too much history of 2.1, 2.3, 2.5 being development
>>trees.
>
> .oO(Though once 2.{7 or more, odd} trickle into the distros, it would
> become pretty much apparent that they are not devel.)
>
>>And then in another few years (probably before getting close to 3.40,
>>so I'm not going to make a big deal of 3 = "third decade"), I'd just
>>do 4.0 etc.
>
> While 2.6 has certainly worn out, already thinking of a 4.0 is highly
> reminiscient of the version number arms race Firefox and ChromeBrowser
> are doing currently.
>
>>Because all our releases are supposed to be stable releases these
>>days, and if we get rid of one level of numbering, I feel perfectly
>>fine with getting rid of the even/odd history too.
>
> If I remember past-time discussions right, ELF was the contributing
> factor to bump the major number to 2.0 back then; ever since 2.0, no
> similarly breakthrough-ing event has occurred.

What then about BKL removal? Nice place to celebrate with version jump
and heaving some beers.

-Jacek
