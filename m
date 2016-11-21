Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36125 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbcKUFt7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2016 00:49:59 -0500
Date: Mon, 21 Nov 2016 16:49:40 +1100
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: 'kbuild' merge before 4.9-rc1 breaks build and boot
Message-ID: <20161121164940.33b555ea@roar.ozlabs.ibm.com>
In-Reply-To: <20161120182623.GA1988@al>
References: <4c04b846-3da8-dc42-4fa6-30f72a5c2437@hartkopp.net>
        <20161027154202.GE27017@al>
        <alpine.DEB.2.20.1611071408040.24418@macbook-air>
        <20161107213907.GB18092@al>
        <20161108123334.3df2dcc9@roar.ozlabs.ibm.com>
        <20161120182623.GA1988@al>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Wu <peter@lekensteyn.nl>
Cc: Vince Weaver <vincent.weaver@maine.edu>, Michal Marek <mmarek@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, regressions@leemhuis.info, Adam Borowski <kilobyte@angband.pl>
Message-ID: <20161121054940.HqrcrASkhGik-YXjU24cbVyQ-3KMH4-ADRCYq-FRT6U@z>

On Sun, 20 Nov 2016 19:26:23 +0100
Peter Wu <peter@lekensteyn.nl> wrote:

> Hi Nicholas,
> 
> Current git master (v4.9-rc5-364-g77079b1) with the latest kbuild fixes
> is still failing to load modules when built with CONFIG_MODVERSIONS=y on
> x86_64 using GCC 6.2.1.
> 
> It can still be reproduced with make defconfig, then enabling
> CONFIG_MODVERSIONS=y. The build output contains:
> 
>     WARNING: "memcpy" [net/netfilter/nf_nat.ko] has no CRC!
>     WARNING: "memmove" [net/netfilter/nf_nat.ko] has no CRC!
>     WARNING: "_copy_to_user" [fs/efivarfs/efivarfs.ko] has no CRC!
>     WARNING: "memcpy" [fs/efivarfs/efivarfs.ko] has no CRC!
>     WARNING: "_copy_from_user" [fs/efivarfs/efivarfs.ko] has no CRC!

Hi Peter,

Sorry it's taken some time, bear with us. The arch specific patches need
to be merged now. Adam, what is the status of your patch? Please submit
to x86 maintainers if you haven't already.

Thanks,
Nick
