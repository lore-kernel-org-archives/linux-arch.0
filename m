From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 06/20] early_res: seperate common memmap func from e820.c
 to fw_memmap.c
Date: Sun, 21 Mar 2010 21:28:38 -0700
Message-ID: <4BA6F1F6.3070102@kernel.org>
References: <1269155601-18247-7-git-send-email-yinghai@kernel.org>	<1269225435.8599.70.camel@pasglop>	<4BA6EA62.1030603@kernel.org> <20100321.210023.209981130.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55119 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877Ab0CVEcL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2010 00:32:11 -0400
In-Reply-To: <20100321.210023.209981130.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: benh@kernel.crashing.org, mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com, akpm@linux-foundation.org, jbarnes@virtuousgeek.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

> 
> That action means you absolutely don't value our feedback at all.

[PATCH 01/20] x86: add find_e820_area_node
is addressing your concern that early_res didn't handle memory cross the nodes problem.

YH
