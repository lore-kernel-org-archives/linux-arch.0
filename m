From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH 4/9] powerpc/prom_init: get rid of PROM_SCRATCH_SIZE
Date: Fri,  3 May 2019 16:59:15 +1000 (AEST)
Message-ID: <44wNKJ1fXYz9sPJ@ozlabs.org>
References: <5ad9ed13155f55e1715274561354aa7ab57973fc.1554195798.git.christophe.leroy@c-s.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5ad9ed13155f55e1715274561354aa7ab57973fc.1554195798.git.christophe.leroy@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, danielwa@cisco.com
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, 2019-04-02 at 09:08:38 UTC, Christophe Leroy wrote:
> PROM_SCRATCH_SIZE is same as sizeof(prom_scratch)
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d7fbe2a0439ce6f20917a65990a78c9e

cheers
