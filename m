From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/4] powerpc: Reduce ELF_ET_DYN_BASE
Date: Fri, 23 Jun 2017 17:01:42 +1000
Message-ID: <87podvp4q1.fsf@concordia.ellerman.id.au>
References: <1498154792-49952-1-git-send-email-keescook@chromium.org> <1498154792-49952-4-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:36559 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754467AbdFWHBp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Jun 2017 03:01:45 -0400
In-Reply-To: <1498154792-49952-4-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, James Hogan <james.hogan@imgtec.com>, Pratyush Anand <panand@redhat.com>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-hardening@lists.openwall.com

Kees Cook <keescook@chromium.org> writes:

> Now that explicitly executed loaders are loaded in the mmap region,
> position PIE binaries lower in the address space to avoid possible
> collisions with mmap or stack regions. For 64-bit, align to 4GB to
> allow runtimes to use the entire 32-bit address space for 32-bit
> pointers.

The change log and subject are a bit out of whack with the actual patch
because previously we used 512MB.

How about?

  powerpc: Move ELF_ET_DYN_BASE to 4GB / 4MB
  
  Now that explicitly executed loaders are loaded in the mmap region,
  we have more freedom to decide where we position PIE binaries in the
  address space to avoid possible collisions with mmap or stack regions.
  
  For 64-bit, align to 4GB to allow runtimes to use the entire 32-bit
  address space for 32-bit pointers. On 32-bit use 4MB.


Is there any particular reasoning behind the 4MB value on 32-bit?


I gave this a quick spin and it booted OK on all my test boxes, which
covers 64-bit/32-bit kernel and userspace. So seems to work!

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
