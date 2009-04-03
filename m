Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57527 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936756AbZDCUQZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Apr 2009 16:16:25 -0400
Date: Fri, 3 Apr 2009 13:08:59 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 143/166] preadv/pwritev: Add preadv and pwritev system
 calls.
In-Reply-To: <49D66A22.7090909@redhat.com>
Message-ID: <alpine.LFD.2.00.0904031303200.4015@localhost.localdomain>
References: <200904022359.n32NxNYu022834@imap1.linux-foundation.org> <alpine.LFD.2.00.0904021839390.15441@localhost.localdomain> <49D5CA58.20908@redhat.com> <alpine.LFD.2.00.0904030739540.4130@localhost.localdomain> <49D66A22.7090909@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, arnd@arndb.de, "H. Peter Anvin" <hpa@zytor.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, ralf@linux-mips.org, tglx@linutronix.de, Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <20090403200859.5CtVHCp3VDcVe13lkSriQwqyos9lKiumbhHDUqa_VOs@z>



On Fri, 3 Apr 2009, Gerd Hoffmann wrote:
> 
> The whole point of the HALF_BITS thing is just to kill the gcc "hey your
> shift is greater than bitsize of $type" warning, right?

No, it's literally a corectness issue.

If you do

	offset = ((loff_t) high) << BITS_IN_LONG;

then that is literally undefined behavior in C (if "loff_t" and "long" are 
the same size), and a lot of C compilers will end up just optimizing it 
away entirely.

Even if they don't optimize it away, and if they actually generate the 
instruction for it, architectures will not actually do what you think they 
do. At least on x86, shift counts are fundamentally limited to the low 
bits, so if you do 

	movl $64,%ecx
	shlq %ecx,reg

then an x86 will literally shift 'reg' by _zero_, because the count is 
masked by 6 bits (or 5, in the 32-bit case).

So literally, if gcc were to generate the obvious (stupid) code, it would 
give the wrong value.

With the double shift, we have well-defined behavior.

> I really like it.  Except for the low/high ordering it is basically
> identical to the patch I've mailed.
> 
> While hashing out all the issues I've learned alot about arch specific
> ABIs.  I can't see possible trouble spots and don't expect vetos from
> arch maintainers.

Ok, a few more ack's, and I can commit it. Anybody disagree?

			Linus
