From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patches] Re: [PATCH 13/17] RISC-V: Add include subdirectory
Date: Sat, 24 Jun 2017 22:01:29 -0500
Message-ID: <1498359689.31581.102.camel@kernel.crashing.org>
References: <mhng-d95a6423-75a8-4a91-bb6a-1f8765b97016@palmer-si-x1c4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:44702 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751115AbdFYDBo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 24 Jun 2017 23:01:44 -0400
In-Reply-To: <mhng-d95a6423-75a8-4a91-bb6a-1f8765b97016@palmer-si-x1c4>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org

On Sat, 2017-06-24 at 14:32 -0700, Palmer Dabbelt wrote:
> On Sat, 24 Jun 2017 08:42:05 PDT (-0700), benh@kernel.crashing.org wrote:
> > On Fri, 2017-06-23 at 19:01 -0700, Palmer Dabbelt wrote:
> > > > > +#define mmiowb()       __asm__ __volatile__ ("fence io,io" : : : "memory");
> > 
> > I forgot if we already mentioned that but mmiowb is primarily intended
> > to order MMIO stores vs. a subsequent spin_unlock.
> > 
> > I'm not sure an IO only fence is sufficient here.
> > 
> > Note that I've never trusted drivers to get that right, it's a rather
> > bad abstraction to begin with, so on powerpc, instead, I just set a
> > per-cpu flag on every non-relaxed MMIO write and test it in spin_unlock
> > in order to "beef up" the barrier in there if necessary.
> 
> Sorry about that -- I thought I'd included a note somewhere that the atomics
> and barriers weren't ready to go yet, as we'd found a bunch of problems with
> them in the first review and I needed to go through them all.  Arnd suggested
> copying the PowerPC approach to mmiowb and I like that better, so we're going
> to use it.

Ah yes, I did see your note, I just wasn't sure we had clarified the
mmiowb case and thought it was worth mentioning.

Cheers,
Ben,
