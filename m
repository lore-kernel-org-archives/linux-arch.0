Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266187AbUHYW1N@vger.kernel.org>
Received: from are.twiddle.net ([64.81.246.98]:26243 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S266263AbUHYW0F (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 18:26:05 -0400
Date: Wed, 25 Aug 2004 15:26:01 -0700
From: Richard Henderson <rth@twiddle.net>
Subject: Re: [patch 8/8] alpha signal race fixes
Message-ID: <20040825222601.GA7109@twiddle.net>
References: <200408252132.i7PLW0129397@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408252132.i7PLW0129397@mail.osdl.org>
To: akpm@osdl.org
Cc: torvalds@osdl.org, linux-arch@vger.kernel.org, wli@holomorphy.com
List-ID: <linux-arch.vger.kernel.org>

On Wed, Aug 25, 2004 at 02:30:17PM -0700, akpm@osdl.org wrote:
> The rampant variable renaming made my eyes bleed, so I omitted that from
> here.  Anyhow, the test app works after I apply this, so I must have done
> something right.

Looks about like what I tested a while ago.  Sorry for not
sending it on.  

And, like you, I didn't like all the variable renaming.  ;-)


r~
