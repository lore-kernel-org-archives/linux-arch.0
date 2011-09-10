Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:42850 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759171Ab1IJMSX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 10 Sep 2011 08:18:23 -0400
From: Pedro Alves <pedro@codesourcery.com>
Subject: Re: [patch v3 19/36] Hexagon: Add ptrace support
Date: Sat, 10 Sep 2011 12:29:57 +0100
References: <20110909010847.294039464@codeaurora.org> <20110909211808.GA3150@codeaurora.org> <CACM3HyH8P=u9pR0sa2besxsgDN5TUKg_7utLJTwL+hu8Wv48ow@mail.gmail.com>
In-Reply-To: <CACM3HyH8P=u9pR0sa2besxsgDN5TUKg_7utLJTwL+hu8Wv48ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <201109101229.58445.pedro@codesourcery.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas.bonn@gmail.com>
Cc: "Linas Vepstas (Code Aurora)" <linas@codeaurora.org>, Richard Kuo <rkuo@codeaurora.org>, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Message-ID: <20110910112957.CUpcv3NBGkhwu_hoFTaExQqQgRle6l7lJ3M-1HI9iqg@z>

On Saturday 10 September 2011 07:42:26, Jonas Bonn wrote:

> I'm really not an expert on GDB, but I believe it can use either the
> PEEK/POKE functions to access regs, or it can use GET/SETREGS; it's an
> architecture-dependent configuration.  I think the second variant can
> be easily modified to become GET/SETREGSET instead, and the PEEK/POKE
> variant wouldn't be needed at all.

Yes, the x86/x86-64 ports or gdb and gdbserver are already
using GET/SETREGSET even.

-- 
Pedro Alves
