Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfCKLz2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Mar 2019 07:55:28 -0400
Date: Mon, 11 Mar 2019 12:55:23 +0100
From: Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH] vmlinux.lds.h: drop unused __vermagic
Message-ID: <20190311115523.GA30951@linux-8ccs>
References: <1546173604-26066-1-git-send-email-minipli@googlemail.com>
 <20190102202938.GA26600@linux-8ccs>
 <CA+rthh87tutLV=857g-Nrd6gAYK8xhRJX8MqpjC+CnmsjTqqJg@mail.gmail.com>
 <CA+rthh_OnmvQQbKAG55rha56HCp2vjhZMv0ahRdgJjbjmG=xRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+rthh_OnmvQQbKAG55rha56HCp2vjhZMv0ahRdgJjbjmG=xRA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathias Krause <minipli@googlemail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190311115523.PbEsQpzRxabb7wp6lnrjU3dKorpuMOthiNvookbP5Gw@z>

+++ Mathias Krause [10/03/19 20:26 +0100]:
>Hi Jessica,
>
>On Mon, 21 Jan 2019 at 12:39, Mathias Krause <minipli@googlemail.com> wrote:
>>
>> On Wed, 2 Jan 2019 at 21:29, Jessica Yu <jeyu@kernel.org> wrote:
>> >
>> > +++ Mathias Krause [30/12/18 13:40 +0100]:
>> > >The reference to '__vermagic' is a relict from v2.5 times. And even
>> > >there it had a very short life time, from v2.5.59 (commit 1d411b80ee18
>> > >("Module Sanity Check") in the historic tree) to v2.5.69 (commit
>> > >67ac5b866bda ("[PATCH] complete modinfo section")).
>> > >
>> > >Neither current kernels nor modules contain a '__vermagic' section any
>> > >more, so get rid of it.
>> > >
>> > >Signed-off-by: Mathias Krause <minipli@googlemail.com>
>> > >Cc: Rusty Russell <rusty@rustcorp.com.au>
>> > >Cc: Jessica Yu <jeyu@kernel.org>
>> >
>> > Thanks for the cleanup.
>> >
>> > Reviewed-by: Jessica Yu <jeyu@kernel.org>
>> >
>>
>> Arnd, will you carry this patch through your asm-generic tree or did
>> the MAINTAINERS file mislead me here?
>>
>
>looks like Arnd keeps ignoring my Emails. :/ Can you carry this patch
>through your module tree? Or do you think I should ask Andrew Morton
>instead?

Sure, I'll queue this up in modules-next shortly after the merge window.

Thanks,

Jessica
