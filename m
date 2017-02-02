From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] kprobes: move kprobe declarations to
 asm-generic/kprobes.h
Date: Wed, 1 Feb 2017 22:00:57 -0500
Message-ID: <20170201220057.5b4828fb@grimm.local.home>
References: <20170118174840.16572-1-mcgrof@kernel.org>
        <20170119103812.248018d8f6f29768389cbd13@kernel.org>
        <20170119154735.b242a91beffc701b140fecda@kernel.org>
        <20170201214604.GJ24047@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170201214604.GJ24047@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, arnd@arndb.de, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, luto@kernel.org, bp@suse.de, bp@alien8.de, will.deacon@arm.com, linux@armlinux.org.uk, dhowells@redhat.com, benh@kernel.crashing.org, ralf@linux-mips.org, jpoimboe@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
