Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267554AbUIUI6b@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:964 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267551AbUIUI5V (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 21 Sep 2004 04:57:21 -0400
Date: Tue, 21 Sep 2004 10:54:46 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: x86-64-waitid-compat-fix
Message-ID: <20040921085446.GC8058@wotan.suse.de>
References: <20040920204055.577976a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040920204055.577976a9.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Sep 20, 2004 at 08:40:55PM -0700, Andrew Morton wrote:
> 
> I guess I'll merge this into Linus's tree this evening.  It breaks sparc64
> and probably other architectures.  The fix will be simple; probably the
> same as x86_64..

Yes, looks good to me. 

Thanks,
-Andi
