From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [patch 33/47] pci: Cleanup the irq_desc mess in msi
Date: Mon, 11 Oct 2010 10:08:49 -0700
Message-ID: <20101011100849.072b9ba6@jbarnes-desktop>
References: <20100930221351.682772535@linutronix.de>
	<20100930221741.720879189@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100930221741.720879189@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

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
