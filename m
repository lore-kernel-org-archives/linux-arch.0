From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 1/4] init: create cmdline param to disable readonly
Date: Tue, 1 Dec 2015 08:19:05 +0100
Message-ID: <20151201071905.GA3956@osiris>
References: <1448494286-16029-1-git-send-email-keescook@chromium.org>
 <1448494286-16029-2-git-send-email-keescook@chromium.org>
 <20151126075130.GB18742@gmail.com>
 <CAGXu5j+Mom2oYbsSE65BMCAgio68J6ST4wODUf8-qHdxOe0jOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110]:41441 "EHLO
	e06smtp14.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537AbbLAHTN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 Dec 2015 02:19:13 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Tue, 1 Dec 2015 07:19:11 -0000
Content-Disposition: inline
In-Reply-To: <CAGXu5j+Mom2oYbsSE65BMCAgio68J6ST4wODUf8-qHdxOe0jOQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Catalin Marinas <catalin.marinas@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, "H. Peter Anvin" <hpa@zytor.com>, Mathias Krause <minipli@googlemail.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, PaX Team <pageexec@freemail.hu>, Emese Revfy <re.emese@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>

On Mon, Nov 30, 2015 at 01:52:10PM -0800, Kees Cook wrote:
> On Wed, Nov 25, 2015 at 11:51 PM, Ingo Molnar <mingo@kernel.org> wrote:
> > * Kees Cook <keescook@chromium.org> wrote:
> >> +#ifdef CONFIG_DEBUG_RODATA
> >
> > Btw., could you please remove the Kconfig option altogether in an additional patch
> > and make read-only sections an always-on feature? It has been default-y for years
> > and all distros have it enabled.
> 
> Yeah, this is something I've wanted to do for a while, but I would
> point out that only a few architectures have actually implemented it,
> and for arm and arm64 it was very recent:
> 
> $ git grep 'config DEBUG_RODATA'
> arch/arm/mm/Kconfig:config DEBUG_RODATA
> arch/arm64/Kconfig.debug:config DEBUG_RODATA
> arch/parisc/Kconfig.debug:config DEBUG_RODATA
> arch/x86/Kconfig.debug:config DEBUG_RODATA
> 
> I think s390 already has strict kernel memory permissions, but they
> set it up ahead of time. And now, I see in reading the parisc tree,
> they do too, and mark_rodata_ro() is effectively a no-op. How does
> powerpc handle permissions for kernel rodata?
> 
> For parisc (and maybe powerpc and s390) we'll need additional changes
> to support __ro_after_init, since they may be making the ro section ro
> _before_ init runs. But, that's okay since this series only uses
> __ro_after_init on x86 for the moment. ;)

s390 marks the ro sections read-only on paging_init() for the kernel
1:1 mapping before we enable address translation.  Afterwards we
currently do not support modification of the kernel 1:1 mapping.
This also might be larger change, since we may need to split large
2GB mappings into 1MB or 4KB mappings.

Given that s390 has priviledged instructions that can easily bypass
page table based write protection (we use that for ftrace for
example), I certainly have doubts about the security value here.  For
me this is more a debugging help which catches random writes to kernel
text and which makes life for "security" module writers a bit more
difficult who try to modify the system call table.

Anyway, if you remove CONFIG_DEBUG_RODATA you could simply make the
existing mark_rodata_ro() function in kernel/init.c a weak function
and architectures could override it if wanted.
