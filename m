Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266751AbUHIRIs@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:22711 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266749AbUHIRIs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Aug 2004 13:08:48 -0400
Date: Mon, 9 Aug 2004 10:08:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: copy_page_range()
In-Reply-To: <20040809090458.GO11200@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0408091006280.1832@ppc970.osdl.org>
References: <20040807000529.5ca6e8fe.davem@redhat.com>
 <16663.15729.828367.307053@napali.hpl.hp.com> <20040809090458.GO11200@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: William Lee Irwin III <wli@holomorphy.com>
Cc: davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>



On Mon, 9 Aug 2004, William Lee Irwin III wrote:
> 
> These results are actually consistent with large-memory ia32.
> Instruction-level profiles showed that the largest overhead in
> copy_page_range() on such ia32 boxen appeared to be mm->rss++.

That sounds unlikely. Most ia32 instruction profiles will give high 
profile counts to instructions _following_ the one that was expensive, and 
in this case I'd strongyl suspect that the real expense on x86 is the 
"get_page(page)" thing. 

Which is an atomic increment, and thus very expensive.

		Linus
