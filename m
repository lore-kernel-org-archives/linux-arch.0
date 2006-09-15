Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from colin.muc.de ([193.149.48.1]:50443 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750762AbWIOIrv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Sep 2006 04:47:51 -0400
Date: 15 Sep 2006 10:47:49 +0200
Date: Fri, 15 Sep 2006 10:47:49 +0200
From: Andi Kleen <ak@muc.de>
Subject: Re: [patch 1/1] make PROT_WRITE imply PROT_READ
Message-ID: <20060915084749.GC9672@muc.de>
References: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net>
Sender: linux-arch-owner@vger.kernel.org
To: akpm@osdl.org
Cc: linux-arch@vger.kernel.org, jbaron@redhat.com, alan@lxorguk.ukuu.org.uk, arjan@linux.intel.com, benh@kernel.crashing.org, geert@linux-m68k.org, hugh@veritas.com, kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, paulus@samba.org, rmk@arm.linux.org.uk, spyro@f2s.com, tony.luck@intel.com, zippel@linux-m68k.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Sep 14, 2006 at 06:39:47PM -0700, akpm@osdl.org wrote:
> From: Jason Baron <jbaron@redhat.com>
> 
> (akpm: needs to be split into nine patches and fed through arch trees. 
> Later.)
> 
> (err, make it's easier to just collect some acks?)

x86_64 part is ok for me.

-Andi
