Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]:58091 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750726AbdBBDIY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2017 22:08:24 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 2AD8E4BA1
        for <linux-arch@vger.kernel.org>; Thu,  2 Feb 2017 03:01:03 +0000 (UTC)
Date: Wed, 1 Feb 2017 22:00:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] kprobes: move kprobe declarations to
 asm-generic/kprobes.h
Message-ID: <20170201220057.5b4828fb@grimm.local.home>
In-Reply-To: <20170201214604.GJ24047@wotan.suse.de>
References: <20170118174840.16572-1-mcgrof@kernel.org>
        <20170119103812.248018d8f6f29768389cbd13@kernel.org>
        <20170119154735.b242a91beffc701b140fecda@kernel.org>
        <20170201214604.GJ24047@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, arnd@arndb.de, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, luto@kernel.org, bp@suse.de, bp@alien8.de, will.deacon@arm.com, linux@armlinux.org.uk, dhowells@redhat.com, benh@kernel.crashing.org, ralf@linux-mips.org, jpoimboe@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20170202030057.PvgYOAxWX-UEXZKtpJ7CtI4-Y1UBFDC2EmKSpcdsCao@z>

On Wed, 1 Feb 2017 22:46:04 +0100
"Luis R. Rodriguez" <mcgrof@kernel.org> wrote:

> On Thu, Jan 19, 2017 at 03:47:35PM +0900, Masami Hiramatsu wrote:
> > OK, then it is OK to me.
> > 
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>  
> 
> Aha, actually I *did* send this out separately already :) --
> who's tree should this go through ?

This hits a lot of archs. Perhaps it should go through the default
tree... Andrew?

-- Steve
