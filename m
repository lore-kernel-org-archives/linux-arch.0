From: Wesley Terpstra <wesley@sifive.com>
Subject: Re: [PATCH 02/17] pcie-xilinx: add missing 5th legacy interrupt
Date: Wed, 7 Jun 2017 12:03:44 -0700
Message-ID: <CAMgXwTjuuE5YHoPJFA+mxGZU=Ck-Wr+A6SdNtpYk-dwQ7SeaBg@mail.gmail.com>
References: <20170523004107.536-1-palmer@dabbelt.com> <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-3-palmer@dabbelt.com> <9e42e6d3-3433-0c3f-812f-28d98ef089dc@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb0-f179.google.com ([209.85.213.179]:34889 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751838AbdFGTDq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jun 2017 15:03:46 -0400
Received: by mail-yb0-f179.google.com with SMTP id f192so4931071yba.2
        for <linux-arch@vger.kernel.org>; Wed, 07 Jun 2017 12:03:45 -0700 (PDT)
In-Reply-To: <9e42e6d3-3433-0c3f-812f-28d98ef089dc@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Albert Ou <albert@sifive.com>, patches@groups.riscv.org, Bjorn Helgaas <bhelgaas@google.com>

On Wed, Jun 7, 2017 at 2:24 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> This is a common problem with the current OF code that numbers INTx from
> 1 instead of zero (there is no 5th legacy interrupts in the PCI spec,
> despite what $SUBJECT says). I'd be inclined to fix this at the core
> level rather than papering over it in the various drivers...

While I agree that it's a problem with OF, every other driver has
already been changed to paper over the issue. This patch just brings
this one remaining OF-PCIe driver to the same level as the others.
Without the patch, the driver doesn't work at all if there is a bridge
chip on the other end of the controller, so this is not just a
hypothetical concern for us.

Couldn't the eventual OF fix just refactor this driver along with all
of the others? Doing such a sweeping OF change is outside my current
comfort zone. I am not familiar enough with the code to understand all
the parts that would need to be touched.
