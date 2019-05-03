Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:40269 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfECG7S (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 May 2019 02:59:18 -0400
In-Reply-To: <5ad9ed13155f55e1715274561354aa7ab57973fc.1554195798.git.christophe.leroy@c-s.fr>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH 4/9] powerpc/prom_init: get rid of PROM_SCRATCH_SIZE
Message-ID: <44wNKJ1fXYz9sPJ@ozlabs.org>
Date: Fri,  3 May 2019 16:59:15 +1000 (AEST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, danielwa@cisco.com
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-ID: <20190503065915.98mz03vJ8bxBhI-_xVW4TtZAW7nxAeF-sfXv_B9t4_Y@z>

On Tue, 2019-04-02 at 09:08:38 UTC, Christophe Leroy wrote:
> PROM_SCRATCH_SIZE is same as sizeof(prom_scratch)
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d7fbe2a0439ce6f20917a65990a78c9e

cheers
