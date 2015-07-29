From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 08/25] arch: introduce memremap()
Date: Wed, 29 Jul 2015 14:47:40 -0700
Message-ID: <CAPcyv4j67493ROvnC1EZBEFMiWB=gLu=C-Y-PrJf0BvO3A=y2w@mail.gmail.com>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150725023842.8664.97620.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150726172527.GA29513@lst.de>
	<CAPcyv4igoopDPpcCRU1TNYdwPhiYdcDiRA7L9Jdian=0rtexRg@mail.gmail.com>
	<20150727051258.GB15836@lst.de>
	<CAPcyv4jN6jYzw11qOOR-xd_w6s5dguQSoHyvmPFSWtL9S+tz3w@mail.gmail.com>
	<20150729065004.GA17162@lst.de>
	<20150729182712.GI30479@wotan.suse.de>
	<CAPcyv4iAeMAmU1QRZ1=WTav0cg2=-gqzzrt3nMC1QoD1+hOeBg@mail.gmail.com>
	<1438203638.3214.418.camel@hp.com>
	<20150729214358.GK30479@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38735 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbbG2Vrm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jul 2015 17:47:42 -0400
Received: by wibxm9 with SMTP id xm9so44207865wib.1
        for <linux-arch@vger.kernel.org>; Wed, 29 Jul 2015 14:47:40 -0700 (PDT)
In-Reply-To: <20150729214358.GK30479@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Toshi Kani <toshi.kani@hp.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "H. Peter Anvin" <hpa@zytor.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Jul 29, 2015 at 2:43 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> While at it, Dan, will / should memremap() support overlapping calls ?
> What is the expectation on behaviour ?

It will be the same as ioremap().  Each mapping gets its own virtual
address and overlapping calls are permitted.  The only protection is
that RAM is never mapped with an alias.
