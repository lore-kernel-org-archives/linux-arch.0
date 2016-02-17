From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2] serial: earlycon: rework common framework for earlycon
 declarations
Date: Tue, 16 Feb 2016 17:31:48 -0800
Message-ID: <56C3CD84.9000504@hurleysoftware.com>
References: <1455273394-27350-1-git-send-email-yamada.masahiro@socionext.com>
 <56BDF799.1030505@hurleysoftware.com>
 <CAK7LNAS_vietwRRFnH3YhbWSzjRFP4U6rjftYek1KQ3ips2ZSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34292 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964921AbcBQBbw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Feb 2016 20:31:52 -0500
Received: by mail-pa0-f48.google.com with SMTP id fy10so1515695pac.1
        for <linux-arch@vger.kernel.org>; Tue, 16 Feb 2016 17:31:51 -0800 (PST)
In-Reply-To: <CAK7LNAS_vietwRRFnH3YhbWSzjRFP4U6rjftYek1KQ3ips2ZSQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-arch@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>

On 02/12/2016 08:30 AM, Masahiro Yamada wrote:
> Hi Peter,
> 
> 
> 2016-02-13 0:17 GMT+09:00 Peter Hurley <peter@hurleysoftware.com>:
>> On 02/12/2016 02:36 AM, Masahiro Yamada wrote:
>>> Commit 71f50c6d9a22 ("of: drop symbols declared by _OF_DECLARE() from
>>> modules") fixed the link error introduced by commit b8d20e06eaad
>>> ("serial: 8250_uniphier: add earlycon support").
>>>
>>> After commit 2eaa790989e0 ("earlycon: Use common framework for
>>> earlycon declarations") was applied, the link error came back
>>> because the commit reworked OF_EARLYCON_DECLARE() to not use
>>> _OF_DECLARE().
>>
>> What link error are you getting?
> 
> The combination of CONFIG_SERIAL_8250_CONSOLE=y
> and CONFIG_SERIAL_8250_UNIPHIER=m causes a link error.
> 
> 
> 
>>
>>> This commit reworks OF_EARLYCON_DECLARE() again based on
>>> _OF_DECLARE().  My motivations are:
>>>
>>>  - Fix the link error in a generic way (without patching
>>>    drivers/tty/serial/8250/8250_uniphier.c)
>>>
>>>  - Delete struct earlycon_id.  This struct is re-inventing the wheel;
>>>    the fields "name", "compatible", "setup" can be implemented in
>>>    struct of_device_id as other frameworks do.
>>
>> This patch basically reverts the common framework.
>> What happens when not building with OF? Does it still declare the
>> earlycon table?
> 
> Ah, I missed this.  (sigh)
> 
> Earlycon must still work without OF.
> My way only works with OF.
> 
> I really screwed up.  Sorry.

Hi Masahiro,

No big deal.

We need to come up with a better way to enable earlycon builds and
opt-in by driver than the current method. Breaking builds with earlycon
support has happened several times in the last couple of years so
it's not just you.

Regards,
Peter Hurley
