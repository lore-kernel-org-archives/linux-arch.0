From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH 5/14] blackfin: use generic ptrace_resume code
Date: Tue, 2 Feb 2010 15:29:38 -0500
Message-ID: <8bd0f97a1002021229x1c84d13flcc95102b7723468c@mail.gmail.com>
References: <20100202185755.GA3630@lst.de> <20100202185907.GE3630@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f189.google.com ([209.85.210.189]:56740 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365Ab0BBUaG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2010 15:30:06 -0500
In-Reply-To: <20100202185907.GE3630@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: roland@redhat.com, oleg@redhat.com, akpm@linux-foundation.org, vapier@gentoo.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, Feb 2, 2010 at 13:59, Christoph Hellwig wrote:
> Use the generic ptrace_resume code for PTRACE_SYSCALL, PTRACE_CONT,
> PTRACE_KILL and PTRACE_SINGLESTEP. =C2=A0This implies defining
> arch_has_single_step in <asm/ptrace.h> and implementing the
> user_enable_single_step and user_disable_single_step functions, which
> also causes the breakpoint information to be cleared on fork, which
> could be considered a bug fix.
>
> Also the TIF_SYSCALL_TRACE thread flag is now cleared on PTRACE_KILL
> which it previously wasn't which is consistent with all architectures
> using the modern ptrace code.

i have local code in the Blackfin tree that does part of this patch
(and has been tested), so i'll split this patch apart and merge into
my tree.  thanks!
-mike
