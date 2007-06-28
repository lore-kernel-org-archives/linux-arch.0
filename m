Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:56495 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760006AbXF1LWl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Jun 2007 07:22:41 -0400
Date: Thu, 28 Jun 2007 05:22:39 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: CONFIG_TRACE_IRQFLAGS or CONFIG_TRACE_IRQFLAGS_SUPPORT?
Message-ID: <20070628112239.GD22063@parisc-linux.org>
References: <13566.1183022110@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13566.1183022110@kao2.melbourne.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
To: Keith Owens <kaos@ocs.com.au>
Cc: no@parisc-linux.org, To-header@parisc-linux.org, on@parisc-linux.org, "input <"@parisc-linux.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Jun 28, 2007 at 07:15:10PM +1000, Keith Owens wrote:
> Arch code tests CONFIG_TRACE_IRQFLAGS, but the kconfig files define
> CONFIG_TRACE_IRQFLAGS_SUPPORT.  Which is correct?

Both:

./lib/Kconfig.debug:config TRACE_IRQFLAGS
./lib/Kconfig.debug:    depends on TRACE_IRQFLAGS_SUPPORT

_SUPPORT means the arch supports it.  TRACE_IRQFLAGS means it's turned on.
