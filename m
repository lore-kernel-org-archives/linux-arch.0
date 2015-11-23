From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] asm-generic: default BUG_ON(x) to "if(x) BUG()"
Date: Mon, 23 Nov 2015 20:29:44 +0100
Message-ID: <5556176.D98dCq6i5B@wuerfel>
References: <5868782.RxZY0W5S4d@wuerfel> <4150271.zrLzq08T60@wuerfel> <20151123172203.GU8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151123172203.GU8644@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Willy Tarreau <w@1wt.eu>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, josh@joshtriplett.org
List-Id: linux-arch.vger.kernel.org

On Monday 23 November 2015 17:22:03 Russell King - ARM Linux wrote:
> On Mon, Nov 23, 2015 at 05:52:38PM +0100, Arnd Bergmann wrote:
> > On Monday 23 November 2015 16:37:50 Russell King - ARM Linux wrote:
> > > Does that not depend on the architectures BUG() implementation?  If an
> > > architecture implements it as a signalling illegal instruction and a
> > > lookup table, changing it to be a panic() would probably be more code.
> > 
> > Correct, overall, we are down to a 1.40% size reduction compared to
> > 1.70% without my patch and 1.49% with my version:
> > 
> > section     CONFIG_BUG=y    CONFIG_BUG=n    CONFIG_BUG=n+patch    panic("BUG!")
> > 
> >  .text            8320248   |     8180944   |     8207688     |  8221848
> >  .rodata          3633720   |     3567144   |     3570648     |  3567344
> >  __bug_table        32508   |         ---   |         ---     |      ---
> >  __modver             692   |        1584   |        2176     |     1384
> >  .init.text        558132   |      548300   |      550088     |   550592
> >  .exit.text         12380   |       12256   |       12380     |    12448
> >  .data            1016672   |     1016064   |     1016128     |  1016064
> >  Total           14622556   |    14374510   |    14407326     | 14417898
> 
> Are you including dropping the bug table in these stats?  See BUG_TABLE
> in include/asm-generic/vmlinux.lds.h.
> 

Yes, it's the output from "size -A vmlinux", with the lines dropped that
are unchanged. See the __bug_table above for the part that got dropped in
all but the first column. This is included in the "Total" row, but is
only 13% of the size difference, 32508 bytes for BUG_TABLE in
multi_v7_defconfig, compared to 139304 bytes difference in .text.

	Arnd
