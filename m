From: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 32/71] ARC: [DeviceTree] Basic support
Date: Tue, 29 Jan 2013 19:09:16 +0530
Message-ID: <5107D104.5050304@synopsys.com>
References: <1359024639-21915-1-git-send-email-vgupta@synopsys.com>
 <1359024639-21915-15-git-send-email-vgupta@synopsys.com>
 <5107CDD3.3050502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5107CDD3.3050502-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

On Tuesday 29 January 2013 06:55 PM, Rob Herring wrote:
> On 01/24/2013 04:50 AM, Vineet Gupta wrote:
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
> One minor thing below, otherwise:
>
> Reviewed-by: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
>
>
>> diff --git a/arch/arc/kernel/devtree.c b/arch/arc/kernel/devtree.c
>> new file mode 100644
>> index 0000000..229f78e
>> --- /dev/null
>> +++ b/arch/arc/kernel/devtree.c
>> @@ -0,0 +1,69 @@
>> +/*
>> + * Copyright (C) 2012 Synopsys, Inc. (www.synopsys.com)
>> + *
>> + * Based on highly stipped down version of METAG
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +
>> +#include <linux/init.h>
>> +#include <linux/export.h>
>> +#include <linux/errno.h>
> Is this include needed?

Nope - removed.

>
>> +#include <linux/types.h>
>> +#include <linux/reboot.h>
> And this?

reboot.h is needed for the machine_halt() prototype.

>
>> +#include <linux/memblock.h>
>> +#include <linux/of.h>
>> +#include <linux/of_fdt.h>
>> +#include <linux/of_irq.h>
> And this?
>
>> +#include <linux/of_platform.h>
> And this?

Both of the above removed.

I'll send a revised patch which also addresses James' review comments as well -
(namely broken dtbs rule, adding dependency on scripts ...)
See https://lkml.org/lkml/2013/1/28/138 for reference.
