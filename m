From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH] mm: Pass virtual address to
 [__]p{te,ud,md}_free_tlb()
Date: Mon, 27 Jul 2009 12:11:13 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907271210210.25224@localhost.localdomain>
References: <20090715074952.A36C7DDDB2@ozlabs.org>  <20090715135620.GD7298@wotan.suse.de> <1248073873.13067.31.camel@pasglop>  <alpine.LFD.2.01.0907220930320.19335@localhost.localdomain> <1248310415.3367.22.camel@pasglop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1248310415.3367.22.camel@pasglop>
Sender: owner-linux-mm@kvack.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nick Piggin <npiggin@suse.de>, Linux Memory Management <linux-mm@kvack.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Hugh Dickins <hugh@tiscali.co.uk>
List-Id: linux-arch.vger.kernel.org



On Thu, 23 Jul 2009, Benjamin Herrenschmidt wrote:
> 
> Hrm... my powerpc-next branch will contain stuff that depend on it, so
> I'll probably have to pull it in though, unless I tell all my
> sub-maintainers to also pull from that other branch first :-)

Ok, I'll just apply the patch. It does look obvious enough.

			Linus

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
