From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] Kconfig cleanup (PARPORT_PC dependencies)
Date: Fri, 13 Sep 2013 18:40:06 +0200
Message-ID: <20130913164006.GA26267@merkur.ravnborg.org>
References: <1379012038-31764-1-git-send-email-msalter@redhat.com> <20130912203204.GA26170@merkur.ravnborg.org> <1379020912.14495.23.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1379020912.14495.23.camel@deneb.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, tony.luck@intel.com, geert@linux-m68k.org, monstr@monstr.eu, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, lethal@linux-sh.org, davem@davemloft.net, cmetcalf@tilera.com, gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 12, 2013 at 05:21:52PM -0400, Mark Salter wrote:
> On Thu, 2013-09-12 at 22:32 +0200, Sam Ravnborg wrote:
> > It is much nicer if you provide a config symbol only once.
> > And then let the architectures who want it select this symbol.
> > 
> > This is the pattern we use for similar things in many places today,
> > so it is best to follow that pattern.
> 
> Okay, I'm ahead of you on that. I actually had two versions of the
> patch. The other uses select. If that is the preferred way these
> days, I'll go with it for V2 of the patch.
Perfect - please use this.

	Sam
