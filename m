From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [opensuse-factory] Re: [opensuse-kernel] libsigsegv build fail
 with kernel 3.18.3
Date: Thu, 29 Jan 2015 09:59:30 +0300
Message-ID: <CAMo8BfLsKCV_2NfgMH4k9jGOHs_-3=NKjCD3o3KK1uH23-6RRg@mail.gmail.com>
References: <1422361485.6648.71.camel@opensuse.org>
	<54C78756.9090605@suse.cz>
	<alpine.LSU.2.11.1501271347440.30227@nerf60.vanv.qr>
	<1422364084.6648.82.camel@opensuse.org>
	<s5h7fw8hvdp.wl-tiwai@suse.de>
	<CA+55aFyzy_wYHHnr2gDcYr7qcgOKM2557bRdg6RBa=cxrynd+Q@mail.gmail.com>
	<CA+55aFxRnj97rpSQvvzLJhpo7C8TQ-F=eB1Ry2n53AV1rN8mwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37765 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbbA2G7c (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jan 2015 01:59:32 -0500
Received: by mail-wi0-f175.google.com with SMTP id fb4so21455135wid.2
        for <linux-arch@vger.kernel.org>; Wed, 28 Jan 2015 22:59:31 -0800 (PST)
In-Reply-To: <CA+55aFxRnj97rpSQvvzLJhpo7C8TQ-F=eB1Ry2n53AV1rN8mwA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, opensuse-factory@opensuse.org, OpenSUSE Kernel Team <opensuse-kernel@opensuse.org>

On Tue, Jan 27, 2015 at 11:57 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> So this would be the more complete patch. Still totally untested. I
> may have screwed up something obvious.

Condition in arch/powerpc/mm/copro_fault.c hunk doesn't look right.

-- 
Thanks.
-- Max
