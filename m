Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35624 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389824AbfBROD7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2019 09:03:59 -0500
MIME-Version: 1.0
References: <20190124142448.23243-1-mst@redhat.com> <20190210231841-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190210231841-mutt-send-email-mst@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 15:03:41 +0100
Message-ID: <CAK8P3a2cWjSSUJehMGEMCmnjdWJRZcyoegtN1ERqX7Tzkm-DXg@mail.gmail.com>
Subject: Re: [PATCH 0/3] generic asm: mman cleanup
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190218140341.5u1IMosgO0TgpeUPAzSex8UEYiIXRQpH6W2-9IN7Zp0@z>

On Mon, Feb 11, 2019 at 5:20 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Feb 08, 2019 at 01:02:51AM -0500, Michael S. Tsirkin wrote:
> > Now that we have MAP_SHARED, MAP_PRIVATE and MAP_SHARED_VALIDATE on all
> > architectures, it probably makes sense to de-duplicate these
> > and put them into a common header.
> >
> > Please review and consider merging though the generic tree.
> >
> > Build tested on x86 only. Has been in linux-next for a while now.
>
> Arnd, would you consider merging at least the cleanups 2/3 and 3/3?
> In linux-next they had no ill effects and make things
> slightly cleaner IMO.

I applied patches 2 and 3 now, sorry for the late reply.

     Arnd
