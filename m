From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] Kconfig cleanup (PARPORT_PC dependencies)
Date: Thu, 12 Sep 2013 22:32:04 +0200
Message-ID: <20130912203204.GA26170@merkur.ravnborg.org>
References: <1379012038-31764-1-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1379012038-31764-1-git-send-email-msalter@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, tony.luck@intel.com, geert@linux-m68k.org, monstr@monstr.eu, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, lethal@linux-sh.org, davem@davemloft.net, cmetcalf@tilera.com, gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 12, 2013 at 02:53:58PM -0400, Mark Salter wrote:
> Remove messy dependencies from PARPORT_PC by having it depend on one
> Kconfig symbol (ARCH_MAY_HAVE_PC_PARPORT) and having architectures
> which need it declare ARCH_MAY_HAVE_PC_PARPORT in arch/*/Kconfig.
> New architectures are unlikely to need PARPORT_PC, so this avoids
> having an ever growing list of architectures to exclude. Those
> architectures which do declare ARCH_MAY_HAVE_PC_PARPORT in this
> patch are the ones which have an asm/parport.h.

It is much nicer if you provide a config symbol only once.
And then let the architectures who want it select this symbol.

This is the pattern we use for similar things in many places today,
so it is best to follow that pattern.

	Sam
