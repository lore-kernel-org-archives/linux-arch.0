From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 34/35] clocksource/drivers/Kconfig: Support andestech
 atcpit100 timer
Date: Thu, 7 Dec 2017 09:40:16 +0100
Message-ID: <d23fa048-9532-ff06-c2cf-7c95afdef7f4@linaro.org>
References: <cover.1511785528.git.green.hu@gmail.com>
 <1a22db002413ff60851737736a86b40c38877220.1511785528.git.green.hu@gmail.com>
 <CAK8P3a2ovDuwWCq2HABZaCVGO04TX0VdgnQbK65RvHhsMEzsiw@mail.gmail.com>
 <CAEbi=3f6YZJySA5A2+y1hiPHwfkq+05cisnRwyhKYDXQdnFzWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAEbi=3f6YZJySA5A2+y1hiPHwfkq+05cisnRwyhKYDXQdnFzWA@mail.gmail.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, linux-serial@vger.kernel.org, Rick Chen <rickchen36@gmail.com>
List-Id: linux-arch.vger.kernel.org

On 28/11/2017 03:53, Greentime Hu wrote:
> 2017-11-27 22:11 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>> On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:
>>> From: Rick Chen <rickchen36@gmail.com>
>>>
>>> Add CLKSRC_ATCPIT100 for Andestech atcpit100 timer selection.
>>> It often be used in Andestech AE3XX platform.
>>>
>>> Signed-off-by: Rick Chen <rickchen36@gmail.com>
>>> Signed-off-by: Greentime Hu <green.hu@gmail.com>
>>
>> No need to split out the Makefile patch from the actual driver, they
>> clearly belong together.
>> The binding change should be a separate patch, as you did.
>>
>> It's probably best to separate the driver patches from the
>> architecture submission
>> in the future, they can simply get merged by the respective subsystem
>> maintainers,
>> with a smaller Cc list.
>>
> 
> Hi, Arnd:
> 
> Thanks.
> We will merge these 2 patches together in the next version patch.
> We will sent to clocksource subsystem with a seperate patchset.

Sounds good.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
