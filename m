From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] X86_64: Optimise fls(), ffs() and fls64()
Date: Wed, 14 Dec 2011 16:03:04 -0800
Message-ID: <CA+55aFzanrQU2DQHxkE7cWBOwT7Xb=+LfmSNWoatDL-oiV6opA@mail.gmail.com>
References: <20111213145654.14362.39868.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62231 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758321Ab1LOAD0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 Dec 2011 19:03:26 -0500
Received: by wgbdr13 with SMTP id dr13so2693568wgb.1
        for <linux-arch@vger.kernel.org>; Wed, 14 Dec 2011 16:03:25 -0800 (PST)
In-Reply-To: <20111213145654.14362.39868.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, linux-arch@vger.kernel.org

On Tue, Dec 13, 2011 at 6:56 AM, David Howells <dhowells@redhat.com> wrote:
>
> It might be possible to optimise the 32-bit versions of these functions, but
> there's a lot more variation, and so the effective non-destructive property of
> BSRL/BSRF cannot be relied on.

I'm pretty sure that we had some chips that actually do write random
stuff to the destination register when the input is zero.

We relied on the "doesn't change the destination" at some point *long*
ago, and it turned out not to work, but I can't remember what chip it
was.

I'm nervous about making this change even on x86-64 unless we add big
comments about the old 32-bit change. Can somebody find the historic
thing and a comment about which chip it was?

                     Linus
