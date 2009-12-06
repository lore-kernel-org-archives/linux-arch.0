From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCHSET] mremap/mmap mess
Date: Sun, 6 Dec 2009 10:00:24 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912061000090.3560@localhost.localdomain>
References: <E1NGzzu-0008RH-T2@ZenIV.linux.org.uk> <Pine.LNX.4.64.0912061715280.3721@sister.anvils>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47005 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757113AbZLFSA0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 6 Dec 2009 13:00:26 -0500
In-Reply-To: <Pine.LNX.4.64.0912061715280.3721@sister.anvils>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org


On Sun, 6 Dec 2009, Hugh Dickins wrote:
> 
> I've never found out why we need access_process_vm() to expand a stack:
> shall we see what breaks if we just forbid expand_stack() on another mm?

Hmm. If you want to actually emulate some stack instruction using ptrace, 
you'd need to be able to extend the stack.

The classic example of this might be to do some crazy user-space emulation 
of 'pushf' for virtualization.

And emulating pushf is not theory: at least KVM does actually do exactly 
that (although KVM obviously does it from kernel space and from within the 
process that faulted). Same goes for vm86 mode (again, we do that 
emulation in kernel) and for ptrace single-stepping (which we actually 
don't bother emulating).

The point being that at least 'pushf' really _is_ an instruction that (a) 
might want to extend the stack and (b) does tend to need emulation or 
fixup in some virtualized/emulated environments. I just don't know if you 
actually ever have user space doing so.

But I could imagine that Wine does some pushf emulation using ptrace, for 
example.

			Linus
