Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44829 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeIHJQh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Sep 2018 05:16:37 -0400
Subject: Re: [PATCH] asm-generic: bug: add unlikely() to BUG_ON()
References: <20180907192119.4931-1-igor.stoppa@huawei.com>
 <CAK8P3a3u0z+Rkt0=UUG04o-uNC_K1+N=h+_Ucd23N-r2H=fTLg@mail.gmail.com>
From: Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <f59169de-fe5b-61b9-df36-321741682da9@gmail.com>
Date: Sat, 8 Sep 2018 07:32:15 +0300
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3u0z+Rkt0=UUG04o-uNC_K1+N=h+_Ucd23N-r2H=fTLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: igor.stoppa@huawei.com, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20180908043215.uMNqCHXxEloMfg4abJR9xCuHM35eihpj79Ce7a2YpNs@z>



On 07/09/18 23:41, Arnd Bergmann wrote:

> Could you add a comment about -Wmaybe-uninitialized next to the definition?
> Otherwise that is easily lost.
> 
> Also, I see that the file has two separate definitions of BUG_ON(), and the
> other one does have an unlikely() in it already. Can you change both
> to do the same thing with unlikely() or not unlikely()?

ack

--
igor
