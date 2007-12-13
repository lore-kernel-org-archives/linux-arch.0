Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:32089 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345AbXLMWoO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 13 Dec 2007 17:44:14 -0500
Received: by rv-out-0910.google.com with SMTP id k20so709890rvb.1
        for <linux-arch@vger.kernel.org>; Thu, 13 Dec 2007 14:44:13 -0800 (PST)
Subject: Re: RFC: remove __read_mostly
From: Harvey Harrison <harvey.harrison@gmail.com>
In-Reply-To: <20071213.143246.175833292.davem@davemloft.net>
References: <20071213222044.GH21616@stusta.de>
	 <20071213.143246.175833292.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 13 Dec 2007 14:44:15 -0800
Message-Id: <1197585855.898.33.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: bunk@kernel.org, linux-kernel@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

On Thu, 2007-12-13 at 14:32 -0800, David Miller wrote:
> From: Adrian Bunk <bunk@kernel.org>
> Date: Thu, 13 Dec 2007 23:20:44 +0100
> 
> > My question is:
> > Is there anywhere in the kernel a case where __read_mostly brings a 
> > measurable improvement or can it be removed?
> 
> Yes, on SMP when read-mostly objects share cache lines
> with other objects which are frequently written to.
> 
> That is the whole reason we created __read_mostly

I'm curious if anyone has been looking into replacing the __read_mostly
approach with Mathieu's immediate values patchset.  Wouldn't they solve
the cacheline sharing as well (perhaps more eficiently even with trading
some icache for dcache)?

Harvey

