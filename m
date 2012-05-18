From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 08/10] Use __kernel_ulong_t in struct msqid64_ds
Date: Fri, 18 May 2012 12:53:04 +0100
Message-ID: <29366.1337341984@redhat.com>
References: <4FB5C843.9070002@kernel.org> <1337292816-10839-1-git-send-email-hjl.tools@gmail.com> <1337292816-10839-9-git-send-email-hjl.tools@gmail.com> <4FB58EFD.7010302@zytor.com> <4FB5C050.9070805@kernel.org> <CAMe9rOrKq8Ait8wKudRF535J5c=dDTKekmUN_=HOs5BBLtsoGQ@mail.gmail.com> <CA+55aFxtejaM8ecOw8VYk74OaXfGY7=LO3JSyz3rdHEv2r9goQ@mail.gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43882 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933335Ab2ERLxU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 May 2012 07:53:20 -0400
In-Reply-To: <4FB5C843.9070002@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@kernel.org>
Cc: dhowells@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>, "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>

H. Peter Anvin <hpa@kernel.org> wrote:

> User mode can, and should, be able to use the exported headers.  David
> Howells have been doing even more work to distill out the actual
> exported ABIs from the kernel and remove remaining chaff.

See:

	http://git.infradead.org/users/dhowells/linux-headers.git/shortlog/refs/heads/uapi-split

Linus: Any chance of this being pulled at the end of the next merge window?  I
know you said you didn't want to do another big header file cleanup for a
while after pulling the system.h disintegration, but I'm wondering if your
distaste has expired yet.

David
