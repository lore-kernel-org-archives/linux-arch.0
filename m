Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 6 Feb 2005 14:25:50 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
Message-Id: <20050206142550.22a3ef3c.davem@davemloft.net>
In-Reply-To: <20050206215020.GJ18245@wotan.suse.de>
References: <200502050150.j151osl11380@mail.osdl.org>
	<Pine.LNX.4.58.0502041806120.2165@ppc970.osdl.org>
	<Pine.LNX.4.58.0502041919300.2165@ppc970.osdl.org>
	<20050205090619.C30866@flint.arm.linux.org.uk>
	<20050205154448.1cc89ee9.davem@davemloft.net>
	<20050206105047.GB6819@wotan.suse.de>
	<20050206131947.6524ece9.davem@davemloft.net>
	<20050206213148.GI18245@wotan.suse.de>
	<20050206133110.528ce713.davem@davemloft.net>
	<20050206215020.GJ18245@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: rmk@arm.linux.org.uk, torvalds@osdl.org, akpm@osdl.org, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 6 Feb 2005 22:50:20 +0100
Andi Kleen <ak@suse.de> wrote:

> And yes this stuff does matter - i remember i got LM benchmarkable
> improvements in signal latency by optimizing __copy_to_user
> to use optimized inlines for small stores.
