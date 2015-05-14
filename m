From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/4] ARC: [axs101] support early 8250 uart
Date: Thu, 14 May 2015 14:53:31 +0200
Message-ID: <2836384.o6ec7X8zDk@wuerfel>
References: <1431607724-9142-1-git-send-email-abrodkin@synopsys.com> <1431607724-9142-3-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431607724-9142-3-git-send-email-abrodkin@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, devicetree@vger.kernel.org, Vineet.Gupta1@synopsys.com
List-Id: linux-arch.vger.kernel.org

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
