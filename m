From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 2/4] ARC: [axs101] support early 8250 uart
Date: Fri, 5 Jun 2015 10:32:19 +0530
Message-ID: <55712D5B.6090302@synopsys.com>
References: <1431607724-9142-1-git-send-email-abrodkin@synopsys.com> <1431607724-9142-3-git-send-email-abrodkin@synopsys.com> <2836384.o6ec7X8zDk@wuerfel> <C2D7FE5348E1B147BCA15975FBA23075665A0229@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075665A0229@IN01WEMBXB.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-arch.vger.kernel.org

+CC  linux-serial

On Thursday 14 May 2015 06:34 PM, Vineet Gupta wrote:
> On Thursday 14 May 2015 06:23 PM, Arnd Bergmann wrote:
> 
> On Thursday 14 May 2015 15:48:42 Alexey Brodkin wrote:
> 
> 
>> >
>> >         chosen {
>> > -               bootargs = "console=tty0 console=ttyS3,115200n8 consoleblank=0";
>> > +               bootargs = "earlycon=uart8250,mmio32,0xe0022000,115200n8 console=tty0 console=ttyS3,115200n8 consoleblank=0";
>> >         };
>> >  };
>> >
> 
> When you do earlycon with DT, better use a 'stdout-path' property that points
> to the device, and just put 'earlycon' without arguments on the command line.
> 
>         Arnd
> 
> 
> Sure ! I tried that once (3.16) and even the dts patch got merged but had to be reverted out !
> 
> 2014-07-27 22524b02b17b Revert "ARC: [arcfpga] stdout-path now suffices for earlycon/console"
> 
> Let me see if that works again since serial land has seen some significant churn in recent times
> 
> Thx for pointing this out !

so specifying console with stdout-path works for me,

-  bootargs = "earlycon=uart8250,mmio32,0xf0000000,115200n8 console=tty0
console=ttyS0,115200n8 consoleblank=0 debug";
+  bootargs = "earlycon=uart8250,mmio32,0xf0000000,115200n8";
+  stdout-path = &uart0;
..

But I don't see earlycon working with paramless earlycon

-  bootargs = "earlycon=uart8250,mmio32,0xf0000000,115200n8";
+  bootargs = "earlycon";
   stdout-path = &uart0;

And I don't see how it would work for others as of 4.1-rc6
Relevant config items I have are:

CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_OF_PLATFORM=y
...

There are 2 earlyparam handlers for earlcon,
(1) param_setup_earlycon() -> setup_earlycon() -> register_console()
(2) setup_of_earlycon() -> early_init_dt_scan_chosen_serial -> of_setup_earlycon()

#1 only works when arg to earlycon is *not NULL*
#2 only works when arg is *NULL*.

For my case, #2 bails out early as __earlycon_of_table happens to be empty.

8071d8a0 T __earlycon_of_table
8071d8a0 000000c4 t __earlycon_of_table_sentinel

This make sense since I don't see any OF_EARLYCON_DECLARE() in 8250 driver.
As a quick hack I added one in 8250/8250_early.c

@@ -152,3 +154,4 @@ static int __init early_serial8250_setup(struct
earlycon_device *device,
 }
 EARLYCON_DECLARE(uart8250, early_serial8250_setup);
 EARLYCON_DECLARE(uart, early_serial8250_setup);
+OF_EARLYCON_DECLARE(uart8250, "ns8250", early_serial8250_setup);

I needed another fine adjustment as of_setup_earlycon() assumes mmio, while it
needs to be memio32 for my case.

@@ -199,7 +199,7 @@ int __init of_setup_earlycon(unsigned long addr,
        int err;
        struct uart_port *port = &early_console_dev.port;

-       port->iotype = UPIO_MEM;
+       port->iotype = UPIO_MEM32;

With this paramless earlycon works.

Now both the above are hacks, but I want to understand if I'm missing something in
ARC port or does core need some adjustments along the lines of above, since
presumably others have it working !

P.S. with respect to the original patch, I would fold it into for-next with change
to stdout-path and keep earlycon as before - we can fix it up later.

Thx,
-vineet
