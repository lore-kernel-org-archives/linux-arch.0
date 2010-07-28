From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH] asm-generic: Use raw_local_irq_save/restore instead
	local_irq_save/restore
Date: Wed, 28 Jul 2010 01:35:20 -0400
Message-ID: <AANLkTimL92k-VnjXRqWsFTnqLcfYU=Ep3ScYLHQXVA9o@mail.gmail.com>
References: <1274863724-14906-1-git-send-email-monstr@monstr.eu>
	<1274863724-14906-2-git-send-email-monstr@monstr.eu> <1274884963.22648.245.camel@gandalf.stny.rr.com>
	<20100526100805.171b3c48.akpm@linux-foundation.org> <4C4D4C2E.8010103@monstr.eu>
	<20100727161819.cf6feab1.akpm@linux-foundation.org> <4C4FBE2B.6030606@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52503 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab0G1Ffm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2010 01:35:42 -0400
In-Reply-To: <4C4FBE2B.6030606@monstr.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@monstr.eu
Cc: Andrew Morton <akpm@linux-foundation.org>, rostedt@goodmis.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu, linux-arch@vger.kernel.org

On Wed, Jul 28, 2010 at 01:20, Michal Simek wrote:
> Andrew Morton wrote:
>> On Mon, 26 Jul 2010 10:49:50 +0200 Michal Simek wrote:
>>> Signed-off-by: Michal Simek <monstr@monstr.eu>
>>> Acked-by: Steven Rostedt <rostedt@goodmis.org>
>>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>
>> hm, I wonder how my signoff got there. =C2=A0Doesn't matter.
>
> http://lkml.org/lkml/2010/5/26/364

Sighed !=3D Signed ;)
-mike
