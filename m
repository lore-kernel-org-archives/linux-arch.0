Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:65278 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752764AbbCXNV5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 Mar 2015 09:21:57 -0400
Message-ID: <551164ED.5000907@nod.at>
Date: Tue, 24 Mar 2015 14:21:49 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 00/11] an introduction of library operating system
 for Linux (LibOS)
References: <1427202642-1716-1-git-send-email-tazaki@sfc.wide.ad.jp>
In-Reply-To: <1427202642-1716-1-git-send-email-tazaki@sfc.wide.ad.jp>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hajime Tazaki <tazaki@sfc.wide.ad.jp>, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Jhristoph Lameter <cl@linux.com>, Jekka Enberg <penberg@kernel.org>, Javid Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Jndrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org, Jeff Dike <jdike@addtoit.com>, Rusty Russell <rusty@rustcorp.com.au>, Mathieu Lacage <mathieu.lacage@gmail.com>
Message-ID: <20150324132149.MT9foi_uXspwzcUZCrs4GNEgkzjqMxiCCbVrrGj_vXo@z>

Am 24.03.2015 um 14:10 schrieb Hajime Tazaki:
 > == More information ==
> 
> The crucial difference between UML (user-mode linux) and this approach
> is that we allow multiple network stack instances to co-exist within a
> single process with dlmopen(3) like linking for easy debugging.

Is this the only difference?
We already have arch/um, why do you need arch/lib/ then?
My point is, can't you merge your arch/lib into the existing arch/um stuff?
