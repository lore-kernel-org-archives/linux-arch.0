From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH v3 04/33] nds32: Kernel booting and initialization
Date: Fri, 8 Dec 2017 21:25:43 +0800
Message-ID: <CAEbi=3cP7YE5V8Y+oe_YVTym442Qki6h67DhgQus0-TqHHvJag@mail.gmail.com>
References: <cover.1512723245.git.green.hu@gmail.com> <7131f15434d17eb64a83999bff9e96a7e9d4b5f5.1512723245.git.green.hu@gmail.com>
 <CAOFm3uF5BpxpAAH4eq-OSY1bS2cSGS27NY524JoAMzJ1F4bbrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAOFm3uF5BpxpAAH4eq-OSY1bS2cSGS27NY524JoAMzJ1F4bbrA@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Greentime <greentime@andestech.com>, LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutlan>
List-Id: linux-arch.vger.kernel.org

Hi, Philippe:

2017-12-08 21:19 GMT+08:00 Philippe Ombredanne <pombredanne@nexb.com>:
> Dear Greentime,
>
> On Fri, Dec 8, 2017 at 10:11 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> From: Greentime Hu <greentime@andestech.com>
>>
>> This patch includes the kernel startup code. It can get dtb pointer
>> passed from bootloader. It will create a temp mapping by tlb
>> instructions at beginning and goto start_kernel.
>>
>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
> []
>> --- /dev/null
>> +++ b/arch/nds32/kernel/head.S
>> @@ -0,0 +1,202 @@
>> +/*
>> + * Copyright (C) 2005-2017 Andes Technology Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>
>
> Have you considered using the new SPDX ids instead of this fine legalese?
> e.g.:
>
> // SPDX-License-Identifier: GPL-2.0
> // Copyright (C) 2005-2017 Andes Technology Corporation
>
> This is much shorter and neater (unless you are a legalese lover of course!)
>
> Check also Thomas doc patches and Linus comments on why he prefers the
> C++ comment style for these.

Thanks for your suggestions. We'd like to do this change.
I will apply it in the next version patch.
