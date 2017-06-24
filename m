From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 13/17] RISC-V: Add include subdirectory
Date: Sat, 24 Jun 2017 10:42:05 -0500
Message-ID: <1498318925.31581.89.camel@kernel.crashing.org>
References: <mhng-002dc1e3-4bff-43d8-b58c-a105e5643aea@palmer-si-x1c4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:44493 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751316AbdFXPmR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 24 Jun 2017 11:42:17 -0400
In-Reply-To: <mhng-002dc1e3-4bff-43d8-b58c-a105e5643aea@palmer-si-x1c4>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org

On Fri, 2017-06-23 at 19:01 -0700, Palmer Dabbelt wrote:
> > > +#define mmiowb()       __asm__ __volatile__ ("fence io,io" : : : "memory");

I forgot if we already mentioned that but mmiowb is primarily intended
to order MMIO stores vs. a subsequent spin_unlock.

I'm not sure an IO only fence is sufficient here.

Note that I've never trusted drivers to get that right, it's a rather
bad abstraction to begin with, so on powerpc, instead, I just set a
per-cpu flag on every non-relaxed MMIO write and test it in spin_unlock
in order to "beef up" the barrier in there if necessary.

Cheers,
Ben.
