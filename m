Return-Path: <anton@samba.org>
Received: from dp.samba.org ([66.70.73.150]:16319 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261205AbUCCWJc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Mar 2004 17:09:32 -0500
Date: Thu, 4 Mar 2004 08:35:25 +1100
From: Anton Blanchard <anton@samba.org>
Subject: Re: [PROPOSAL] switch atomic_t to long
Message-ID: <20040303213525.GY5801@krispykreme>
References: <20040226141645.GL25779@parcelfarce.linux.theplanet.co.uk> <20040226113641.43b4afe8.akpm@osdl.org> <20040226120012.55b652d2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040226120012.55b652d2.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: willy@debian.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


> > vm_committed_space is in pages.  16TB of virtual space sounds rather a lot
> > to me but I'm a fogey.
> 
> Make that 16TB of physmem+swap

There are 1TB machines today, 16TB wont be too many years off.

Anton
