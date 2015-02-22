Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:57570 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbbBVXvy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 22 Feb 2015 18:51:54 -0500
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <benh@au1.ibm.com>;
	Mon, 23 Feb 2015 09:51:52 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id A9BE52BB0040
	for <linux-arch@vger.kernel.org>; Mon, 23 Feb 2015 10:51:49 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t1MNpf3345154522
	for <linux-arch@vger.kernel.org>; Mon, 23 Feb 2015 10:51:49 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t1MNpFl3011282
	for <linux-arch@vger.kernel.org>; Mon, 23 Feb 2015 10:51:16 +1100
Message-ID: <1424649052.4980.17.camel@au1.ibm.com>
Subject: Re: [opensuse-factory] Re: [opensuse-kernel] libsigsegv build fail
 with kernel 3.18.3
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Date: Mon, 23 Feb 2015 10:50:52 +1100
In-Reply-To: <CA+55aFw9sg7pu9-2RbMGyPv5yUtcH54QowoH+5RhWqpPYg4YGQ@mail.gmail.com>
References: <1422361485.6648.71.camel@opensuse.org>
	 <54C78756.9090605@suse.cz>
	 <alpine.LSU.2.11.1501271347440.30227@nerf60.vanv.qr>
	 <1422364084.6648.82.camel@opensuse.org> <s5h7fw8hvdp.wl-tiwai@suse.de>
	 <CA+55aFyzy_wYHHnr2gDcYr7qcgOKM2557bRdg6RBa=cxrynd+Q@mail.gmail.com>
	 <CA+55aFxRnj97rpSQvvzLJhpo7C8TQ-F=eB1Ry2n53AV1rN8mwA@mail.gmail.com>
	 <CAMo8BfLsKCV_2NfgMH4k9jGOHs_-3=NKjCD3o3KK1uH23-6RRg@mail.gmail.com>
	 <CA+55aFzQ5QEZ1AYauWviq1gp5j=mqByAtt4fpteeK7amuxcyjw@mail.gmail.com>
	 <1422836637.17302.9.camel@au1.ibm.com>
	 <CA+55aFw9sg7pu9-2RbMGyPv5yUtcH54QowoH+5RhWqpPYg4YGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Takashi Iwai <tiwai@suse.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, opensuse-factory@opensuse.org, OpenSUSE Kernel Team <opensuse-kernel@opensuse.org>
Message-ID: <20150222235052.G3sxfK3unPjxZCEyEONbc11dqE3hm_YMOW6zs0qlN3w@z>

On Sun, 2015-02-01 at 17:09 -0800, Linus Torvalds wrote:
> On Sun, Feb 1, 2015 at 4:23 PM, Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:
> >
> > I prefer having the test inside mm_fault_error(), even if that makes the
> > patch a bit bigger, it keeps the logic in a single place. Untested
> > patch:
> 
> I'm certainly ok with that, but I wanted to make the code that I
> wasn't going to compile (much less test) for various architectures be
> as simple and straightforward as possible.

Ah, I missed your reply ... my fault for using the wrong email address
to send my message in the first place :-)

> So feel free to send a patch that fixes it up to do it in a single
> place after testing it.

Ok sure, I'll have a look in the next few days, bogged down with some
local emergency right now.

> Of course, what I *really* want would be to make a new
> "generic_mm_fault()" helper that would do all the normal stuff:
> 
>  - find_vma()
>  - check permissions and ranges
>  - call 'handle_mm_fault()'
>  - do the proper error, retry and minor/major fault handling
> 
> and then most architectures could just call that.

That would be great ...

> Anybody willing to see if they could encapsulate that part of the x86
> code, and make it more widely useful? I say "x86 code", because that's
> the most tested one, and I think it gets the odd retry and error cases
> right (and minor/major fault counting etc), unlike some.

I can try to give it a spin some time this week I think, I can probably
do x86, powerpc and arm. Let's see if I manage to not forget :)

Cheers,
Ben.


>                            Linus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


