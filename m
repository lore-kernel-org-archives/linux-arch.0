From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 0/5] powerpc: make iowrite32be etc. inline
Date: Thu, 31 Oct 2019 14:46:41 +0100
Message-ID: <CAK8P3a17NbSuWzvjKSJiUkxPLhKbqnAEzJLBKuHkPGGjDA6QtQ@mail.gmail.com>
References: <20191031003154.21969-1-linux@rasmusvillemoes.dk> <04799503-b423-6bc8-71cd-bee54e45883e@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <04799503-b423-6bc8-71cd-bee54e45883e@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-arch <linux-arch@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christophe Leroy <christophe.leroy@c-s.fr>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

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
