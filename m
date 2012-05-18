From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 08/10] Use __kernel_ulong_t in struct msqid64_ds
Date: Thu, 17 May 2012 20:49:28 -0700
Message-ID: <CA+55aFxtejaM8ecOw8VYk74OaXfGY7=LO3JSyz3rdHEv2r9goQ@mail.gmail.com>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com>
 <1337292816-10839-9-git-send-email-hjl.tools@gmail.com> <4FB58EFD.7010302@zytor.com>
 <4FB5C050.9070805@kernel.org> <CAMe9rOrKq8Ait8wKudRF535J5c=dDTKekmUN_=HOs5BBLtsoGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:51979 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760223Ab2ERDtt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 May 2012 23:49:49 -0400
In-Reply-To: <CAMe9rOrKq8Ait8wKudRF535J5c=dDTKekmUN_=HOs5BBLtsoGQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: "H. Peter Anvin" <hpa@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>

On Thu, May 17, 2012 at 8:39 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
>
> That will be wrong. =A0 __BITS_PER_LONG defines # bits of long
> as seen by kernel. =A0We don't use it in user space.

Yes you do. Exactly in that structure that Peter points to. *Exactly*
because that structure uses "long" instead of some fixed size. Which
will be different in user mode than in kernel mode.

And if user mode doesn't use these headers at all, then we should stop
playing the insane games.

                     Linus
