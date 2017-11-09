From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 23/31] nds32: Device tree support
Date: Thu, 9 Nov 2017 15:48:40 +0800
Message-ID: <CAEbi=3e6rKX3Z-7ssKna1HFH-_7sLVvoBXDqK2weuG9achD9Nw@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <b8120c11ba60eb2a3c7741197c6b2cbf1490bc96.1510118606.git.green.hu@gmail.com>
 <CAK8P3a1C-FUkJePjueRF1hFDRLr8OQ3KL89K_kvmBdbrjhvvVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1C-FUkJePjueRF1hFDRLr8OQ3KL89K_kvmBdbrjhvvVQ@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

2017-11-08 17:53 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> From: Greentime Hu <greentime@andestech.com>
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
>> +BUILTIN_DTB := $(patsubst "%",%,$(CONFIG_NDS32_BUILTIN_DTB)).dtb.o
>> +else
>> +BUILTIN_DTB :=
>> +endif
>> +obj-$(CONFIG_OF) += $(BUILTIN_DTB)
>
> For new architectures, I think it's better to not support built-in dtb
> but instead require the
> boot loader to be aware of device trees.

Thanks.
I got your point and we have uboot supporting DTB too.
But we use gdb to load vmlinux without uboot sometimes, it can help us
to verify kernel more easily.
If dtb pointer is set by uboot, we will use it instead of using built-in dtb.

>> +clean-files := *.dtb *.dtb.S
>> diff --git a/arch/nds32/boot/dts/ae3xx.dts b/arch/nds32/boot/dts/ae3xx.dts
>> new file mode 100644
>> index 0000000..b6c85dc
>> --- /dev/null
>> +++ b/arch/nds32/boot/dts/ae3xx.dts
>> @@ -0,0 +1,55 @@
>> +/dts-v1/;
>> +/ {
>> +       compatible = "nds32 ae3xx";
>
> ae3xx looks like a wildcard name for multiple boards. Please always
> have compatible
> names without wildcards. You usually also want to list both the SoC
> and the board
> here.

Thanks.
It looks a little bit weird but its not a wildcards. :p
I will list all the names instead of wildcards if I need to add more platforms.

>> +       #address-cells = <1>;
>> +       #size-cells = <1>;
>> +       interrupt-parent = <&intc>;
>> +
>> +       chosen {
>> +               bootargs = "console=ttyS0,38400n8 earlyprintk=uart8250-32bit,0xf0300000 debug loglevel=7";
>> +       };
>
> Remove the earlyprintk option from the bootargs here, regular boards
> should never rely
> on earlyprintk. The "earlycon" support in the uart drivers works
> almost as well (it starts
> slightly later in the boot process), and it will pick up the uart from
> the chosen/stdout-path
> property.

Thanks.
I will remove it.

>> +       if (!params || !early_init_dt_scan(params)) {
>> +               pr_crit("\n"
>> +                       "Error: invalid device tree blob at (virtual address 0x%p)\n"
>> +                       "The dtb must be 8-byte aligned and must not exceed 8 KB in size\n"
>> +                       "\nPlease check your bootloader.", params);
>
> What is the 8KB limit for the dtb for? This sounds really limiting
> once you get to
> more complex SoCs.

Thanks.
We allow uboot to set its start address and we think it might not be
too big thus we limit it to 8KB.
Maybe I should use a big size for complex SoCs.
I will update it in the next version patch.
