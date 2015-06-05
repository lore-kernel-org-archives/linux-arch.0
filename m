From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: console setting via stdout-path vs console=xxx (was Re: [PATCH 2/4]
 ARC: [axs101] support early 8250 uart)
Date: Fri, 5 Jun 2015 13:01:23 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665A3DF6@IN01WEMBXB.internal.synopsys.com>
References: <1431607724-9142-1-git-send-email-abrodkin@synopsys.com>
 <1431607724-9142-3-git-send-email-abrodkin@synopsys.com>
 <2836384.o6ec7X8zDk@wuerfel>
 <C2D7FE5348E1B147BCA15975FBA23075665A0229@IN01WEMBXB.internal.synopsys.com>
 <55712D5B.6090302@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Friday 05 June 2015 10:32 AM, Vineet Gupta wrote:
> On Thursday 14 May 2015 06:34 PM, Vineet Gupta wrote:
>> > On Thursday 14 May 2015 06:23 PM, Arnd Bergmann wrote:
>> > 
>> > On Thursday 14 May 2015 15:48:42 Alexey Brodkin wrote:
>> > 
>> > 
>>>> >> >
>>>> >> >         chosen {
>>>> >> > -               bootargs = "console=tty0 console=ttyS3,115200n8 consoleblank=0";
>>>> >> > +               bootargs = "earlycon=uart8250,mmio32,0xe0022000,115200n8 console=tty0 console=ttyS3,115200n8 consoleblank=0";
>>>> >> >         };
>>>> >> >  };
>>>> >> >
>> > 
>> > When you do earlycon with DT, better use a 'stdout-path' property that points
>> > to the device, and just put 'earlycon' without arguments on the command line.
>> > 
>> >         Arnd
>> > 
>> > 
>> > Sure ! I tried that once (3.16) and even the dts patch got merged but had to be reverted out !
>> > 
>> > 2014-07-27 22524b02b17b Revert "ARC: [arcfpga] stdout-path now suffices for earlycon/console"
>> > 
>> > Let me see if that works again since serial land has seen some significant churn in recent times
>> > 
>> > Thx for pointing this out !
> so specifying console with stdout-path works for me,
> 
> -  bootargs = "earlycon=uart8250,mmio32,0xf0000000,115200n8 console=tty0
> console=ttyS0,115200n8 consoleblank=0 debug";
> +  bootargs = "earlycon=uart8250,mmio32,0xf0000000,115200n8";
> +  stdout-path = &uart0;
> ..

Also interestingly, specifying console with stdout-path vs. console=xyz leads to a
subtle behaviour change of boot printing.

With console=xyz, console_setup() -> __add_preferred_console() sets
preferred_console = 0, which doesn't happen with stdout-path.

ARC defconfigs have CONFIG_VT_CONSOLE, so tty0 gets registered. For stdout-path
case it becomes default (deregistering the earlycon), but not in case of cconsole=xyz.

This manifests as a "pause" in boot logging (perceivable if u have linux running
in simulation on a slow host or a large initramfs loading etc). printing is
restored when the real 8250 console registers towards end of boot.

One workaround to this seems to be using @keep_bootcon cmdline option. Asking for
all the bells and whistles to be implemented with paramless earlycon is perhaps
not fair :-)

But this is something developers in this area need to be aware of nevertheless.

Thx,
-Vineet
