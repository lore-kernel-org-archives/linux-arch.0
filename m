From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: handle_mm_fault() calling convention cleanup..
Date: Mon, 22 Jun 2009 09:58:01 -0500
Message-ID: <1245682681.6901.2.camel@mulgrave.site>
References: <alpine.LFD.2.01.0906211331480.3240@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <alpine.LFD.2.01.0906211331480.3240@localhost.localdomain>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Hugh Dickins <hugh@veritas.com>, Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Wu Fengguang <fengguang.wu@intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-arch.vger.kernel.org

On Sun, 2009-06-21 at 13:42 -0700, Linus Torvalds wrote:
> I hope it works on all architectures. But I thought I'd 
> better give people a shout-out regardless.

Works on parisc.

James


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
