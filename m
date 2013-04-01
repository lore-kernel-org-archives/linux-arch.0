From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: host gcc 4.7 warning when generating defconfig
Date: Mon, 1 Apr 2013 17:58:25 +0530
Message-ID: <51597D69.5090008@synopsys.com>
References: <514AADAD.1060503@synopsys.com> <20130401121218.GA4409@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20130401121218.GA4409@merkur.ravnborg.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>
List-Id: linux-arch.vger.kernel.org

Hi Sam,

On 04/01/2013 05:42 PM, Sam Ravnborg wrote:
> On Thu, Mar 21, 2013 at 12:20:21PM +0530, Vineet Gupta wrote:
>> Hi,
>>
>> We do cross compile builds for ARC Linux. To avoid the env var set, we have a
>> defconfig entry for CONFIG_CROSS_COMPILE.
>> This worked fine so far (host gcc 4.4 i.e.). When switched to a new host distro
>> (gcc 4.7), a defconfig build spews out the warning.
>>
>> ------------------->8--------------------------
>> mymake defconfig
>> gcc: error: unrecognized command line option '-marc600'
>> gcc: error: unrecognized command line option '-mA7'
>> gcc: error: unrecognized command line option '-mno-sdata'
>> gcc: error: unrecognized command line option '-mno-mpy'
>> *** Default configuration is based on 'fpga_defconfig'
>> #
>> # configuration written to .config
>> ------------------->8--------------------------
>>
>> While the following trivial fix seems to fix this, it seems that the spew is
>> coming due to LIBGCC definition line, which is strange to be called for defconfig
>> generation. Any thoughts ?
>>
>> ---------------->
>> diff --git a/arch/arc/Makefile b/arch/arc/Makefile
>> index 4232d4e..97e6c20 100644
>> --- a/arch/arc/Makefile
>> +++ b/arch/arc/Makefile
>> @@ -8,6 +8,10 @@
>>  
>>  UTS_MACHINE := arc
>>  
>> +ifeq ($(CROSS_COMPILE),)
>> +#CROSS_COMPILE := arc-elf32-
>> +endif
>> +
>>  KBUILD_DEFCONFIG := fpga_defconfig
> 
> 
> You could try to use LIBGCC = $(shell ... for assignment.
> Use "=" and not ":=".
> 
> Like this:
> 
> -LIBGCC := $(shell $(CC) $(ARC_LIBGCC) $(cflags-y) --print-libgcc-file-name)
> +LIBGCC = $(shell $(CC) $(ARC_LIBGCC) $(cflags-y) --print-libgcc-file-name)
> 
> This would defer the evaluation until we actually reference the variable,
> and thus I think it will not trigger for a defconfig build.
> 
> I could not reproduce the problem here so I am not sure this has any effect though...

Indeed the defconfig is fixed with your suggestion.
However make ARCH=arc {clean,distclean} still show the same spew !

Thx,
-Vineet
