From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2] of/fdt: Allow memory node and root to have different
 size/address cells
Date: Sat, 3 Oct 2015 08:08:12 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075D781A265@IN01WEMBXB.internal.synopsys.com>
References: <1443701901-362-1-git-send-email-vgupta@synopsys.com>
 <1712345.yOlLsP4Oji@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>, kbuild test robot <lkp@intel.com>, "kbuild-all@01.org" <kbuild-all@01.org>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thursday 01 October 2015 05:52 PM, Arnd Bergmann wrote:
> On Thursday 01 October 2015 17:48:21 Vineet Gupta wrote:
>> Currently memory node parsing uses root "#size-cells", "#address-cells"
>> This doesn't work correctly when memory address/size is different or
>> greater than root's.
>>
>> e.g. ARC 32-bit systems implementing physical adressing extension and
>> say 4GB of memory. All peripherals mappings stay within the 4GB (so root
>> address/size cells remain 1 each), only the memory node address/size
>> cells needs to specify greater than 32-bits as below
>>
>>         memory {
>>                 device_type = "memory";
>>                 reg = <0x0 0x80000000 0x1 0x00000000>;  /* 4 GB */
>>                 #address-cells = <2>;
>>                 #size-cells = <2>;
>>         };
>>
>> This patch lets me boot a ARC system with PAE40 + 4GB of memory specified
>> as above and fails to boot otherwise as memory parsing doesn't populate
>> right base, size.
>>
> This looks wrong: the #address-cells property in a device node is used
> to parse the reg property of its child nodes, not the node itself.
>
> The only way to list memory like this is to put #size-cells=<2>
> into the root node. All lower bus nodes can then use the
> normal #address-cells/#size-cells again and use a ranges property
> to convert the register ranges so you don't need to update all
> nodes.

Thx for taking a look Arnd. I changed the DT per your suggestion and that works
equally well.

Thx,
-Vineet
