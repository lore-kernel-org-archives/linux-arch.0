From: Will Deacon <will.deacon@arm.com>
Subject: Re: [GIT PULL] asm-generic/io.h overhaul
Date: Tue, 11 Nov 2014 11:40:48 +0000
Message-ID: <20141111114047.GD16265@arm.com>
References: <20141110162520.GA3926@ulmo.nvidia.com>
 <7499625.xm054LhcvJ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7499625.xm054LhcvJ@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Arnd,

On Mon, Nov 10, 2014 at 05:01:27PM +0000, Arnd Bergmann wrote:
> On Monday 10 November 2014 17:25:23 Thierry Reding wrote:
> > The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> > 
> >   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> > 
> > are available in the git repository at:
> > 
> >   https://github.com/thierryreding/linux.git asm-generic-io
> > 
> > for you to fetch changes up to 09a5723983e383e7d627fe3191366761722695bc:
> > 
> >   arm64: Use include/asm-generic/io.h (2014-11-10 15:59:23 +0100)
> 
> I've pulled this into my asm-generic branch again now, let's see if
> anything breaks.

Any chance you could try merging in the relaxed accessors too, please?

Will
