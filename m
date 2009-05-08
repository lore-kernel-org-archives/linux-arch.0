From: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Subject: Re: [PATCH 00/27] more non-ABI asm-generic headers
Date: Fri, 8 May 2009 16:04:15 +0200
Message-ID: <10f740e80905080704q4d2336b2v8ec851d0c87c6cda@mail.gmail.com>
References: <cover.1241105648.git.arnd@arndb.de>
	 <10f740e80905030417m3b67da38uecd6bd008b4c7e3f@mail.gmail.com>
	 <200905041632.28026.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:34583 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760543AbZEHOEQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 May 2009 10:04:16 -0400
In-Reply-To: <200905041632.28026.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org

On Mon, May 4, 2009 at 16:32, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 03 May 2009, Geert Uytterhoeven wrote:
>> On Thu, Apr 30, 2009 at 17:34, Arnd Bergmann <arnd@arndb.de> wrote:
>> > To avoid trouble with quilt mail, I'm now trying
>> > git-format-patch to generate them, hopefully this
>> > works a little better. Can anyone tell me why I can't
>> > add a 'To' header rather than just 'Cc' in
>> > git-format-patch?
>>
>> I always specify the --to with git send-email.
>
> I haven't tried using git send-email yet, because it does not let
> me inspect mails after changing the headers but before sending
> them out.

The --dry-run option is not sufficient for you?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
