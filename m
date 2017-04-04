Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:35757 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752326AbdDDXRX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Apr 2017 19:17:23 -0400
Received: by mail-yw0-f175.google.com with SMTP id d191so68989691ywe.2
        for <linux-arch@vger.kernel.org>; Tue, 04 Apr 2017 16:17:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMgXwTgacUcfzinQKuf8htwxFDJ_GvUN-R0zj7sNbqnpJF3QBA@mail.gmail.com>
References: <CAMgXwTjX1j2dhi7n+APNef0di5oo+iK57Cq0S+3NdMtQzAc=Vw@mail.gmail.com>
 <20170404205617.GG27692@bhelgaas-glaptop.roam.corp.google.com> <CAMgXwTgacUcfzinQKuf8htwxFDJ_GvUN-R0zj7sNbqnpJF3QBA@mail.gmail.com>
From: Wesley Terpstra <wesley@sifive.com>
Date: Tue, 4 Apr 2017 16:17:22 -0700
Message-ID: <CAMgXwTgOw_ANwTGYSSo7687dgW84_mweja3dFkziHwB5izZPfQ@mail.gmail.com>
Subject: Re: PCI enumeration without a BIOS
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20170404231722.Caeep9H3StlQeo8lOrzHXGx4JrXa_fVfvBnIHx9l6cs@z>

On Tue, Apr 4, 2017 at 4:00 PM, Wesley Terpstra <wesley@sifive.com> wrote:
>> Yeah, everything seems mostly working.  The "invalid BAR" things
>> *could* be an issue -- those registers are not what the PCI spec says
>> they should be.
>
> The devices in question are:
> 04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 06)
> 06:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9230 PCIe
> SATA 6Gb/s Controller (rev 11)
>
> I am going to plug them in to an Intel machine with 4.11 and see if I
> get the same warnings.

What the devil! I just booted the riscv machine again and the
"Firmware Bug" warnings were gone. All the other warnings remain the
same.

I've tried to reproduce it, but I can't. It's possible that I got the
cards into a bad state from reprogramming my FPGA repeatedly with
sometimes bad firmware. After the cold start that made the warnings go
away, I can't get them back. I'm going to chalk those warnings up to
"only happens when exposed to a bad processor image".

Thanks again for your help.
