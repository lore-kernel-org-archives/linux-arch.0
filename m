Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34455 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbbCAAll (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 28 Feb 2015 19:41:41 -0500
MIME-Version: 1.0
In-Reply-To: <1425164559.4645.157.camel@kernel.crashing.org>
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
	<1425158083.4645.139.camel@kernel.crashing.org>
	<1425161796.4645.149.camel@kernel.crashing.org>
	<1425164559.4645.157.camel@kernel.crashing.org>
Date: Sat, 28 Feb 2015 16:41:41 -0800
Message-ID: <CA+55aFw+K6aev6JPTiYxWjtJS0O8+MUwC-5=O4Gb+0mCd+tOfQ@mail.gmail.com>
Subject: Re: Generic page fault (Was: libsigsegv ....)
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Message-ID: <20150301004141.C7Vz-1ttjlwmD1ViZGQmVJGeZy8RcxUisl9Ui9HI2xk@z>

On Sat, Feb 28, 2015 at 3:02 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Anyway, here's the current patch:

Ok, I think I like this approach better.

Your FAULT_FLAG_EXEC handling is wrong, though. It shouldn't check
VM_WRITE, it should check VM_EXEC. A bit too much copy-paste ;)

Btw, it's quite possible that we could just do all the PF_PROT
handling at the x86 level, before even calling the generic fault
handler. It's not like we even need the vma or the mm semaphore: if
it's a non-write protection fault, we always SIGSEGV. So why even
bother getting the locks and looking up the page tables etc?

Now, that PF_PROT handling isn't exactly performance-critical, but it
might help to remove the odd x86 special case from the generic code.

                      Linus
