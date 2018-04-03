Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33058 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbeDCKx5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Apr 2018 06:53:57 -0400
Date: Tue, 3 Apr 2018 12:53:52 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] remove in-kernel calls to syscalls
Message-ID: <20180403105352.eicib6jcicif5zoo@gmail.com>
References: <20180402190454.GB29890@light.dominikbrodowski.net>
 <CA+55aFyaVVKKbXPFzW1Tr7CTpiLCK+1nGdhS21wnm1j64bqWPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyaVVKKbXPFzW1Tr7CTpiLCK+1nGdhS21wnm1j64bqWPA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, hmclauchlan@fb.com, tautschn@amazon.co.uk, Amir Goldstein <amir73il@gmail.com>, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Darren Hart <dvhart@infradead.org>, "David S. Miller" <davem@davemloft.net>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Jaswinder Singh <jaswinder@infradead.org>, Jeff Dike <jdike@addtoit.com>, Jiri Slaby <jslaby@suse.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-s390 <linux-s390@vger.kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Network Development <netdev@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, the arch/x86 maintainers <x86@kernel.org>
Message-ID: <20180403105352.Q0SL3FesiDVsPMhlT6PQ-_D4oadvng_NVFsOtZknNF0@z>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Apr 2, 2018 at 12:04 PM, Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> >
> > This patchset removes all in-kernel calls to syscall functions in the
> > kernel with the exception of arch/.
> 
> Ok, this finished off my arch updates for today, I'll probably move on
> to driver pulls tomorrow.
> 
> Anyway, it's in my tree, will push out once my test build finishes.

Thanks!

Dominik, if you submit the x86 ptregs conversion patches in the next 1-2 days on 
top of Linus's tree (642e7fd23353), then I can apply them and if they are 
problem-free I can perhaps tempt Linus with a pull request early next week or so.

The Spectre angle does make me want those changes as well.

Thanks,

	Ingo
