From: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 32/76] ARC: [DeviceTree] Basic support
Date: Mon, 21 Jan 2013 15:44:28 +0530
Message-ID: <50FD1504.5020408@synopsys.com>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com>
 <1358511930-7424-33-git-send-email-vgupta@synopsys.com>
 <50F97017.4090705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <50F97017.4090705-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Friday 18 January 2013 09:23 PM, Rob Herring wrote:
> On 01/18/2013 06:24 AM, Vineet Gupta wrote:
>> This is minimal infrastructure needed for devicetree work.
>> It uses an a sample "skeleton" devicetree - embedded in kernel image -
>> to print the board, manufacturer by parsing the top-level "compatible"
>> string.
>>
>> As of now we don't need any additional "board" specific "machine_desc".
>>
>> TODO: support interpreting the command line as boot-loader passed dtb
>>
>> Signed-off-by: Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
>> Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
>> Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
>> ---
>>  arch/arc/Kconfig                |    9 +++++
>>  arch/arc/Makefile               |    9 +++++
>>  arch/arc/boot/dtb/Makefile      |   22 ++++++++++++
> 
> This is .../boot/dts/Makefile on other arches. We should be consistent.

OK, everything moved over to boot/dts folder, boot/dtb nuked, although latter
seemed a clean approach - specially given that some arches have billions of source
files in them - anyways not a big worry for ARC port.


>> [snip....]
>>
>> +
>> +# Rule to build device tree blobs
>> +$(obj)/%.dtb: $(src)/../dts/%.dts FORCE
>> +	$(call if_changed_dep,dtc)
> 
> There are common rules that went into 3.8. Please use them.

How does the equivalent of following look like:

diff --git a/arch/arc/boot/dts/Makefile b/arch/arc/boot/dts/Makefile

@@ -1,7 +1,5 @@
 ifeq ($(CONFIG_OF),y)

-dtb-y  += skeleton.dtb
-
 # Built-in dtb
 builtindtb-y                           := skeleton

@@ -11,12 +9,6 @@ endif

 obj-y  += $(patsubst "%",%,$(builtindtb-y)).dtb.o

-clean-files += $(obj)/$(dtb-y) $(obj)/*.dtb.S $(obj)/*.dtb.o
-
-# Rule to build device tree blobs
-$(obj)/%.dtb: $(src)/../dts/%.dts FORCE
-       $(call if_changed_dep,dtc)
-
-$(obj)/dtbs: $(addprefix $(obj)/, $(dtb-y))
+clean-files += *.dtb

One observation above is that the explicitly build dtb file (make ARCH=arc
angel4.dtb) doesn't get cleaned with make {clean,distclean} despite above
clean-files and this is true even for orig version.

>> +
>> +$(obj)/dtbs: $(addprefix $(obj)/, $(dtb-y))
>> +
>> +endif
>> diff --git a/arch/arc/boot/dts/skeleton.dts b/arch/arc/boot/dts/skeleton.dts
>> new file mode 100644
>> index 0000000..25a84fb
>> --- /dev/null
>> +++ b/arch/arc/boot/dts/skeleton.dts
>> @@ -0,0 +1,10 @@
>> +/*
>> + * Copyright (C) 2012 Synopsys, Inc. (www.synopsys.com)
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +/dts-v1/;
>> +
>> +/include/ "skeleton.dtsi"
>> diff --git a/arch/arc/boot/dts/skeleton.dtsi b/arch/arc/boot/dts/skeleton.dtsi
>> new file mode 100644
>> index 0000000..f6a457a
>> --- /dev/null
>> +++ b/arch/arc/boot/dts/skeleton.dtsi
>> @@ -0,0 +1,21 @@
>> +/*
>> + * Copyright (C) 2012 Synopsys, Inc. (www.synopsys.com)
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +/*
>> + * Skeleton device tree; the bare minimum needed to boot; just include and
>> + * add a compatible value.
>> + */
>> +
>> +/ {
>> +	compatible = "snps,arc-angel4", "snps,arc-ml509";
> 
> Normally, you wouldn't have this as part of skeleton. If you need
> something generic, then perhaps generic.dts would be better.

So you mean rename arc/arc/boot/dts/skeleton.dts to arch/arc/boot/dts/generic.dts
as that's what the semantics are here. I agree.

However I think skeleton semantics are better: I'll take out the specific boards
name from it, and for empty CONFIG_ARC_BUILTIN_DTB_NAME, include a real board DT
file rather than skeleton. OK ?


>> [snipped...]
>>  early_param("mem", setup_mem_sz);
>>  
>> +void __init early_init_dt_add_memory_arch(u64 base, u64 size)
>> +{
>> +	pr_err("%s(%llx, %llx)\n", __func__, base, size);
> 
> ? Is this todo?

Yes, ARC port currently doesn't handle the cmdline provided by DT - given that I
added the the DT support itself very recently. I plan to fix this soon, but assume
it not absolutely must in terms of requirements.


>> +#ifdef CONFIG_OF_FLATTREE
>> +void __init early_init_dt_setup_initrd_arch(unsigned long start,
>> +					    unsigned long end)
>> +{
>> +	pr_err("%s(%lx, %lx)\n", __func__, start, end);
> 
> And this?

Ditto !

Many thanks for your review.
-Vineet
