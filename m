Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:49483 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbbCKS74 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Mar 2015 14:59:56 -0400
Received: by mail-vc0-f180.google.com with SMTP id hq12so3711177vcb.11
        for <linux-arch@vger.kernel.org>; Wed, 11 Mar 2015 11:59:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1425518828-16017-1-git-send-email-keescook@chromium.org>
References: <1425518828-16017-1-git-send-email-keescook@chromium.org>
Date: Wed, 11 Mar 2015 11:59:55 -0700
Message-ID: <CAGXu5j+PMBEPLTLiDVZ9XvnT9a2P+tOGPLXfE865crteeChDFQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] switch to using asm-generic for seccomp.h
From: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@arm.linux.org.uk>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker <fweisbec@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Daniel Borkmann <dborkman@redhat.com>, Laura Abbott <lauraa@codeaurora.org>, James Hogan <james.hogan@imgtec.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-parisc <linux-parisc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, sparclinux <sparclinux@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20150311185955.j6xYMph3d1ioGuS-3v17htwYyX3QAjYUkI2IGMK04gA@z>

On Wed, Mar 4, 2015 at 5:27 PM, Kees Cook <keescook@chromium.org> wrote:
> Most architectures don't need to do much special for the strict-mode
> seccomp syscall entries. Remove the redundant headers and reduce the
> others.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Hi Andrew,

Just a quick ping: are you able to pick up this series, or should I
try to get this in on a per-arch basis?

Thanks!

-Kees

> ---
> v3:
> - split patch series by architecture
> - fix up architectures that need sigreturn overrides (ingo)
> v2:
> - use Kbuild "generic-y" instead of explicit #include lines (sfr)
>



-- 
Kees Cook
Chrome OS Security
