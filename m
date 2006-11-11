Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49894 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1947115AbWKKGny (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 11 Nov 2006 01:43:54 -0500
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] add dev_archdata to struct device
Date: Sat, 11 Nov 2006 07:43:43 +0100
References: <1163225919.4982.219.camel@localhost.localdomain>
In-Reply-To: <1163225919.4982.219.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611110743.43829.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Arch list <linux-arch@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
List-ID: <linux-arch.vger.kernel.org>

On Saturday 11 November 2006 07:18, Benjamin Herrenschmidt wrote:
> Add arch specific dev_archdata to struct device
> 
> Adds an arch specific struct dev_arch to struct device. This enables
> architecture to add specific fields to every device in the system, like
> DMA operation pointers, NUMA node ID, firmware specific data, etc...

Fine by me from the x86 side.

-Andi
