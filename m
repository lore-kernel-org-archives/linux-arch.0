From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/4]: Respin local_irq_*_nmi() stuff.
Date: Tue, 13 Apr 2010 09:48:58 +0200
Message-ID: <1271144938.4807.925.camel@twins>
References: <20100409.160132.216116766.davem@davemloft.net>
	 <20100412.220838.132238558.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35237 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215Ab0DMHs5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Apr 2010 03:48:57 -0400
In-Reply-To: <20100412.220838.132238558.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org

On Mon, 2010-04-12 at 22:08 -0700, David Miller wrote:
> I'm rescinding these patches for now, for two reasons:
> 
> 1) The NMI annotations necessary to get everything working really gets
>    out of control.
> 
> 2) I think I found a cheap way to do this in sparc64 specific code.

Ah, ok..

Care to enlighten the curious amongst us as to what exactly you're doing
in the sparc code?
