From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] irq: handle irq0 special only on x86
Date: Tue, 12 Jan 2010 20:59:21 -0800
Message-ID: <4B4D5329.7050107@zytor.com>
References: <1260350401-9858-1-git-send-email-u.kleine-koenig@pengutronix.de> <20100112155929.GA5615@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:48744 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab0AMFLU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jan 2010 00:11:20 -0500
In-Reply-To: <20100112155929.GA5615@pengutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>

On 01/12/2010 07:59 AM, Uwe Kleine-K=C3=B6nig wrote:
> the feed-back I have got up to now wasn't helpfull.  (Only some "irq0=
 is
> evil---no it's not" discussion.) So what do you think?  I admit the
> #ifdef isn't nice, but if the semantic is OK I'm willing to rework it
> into something more pretty.

There was a debate on this a long time ago, and the outcome was that IR=
Q
0 is invalid, across the kernel, and that it is up to each architecture
to carry exceptions (like IRQ 0 for the timer interrupt in x86.)  Hinc
dictat Linus, so you would have to convince him before any of the arch
maintainer could realistically even consider this change.

	-hpa

--=20
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
