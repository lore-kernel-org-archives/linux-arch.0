Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:50638
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932421AbXLMWcs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 13 Dec 2007 17:32:48 -0500
Date: Thu, 13 Dec 2007 14:32:46 -0800 (PST)
Message-Id: <20071213.143246.175833292.davem@davemloft.net>
Subject: Re: RFC: remove __read_mostly
From: David Miller <davem@davemloft.net>
In-Reply-To: <20071213222044.GH21616@stusta.de>
References: <20071213222044.GH21616@stusta.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: bunk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 13 Dec 2007 23:20:44 +0100

> My question is:
> Is there anywhere in the kernel a case where __read_mostly brings a 
> measurable improvement or can it be removed?

Yes, on SMP when read-mostly objects share cache lines
with other objects which are frequently written to.

That is the whole reason we created __read_mostly
