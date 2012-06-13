Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39790 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab2FMOAU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jun 2012 10:00:20 -0400
Date: Wed, 13 Jun 2012 23:00:13 +0900
From: Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
Subject: Re: [PATCH 2/5] drivers/net/ethernet/dec/tulip: Use standard
 __set_bit_le() function
Message-ID: <20120613230013.3cc59bf908616e94bb4ccef2@gmail.com>
In-Reply-To: <CAC5umygutE35hVObuooWj=ADP6PZDy4cqLtxGnRtxRX8uTtGSw@mail.gmail.com>
References: <20120613130054.b5695621.yoshikawa.takuya@oss.ntt.co.jp>
	<20120613130304.0186fa9d.yoshikawa.takuya@oss.ntt.co.jp>
	<CAC5umyj582T+9GbOYDzOAanmMcVZ-Fdxr7i-8GWf3gTSmtAKUA@mail.gmail.com>
	<20120613214157.0a5179d5358ec7f1b2646606@gmail.com>
	<CAC5umygutE35hVObuooWj=ADP6PZDy4cqLtxGnRtxRX8uTtGSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>, akpm@linux-foundation.org, bhutchings@solarflare.com, grundler@parisc-linux.org, arnd@arndb.de, benh@kernel.crashing.org, avi@redhat.com, mtosatti@redhat.com, linux-net-drivers@solarflare.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org
Message-ID: <20120613140013.vmQUN0nFLzCL9wSHLWHgkV-lvYQsYSEJLmetZGZGhaY@z>

On Wed, 13 Jun 2012 22:31:13 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> >> Should this hash_table be converted from u16 hash_table[32] to
> >> DECLARE_BITMAP(hash_table, 16 * 32) to ensure that it is aligned
> >> on long-word boundary?
> >
> > I think hash_table is already long-word aligned because it is placed
> > right after a pointer.
> 
> I recommend converting to proper bitmap.  Because such an implicit
> assumption is easily broken by someone touching this function.

Do you mean something like:
	DECLARE_BITMAP(__hash_table, 16 * 32);
	u16 *hash_table = (u16 *)__hash_table;
?

Grant, what do you think about this?

	Takuya


===
drivers/net/ethernet/dec/tulip/tulip_core.c:

static void build_setup_frame_hash(u16 *setup_frm, struct net_device *dev)
{
	struct tulip_private *tp = netdev_priv(dev);
	u16 hash_table[32];
	...
}

drivers/net/ethernet/dec/tulip/de2104x.c:

static void build_setup_frame_hash(u16 *setup_frm, struct net_device *dev)
{
	struct de_private *de = netdev_priv(dev);
	u16 hash_table[32];
	...
}
