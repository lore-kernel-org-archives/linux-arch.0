Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:17385 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263078AbUCSSzx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Mar 2004 13:55:53 -0500
Date: Fri, 19 Mar 2004 10:55:49 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: pci_map_single return value
Message-Id: <20040319105549.1285ef71.davem@redhat.com>
In-Reply-To: <1079715431.1732.18.camel@mulgrave>
References: <20031212155752.GD17683@krispykreme>
	<20031212175104.07dc8444.ak@suse.de>
	<20031212192131.GF17683@krispykreme>
	<20031213220444.4c526afa.davem@redhat.com>
	<20040102120121.GT28023@krispykreme>
	<20040102133454.22daa451.ak@suse.de>
	<20040319001448.GP28212@krispykreme>
	<1079715431.1732.18.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: anton@samba.org, ak@suse.de, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On 19 Mar 2004 11:57:10 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> Actually, there is a fundamental problem with this.  Today drivers
> assume the system will panic if it runs out of mapping resources, so
> very few of them actually check return values.
> 
> Unless someone is stepping up to fix *all* the drivers in the kernel,
> then we need to cope with this for a while yet.

I agree with your concerns, but I don't think I'd go that far.

This error return issue has been around far too long, years in fact.
We should make it easier to get this functionality into the tree, not
harder.

If there are extra knobs and stuff people need to do in order to what
effectively amounts to checking for kmalloc() returning NULL, they
are going to be less inclined to do the work.
