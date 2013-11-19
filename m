From: czankel <chris@zankel.net>
Subject: Re: [PATCH 00/17] xtensa SMP queue
Date: Mon, 18 Nov 2013 22:45:26 -0800
Message-ID: <528B0906.6070105@zankel.net>
References: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com> <528AE38B.4020300@zankel.net> <CAMo8BfKkGsRnGvf-AaB0F9fVNRzzHxCmo-=9yLzt=2TMmN7+3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36051 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab3KSGp1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Nov 2013 01:45:27 -0500
Received: by mail-pd0-f174.google.com with SMTP id y13so1507838pdi.19
        for <linux-arch@vger.kernel.org>; Mon, 18 Nov 2013 22:45:26 -0800 (PST)
In-Reply-To: <CAMo8BfKkGsRnGvf-AaB0F9fVNRzzHxCmo-=9yLzt=2TMmN7+3g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Marc Gauthier <marc@tensilica.com>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, Linux-Arch <linux-arch@vger.kernel.org>

On 11/18/13 10:36 PM, Max Filippov wrote:
> Hi Chris,
>
> On Tue, Nov 19, 2013 at 8:05 AM, Chris Zankel <chris@zankel.net> wrote:
>> Hi Max,
>>
>> I have added the SMP patch-set to the for_next tree (for the time being).
>> Let me know if you wanted it in for this release or if you think it's not
>> ready for prime time. Note that I skipped the variant configuration as it is
>> a lot of code and it is more of a 'test' configuration.
> Cool (: I currently only have a small optimization fix for the MX interrupt
> controller, otherwise I think it's good. Should I send a follow-up patch
> or respin the whole series?
Feel free to just send me the patch, patch to the patch, or whatever is 
easiest for you.

Thanks,
-Chris
