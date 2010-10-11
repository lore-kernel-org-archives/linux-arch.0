From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [patch 29/47] pci: Convert msi to new irq_chip functions
Date: Mon, 11 Oct 2010 10:09:26 -0700
Message-ID: <20101011100926.29241d87@jbarnes-desktop>
References: <20100930221351.682772535@linutronix.de>
	<20100930221741.327789575@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100930221741.327789575@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

On Thu, 30 Sep 2010 23:16:55 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/arm/mach-iop13xx/msi.c            |    8 ++++----
>  arch/ia64/kernel/msi_ia64.c            |    4 ++--
>  arch/ia64/sn/kernel/msi_sn.c           |    4 ++--
>  arch/powerpc/platforms/cell/axon_msi.c |    6 +++---
>  arch/powerpc/platforms/pseries/xics.c  |    2 +-
>  arch/powerpc/sysdev/fsl_msi.c          |    4 ++--
>  arch/powerpc/sysdev/mpic_pasemi_msi.c  |   22 +++++++++++-----------
>  arch/powerpc/sysdev/mpic_u3msi.c       |   16 ++++++++--------
>  arch/sparc/kernel/pci_msi.c            |    8 ++++----
>  arch/x86/kernel/apic/io_apic.c         |    8 ++++----
>  drivers/pci/msi.c                      |   14 +++++++-------
>  include/linux/msi.h                    |    5 +++--
>  12 files changed, 51 insertions(+), 50 deletions(-)

I like the MSI bits here too.

Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>

-- 
Jesse Barnes, Intel Open Source Technology Center
