From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 23/31] arm64: Debugging support
Date: Mon, 20 Aug 2012 20:10:59 +0000
Message-ID: <201208202010.59985.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <20120820090754.GB25864@mudshark.cambridge.arm.com> <20120820092744.GD25864@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:51140 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226Ab2HTULG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Aug 2012 16:11:06 -0400
In-Reply-To: <20120820092744.GD25864@mudshark.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ulrich.weigand@linaro.org" <ulrich.weigand@linaro.org>

On Monday 20 August 2012, Will Deacon wrote:
> On Mon, Aug 20, 2012 at 10:07:54AM +0100, Will Deacon wrote:
> > On Fri, Aug 17, 2012 at 08:06:07AM +0100, Arnd Bergmann wrote:
> > > Sorry for the dumb question, but why do you even need PTRACE_GET_THREAD_AREA
> > > for 64 bit tasks? I thought the thread pointer is a GPR, or is this just
> > > for compat tasks?
> > 
> > The TLS is stored in a co-processor register which is read-only for
> > userspace.
> 
> I should elaborate: the register is RW for AArch64 tasks, RO for aarch32
> tasks (although that doesn't affect the need for the ptrace request).

So can't you just /add/ that register to the GPR regset?

	Arnd
