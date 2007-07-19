Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:44220 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938817AbXGSOCa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jul 2007 10:02:30 -0400
Date: Thu, 19 Jul 2007 15:02:26 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Consolidate PTRACE_DETACH
Message-ID: <20070719140226.GC16279@infradead.org>
References: <20070719123800.GA31240@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070719123800.GA31240@localhost.sw.ru>
Sender: linux-arch-owner@vger.kernel.org
To: Alexey Dobriyan <adobriyan@sw.ru>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, hch@infradead.org, devel@openvz.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Jul 19, 2007 at 04:38:01PM +0400, Alexey Dobriyan wrote:
> Identical handlers of PTRACE_DETACH go into ptrace_request().
> Not touching compat code.
> Not touching archs that don't call ptrace_request.

Looks very nice, thanks.
