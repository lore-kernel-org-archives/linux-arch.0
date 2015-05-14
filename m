From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 2/4] ARC: [axs101] support early 8250 uart
Date: Thu, 14 May 2015 13:04:27 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665A0229@IN01WEMBXB.internal.synopsys.com>
References: <1431607724-9142-1-git-send-email-abrodkin@synopsys.com>
 <1431607724-9142-3-git-send-email-abrodkin@synopsys.com>
 <2836384.o6ec7X8zDk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:52219 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932490AbbENNEd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 May 2015 09:04:33 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Peter Hurley <peter@hurleysoftware.com>

On Thursday 14 May 2015 06:23 PM, Arnd Bergmann wrote:

On Thursday 14 May 2015 15:48:42 Alexey Brodkin wrote:


>
>         chosen {
> -               bootargs = "console=tty0 console=ttyS3,115200n8 consoleblank=0";
> +               bootargs = "earlycon=uart8250,mmio32,0xe0022000,115200n8 console=tty0 console=ttyS3,115200n8 consoleblank=0";
>         };
>  };
>


When you do earlycon with DT, better use a 'stdout-path' property that points
to the device, and just put 'earlycon' without arguments on the command line.

        Arnd


Sure ! I tried that once (3.16) and even the dts patch got merged but had to be reverted out !

2014-07-27 22524b02b17b Revert "ARC: [arcfpga] stdout-path now suffices for earlycon/console"

Let me see if that works again since serial land has seen some significant churn in recent times

Thx for pointing this out !

-Vineet
