From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 06/19] OpenRISC: PTrace
Date: Tue, 5 Jul 2011 18:42:11 +0200
Message-ID: <201107051842.11666.arnd@arndb.de>
References: <1309641352-18714-1-git-send-email-jonas@southpole.se> <201107051742.29359.arnd@arndb.de> <1309881907.3393.15.camel@jerome>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57468 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877Ab1GEQmQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2011 12:42:16 -0400
In-Reply-To: <1309881907.3393.15.camel@jerome>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tuesday 05 July 2011, Jonas Bonn wrote:
> I've been looking a bit at the ptrace stuff the last couple of days.
> One question that occurred to me was:  is it mandatory to export the
> "struct pt_regs" info in ptrace.h to userspace?

I don't know, it certainly has been the case traditionally, but as
far as I can tell, this was mainly used by ancient gdb ports,
while newer versions just hardcode the offsets for PTRACE_PEEKUSR.

> I'm not sure I like the layout of our struct pt_regs.  It would be
> better to lay out the registers in a way that mirrors the order that
> they are saved during exception/syscall entry in order to make better
> use of the cache.
> 
> Since the registers can be exported via a regset to userspace anyway
> (which doesn't necessarily need to look like pt_regs), I don't see that
> userspace really needs how we lay out the registers on the stack.  By
> not exporting pt_regs, I am free to change the layout... if it's
> exported, it becomes ABI.

Yes. I think you can just change your ptrace code to not export
pt_regs through PEEKUSR but only through elf_gregset_t, which
you can define independently.

	Arnd
