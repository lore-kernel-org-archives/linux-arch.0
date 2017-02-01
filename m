From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH] kprobes: move kprobe declarations to
 asm-generic/kprobes.h
Date: Wed, 1 Feb 2017 22:46:04 +0100
Message-ID: <20170201214604.GJ24047@wotan.suse.de>
References: <20170118174840.16572-1-mcgrof@kernel.org>
 <20170119103812.248018d8f6f29768389cbd13@kernel.org>
 <20170119154735.b242a91beffc701b140fecda@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:32981 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751501AbdBAVqJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 1 Feb 2017 16:46:09 -0500
Content-Disposition: inline
In-Reply-To: <20170119154735.b242a91beffc701b140fecda@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, arnd@arndb.de, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, luto@kernel.org, rostedt@goodmis.org, bp@suse.de, bp@alien8.de, will.deacon@arm.com, linux@armlinux.org.uk, dhowells@redhat.com, benh@kernel.crashing.org, ralf@linux-mips.org, jpoimboe@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 19, 2017 at 03:47:35PM +0900, Masami Hiramatsu wrote:
> OK, then it is OK to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Aha, actually I *did* send this out separately already :) --
who's tree should this go through ?

  Luis
