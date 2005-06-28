Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 28 Jun 2005 02:29:20 -0700 (PDT)
Message-Id: <20050628.022920.68151330.davem@davemloft.net>
Subject: Re: RFC: is_compat_task
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050628092703.GK8035@wotan.suse.de>
References: <20050628091704.GP4171@wotan.suse.de>
	<20050628.022346.34749336.davem@davemloft.net>
	<20050628092703.GK8035@wotan.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: ak@suse.de
Cc: sfr@canb.auug.org.au, hch@lst.de, akpm@osdl.org, linux-kernel@vger.kernel.rg, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Andi Kleen <ak@suse.de>
Date: Tue, 28 Jun 2005 11:27:04 +0200

> On what issue exactly? So far all the code was relatively easily
> fixable. 

If this input layer case is too then the situation is different.  But
I suspect this input case is hard to implement without the
is_compat_task() thing.

Prove me wrong and then there's nothing to discuss :)
