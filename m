Return-Path: <SRS0=ZCnS=4X=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:60345 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgCFMHt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 07:07:49 -0500
References: <20200306080905.173466-1-syq@debian.org>
 <87r1y53npd.fsf@mid.deneb.enyo.de>
 <8441f497-61eb-5c14-bf1e-c90a464105a7@vivier.eu>
 <87mu8t3mlw.fsf@mid.deneb.enyo.de>
 <40da389d-4e74-2644-2e7c-04d988fcc26f@vivier.eu>
 <CAKcpw6WEO5Rmsv+WFkOMrkH+0jwtFKKy7b2n3U9xgv-xGC0UUQ@mail.gmail.com>
 <87v9nhzp6w.fsf@mid.deneb.enyo.de>
 <CAKcpw6VF1N2gTVXeWLU4aVOuARf5oN6yPg9O=RCzgkMrjXmxYQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] binfmt_misc: pass binfmt_misc P flag to the interpreter
Message-ID: <fded1845-98db-f0fb-9320-842c9fdc30dc@vivier.eu>
Date: Fri, 6 Mar 2020 13:07:35 +0100
MIME-Version: 1.0
In-Reply-To: <CAKcpw6VF1N2gTVXeWLU4aVOuARf5oN6yPg9O=RCzgkMrjXmxYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: YunQiang Su <syq@debian.org>, Florian Weimer <fw@deneb.enyo.de>
Cc: torvalds@linux-foundation.org, Greg KH <gregkh@linuxfoundation.org>, akpm@linux-foundation.org, Al Viro <viro@zeniv.linux.org.uk>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, libc-alpha@sourceware.org
Message-ID: <20200306120735.PGIueqv3rbm7N_hB7ex4JGkey50kajTKQpgSUC0YAUs@z>

Le 06/03/2020 à 12:48, YunQiang Su a écrit :
> Florian Weimer <fw@deneb.enyo.de> 于2020年3月6日周五 下午7:42写道：
>>
>> * YunQiang Su:
>>
>>> AT_* only has 32 slot and now. I was afraid that maybe we shouldn't take one.
>>>    /* AT_* values 18 through 22 are reserved */
>>>    27,28,29,30 are not used now.
>>> Which should we use?
>>
>> Where does this limit of 32 tags come from?  I don't see it from a
>> userspace perspective.
> 
> Sorry it is my mistake: In linux/auxvec.h, I saw
> 
> #define AT_RANDOM 25    /* address of 16 random bytes */
> #define AT_HWCAP2 26    /* extension of AT_HWCAP */
> 
> #define AT_EXECFN  31   /* filename of program */
> 
> The number jump to 31 from 26.
> 
> It is my fault: in x86_64-linux-gnu/bits/auxv.h, the max number is 47 now.
> 

Numbers starting from 32 are arch specific.
18 to 22 are also reserved (and used by some archs).
(linux/arch/*/include/uapi/asm/auxvec.h)

So there is only 4 entries available (27 to 30)
(linux/include/uapi/linux/auxvec.h)
Do we want to waste one more entry whereas we can use an unused one?

Thanks,
Laurent
