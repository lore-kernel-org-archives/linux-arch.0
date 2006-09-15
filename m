Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:41907 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750704AbWIOEyC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Sep 2006 00:54:02 -0400
Message-ID: <450A31D4.1020108@linux.intel.com>
Date: Fri, 15 Sep 2006 06:53:40 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
MIME-Version: 1.0
Subject: Re: [patch 1/1] make PROT_WRITE imply PROT_READ
References: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net>
In-Reply-To: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: akpm@osdl.org
Cc: linux-arch@vger.kernel.org, jbaron@redhat.com, ak@muc.de, alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, geert@linux-m68k.org, hugh@veritas.com, kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, paulus@samba.org, rmk@arm.linux.org.uk, spyro@f2s.com, tony.luck@intel.com, zippel@linux-m68k.org
List-ID: <linux-arch.vger.kernel.org>

> Additional discussion:
> 
> Several architectures, including x86, can not support write-only mappings. 

actually on x86 the kernel can support it, just that it's highly expensive in
terms of performance so we don't currently do it. We could if we wanted to though.

This patch will create a userspace ABI precedent that will hurt us if we ever
decide to implement this, or if Intel or AMD add support for this to the cpu...
