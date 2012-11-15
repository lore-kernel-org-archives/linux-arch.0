From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V5 1/2] kbuild: centralize .dts->.dtb rule
Date: Thu, 15 Nov 2012 10:32:56 +0000
Message-ID: <CACxGe6vhd_4rcBbYyqtvbySVaY6XpNE+HQq42PZhKe5yt=zcaA@mail.gmail.com>
References: <1351721431-26220-1-git-send-email-swarren@wwwdotorg.org>
 <20121102095801.GC17860@linux-mips.org> <20121102102335.GF2905@linux-mips.org>
 <CACxGe6vUGaRG-c3Vr5Zuuohhct6hEM-AhrZ6fmFfd6nyNZdo=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56764 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992441Ab2KOKdR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Nov 2012 05:33:17 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so988233pad.19
        for <linux-arch@vger.kernel.org>; Thu, 15 Nov 2012 02:33:16 -0800 (PST)
In-Reply-To: <CACxGe6vUGaRG-c3Vr5Zuuohhct6hEM-AhrZ6fmFfd6nyNZdo=Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Michal Marek <mmarek@suse.cz>, David Gibson <david@gibson.dropbear.id.au>, Jon Loeliger <jdl@jdl.com>, Rob Herring <rob.herring@calxeda.com>, Scott Wood <scottwood@freescale.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arch@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, linux-mips@linux-mips.org

On Thu, Nov 15, 2012 at 10:15 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Fri, Nov 2, 2012 at 10:23 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
>> On Fri, Nov 02, 2012 at 10:58:01AM +0100, Ralf Baechle wrote:
>>
>>> Can you fold these MIPS bits into your patch?
>>
>> I missed Lantiq.
>>
>>   Ralf
>>
>> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>>
>>  arch/mips/cavium-octeon/Makefile | 3 ---
>>  arch/mips/lantiq/dts/Makefile    | 3 ---
>>  arch/mips/netlogic/dts/Makefile  | 3 ---
>>  3 files changed, 9 deletions(-)
>>
>> diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
>> index bc96e29..6e927cf 100644
>> --- a/arch/mips/cavium-octeon/Makefile
>> +++ b/arch/mips/cavium-octeon/Makefile
>> @@ -24,9 +24,6 @@ DTB_FILES = $(patsubst %.dts, %.dtb, $(DTS_FILES))
>>
>>  obj-y += $(patsubst %.dts, %.dtb.o, $(DTS_FILES))
>>
>> -$(obj)/%.dtb: $(src)/%.dts FORCE
>> -       $(call if_changed_dep,dtc)
>> -
>>  # Let's keep the .dtb files around in case we want to look at them.
>>  .SECONDARY:  $(addprefix $(obj)/, $(DTB_FILES))
>>
>> diff --git a/arch/mips/lantiq/dts/Makefile b/arch/mips/lantiq/dts/Makefile
>> index 674fca4..6fa72dd 100644
>> --- a/arch/mips/lantiq/dts/Makefile
>> +++ b/arch/mips/lantiq/dts/Makefile
>> @@ -1,4 +1 @@
>>  obj-$(CONFIG_DT_EASY50712) := easy50712.dtb.o
>> -
>> -$(obj)/%.dtb: $(obj)/%.dts
>> -       $(call if_changed,dtc)
>> diff --git a/arch/mips/netlogic/dts/Makefile b/arch/mips/netlogic/dts/Makefile
>> index 67ae3fe2..d117d46 100644
>> --- a/arch/mips/netlogic/dts/Makefile
>> +++ b/arch/mips/netlogic/dts/Makefile
>> @@ -1,4 +1 @@
>>  obj-$(CONFIG_DT_XLP_EVP) := xlp_evp.dtb.o
>> -
>> -$(obj)/%.dtb: $(obj)/%.dts
>> -       $(call if_changed,dtc)
>
> This actually breaks MIPS builds. MIPS builds the .dtbs in the same
> directory as the .dts files. Everyone else has a dts/ subdirectory,
> which is admittedly a bit insane, but until things are resolved I've
> dropped the above MIPS hunks.
>
> MIPS /could/ be changed to also use a dts directory, but I'd actually
> rather if someone could make all the other platforms build the dtbs in
> the same directory. I've looked at it briefly, but I haven't figured
> out all the make magic needed to do it nicely.

On second thought. I'm dropping this patch entirely for now. I don't
want to put in a generic rule that expects files in weird locations.
If we can fix up all the architectures to build dtb in the dts
directory, then it is better for each architecture to have a separate
fixup patch instead of changing everyone at once.

Or how about: I could pick up the patch with only the MIPS hunk and
every other user can be fixed up independently to use the new rule.

g.
