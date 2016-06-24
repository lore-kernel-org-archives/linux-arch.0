From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v4 12/16] x86/dumpstack: When dumping stack bytes due to
 OOPS, start with regs->sp
Date: Fri, 24 Jun 2016 10:31:33 -0500
Message-ID: <20160624153133.qekzryuhcu4rug57@treble>
References: <cover.1466741835.git.luto@kernel.org>
 <077c8fb1f0a6b7514ef473ed1403b507ff919932.1466741835.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54998 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbcFXPbf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 Jun 2016 11:31:35 -0400
Content-Disposition: inline
In-Reply-To: <077c8fb1f0a6b7514ef473ed1403b507ff919932.1466741835.git.luto@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>

On Thu, Jun 23, 2016 at 09:23:07PM -0700, Andy Lutomirski wrote:
> The comment suggests that show_stack(NULL, NULL) should backtrace
> the current context, but the code doesn't match the comment.  If
> regs are given, start the "Stack:" hexdump at regs->sp.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
