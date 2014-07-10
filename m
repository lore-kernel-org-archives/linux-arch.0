From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH 10/17] tile: Remove tile-specific _sinitdata and _einitdata
Date: Thu, 10 Jul 2014 15:49:12 -0400
Message-ID: <53BEEE38.8030407@tilera.com>
References: <1384285347-13506-1-git-send-email-geert@linux-m68k.org>	<1384285347-13506-11-git-send-email-geert@linux-m68k.org>	<528414A6.8090208@tilera.com>	<alpine.DEB.2.02.1311140927170.9407@ayla.of.borg>	<5284E467.6040502@tilera.com> <CAMuHMdXUSMU6dTnaMtSDPgL-x89XJh8hKKRhhDBYJvWZ9rpomQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:29255 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbaGJTtO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Jul 2014 15:49:14 -0400
In-Reply-To: <CAMuHMdXUSMU6dTnaMtSDPgL-x89XJh8hKKRhhDBYJvWZ9rpomQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 7/9/2014 2:33 PM, Geert Uytterhoeven wrote:
> Hi Chris,
>
> On Thu, Nov 14, 2013 at 3:55 PM, Chris Metcalf <cmetcalf@tilera.com> wrote:
>> On 11/14/2013 3:31 AM, Geert Uytterhoeven wrote:
>>> Feel free to take v2 below. Thanks!
>>>
>>>  From d761d4d63945ff0a6eab5a9058c132f870c92aff Mon Sep 17 00:00:00 2001
>>> From: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Date: Fri, 8 Nov 2013 21:33:29 +0100
>>> Subject: [PATCH -v2] tile: Remove tile-specific _sinitdata and _einitdata
>>>
>>> Use standard __init_begin and __init_end instead.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Acked-by: Chris Metcalf <cmetcalf@tilera.com>
>> Taken into the tile tree; thanks!  (I did fix one extra place where it mentioned _sinitdata in a comment.)
> I'm going through old patches, and it seems this is still not upstream?

Yes, and I'm not at all sure what happened.  There were a couple of mistakes
in the original post (einittext converted instead of einitdata), and maybe I
ended up dropping it entirely instead of taking v2.

In any case it's now in the tile tree and upstreamed to linux-tile so you
should see it in linux-next shortly.

Sorry!

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
