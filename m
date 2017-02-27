From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: Force cast get_user() setting x to 0
Date: Mon, 27 Feb 2017 16:52:41 +0100
Message-ID: <CAK8P3a2B45hyQj0OvToUXg7fXi8bDCtYs7ZJChQ6gdwN9NDcfg@mail.gmail.com>
References: <20170217165229.17768-1-stephen.boyd@linaro.org> <148798589245.16996.9285242756855195986@sboyd-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <148798589245.16996.9285242756855195986@sboyd-linaro>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <stephen.boyd@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Sat, Feb 25, 2017 at 2:24 AM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> Quoting Stephen Boyd (2017-02-17 08:52:29)
>> If we call get_user() with an __le* or __be* type sparse will
>> complain when we assign the result to 0 on the faulting path.
>> Let's force cast here so that sparse doesn't complain. This
>> mirrors what we do in __get_user() as well.
>>
>> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
>> ---
>>
>> I made a similar fix to arm64 headers, and it looks like asm-generic
>> would need the same fix.
>
> I suppose we can ignore this. I was using sparse v0.5.0 but it seems
> that later versions of sparse don't complain here anymore as Luc has
> pointed out.

Ok, thanks for the follow-up.

   Arnd
