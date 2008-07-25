From: Matthew Wilcox <matthew@wil.cx>
Subject: __weak vs ifdef
Date: Fri, 25 Jul 2008 06:24:54 -0600
Message-ID: <20080725122454.GE6701@parisc-linux.org>
References: <20080725083943.GC19310@cs181140183.pp.htv.fi> <20080725015537.564e3397.akpm@linux-foundation.org> <20080725091455.GD19310@cs181140183.pp.htv.fi> <20080725092748.GF19310@cs181140183.pp.htv.fi> <20080725023455.dde3eb27.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:38387 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712AbYGYMZL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 Jul 2008 08:25:11 -0400
Content-Disposition: inline
In-Reply-To: <20080725023455.dde3eb27.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Adrian Bunk <bunk@kernel.org>, Andrea Righi <righi.andrea@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jul 25, 2008 at 02:34:55AM -0700, Andrew Morton wrote:
> We should make arch_pick_mmap_layout __weak and nuke that ifdef.

I strongly disagree.  I find it makes it harder to follow code flow
when __weak functions are involved.  Ifdefs are ugly, no question, but
they're easier to grep for, see when they'll be defined and know which of
the arch_pick_mmap_layout() functions will be called.  __weak certainly
has its uses (eg the sys_ni_syscall is great) but I find it's becoming
overused.

My basic point here is that __weak makes the code easier to write but
harder to read, and we're supposed to be optimising for easier to read.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
