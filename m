From: afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: Re: [PATCH 00/16] remove eight obsolete architectures
Date: Fri, 16 Mar 2018 10:20:16 +0530
Message-ID: <20180316045016.GA7697@afzalpc>
References: <20180314143529.1456168-1-arnd@arndb.de>
 <2929.1521106970@warthog.procyon.org.uk>
 <CAK8P3a10hBz7QYk5v5MfhVMPOwFnWYTn95WZp1HtHrd7-GQpRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a10hBz7QYk5v5MfhVMPOwFnWYTn95WZp1HtHrd7-GQpRg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-spi <linux-spi@vger.kernel.org>, linux-usb@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
List-Id: linux-arch.vger.kernel.org

Hi,

On Thu, Mar 15, 2018 at 10:56:48AM +0100, Arnd Bergmann wrote:
> On Thu, Mar 15, 2018 at 10:42 AM, David Howells <dhowells@redhat.com> wrote:

> > Do we have anything left that still implements NOMMU?

Please don't kill !MMU.

> Yes, plenty.

> I've made an overview of the remaining architectures for my own reference[1].
> The remaining NOMMU architectures are:
> 
> - arch/arm has ARMv7-M (Cortex-M microcontroller), which is actually
> gaining traction

ARMv7-R as well, also seems ARM is coming up with more !MMU's - v8-M,
v8-R. In addition, though only of academic interest, ARM MMU capable
platform's can run !MMU Linux.

afzal

> - arch/sh has an open-source J2 core that was added not that long ago,
> it seems to
>   be the only SH compatible core that anyone is working on.
> - arch/microblaze supports both MMU/NOMMU modes (most use an MMU)
> - arch/m68k supports several NOMMU targets, both the coldfire SoCs and the
>   classic processors
> - c6x has no MMU
