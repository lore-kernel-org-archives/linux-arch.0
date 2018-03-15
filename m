Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:38504 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751508AbeCOT1g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Mar 2018 15:27:36 -0400
Subject: Re: [Blackfin removal] [PATCH 11/28] misc: Remove Blackfin DSP echo
 support
References: <1521111028-19856-1-git-send-email-aaron.wu@analog.com>
 <1521111028-19856-11-git-send-email-aaron.wu@analog.com>
 <CAK8P3a2MKK4gNfP6jN8+ZXpUgS56UBqwdM5aPnbe3e--0BWr5w@mail.gmail.com>
 <20180315162522.GA2258@kroah.com>
From: David Rowe <david@rowetel.com>
Message-ID: <a99dbbf2-446d-515a-5fe4-7431ece31fce@rowetel.com>
Date: Fri, 16 Mar 2018 05:57:32 +1030
MIME-Version: 1.0
In-Reply-To: <20180315162522.GA2258@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: gregkh <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Aaron Wu <aaron.wu@analog.com>, linux-arch <linux-arch@vger.kernel.org>, Steve Underwood <steveu@coppice.org>

Yes can confirm - I've recently been contacted be end-users of the 
module.  It provides effective software based echo cancellation for 
users of the Asterisk IP-PBX.

Thanks,

David

On 16/03/18 02:55, gregkh wrote:
> On Thu, Mar 15, 2018 at 04:54:11PM +0100, Arnd Bergmann wrote:
>> On Thu, Mar 15, 2018 at 11:50 AM, Aaron Wu <aaron.wu@analog.com> wrote:
>>> Signed-off-by: Aaron Wu <aaron.wu@analog.com>
>>>
>>> Remove Blackfin DSP echo support
>>> ---
>>>   drivers/misc/echo/echo.c | 73 ------------------------------------------------
>>>   drivers/misc/echo/fir.h  | 50 ---------------------------------
>>>   2 files changed, 123 deletions(-)
>>
>> I had picked up this patch at first, but now took a closer look and found no
>> users of this module. It sounds to me like we should remove the entire
>> directory rather than just the blackfin portion.
>>
>> Adding the original authors to Cc for clarification.
> 
> The echo "driver" is used by Asterix systems.  It seems to be the only
> driver that ended up getting merged upstream from that huge mess.  So
> there are users of it, or at least there were, I don't know how popular
> Asterix is these days.
> 
> thanks,
> 
> greg k-h
> 
