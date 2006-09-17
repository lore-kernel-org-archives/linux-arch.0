Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:27365 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S964948AbWIQL7t (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 17 Sep 2006 07:59:49 -0400
Date: Sun, 17 Sep 2006 20:59:44 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [patch 1/1] make PROT_WRITE imply PROT_READ
Message-ID: <20060917115944.GA20782@localhost.usen.ad.jp>
References: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net>
Sender: linux-arch-owner@vger.kernel.org
To: akpm@osdl.org
Cc: linux-arch@vger.kernel.org, jbaron@redhat.com, ak@muc.de, alan@lxorguk.ukuu.org.uk, arjan@linux.intel.com, benh@kernel.crashing.org, geert@linux-m68k.org, hugh@veritas.com, kkojima@rr.iij4u.or.jp, paulus@samba.org, rmk@arm.linux.org.uk, spyro@f2s.com, tony.luck@intel.com, zippel@linux-m68k.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Sep 14, 2006 at 06:39:47PM -0700, akpm@osdl.org wrote:
> From: Jason Baron <jbaron@redhat.com>
> 
> (akpm: needs to be split into nine patches and fed through arch trees. 
> Later.)
> 
> (err, make it's easier to just collect some acks?)
> 
sh part is fine.

Acked-by: Paul Mundt <lethal@linux-sh.org>
