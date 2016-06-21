Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34061 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbcFUKXq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2016 06:23:46 -0400
Received: by mail-lf0-f48.google.com with SMTP id h129so16483092lfh.1
        for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2016 03:23:18 -0700 (PDT)
Date: Tue, 21 Jun 2016 10:53:42 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH v3 03/13] x86/mm: Remove kernel_unmap_pages_in_pgd() and
 efi_cleanup_page_tables()
Message-ID: <20160621095342.GR2658@codeblueprint.co.uk>
References: <cover.1466466093.git.luto@kernel.org>
 <0b78b5c100c1c046c498f1085f40e9422e9d23f5.1466466093.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b78b5c100c1c046c498f1085f40e9422e9d23f5.1466466093.git.luto@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-efi@vger.kernel.org
Message-ID: <20160621095342.epQnds7sL26L3fuh_wHW3ZC8xR7rhyGkxUGoIFJooiU@z>

On Mon, 20 Jun, at 04:43:33PM, Andy Lutomirski wrote:
> kernel_unmap_pages_in_pgd() is dangerous: if a pgd entry in
> init_mm.pgd were to be cleared, callers would need to ensure that
> the pgd entry hadn't been propagated to any other pgd.
> 
> Its only caller was efi_cleanup_page_tables(), and that, in turn,
> was unused, so just delete both functions.  This leaves a couple of
> other helpers unused, so delete them, too.
> 
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Cc: linux-efi@vger.kernel.org
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/include/asm/efi.h           |  1 -
>  arch/x86/include/asm/pgtable_types.h |  2 --
>  arch/x86/mm/pageattr.c               | 28 ----------------------------
>  arch/x86/platform/efi/efi.c          |  2 --
>  arch/x86/platform/efi/efi_32.c       |  3 ---
>  arch/x86/platform/efi/efi_64.c       |  5 -----
>  6 files changed, 41 deletions(-)

Looks fine.

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
