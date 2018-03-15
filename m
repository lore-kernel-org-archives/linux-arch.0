From: Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: rfc: remove print_vma_addr ? (was Re: [PATCH 00/16] remove eight
 obsolete architectures)
Date: Thu, 15 Mar 2018 10:08:30 -0700
Message-ID: <20180315170830.GA17574@bombadil.infradead.org>
References: <20180314143529.1456168-1-arnd@arndb.de>
 <2929.1521106970@warthog.procyon.org.uk>
 <CAMuHMdXcxuzCOnFCNm4NXDv-wfYJDO5GQpB_ECu7j=2BjMhNpA@mail.gmail.com>
 <1521133006.22221.35.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1521133006.22221.35.camel-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux-Arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-rtc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, DRI Development <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Watchdog Mailing List <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux FS Devel <linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 15, 2018 at 09:56:46AM -0700, Joe Perches wrote:
> I have a patchset that creates a vsprintf extension for
> print_vma_addr and removes all the uses similar to the
> print_symbol() removal.
> 
> This now avoids any possible printk interleaving.
> 
> Unfortunately, without some #ifdef in vsprintf, which
> I would like to avoid, it increases the nommu kernel
> size by ~500 bytes.
> 
> Anyone think this is acceptable?
> 
> Here's the overall patch, but I have it as a series
> ---
>  Documentation/core-api/printk-formats.rst |  9 +++++
>  arch/arm64/kernel/traps.c                 | 13 +++----
>  arch/mips/mm/fault.c                      | 16 ++++-----
>  arch/parisc/mm/fault.c                    | 15 ++++----
>  arch/riscv/kernel/traps.c                 | 11 +++---
>  arch/s390/mm/fault.c                      |  7 ++--
>  arch/sparc/mm/fault_32.c                  |  8 ++---
>  arch/sparc/mm/fault_64.c                  |  8 ++---
>  arch/tile/kernel/signal.c                 |  9 ++---
>  arch/um/kernel/trap.c                     | 13 +++----
>  arch/x86/kernel/signal.c                  | 10 ++----
>  arch/x86/kernel/traps.c                   | 18 ++++------
>  arch/x86/mm/fault.c                       | 12 +++----
>  include/linux/mm.h                        |  1 -
>  lib/vsprintf.c                            | 58 ++++++++++++++++++++++++++-----
>  mm/memory.c                               | 33 ------------------
>  16 files changed, 112 insertions(+), 129 deletions(-)

This doesn't feel like a huge win since it's only called ~once per
architecture.  I'd be more excited if it made the printing of the whole
thing standardised; eg we have a print_fault() function in mm/memory.c
which takes a suitable set of arguments.
