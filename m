Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:50360 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPT0k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Apr 2019 15:26:40 -0400
Date: Tue, 16 Apr 2019 21:26:13 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 5/5] arm64/speculation: Support 'mitigations=' cmdline
 option
In-Reply-To: <24039e1370ed57e8075730c0b88c505afd9e0ab7.1555085500.git.jpoimboe@redhat.com>
Message-ID: <alpine.DEB.2.21.1904162124020.1780@nanos.tec.linutronix.de>
References: <cover.1555085500.git.jpoimboe@redhat.com> <24039e1370ed57e8075730c0b88c505afd9e0ab7.1555085500.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tyler Hicks <tyhicks@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Steven Price <steven.price@arm.com>, Phil Auld <pauld@redhat.com>
Message-ID: <20190416192613.S91nm-RZsx2mYrhSIcCl17YEj1vVpFiYsyoP12HwdKg@z>

On Fri, 12 Apr 2019, Josh Poimboeuf wrote:

> Configure arm64 runtime CPU speculation bug mitigations in accordance
> with the 'mitigations=' cmdline option.  This affects Meltdown, Spectre
> v2, and Speculative Store Bypass.
> 
> The default behavior is unchanged.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
> NOTE: This is based on top of Jeremy Linton's patches:
>       https://lkml.kernel.org/r/20190410231237.52506-1-jeremy.linton@arm.com

So I keep that out and we have to revisit that once the ARM64 stuff hits a
tree, right? I can have a branch with just the 4 first patches applied
which ARM64 folks can pull in when they apply Jeremy's patches before te
merge window.

Thanks,

	tglx
