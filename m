Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:9572 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932395AbWIQUYM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 17 Sep 2006 16:24:12 -0400
Date: Sun, 17 Sep 2006 13:24:08 -0700
From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [patch 1/1] make PROT_WRITE imply PROT_READ
Message-ID: <20060917202408.GA10031@tuatara.stupidest.org>
References: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net>
Sender: linux-arch-owner@vger.kernel.org
To: akpm@osdl.org
Cc: linux-arch@vger.kernel.org, jbaron@redhat.com, ak@muc.de, alan@lxorguk.ukuu.org.uk, arjan@linux.intel.com, benh@kernel.crashing.org, geert@linux-m68k.org, hugh@veritas.com, kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, paulus@samba.org, rmk@arm.linux.org.uk, spyro@f2s.com, tony.luck@intel.com, zippel@linux-m68k.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Sep 14, 2006 at 06:39:47PM -0700, akpm@osdl.org wrote:

> Make PROT_WRITE imply PROT_READ for a number of architectures which
> don't support write only in hardware.

Why don't we WARN where PROT_WRITE is used w/o PROT_READ?  Do
non-trivial or non-contrived applications really use PROT_WRITE and
assume reads are OK?

It seems once we do this there will be little or no chance of ever
doing write-only mappings should we want to in the future using this
mechanism.

We could just update the definition of PROT_WRITE in the userspace
headers...
