Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:36774 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbcF0HT0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 27 Jun 2016 03:19:26 -0400
In-Reply-To: <f49fbe4a40e1630981614b910fbfbcaa387e6c8f.1466974736.git.luto@kernel.org>
References: <cover.1466974736.git.luto@kernel.org><cover.1466974736.git.luto@kernel.org> <f49fbe4a40e1630981614b910fbfbcaa387e6c8f.1466974736.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 05/29] x86/mm: Remove kernel_unmap_pages_in_pgd() and efi_cleanup_page_tables()
From: Borislav Petkov <bp@alien8.de>
Date: Mon, 27 Jun 2016 09:19:10 +0200
Message-ID: <f7f8c528-b72d-4b3d-a595-2c7c4743d0f0@email.android.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-efi@vger.kernel.org
Message-ID: <20160627071910.mEEy_KtGep4FmFNf-I-iFXDazvah-Xruhy_PcciFcY8@z>

Andy Lutomirski <luto@kernel.org> wrote:

>kernel_unmap_pages_in_pgd() is dangerous: if a pgd entry in
>init_mm.pgd were to be cleared, callers would need to ensure that
>the pgd entry hadn't been propagated to any other pgd.
>
>Its only caller was efi_cleanup_page_tables(), and that, in turn,
>was unused, so just delete both functions.  This leaves a couple of
>other helpers unused, so delete them, too.
>
>Cc: Matt Fleming <matt@codeblueprint.co.uk>
>Cc: linux-efi@vger.kernel.org
>Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
>Signed-off-by: Andy Lutomirski <luto@kernel.org>
>---
> arch/x86/include/asm/efi.h           |  1 -
> arch/x86/include/asm/pgtable_types.h |  2 --
> arch/x86/mm/pageattr.c               | 28 ----------------------------
> arch/x86/platform/efi/efi.c          |  2 --
> arch/x86/platform/efi/efi_32.c       |  3 ---
> arch/x86/platform/efi/efi_64.c       |  5 -----
> 6 files changed, 41 deletions(-)

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Sent from a small device: formatting sucks and brevity is inevitable. 
