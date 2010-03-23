From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 06/20] early_res: seperate common memmap func from e820.c
	to fw_memmap.c
Date: Tue, 23 Mar 2010 09:53:57 +0100
Message-ID: <10f740e81003230153w373e70c8p55b79f6efb042209@mail.gmail.com>
References: <4BA6EA62.1030603@kernel.org>
	 <20100321.210023.209981130.davem@davemloft.net>
	 <4BA6F1F6.3070102@kernel.org>
	 <20100321.213350.176660494.davem@davemloft.net>
	 <20100322092809.GA20607@elte.hu> <1269290862.8599.77.camel@pasglop>
	 <20100322205703.GA25254@elte.hu> <1269294857.8599.90.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60604 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754396Ab0CWIx7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Mar 2010 04:53:59 -0400
In-Reply-To: <1269294857.8599.90.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, yinghai@kernel.org, tglx@linutronix.de, hpa@zytor.com, jbarnes@virtuousgeek.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, Mar 22, 2010 at 22:54, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2010-03-22 at 21:57 +0100, Ingo Molnar wrote:
>> > You use that arguemnt ONE MORE FUCKING TIME and you'll end up in my killfile
>> > with a auto-NACK reply of anything that looks like a patch from you.
>>
>> Does this mean you disagree with that? (I think it's pretty factual, last i
>> checked the usage stats of devel kernels was somewhere around 99.7%.)
>
> I disagree with that being a relevant argument in the technical
> discussion on the relative merits of two implementations of a given
> facility. I also disagree with your numbers, if you talk about
> deployement, I would be very very surprised if ARM wasn't close to
> on-par with x86.

FWIW, several years ago a MontaVista representative said there were more Linux
units that did have their RT extensions than there were Linux units
that did not have them...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
