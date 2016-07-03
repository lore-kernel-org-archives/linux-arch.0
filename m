From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 10/29] x86/die: Don't try to recover from an OOPS on a
 non-default stack
Date: Sun, 3 Jul 2016 20:42:13 +0200
Message-ID: <20160703184213.GB1781@pd.tnic>
References: <cover.1466974736.git.luto@kernel.org>
 <37ac7589ff0ea147e8a21cda5eb84d3af1f6cd60.1466974736.git.luto@kernel.org>
 <20160702172441.GA22748@pd.tnic>
 <20160702183451.e2nlfkfxlsuicbqd@treble>
 <CALCETrVowqk90fmsg9eJG7Fvk0EMVFS0azCbJ89dioRtuXZOKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:41710 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845AbcGCSmX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 3 Jul 2016 14:42:23 -0400
Content-Disposition: inline
In-Reply-To: <CALCETrVowqk90fmsg9eJG7Fvk0EMVFS0azCbJ89dioRtuXZOKQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>

On Sun, Jul 03, 2016 at 07:25:05AM -0700, Andy Lutomirski wrote:
> Given that the very next patch deletes this code, I vote for leaving
> it alone.  Or I could fold the patches together.

Ah, true. Yes, please fold them together.

-- 
Regards/Gruss,
Boris.

ECO tip #101: Trim your mails when you reply.
