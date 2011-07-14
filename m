From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 13/13] memblock, x86: Replace memblock_x86_reserve/free_range()
 with generic ones
Date: Thu, 14 Jul 2011 22:32:53 +0200
Message-ID: <CAOS58YM38mwmLcErARLc2+7wBrBa5Je3VOM5L28z63L6+ysqpQ@mail.gmail.com>
References: <1310462166-31469-1-git-send-email-tj@kernel.org>
	<1310462166-31469-14-git-send-email-tj@kernel.org>
	<4E1F4D2C.3000507@zytor.com>
	<CAOS58YPhFWEYgB7moPoTj+BKBn6WMHCi5FqZ5eYp+m4bbEN_7A@mail.gmail.com>
	<4E1F5040.50004@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:58018 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab1GNUcy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jul 2011 16:32:54 -0400
In-Reply-To: <4E1F5040.50004@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: mingo@redhat.com, tglx@linutronix.de, benh@kernel.crashing.org, yinghai@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org

Hello,

On Thu, Jul 14, 2011 at 10:23 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 07/14/2011 01:20 PM, Tejun Heo wrote:
> Sorry I don't follow. =A0We display resources as [...] ranges, and in
> particular when there are those kinds of brackets they tend to be
> inclusive ranges.
>
> For the internal representation, of course, [ ) ranges or (base, leng=
th)
> are the only sensible options.

[ ) ranges: e820, init_memory_mapping, NUMA nodes, Zone PFN ranges, PM
nosave memory

[ ] ranges: MTRR, NODE_DATA, early_node_map, [mm]io ranges

Hmm... I was only looking at the early boot messages which didn't
include the io ranges.  It ultimately is a cosmetic issue so my
opinions aren't very strong but I think we can leave [mm]io ranges
alone and converge the rest into [ ) ranges sans the brackets?

Thanks.

--=20
tejun
