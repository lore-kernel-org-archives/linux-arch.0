Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37475 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbbB1T65 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 28 Feb 2015 14:58:57 -0500
MIME-Version: 1.0
In-Reply-To: <CA+55aFy5UvzSgOMKq09u4psz5twtC4aowuK6tofGKDEu-KFMJQ@mail.gmail.com>
References: <1422361485.6648.71.camel@opensuse.org>
	<54C78756.9090605@suse.cz>
	<alpine.LSU.2.11.1501271347440.30227@nerf60.vanv.qr>
	<1422364084.6648.82.camel@opensuse.org>
	<s5h7fw8hvdp.wl-tiwai@suse.de>
	<CA+55aFyzy_wYHHnr2gDcYr7qcgOKM2557bRdg6RBa=cxrynd+Q@mail.gmail.com>
	<CA+55aFxRnj97rpSQvvzLJhpo7C8TQ-F=eB1Ry2n53AV1rN8mwA@mail.gmail.com>
	<CAMo8BfLsKCV_2NfgMH4k9jGOHs_-3=NKjCD3o3KK1uH23-6RRg@mail.gmail.com>
	<CA+55aFzQ5QEZ1AYauWviq1gp5j=mqByAtt4fpteeK7amuxcyjw@mail.gmail.com>
	<1422836637.17302.9.camel@au1.ibm.com>
	<CA+55aFw9sg7pu9-2RbMGyPv5yUtcH54QowoH+5RhWqpPYg4YGQ@mail.gmail.com>
	<1425107567.4645.108.camel@kernel.crashing.org>
	<CA+55aFy5UvzSgOMKq09u4psz5twtC4aowuK6tofGKDEu-KFMJQ@mail.gmail.com>
Date: Sat, 28 Feb 2015 11:58:56 -0800
Message-ID: <CA+55aFysKeSnhmm=a-Rh+SjZTQw6gQctgjSdc89G1H=D74_Hwg@mail.gmail.com>
Subject: Re: Generic page fault (Was: libsigsegv ....)
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Message-ID: <20150228195856.jWNmsVSNaDnr4147kg6iuIM2r0cHXBxholw8O528TAo@z>

On Sat, Feb 28, 2015 at 11:56 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But I don't know. Maybe I'm wrong. I don't hate the patch as-is, I
> just have this feeling that it coudl be more "generic", and less
> "random small arch helpers".

Oh, and I definitely agree with you on the "single handle_bad_fault()"
thing rather than the current
handle_bad_area/handle_kernel_fault/do_sigbus.

                 Linus
