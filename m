Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268831AbUIHFqZ@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:53204 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268846AbUIHFp7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Sep 2004 01:45:59 -0400
Date: Tue, 7 Sep 2004 22:43:53 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [ppc64] Fix compat cpu affinity on big endian 64bit
Message-Id: <20040907224353.3bffdf59.akpm@osdl.org>
In-Reply-To: <20040908053429.GH25278@krispykreme>
References: <20040904211749.3f713a8a.pj@sgi.com>
	<20040904215205.0a067ab8.pj@sgi.com>
	<20040906182330.GA79122@muc.de>
	<Pine.LNX.4.58.0409061147220.28608@ppc970.osdl.org>
	<20040906141142.663941fb.pj@sgi.com>
	<Pine.LNX.4.58.0409070736100.2299@ppc970.osdl.org>
	<20040908002408.GA25278@krispykreme>
	<20040908003359.GC25278@krispykreme>
	<20040908004040.GD25278@krispykreme>
	<20040907222250.62bc6ff9.akpm@osdl.org>
	<20040908053429.GH25278@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Anton Blanchard <anton@samba.org>
Cc: torvalds@osdl.org, pj@sgi.com, ak@muc.de, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Anton Blanchard <anton@samba.org> wrote:
>
>  > umm, wanna send along a patch which defines BITS_PER_COMPAT_LONG?
> 
>  Yep, did you get the first in the series?

<looks>

Oh, so I did.
