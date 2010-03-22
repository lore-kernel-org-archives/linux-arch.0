From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 19/20] x86/pci: ioh new version read all at same time
Date: Mon, 22 Mar 2010 09:16:20 -0700
Message-ID: <20100322091620.5aebf353@jbarnes-piketon>
References: <1269155601-18247-1-git-send-email-yinghai@kernel.org>
	<1269155601-18247-20-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from outbound-mail-01.bluehost.com ([69.89.21.11]:46799 "HELO
	outbound-mail-01.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754970Ab0CVQQX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2010 12:16:23 -0400
In-Reply-To: <1269155601-18247-20-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>

On Sun, 21 Mar 2010 00:13:20 -0700
Yinghai Lu <yinghai@kernel.org> wrote:

> also it will add back default range to legacy IOH
> 

This patch is a bit short on details.  Are we fixing a real bug here
that _CRS fails to cover?  Or is it just for debug purposes?

-- 
Jesse Barnes, Intel Open Source Technology Center
