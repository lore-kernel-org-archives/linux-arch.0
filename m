From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH] Kconfig cleanup (PARPORT_PC dependencies)
Date: Thu, 12 Sep 2013 17:21:52 -0400
Message-ID: <1379020912.14495.23.camel@deneb.redhat.com>
References: <1379012038-31764-1-git-send-email-msalter@redhat.com>
	 <20130912203204.GA26170@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130912203204.GA26170@merkur.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, tony.luck@intel.com, geert@linux-m68k.org, monstr@monstr.eu, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, lethal@linux-sh.org, davem@davemloft.net, cmetcalf@tilera.com, gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
List-Id: linux-arch.vger.kernel.org

On Thu, 2013-09-12 at 22:32 +0200, Sam Ravnborg wrote:
> It is much nicer if you provide a config symbol only once.
> And then let the architectures who want it select this symbol.
> 
> This is the pattern we use for similar things in many places today,
> so it is best to follow that pattern.

Okay, I'm ahead of you on that. I actually had two versions of the
patch. The other uses select. If that is the preferred way these
days, I'll go with it for V2 of the patch.
