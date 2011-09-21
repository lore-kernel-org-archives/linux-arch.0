Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:41148 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844Ab1IUQP0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Sep 2011 12:15:26 -0400
From: Pedro Alves <pedro@codesourcery.com>
Subject: Re: [patch v3 19/36] Hexagon: Add ptrace support
Date: Wed, 21 Sep 2011 17:15:20 +0100
References: <20110909010847.294039464@codeaurora.org> <201109101229.58445.pedro@codesourcery.com> <20110919152505.GB6830@codeaurora.org>
In-Reply-To: <20110919152505.GB6830@codeaurora.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201109211715.20795.pedro@codesourcery.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Linas Vepstas (Code Aurora)" <linas@codeaurora.org>
Cc: Jonas Bonn <jonas.bonn@gmail.com>, Richard Kuo <rkuo@codeaurora.org>, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Message-ID: <20110921161520.Xrwkq3iPainsu06Mzqv0H3OxZaGQN2cklgazWhT2BNg@z>

On Monday 19 September 2011 16:25:05, Linas Vepstas (Code Aurora) wrote:
> On Sat, Sep 10, 2011 at 12:29:57PM +0100, Pedro Alves wrote:
> > On Saturday 10 September 2011 07:42:26, Jonas Bonn wrote:
> > 
> > > I'm really not an expert on GDB, but I believe it can use either the
> > > PEEK/POKE functions to access regs, or it can use GET/SETREGS; it's an
> > > architecture-dependent configuration.  I think the second variant can
> > > be easily modified to become GET/SETREGSET instead, and the PEEK/POKE
> > > variant wouldn't be needed at all.
> > 
> > Yes, the x86/x86-64 ports or gdb and gdbserver are already
> > using GET/SETREGSET even.
> 
> Reading the code, it seemed to only fetch "extended state" in
> this way, and not all of the registers.  Am I mistaken?

True.  gdb/gdbserver need to keep working with older x86 kernels, so
we avoid having two ways of doing things with the other registers.
No reason to support legacy interfaces with new ports though.

I wish there was an equivalent of PTRACE_GETREGSET for siginfo...

-- 
Pedro Alves
