Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43937 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGPMqn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 08:46:43 -0400
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907151513450.1722@nanos.tec.linutronix.de> <12bdaca8-99eb-e576-f842-5970ab1d6a92@virtuozzo.com>
In-Reply-To: <12bdaca8-99eb-e576-f842-5970ab1d6a92@virtuozzo.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 16 Jul 2019 14:46:25 +0200
Message-ID: <CAK8P3a208iz_Ra2CwsRvCmcDiQcUFyAO54SNrH3B+dRqpw9ykg@mail.gmail.com>
Subject: Re: [PATCH v2] futex: generic arch_futex_atomic_op_inuser() cleanup
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vasily Averin <vvs@virtuozzo.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20190716124625.a0qK9aUcLj63kdOJzGeF0ZgnAbHn7k-RBQi4u521-B4@z>

On Tue, Jul 16, 2019 at 8:22 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> generic smp version of arch_futex_atomic_op_inuser() always returns -ENOSYS
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I see what you mean now, I got confused earlier when I looked at the
non-SMP version of the same function.
