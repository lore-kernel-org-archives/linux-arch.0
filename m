From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v8 0/8] powerpc: switch VDSO to C implementation
Date: Thu, 16 Jul 2020 22:55:47 +1000 (AEST)
Message-ID: <159490400799.3805857.1673818426986159282.b4-ty@ellerman.id.au>
References: <cover.1588079622.git.christophe.leroy@c-s.fr>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:35969 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgGPMzv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Jul 2020 08:55:51 -0400
In-Reply-To: <cover.1588079622.git.christophe.leroy@c-s.fr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: nathanl@linux.ibm.com, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christophe Leroy <christophe.leroy@c-s.fr>, Paul Mackerras <paulus@samba.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, vincenzo.frascino@arm.com, tglx@linutronix.de, luto@kernel.org, arnd@arndb.de, linuxppc-dev@lists.ozlabs.org

On Tue, 28 Apr 2020 13:16:46 +0000 (UTC), Christophe Leroy wrote:
> This is the seventh version of a series to switch powerpc VDSO to
> generic C implementation.
> 
> Main changes since v7 are:
> - Added gettime64 on PPC32
> 
> This series applies on today's powerpc/merge branch.
> 
> [...]

Patch 1 applied to powerpc/next.

[1/8] powerpc/vdso64: Switch from __get_datapage() to get_datapage inline macro
      https://git.kernel.org/powerpc/c/793d74a8c78e05d6833bfcf582e24e40bd92518f

cheers
