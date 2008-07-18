From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86: fix description of __fls(): __fls(0) is undefined
Date: Fri, 18 Jul 2008 14:33:00 +0200
Message-ID: <20080718123300.GP6875@elte.hu>
References: <20080315172913.GA21648@mailshack.com> <20080315173236.GC21659@mailshack.com> <1215276997.7167.12.camel@localhost> <20080705175345.GA7698@mailshack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:51449 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899AbYGRMdU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 Jul 2008 08:33:20 -0400
Content-Disposition: inline
In-Reply-To: <20080705175345.GA7698@mailshack.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander van Heukelum <heukelum@mailshack.com>
Cc: "Ricardo M. Correia" <Ricardo.M.Correia@Sun.COM>, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, LKML <linux-kernel@vger.kernel.org>, heukelum@fastmail.fm


* Alexander van Heukelum <heukelum@mailshack.com> wrote:

> Ricardo M. Correia spotted that the use of __fls() in fls64() did not 
> seem to make sense. In fact fls64()'s implementation is fine, but the 
> description of __fls() was wrong. Fix that.
> 
> Reported-by: "Ricardo M. Correia" <Ricardo.M.Correia@Sun.COM>
> Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>

applied to tip/x86/cleanups, thanks!

	Ingo
