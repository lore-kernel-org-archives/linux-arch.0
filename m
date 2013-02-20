From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [git pull] signal.git
Date: Wed, 20 Feb 2013 22:58:22 +0000
Message-ID: <20130220225822.GK4503@ZenIV.linux.org.uk>
References: <20130220225214.GJ4503@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:37052 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab3BTW6X (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 Feb 2013 17:58:23 -0500
Content-Disposition: inline
In-Reply-To: <20130220225214.GJ4503@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, Feb 20, 2013 at 10:52:14PM +0000, Al Viro wrote:
> That's the first pile; another one will come a bit later and will contain
> SYSCALL_DEFINE-related patches.  Please, pull from
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/signal for-linus

For the sake of completeness - one obvious conflict on merge is in
arch/x86/Kconfig; suggested resolution is
...
        select MODULES_USE_ELF_REL if X86_32
        select MODULES_USE_ELF_RELA if X86_64
        select CLONE_BACKWARDS if X86_32
        select ARCH_USE_BUILTIN_BSWAP
        select OLD_SIGSUSPEND3 if X86_32 || IA32_EMULATION
        select OLD_SIGACTION if X86_32
        select COMPAT_OLD_SIGACTION if IA32_EMULATION

config INSTRUCTION_DECODER
...
