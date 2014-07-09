From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 10/17] tile: Remove tile-specific _sinitdata and _einitdata
Date: Wed, 9 Jul 2014 20:33:19 +0200
Message-ID: <CAMuHMdXUSMU6dTnaMtSDPgL-x89XJh8hKKRhhDBYJvWZ9rpomQ@mail.gmail.com>
References: <1384285347-13506-1-git-send-email-geert@linux-m68k.org>
	<1384285347-13506-11-git-send-email-geert@linux-m68k.org>
	<528414A6.8090208@tilera.com>
	<alpine.DEB.2.02.1311140927170.9407@ayla.of.borg>
	<5284E467.6040502@tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:41958 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbaGISdV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jul 2014 14:33:21 -0400
In-Reply-To: <5284E467.6040502@tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Chris,

On Thu, Nov 14, 2013 at 3:55 PM, Chris Metcalf <cmetcalf@tilera.com> wrote:
> On 11/14/2013 3:31 AM, Geert Uytterhoeven wrote:
>> Feel free to take v2 below. Thanks!
>>
>> From d761d4d63945ff0a6eab5a9058c132f870c92aff Mon Sep 17 00:00:00 2001
>> From: Geert Uytterhoeven <geert@linux-m68k.org>
>> Date: Fri, 8 Nov 2013 21:33:29 +0100
>> Subject: [PATCH -v2] tile: Remove tile-specific _sinitdata and _einitdata
>>
>> Use standard __init_begin and __init_end instead.
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Acked-by: Chris Metcalf <cmetcalf@tilera.com>
>
> Taken into the tile tree; thanks!  (I did fix one extra place where it mentioned _sinitdata in a comment.)

I'm going through old patches, and it seems this is still not upstream?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
