From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 22/35] nds32: Device tree support
Date: Sun, 3 Dec 2017 00:47:02 +0800
Message-ID: <CAEbi=3c4fx5NoBX1qXSi97YAHbHXOJiwOjFsy0XF5r5hLwcD-A@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <1055af0e8b98571b4461d6f899d043fe7f17408b.1511785528.git.green.hu@gmail.com>
 <CAL_Jsq+c4vt4-royBuTxAj+AY2wFHMugyyy41S5YP-QXyF2gbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_Jsq+c4vt4-royBuTxAj+AY2wFHMugyyy41S5YP-QXyF2gbQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

2017-11-28 3:07 GMT+08:00 Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Mon, Nov 27, 2017 at 6:28 AM, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>>
>> This patch adds support for device tree.
>>
>> Signed-off-by: Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>> Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
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

As you mentioned in the next thread, it is handled in head.S
We would like to keep it because we debug kernel through gdb without
bootloader very often.

>> +BUILTIN_DTB := $(patsubst "%",%,$(CONFIG_NDS32_BUILTIN_DTB)).dtb.o
>> +else
>> +BUILTIN_DTB :=
>> +endif
>> +obj-$(CONFIG_OF) += $(BUILTIN_DTB)
>> +
>> +clean-files := *.dtb *.dtb.S
>> diff --git a/arch/nds32/boot/dts/ae3xx.dts b/arch/nds32/boot/dts/ae3xx.dts
>> new file mode 100644
>> index 0000000..4181060
>> --- /dev/null
>> +++ b/arch/nds32/boot/dts/ae3xx.dts
>> @@ -0,0 +1,55 @@
>> +/dts-v1/;
>> +/ {
>> +       compatible = "nds32 ae3xx";
>
> This compatible needs to be documented and is not valid. Needs to be
> in the form "vendor,board-name" without spaces.

Sorry I forgot to check this.
I will provide a document in bindings like
"Documentation/devicetree/bindings/nds32/andestech-boards".

>> +       #address-cells = <1>;
>> +       #size-cells = <1>;
>> +       interrupt-parent = <&intc>;
>> +
>> +       chosen {
>> +               bootargs = "earlycon console=ttyS0,38400n8 debug loglevel=7";
>> +               stdout-path = &serial0;
>> +       };
>> +
>> +       memory@0 {
>> +               device_type = "memory";
>> +               reg = <0x00000000 0x40000000>;
>> +       };
>> +
>> +       cpu {
>> +               device_type = "cpu";
>> +               compatible = "andestech,n13", "andestech,nds32v3";
>> +               clock-frequency = <60000000>;
>> +       };
>> +
>> +       intc: interrupt-controller {
>> +               compatible = "andestech,ativic32";
>> +               #interrupt-cells = <1>;
>> +               interrupt-controller;
>> +       };
>> +
>> +       serial0: serial@f0300000 {
>> +               compatible = "andestech,uart16550", "ns16550a";
>> +               reg = <0xf0300000 0x1000>;
>> +               interrupts = <8>;
>> +               clock-frequency = <14745600>;
>> +               reg-shift = <2>;
>> +               reg-offset = <32>;
>> +               no-loopback-test = <1>;
>> +       };
>> +
>> +       timer0: timer@f0400000 {
>> +               compatible = "andestech,atcpit100";
>> +               reg = <0xf0400000 0x1000>;
>> +               interrupts = <2>;
>> +               clock-frequency = <30000000>;
>> +               cycle-count-offset = <0x38>;
>> +               cycle-count-down;
>> +       };
>> +
>> +       mac0: mac@e0100000 {
>
> ethernet@...
>
>> +               compatible = "andestech,atmac100";
>> +               reg = <0xe0100000 0x1000>;
>> +               interrupts = <18>;
>> +       };
>> +
>> +};
>> diff --git a/arch/nds32/boot/dts/ag101p.dts b/arch/nds32/boot/dts/ag101p.dts
>> new file mode 100644
>> index 0000000..f1cb540
>> --- /dev/null
>> +++ b/arch/nds32/boot/dts/ag101p.dts
>> @@ -0,0 +1,60 @@
>> +/dts-v1/;
>> +/ {
>> +       compatible = "nds32 ag101p";
>
> Same here.

Sorry I forgot to check this.
I will provide a document in bindings like
"Documentation/devicetree/bindings/nds32/andestech-boards".

>> +       #address-cells = <1>;
>> +       #size-cells = <1>;
>> +       interrupt-parent = <&intc>;
>> +
>> +       chosen {
>> +               bootargs = "earlycon console=ttyS0,38400n8 debug loglevel=7";
>> +               stdout-path = &serial0;
>> +       };
>> +
>> +       memory@0 {
>> +               device_type = "memory";
>> +               reg = <0x00000000 0x40000000>;
>> +       };
>> +
>> +       cpu@0 {
>> +               device_type = "cpu";
>> +               compatible = "andestech,n13";
>> +               clock-frequency = <60000000>;
>> +               next-level-cache = <&L2>;
>> +       };
>> +
>> +       intc: interrupt-controller {
>> +               compatible = "andestech,ativic32";
>> +               #interrupt-cells = <2>;
>> +               interrupt-controller;
>> +       };
>> +
>> +       serial0: serial@99600000 {
>> +               compatible = "andestech,uart16550", "ns16550a";
>> +               reg = <0x99600000 0x1000>;
>> +               interrupts = <7 4>;
>> +               clock-frequency = <14745600>;
>> +               reg-shift = <2>;
>> +               no-loopback-test = <1>;
>> +       };
>> +
>> +       timer0: timer@98400000 {
>> +               compatible = "andestech,atftmr010";
>> +               reg = <0x98400000 0x1000>;
>> +               interrupts = <19 4>;
>> +               clock-frequency = <15000000>;
>> +               cycle-count-offset = <0x20>;
>> +       };
>> +
>> +       mac0: mac@90900000 {
>> +               compatible = "andestech,atmac100";
>> +               reg = <0x90900000 0x1000>;
>> +               interrupts = <25 4>;
>> +       };
>> +
>> +       L2: l2-cache {
>> +               compatible = "andestech,atl2c";
>> +               reg = <0x90f00000 0x1000>;
>> +               cache-unified;
>> +               cache-level = <2>;
>> +       };
>> +};
>> diff --git a/arch/nds32/kernel/devtree.c b/arch/nds32/kernel/devtree.c
>> new file mode 100644
>> index 0000000..2af0f1c
>> --- /dev/null
>> +++ b/arch/nds32/kernel/devtree.c
>> @@ -0,0 +1,45 @@
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
>> +
>> +#include <linux/memblock.h>
>> +#include <linux/of_fdt.h>
>> +#include <linux/bootmem.h>
>> +
>> +void __init early_init_dt_add_memory_arch(u64 base, u64 size)
>> +{
>> +       size &= PAGE_MASK;
>> +       memblock_add_node(base, size, 0);
>> +}
>> +
>> +void *__init early_init_dt_alloc_memory_arch(u64 size, u64 align)
>> +{
>> +       return alloc_bootmem_align(size, align);
>> +}
>
> You should be able to use the default functions for these 2.

Thanks. I will remove these 2 functions to use default ones.

>> +
>> +void __init early_init_devtree(void *params)
>> +{
>> +       if (!params || !early_init_dt_scan(params)) {
>> +               pr_crit("\n"
>> +                       "Error: invalid device tree blob at (virtual address 0x%p)\n"
>> +                       "The dtb must be 8-byte aligned and must not exceed 8 KB in size\n"
>
> Why the size limit? That's pretty small for a DT.

Thanks. I will update it in the next version patch.

>> +                       "\nPlease check your bootloader.", params);
>> +
>> +               while (true)
>> +                       cpu_relax();
>
> Might as well use BUG_ON here if you're not going to continue. It's
> generally better to WARN and continue on otherwise the messages aren't
> visible until the console is up. However, if you have DT errors this
> early, there's not much you can really do here.

Yup. Maybe we shall hang in here for user to know he use a wrong DT.
I will change it to BUG_ON(1).

>> +       }
>> +
>> +       dump_stack_set_arch_desc("%s (DT)", of_flat_dt_get_machine_name());
>> +}
>> --
>> 1.7.9.5
>>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
