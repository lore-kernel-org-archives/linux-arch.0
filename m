Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from there.is.no.cabal.ca ([134.117.69.58]:54203 "EHLO
	fattire.cabal.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759999AbXLMXye (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 13 Dec 2007 18:54:34 -0500
Date: Thu, 13 Dec 2007 18:54:32 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: RFC: remove __read_mostly
Message-ID: <20071213235432.GA26669@fattire.cabal.ca>
References: <20071213222044.GH21616@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071213222044.GH21616@stusta.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, Dec 13, 2007 at 11:20:44PM +0100, Adrian Bunk wrote:
> Is there anywhere in the kernel a case where __read_mostly brings a 
> measurable improvement or can it be removed?
> 

Yes, definitely[1]... the problem is, and this is also true of other
annotations[2], that people go absolutely nuts adding these annotations
without doing any profiling to see whether they actually improve things.

I'd bet, in the __read_mostly case at least, that there's no
improvement in almost all cases.

cheers, Kyle

1. It's hugely relevant on big-SMP machines.
2. I mean __read_mostly, likely, unlikely, etc., not the useful sparse
annotations.
