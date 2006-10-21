Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:10158 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030366AbWJUAjM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Oct 2006 20:39:12 -0400
Date: Fri, 20 Oct 2006 17:38:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
In-Reply-To: <20061021000609.GA32701@linux-mips.org>
Message-ID: <Pine.LNX.4.64.0610201733490.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610201302090.3962@g5.osdl.org>
 <20061020214916.GA27810@linux-mips.org> <Pine.LNX.4.64.0610201500040.3962@g5.osdl.org>
 <20061020.152247.111203913.davem@davemloft.net> <20061020225118.GA30965@linux-mips.org>
 <Pine.LNX.4.64.0610201625190.3962@g5.osdl.org> <20061021000609.GA32701@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com, James.Bottomley@steeleye.com
List-ID: <linux-arch.vger.kernel.org>



On Sat, 21 Oct 2006, Ralf Baechle wrote:
>
> > That said, maybe nobody does that. Virtual caches are a total braindamage 
> > in the first place, so hopefully they have limited use.
> 
> On MIPS we never had pure virtual caches.

Ok, so on MIPS my schenario doesn't matter.

I think (but may be mistaken) that ARM _does_ have pure virtual caches 
with a process ID, but people have always ended up flushing them at 
context switch simply because it just causes too much trouble.

Sparc? VIPT too? Davem?

I have absolutely zero clue about s390.

Anyway, it sounds to me like this is too big to decide for 2.6.19 anyway, 
and as far as I can tell this i snot a regression, right? Ie we've always 
had the aliasing issue. Ralf?

But it would be good to have something for the early -rc1 sequence for 
2.6.20, and maybe the MIPS COW D$ patches are it, if it has performance 
advantages on MIPS that can also be translated to other virtual cache 
users..

> Be sure I'm sending a CPU designers a strong message about aliases.

Castration. That's the best solution. We don't want those people 
procreating.

			Linus
