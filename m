Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:34365 "EHLO
	resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753210AbbDQW0i (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Apr 2015 18:26:38 -0400
Date: Fri, 17 Apr 2015 17:26:34 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
Subject: Re: [RFC PATCH v2 02/11] slab: add private memory allocator header
 for arch/lib
In-Reply-To: <553121E6.5000005@nod.at>
Message-ID: <alpine.DEB.2.11.1504171725100.10545@gentwo.org>
References: <1427202642-1716-1-git-send-email-tazaki@sfc.wide.ad.jp> <1429263374-57517-1-git-send-email-tazaki@sfc.wide.ad.jp> <1429263374-57517-3-git-send-email-tazaki@sfc.wide.ad.jp> <alpine.DEB.2.11.1504170716380.20800@gentwo.org> <55310033.1060108@nod.at>
 <m2h9se4x2b.wl@sfc.wide.ad.jp> <553121E6.5000005@nod.at>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: Hajime Tazaki <tazaki@sfc.wide.ad.jp>, linux-arch@vger.kernel.org, arnd@arndb.de, corbet@lwn.net, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org, jdike@addtoit.com, rusty@rustcorp.com.au, upa@haeena.net, christoph.paasch@gmail.com, mathieu.lacage@gmail.com, libos-nuse@googlegroups.com
Message-ID: <20150417222634.w_EcpC9T8BDGKA9mzXKNTf2qNgbmaoSwuczY970YSX4@z>

On Fri, 17 Apr 2015, Richard Weinberger wrote:

> SLUB is the unqueued SLAB and SLLB is the library SLAB. :D

Good that this convention is now so broadly known that I did not even
have to explain what it meant. But I think you can give it any name you
want. SLLB was just a way to tersely state how this is going to integrate
into the overall scheme of things.

