Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hoboi3bl4.telenet-ops.be ([195.130.137.79]:41884 "EHLO
	hoboi3bl4.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755678AbXEVL0e (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 May 2007 07:26:34 -0400
Received: from assei2bl6.telenet-ops.be (assei2bl6.telenet-ops.be [195.130.133.69])
	by hoboi3bl4.telenet-ops.be (Postfix) with ESMTP id 2FF9324458E
	for <linux-arch@vger.kernel.org>; Tue, 22 May 2007 11:44:41 +0200 (CEST)
Date: Tue, 22 May 2007 11:44:17 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [rfc] increase struct page size?!
In-Reply-To: <Pine.LNX.4.64.0705211737450.24160@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0705221142340.11196@anakin>
References: <20070518040854.GA15654@wotan.suse.de>
 <Pine.LNX.4.64.0705191121480.17008@schroedinger.engr.sgi.com>
 <464FCA28.9040009@cosmosbay.com> <200705201456.26283.ak@suse.de>
 <Pine.LNX.4.64.0705211006550.26282@schroedinger.engr.sgi.com>
 <20070522093050.0320d092.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0705211737450.24160@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, ak@suse.de, dada1@cosmosbay.com, wli@holomorphy.com, npiggin@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 21 May 2007, Christoph Lameter wrote:
> On Tue, 22 May 2007, KAMEZAWA Hiroyuki wrote:
> > For i386(32bit arch), there is not enough space for vmemmap.
> 
> I thought 32 bit would use flatmem? Is memory really sparse on 32 
> bit? Likely difficult due to lack of address space?

Throwing in more crazy comments: many m68k boxes have really sparse memory, due
to lack of memory and large address space.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
