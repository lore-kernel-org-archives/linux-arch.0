From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [revert request for commit 9fff2fa] Re: [git pull] signals
 pile 3
Date: Mon, 15 Oct 2012 17:07:10 +0100
Message-ID: <20121015160710.GC30907@arm.com>
References: <20121013005334.GM2616@ZenIV.linux.org.uk>
 <507ADBBB.9090209@gmail.com>
 <20121014164020.GV2616@ZenIV.linux.org.uk>
 <CACTFLAOpcLtHNx-TCHQkUOPNAkTO8EgDhbyZSGQ9ag+Wu_cNRw@mail.gmail.com>
 <20121014172640.GW2616@ZenIV.linux.org.uk>
 <20121014192402.GZ2616@ZenIV.linux.org.uk>
 <20121014195611.GA2616@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:36488 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639Ab2JOQHU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Oct 2012 12:07:20 -0400
In-Reply-To: <20121014195611.GA2616@ZenIV.linux.org.uk>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Daniel Mack <zonque@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sun, Oct 14, 2012 at 08:56:11PM +0100, Al Viro wrote:
> On Sun, Oct 14, 2012 at 08:24:03PM +0100, Al Viro wrote:
> 
> > Russell, could you recall what those had been about?  I'm not sure if that
> > had been oopsable that far back (again, oops scenario is userland stack
> > page getting swapped out before we get to start_thread(), leading to
> > direct read from an absent page in start_thread() by plain ldr, without
> > anything in exception table about that insn), but it looks very odd
> > regardless of that problem.
> 
> BTW, arm64 has copied that logics, so it also seems to be unsafe and very
> odd - there we definitely have only ELF to cope with.  arm64 folks Cc'd...

Good point. We don't need this on arm64 and probably neither on arm (at
least since EABI).

Setting x0 may cause other issues as well. The dynamic loader simply
ignores the startup registers but for static binaries the _start code in
glibc expects r0 to contain a function pointer to be registered with
atexit() in __libc_start_main() or NULL. Since we pass argc in there,
for static binaries the rtld_fini argument to __libc_start_main() is
neither NULL nor something meaningful.

Russell, do you know whether setting these registers is needed for OABI?

-- 
Catalin
