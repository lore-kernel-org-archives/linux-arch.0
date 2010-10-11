Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cpoproxy3-pub.bluehost.com ([67.222.54.6]:44053 "HELO
	cpoproxy3-pub.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755634Ab0JKRFh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Oct 2010 13:05:37 -0400
Date: Mon, 11 Oct 2010 10:08:49 -0700
From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [patch 33/47] pci: Cleanup the irq_desc mess in msi
Message-ID: <20101011100849.072b9ba6@jbarnes-desktop>
In-Reply-To: <20100930221741.720879189@linutronix.de>
References: <20100930221351.682772535@linutronix.de>
	<20100930221741.720879189@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20101011170849.RCUQVqfH0JrSajwLfSlgVkYh_D0yqJB_c3SDdFUCNoA@z>

On Thu, 30 Sep 2010 23:17:18 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> Handing down irq_desc to msi just so that msi can access
> irq_desc.irq_data.msi_desc is a pretty stupid idea. The calling code
> can hand down a pointer to msi_desc so msi code does not need to know
> about the irq descriptor at all.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

Looks like a good cleanup.

Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>

-- 
Jesse Barnes, Intel Open Source Technology Center
