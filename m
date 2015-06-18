From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: subtle side effect of commit a1c48bb160f836
Date: Thu, 18 Jun 2015 09:37:14 +0200
Message-ID: <CAMuHMdWwT43j-_Ry52_gA7uOp1SsHgMTq_hobd0950ApcFxz0A@mail.gmail.com>
References: <55826966.6050202@synopsys.com>
	<CAMuHMdXWHYF8hEEgeFxLTrhvmEDBVS2=VmKykfOtDkGjqODQbA@mail.gmail.com>
	<5582742D.9090206@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34126 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbbFRHhP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jun 2015 03:37:15 -0400
In-Reply-To: <5582742D.9090206@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Michal Marek <mmarek@suse.cz>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Thu, Jun 18, 2015 at 9:33 AM, Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
> On Thursday 18 June 2015 12:40 PM, Geert Uytterhoeven wrote:
>> On Thu, Jun 18, 2015 at 8:47 AM, Vineet Gupta
>> <Vineet.Gupta1@synopsys.com> wrote:
>>> > commit a1c48bb160f8368 "Makefile: Fix unrecognized cross-compiler command line
>>> > options" moved ARCH specific cc option handling before common -Os/O2 setup.
>>> >
>>> > For ARC this had a subtle effect that we can no longer over-ride generic -O2 with
>>> > -O3, hence a performance regression observed going from 3.13 to 3.18 (the above
>>> > commit went into 3.16)
>>> >
>>> > I want to understand how to properly fix this. Moving the include of arch makefile
>>> > will bring back the old issue. I can introduce another option to set default optim
>>> > level, but only arc/m32r care about it anyways.
>> Can we include $(srctree)/arch/$(SRCARCH)/Makefile twice?
>
> Something like this would be ideal, but does that not bring back your warnings ?

I don't think so. The warnings were caused by using the host compiler instead
of the cross compiler while checking for the support of some compiler options.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
