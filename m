From: Igor Stoppa <igor.stoppa@gmail.com>
Subject: Re: [PATCH] asm-generic: bug: add unlikely() to BUG_ON()
Date: Sat, 8 Sep 2018 07:32:15 +0300
Message-ID: <f59169de-fe5b-61b9-df36-321741682da9@gmail.com>
References: <20180907192119.4931-1-igor.stoppa@huawei.com>
 <CAK8P3a3u0z+Rkt0=UUG04o-uNC_K1+N=h+_Ucd23N-r2H=fTLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a3u0z+Rkt0=UUG04o-uNC_K1+N=h+_Ucd23N-r2H=fTLg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: igor.stoppa@huawei.com, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org



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
