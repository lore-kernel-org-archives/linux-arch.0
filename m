Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:48010 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbfECMiD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 May 2019 08:38:03 -0400
Date: Fri, 3 May 2019 06:37:56 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: Add ARM64 to kernel-parameters.rst
Message-ID: <20190503063756.09c74f6e@lwn.net>
In-Reply-To: <20190413035621.tohihjksatqushwf@treble>
References: <cover.1555085500.git.jpoimboe@redhat.com>
        <24039e1370ed57e8075730c0b88c505afd9e0ab7.1555085500.git.jpoimboe@redhat.com>
        <25174c3c-0e39-0562-7d02-bb7d51cd2b43@infradead.org>
        <20190413035621.tohihjksatqushwf@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tyler Hicks <tyhicks@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Price <steven.price@arm.com>, Phil Auld <pauld@redhat.com>
Message-ID: <20190503123756.7KS7-7cUv2GLRD6gtE0YTGt_QCI2dj1FhTwb11HIdic@z>

On Fri, 12 Apr 2019 22:56:21 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> Add ARM64 to the legend of architectures.  It's already used in several
> places in kernel-parameters.txt.
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

It looks like nobody has picked this up...so I've applied it.

Thanks,

jon
