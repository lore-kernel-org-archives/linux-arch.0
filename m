From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 03/23] lmb: Print new doubled array location info
Date: Thu, 8 Jul 2010 12:55:56 -0600
Message-ID: <201007081255.58049.bjorn.helgaas@hp.com>
References: <1278226587-31213-1-git-send-email-yinghai@kernel.org> <1278226587-31213-4-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:11915 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757276Ab0GHS43 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jul 2010 14:56:29 -0400
In-Reply-To: <1278226587-31213-4-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sunday, July 04, 2010 12:56:07 am Yinghai Lu wrote:
> -		pr_info(" %s[0x%x]\t0x%016llx - 0x%016llx, 0x%llx bytes\n",
> -		    name, i, base, base + size - 1, size);
> +		pr_info(" %s[%#x]\t[%#016llx - %#016llx], %#llx bytes\n",
> +		    name, i, base, base + size, size);

I know you think it's prettier to have zeroes and extra spaces like this:

  [0xe7000000 - 0xe8000000, 0x1000000 bytes]

rather than a bunch of 'F's:

  [0xe7000000-0xe7ffffff]

But for the record, I still think you're wrong and that it's better
to be consistent even if it's slightly uglier.  The inconsistencies
lead to confusion and off-by-one errors.

Bjorn
