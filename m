Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33573 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbdFUWJW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2017 18:09:22 -0400
Received: by mail-io0-f195.google.com with SMTP id j200so2124087ioe.0
        for <linux-arch@vger.kernel.org>; Wed, 21 Jun 2017 15:09:17 -0700 (PDT)
Subject: Re: [PATCH 3/5] sh: thin archives fix linking
References: <20170609052417.561-1-npiggin@gmail.com>
 <20170609052417.561-4-npiggin@gmail.com>
 <CAK7LNARFQ0bLEYOgEKd+0oULevSxRqwFu_VSLn89gn_XBo+-uQ@mail.gmail.com>
From: Rob Landley <rob@landley.net>
Message-ID: <7a1286aa-b656-7b71-2628-9093156143ff@landley.net>
Date: Wed, 21 Jun 2017 17:09:06 -0500
MIME-Version: 1.0
In-Reply-To: <CAK7LNARFQ0bLEYOgEKd+0oULevSxRqwFu_VSLn89gn_XBo+-uQ@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------456D35A4F606E4BE60E3CBC6"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Nicholas Piggin <npiggin@gmail.com>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20170621220906.YbODRh-tlmdYi2nxpgIaUrMPmGgNb4_EFKMo7GLzPVo@z>

This is a multi-part message in MIME format.
--------------456D35A4F606E4BE60E3CBC6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 06/19/2017 01:19 AM, Masahiro Yamada wrote:
> 2017-06-09 14:24 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
>> The VDSO symbols can't be linked into built-in.o when building with
>> thin archives, so change this to linking them into the final link.
>>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Rich Felker <dalias@libc.org>
>> Cc: linux-sh@vger.kernel.org
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
> 
> SH maintainers, any comments for this patch?
> 
> 
> I confirmed this patch solved the build error,
> but I do not have access to any SH hardware.

You can build and boot the kernel under qemu for several architectures
(including sh4) by following the instructions on:

  https://github.com/landley/mkroot

I believe I last built -rc6?

You may need the attached patch to fix the serial port issue from:

  https://www.spinics.net/lists/linux-serial/msg26085.html

Which is still there because the kernel guys don't care that they broke
qemu, and the qemu guys are still using old kernel versions that work
fine. My patch just reverts the kernel change (which enabled hardware
buffer logic qemu doesn't implement).

Rob




--------------456D35A4F606E4BE60E3CBC6
Content-Type: text/x-diff;
 name="qemu-sh4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="qemu-sh4.patch"

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 71707e8..a798def 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2193,7 +2193,7 @@ static void sci_reset(struct uart_port *port)
 			setup_timer(&s->rx_fifo_timer, rx_fifo_timer_fn,
 				    (unsigned long)s);
 		} else {
-			if (port->type == PORT_SCIFA ||
+			if (1 || port->type == PORT_SCIFA ||
 			    port->type == PORT_SCIFB)
 				scif_set_rtrg(port, 1);
 			else

--------------456D35A4F606E4BE60E3CBC6--
