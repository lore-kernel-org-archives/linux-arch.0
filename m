Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37444 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932Ab0CVTeF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2010 15:34:05 -0400
Message-ID: <4BA7C5D3.2040804@kernel.org>
Date: Mon, 22 Mar 2010 12:32:35 -0700
From: Yinghai Lu <yinghai@kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 19/20] x86/pci: ioh new version read all at same time
References: <1269155601-18247-1-git-send-email-yinghai@kernel.org>	<1269155601-18247-20-git-send-email-yinghai@kernel.org> <20100322091620.5aebf353@jbarnes-piketon>
In-Reply-To: <20100322091620.5aebf353@jbarnes-piketon>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20100322193235.de13jfG6-R6-ghvC8_4vakTFqBq7B4B4sZPmoVxwqK8@z>

On 03/22/2010 09:16 AM, Jesse Barnes wrote:
> On Sun, 21 Mar 2010 00:13:20 -0700
> Yinghai Lu <yinghai@kernel.org> wrote:
> 
>> also it will add back default range to legacy IOH
>>
> 
> This patch is a bit short on details.  Are we fixing a real bug here
> that _CRS fails to cover?  Or is it just for debug purposes?
> 

yes for debug purpose. anyway BIOS need to keep them the same.

one from HW register reading, and one from acpi.

Yinghai
