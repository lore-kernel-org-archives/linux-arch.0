Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:41368 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750782AbeCFRED (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Mar 2018 12:04:03 -0500
References: <20180305190824.847-1-logang@deltatee.com>
 <20180305190824.847-8-logang@deltatee.com>
 <CAHp75Vc41MwtDr24-z3po2nx3Hr7_=tFUD0odcrbnVTP4SnJ1g@mail.gmail.com>
 <20180306114632.GB16784@kroah.com>
 <CAHp75Vf6sYss8q5FjgLYaQXYN761M4awmLVjZ48Cdd8+NrrhxQ@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <18e6f79d-04db-463a-8916-09d7d859d273@deltatee.com>
Date: Tue, 6 Mar 2018 10:03:55 -0700
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf6sYss8q5FjgLYaQXYN761M4awmLVjZ48Cdd8+NrrhxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 7/7] ntb: ntb_hw_switchtec: Cleanup 64bit IO defines
 to use the common header
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, linux-crypto <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>, Jon Mason <jdmason@kudzu.us>
Message-ID: <20180306170355.qxaPWwNeNHSDOcfpVBvnufit1TCC2x3Wl31TFvAZ2qI@z>



On 06/03/18 04:57 AM, Andy Shevchenko wrote:
> On Tue, Mar 6, 2018 at 1:46 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Tue, Mar 06, 2018 at 12:48:29PM +0200, Andy Shevchenko wrote:
>>> On Mon, Mar 5, 2018 at 9:08 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>>>> Clean up the ifdefs which conditionally defined the io{read|write}64
>>>> functions in favour of the new common io-64-nonatomic-lo-hi header.
>>>
>>>>   #include <linux/kthread.h>
>>>>   #include <linux/interrupt.h>
>>>>   #include <linux/ntb.h>
>>>> +#include <linux/io-64-nonatomic-lo-hi.h>
>>>
>>> A nit, can we preserve alphabetical ordering?
>>
>> Ugh, why, it doesn't matter at all :)
> 
> I'm fine with either way, but ordering is a good thing to have in long
> term prospective.
> Easy to find what headers are in there, easy to understand if you need
> another one or not, easy to maintain the list w/o duplications.
> 
> I saw already few examples where long list of headers contained
> duplications b/c it was in messy order.
> 

I agree with Greg here. This is a bit silly. The list isn't even 
alphabetical to begin with so it can't be preserved. However, if I do a 
v12 I'll make it alphabetical.

Logan
