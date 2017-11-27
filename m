From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 22/35] nds32: Device tree support
Date: Mon, 27 Nov 2017 13:14:28 -0600
Message-ID: <CAL_JsqL2B0hbiWjk2RET6f6OMcAiB+B7dxwvYVPH=xtkgqVnQg@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <1055af0e8b98571b4461d6f899d043fe7f17408b.1511785528.git.green.hu@gmail.com>
 <CAL_Jsq+c4vt4-royBuTxAj+AY2wFHMugyyy41S5YP-QXyF2gbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+c4vt4-royBuTxAj+AY2wFHMugyyy41S5YP-QXyF2gbQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, netdev <netdev@vger.kernel.org>, deanbo422@gmail.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 27, 2017 at 1:07 PM, Rob Herring <robh+dt@kernel.org> wrote:
> On Mon, Nov 27, 2017 at 6:28 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> From: Greentime Hu <greentime@andestech.com>
>>
>> This patch adds support for device tree.
>>
>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>> ---
>>  arch/nds32/boot/dts/Makefile   |    8 ++++++
>>  arch/nds32/boot/dts/ae3xx.dts  |   55 ++++++++++++++++++++++++++++++++++++
>>  arch/nds32/boot/dts/ag101p.dts |   60 ++++++++++++++++++++++++++++++++++++++++
>>  arch/nds32/kernel/devtree.c    |   45 ++++++++++++++++++++++++++++++
>>  4 files changed, 168 insertions(+)
>>  create mode 100644 arch/nds32/boot/dts/Makefile
>>  create mode 100644 arch/nds32/boot/dts/ae3xx.dts
>>  create mode 100644 arch/nds32/boot/dts/ag101p.dts
>>  create mode 100644 arch/nds32/kernel/devtree.c
>>
>> diff --git a/arch/nds32/boot/dts/Makefile b/arch/nds32/boot/dts/Makefile
>> new file mode 100644
>> index 0000000..d31faa8
>> --- /dev/null
>> +++ b/arch/nds32/boot/dts/Makefile
>> @@ -0,0 +1,8 @@
>> +ifneq '$(CONFIG_NDS32_BUILTIN_DTB)' '""'
>
> Built-in dtb's are really for legacy bootloader cases where the
> bootloader doesn't understand dtbs. Do you have that here?
>
> Plus, I don't see any code here to handle the built-in dtb.

I see it is in patch 2. That means patch 2 won't actually compile. You
should move the devtree.c parts at least and maybe the Makefile
infrastructure part too to patch 2. I don't think you need to split
things up so much, but I'll defer to Arnd on that.

Rob
