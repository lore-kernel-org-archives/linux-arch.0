From: Matt Mackall <mpm@selenic.com>
Subject: Re: Behavior of BUG() [Was: Re: [PATCH 2/5] of/fdt: add kernel
 command line option for dtb_compat string]
Date: Tue, 16 Nov 2010 22:07:23 -0600
Message-ID: <1289966843.26343.359.camel@calx>
References: <AANLkTinop4_JT4JLtdmWkydPgDDU=TyZNbtiBbgeh1dj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <AANLkTinop4_JT4JLtdmWkydPgDDU=TyZNbtiBbgeh1dj@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnaud Lacombe <lacombar@gmail.com>
Cc: linux-kernel@vger.kernel.org, dirk.brandewie@gmail.com, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-arch.vger.kernel.org

On Tue, 2010-11-16 at 22:45 -0500, Arnaud Lacombe wrote:
> Hi,
> 
> [CC: list reduced as starting a new thread, most on the context
> removed as this concern a different issue.]
> 
> On Tue, Nov 16, 2010 at 7:16 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On Tue, Nov 16, 2010 at 3:41 PM,  <dirk.brandewie@gmail.com> wrote:
> >> From: Dirk Brandewie <dirk.brandewie@gmail.com>
> >> [...]
> > The kernel needs to complain *loudly* if this occurs because it
> > represents a bug.  I'm tempted to say use BUG, but that would halt the
> > kernel and prevent any possibility of kernel log output.
> > [...]
> does it ? if CONFIG_BUG is not enabled and the arch has no define for
> it, the default does _nothing_:

That's because CONFIG_BUG=N is intended for machines where logging is
irrelevant/impossible. You are encouraged to ignore all options under
CONFIG_EMBEDDED when trying to have a sensible discussion.

-- 
Mathematics is the supreme nostalgia of our time.


