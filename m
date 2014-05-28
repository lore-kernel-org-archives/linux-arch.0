From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: uaccess: avoid name conflicts for strncpy and str(n)len
Date: Wed, 28 May 2014 21:44:12 +0200
Message-ID: <9795542.Hus6bU8DVG@wuerfel>
References: <1401290511-10211-1-git-send-email-joel@porquet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:50830 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbaE1ToQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 May 2014 15:44:16 -0400
In-Reply-To: <1401290511-10211-1-git-send-email-joel@porquet.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joel Porquet <joel@porquet.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 28 May 2014 17:21:51 Joel Porquet wrote:
> asm-generic/uaccess.h defines 'strncpy_from_user', 'strnlen_user' and
> 'strlen_user' as static inline functions. It makes it impossible for an
> arch to include asm-generic/uaccess.h and benefits from its content, in
> addition to defining GENERIC_STRNCPY_FROM_USER and GENERIC_STRNLEN_USER.
> 
> Both configuration tokens respectively enable lib/strncpy_from_user.c
> and lib/strnlen_user.c which redefine the same symbols, causing
> redefinition errors at compilation.
> 
> This patch modifies asm-generic/uaccess.h so that strncpy_from_user is
> not defined when GENERIC_STRNCPY_FROM_USER is, and strnlen_user and
> strlen_user are not defined when GENERIC_STRNLEN_USER is, thus avoiding
> any name conflict.
> 
> At the moment, numerous archs, which make use of
> GENERIC_STRNCPY_FROM_USER and GENERIC_STRNLEN_USER, are forced to
> rewrite an entire asm/uaccess.h header because of this issue.
> 
> To the best of my knowledge, the following list of archs could benefit
> from this patch: x86, sh, openrisc, powerpc, arm64, arm, alpha, parisc,
> sparc, m68k.
> 
> Signed-off-by: Joel Porquet <joel@porquet.org>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

It makes sense to do this for any architecture that want's to use
this file, so feel free to add your patch the tree of whatever architecture
you want to convert.

Note however that asm/uaccess.h can't be implemented correctly in
generic code: you always need inline assembly to add the correct fixup
section magic.

	Arnd
