Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41772 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752665AbZFUUmt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 21 Jun 2009 16:42:49 -0400
Date: Sun, 21 Jun 2009 13:42:35 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: handle_mm_fault() calling convention cleanup..
Message-ID: <alpine.LFD.2.01.0906211331480.3240@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Wu Fengguang <fengguang.wu@intel.com>, Ingo Molnar <mingo@elte.hu>
Message-ID: <20090621204235.dD7YBZMipYF-iOrHkP3iUGBXSuEO3TXcAWwTlmQc7og@z>


Just a heads up that I committed the patches that I sent out two months 
ago to make the fault handling routines use the finer-grained fault flags 
(FAULT_FLAG_xyzzy) rather than passing in a boolean for "write".

That was originally for the NOPAGE_RETRY patches, but it's a general 
cleanup too. I have this suspicion that we should extend this to 
"get_user_pages()" too, instead of having those boolean "write" and 
"force" flags (and GUP_FLAGS_xyzzy as opposed to FAULT_FLAGS_yyzzy).

We should probably also get rid of the insane FOLL_xyz flags too. Right 
now the code in fact depends on FOLL_WRITE being the same as 
FAULT_FLAGS_WRITE, and while that is a simple dependency, it's just crazy 
how we have all these different flags for what ends up often boiling down 
to the same fundamental issue in the end (even if not all versions of the 
flags are necessarily always valid for all uses).

I fixed up all architectures that I noticed (at least microblaze had been 
added since the original patches in April), but arch maintainers should 
double-check. Arch maintainers might also want to check whether the 
mindless conversion of

	'is_write' => 'is_write ? FAULT_FLAGS_WRITE : 0'

might perhaps be written in some more natural way (for example, maybe 
you'd like to get rid of 'iswrite' as a variable entirely, and replace it 
with a 'fault_flags' variable).

It's pushed out and tested on x86-64, but it really was such a mindless 
conversion that I hope it works on all architectures. But I thought I'd 
better give people a shout-out regardless.

		Linus
