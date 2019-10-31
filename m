Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:51615 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfJaNrE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2019 09:47:04 -0400
MIME-Version: 1.0
References: <20191031003154.21969-1-linux@rasmusvillemoes.dk> <04799503-b423-6bc8-71cd-bee54e45883e@rasmusvillemoes.dk>
In-Reply-To: <04799503-b423-6bc8-71cd-bee54e45883e@rasmusvillemoes.dk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 31 Oct 2019 14:46:41 +0100
Message-ID: <CAK8P3a17NbSuWzvjKSJiUkxPLhKbqnAEzJLBKuHkPGGjDA6QtQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] powerpc: make iowrite32be etc. inline
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-arch <linux-arch@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christophe Leroy <christophe.leroy@c-s.fr>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20191031134641.coB02a7KO7d1YZuilrM17zAaVE_PNmAwMBmH1UfwfuA@z>

On Thu, Oct 31, 2019 at 8:39 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 31/10/2019 01.31, Rasmus Villemoes wrote:
>
> So sorry for the noise. Maybe I'll just have to bite the bullet and
> introduce private qe_iowrite32be etc. and define them based on $ARCH.
> Any better ideas would be much appreciated.

We use that approach in a number of drivers already, I think it's ok to add it
to another driver. Just make the powerpc case use out_be32 and everything
else use iowrite32_be. You may also be able to enable the driver for
CONFIG_COMPILE_TEST after that.

     Arnd
