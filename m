From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] kbuild: provide THIN_ARCHIVES option for all
 architectures
Date: Mon, 29 May 2017 20:52:51 +0200
Message-ID: <20170529185251.GA3359@ravnborg.org>
References: <20170529081103.29999-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170529081103.29999-1-npiggin@gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>, Alan Modra <amodra@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

Hi Nicholas.

> Supporting two different intermediate-artifact packaging schemes
> was only ever intended as a temporary transition.
> 
> This has so far caused no problems for powerpc, after a small fix
> for how the arch invoked ar. So now allow any arch to select the
> option, continue defaulting to N.

Alan Modra recommended this approach several years ago, and I think
Stephen was the first to implement this for the kernel.
It would be good to have the rational whay ar is better than ld -r
included in the commit message for later reference.

I also recall that using ar gave some small kernel size reductions
from last time we played with this.
This info could also be nice to give a rough idea of the impact.

Added Alan to list of receivers.

	Sam
