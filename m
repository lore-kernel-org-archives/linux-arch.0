From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 07/31] lmb: Add reserve_lmb/free_lmb
Date: Tue, 30 Mar 2010 16:24:14 +1100
Message-ID: <1269926654.7101.44.camel@pasglop>
References: <1269830604-26214-1-git-send-email-yinghai@kernel.org>
	 <1269830604-26214-8-git-send-email-yinghai@kernel.org>
	 <1269865322.24620.42.camel@concordia>  <4BB0D92C.3010103@kernel.org>
	 <1269901252.2286.11.camel@concordia>  <4BB12BBA.4060108@kernel.org>
	 <1269905664.7101.43.camel@pasglop>  <4BB13D61.3040902@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:45572 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752242Ab0C3F1X (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 30 Mar 2010 01:27:23 -0400
In-Reply-To: <4BB13D61.3040902@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: michael@ellerman.id.au, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, 2010-03-29 at 16:53 -0700, Yinghai Lu wrote:
> 
> ok, can i reuse rmo_size, or introduce one new member in struct lmb.
> 
> default_limit? 

lmb.default_limit sounds good to me.

Cheers,
Ben.
