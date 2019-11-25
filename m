Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33952 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYWHV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2019 17:07:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so20071078wrr.1
        for <linux-arch@vger.kernel.org>; Mon, 25 Nov 2019 14:07:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573179553.git.thehajime@gmail.com> <1531c5f16a00b608635c9a62fa3951807075f950.1573179553.git.thehajime@gmail.com>
In-Reply-To: <1531c5f16a00b608635c9a62fa3951807075f950.1573179553.git.thehajime@gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 25 Nov 2019 23:07:09 +0100
Message-ID: <CAFLxGvzCwCLbLMhcF6ZJ2afeo7PSd8xLQrU9hRH6YVaMakBSyw@mail.gmail.com>
Subject: Re: [RFC v2 17/37] lkl tools: host lib: virtio devices
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, Linux-Arch <linux-arch@vger.kernel.org>, Conrad Meyer <cem@freebsd.org>, Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>, Yuan Liu <liuyuan@google.com>, Patrick Collins <pscollins@google.com>, linux-kernel-library@freelists.org, Michael Zimmermann <sigmaepsilon92@gmail.com>

On Fri, Nov 8, 2019 at 6:03 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>
> From: Octavian Purdila <tavi.purdila@gmail.com>
>
> Add helpers for implementing host virtio devices. It uses the memory
> mapped I/O helpers to interact with the Linux MMIO virtio transport
> driver and offers support to setup and add a new virtio device,
> dispatch requests from the incoming queues as well as support for
> completing requests.
>
> All added virtio devices are stored in lkl_virtio_devs as strings, per
> the Linux MMIO virtio transport driver command line specification.

Did you checkout arch/um/drivers/virtio_uml.c?
Why is this driver needed?

Virtio support is rather new in UML, we definitely need a common
code base for LKL and UML regarding to virtio.

-- 
Thanks,
//richard
