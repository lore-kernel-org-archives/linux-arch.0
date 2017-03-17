From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 0/3] ioremap() tidy-up
Date: Fri, 17 Mar 2017 23:00:03 +0100
Message-ID: <CAK8P3a04OP+0gXBzDdC3=BJ99SL5Hw_rRLESsLJ7_PG9OHFt6w@mail.gmail.com>
References: <20170317172752.6308.91062.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36331 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdCQWAI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Mar 2017 18:00:08 -0400
In-Reply-To: <20170317172752.6308.91062.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Mar 17, 2017 at 6:46 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> 1) Fix some comments that say "IOMMU" when they mean "MMU".
>
> 2) Remove the generic __ioremap() definition, which I think is unused and
> confusing.
>
> 3) Simplify the comments about ioremap() implementation.  I split this out
> in case I went too far and made this controversial.

All look good

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Do you want to take them through your PCI tree?

    Arnd
