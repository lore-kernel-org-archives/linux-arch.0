From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [42/73] rtc: delete non-required instances of include <linux/init.h>
Date: Tue, 9 Jun 2015 21:49:31 -0400
Message-ID: <CAP=VYLpGg0WkYVd6KcCg-j50pYNLRSXKxo1a6SwoT4cNm6CaSw@mail.gmail.com>
References: <1390339396-3479-43-git-send-email-paul.gortmaker@windriver.com>
 <20150608195455.GF5222@piout.net> <20150608210634.GJ7125@windriver.com> <20150609074946.GG5222@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36708 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbbFJBuD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 21:50:03 -0400
In-Reply-To: <20150609074946.GG5222@piout.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com

On Tue, Jun 9, 2015 at 3:49 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 08/06/2015 at 17:06:34 -0400, Paul Gortmaker wrote :
>> > I've contemplated applying that patch but I'm not sure it is actually a
>> > good idea because those 46 drivers are using a variant of module_driver
>> > which actually uses __init and __exit. After your patch it is still
>> > working simply because init.h gets included that way:
>>
>> Firstly, I am kind of curious why an 18 month old patch is getting
>> replied to now.   That aside, this interdependence between module.h and
>> init.h was reconsidered and you can see the resolution solution here:
>>
>> https://lkml.kernel.org/r/1433276168-21550-1-git-send-email-paul.gortmaker@windriver.com
>>
>> To summarize what is said there, yes - you can ignore the one line
>> removals for now.  We will revisit them after the above is merged.
>>
>
> I've taken the RTC subsystem maintainership and I've been sorting the
> 2372 patches left in patchwork down to 126 and yours was one of these.
>
> Seeing your answer, I think my question was legitimate. I'll be happy to
> take your revised patch once ready.

Yes, it was a legit (and correct) spotting ; just some months late.  :)

I'll be sure to make sure you are CC'd on any updates.  And thanks
for taking over maintainership of the rtc subsystem.   I'll go out on
a limb here and guess that the original rtc driver author ; that idiot
never imagined it would become a subsystem, else he'd thank you
as well.

Paul.
--

>
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
