Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42571 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbfECN3i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 May 2019 09:29:38 -0400
MIME-Version: 1.0
References: <20190501173943.5688-1-hch@lst.de> <20190501173943.5688-6-hch@lst.de>
In-Reply-To: <20190501173943.5688-6-hch@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 3 May 2019 09:29:20 -0400
Message-ID: <CAK8P3a2-bFU=2Pmva9qj06JQ44MAW_D-Jaf_0fSExYm1yM8dtQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] asm-generic: remove ptrace.h
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Oleg Nesterov <oleg@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mips@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20190503132920.sLtlgncbzZNfMqff8nfHwESxIq5zV567KekzP3hQ-8g@z>

On Wed, May 1, 2019 at 1:40 PM Christoph Hellwig <hch@lst.de> wrote:
>
> No one is using this helper anymore.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
