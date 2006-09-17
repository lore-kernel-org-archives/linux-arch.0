Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:32799 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S965100AbWIQVFt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 17 Sep 2006 17:05:49 -0400
Message-ID: <450DB8A0.1020009@linux.intel.com>
Date: Sun, 17 Sep 2006 23:05:36 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
MIME-Version: 1.0
Subject: Re: [patch 1/1] make PROT_WRITE imply PROT_READ
References: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net>	 <20060917202408.GA10031@tuatara.stupidest.org> <1158527646.6069.67.camel@localhost.localdomain>
In-Reply-To: <1158527646.6069.67.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Wedgwood <cw@f00f.org>, akpm@osdl.org, linux-arch@vger.kernel.org, jbaron@redhat.com, ak@muc.de, benh@kernel.crashing.org, geert@linux-m68k.org, hugh@veritas.com, kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, paulus@samba.org, rmk@arm.linux.org.uk, spyro@f2s.com, tony.luck@intel.com, zippel@linux-m68k.org
List-ID: <linux-arch.vger.kernel.org>

Alan Cox wrote:

> Frankly I think the odds of Intel cpus growing write-only
> are remote....

in the VT virtualization case it's there already basically...
(at least for MMIO regions, for memory regions it's probably not
done for performance reasons)
