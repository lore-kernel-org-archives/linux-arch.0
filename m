From: "H. Peter Anvin" <hpa@kernel.org>
Subject: Re: [PATCH RFC 1/5] scripts: Add sortextable to sort the kernel's
 exception table.
Date: Sun, 20 Nov 2011 15:27:49 -0800
Message-ID: <4EC98CF5.3070500@kernel.org>
References: <1321645068-20475-1-git-send-email-ddaney.cavm@gmail.com> <1321645068-20475-2-git-send-email-ddaney.cavm@gmail.com> <4EC98C97.50604@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:43019 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754199Ab1KTX2A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 20 Nov 2011 18:28:00 -0500
In-Reply-To: <4EC98C97.50604@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, x86@kernel.org, David Daney <david.daney@cavium.com>

On 11/20/2011 03:26 PM, H. Peter Anvin wrote:
> On 11/18/2011 11:37 AM, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> Using this build-time sort saves time booting as we don't have to burn
>> cycles sorting the exception table.
>>
> 
> If we're going to do this at build time, I would suggest using a
> collisionless hash instead.  The lookup time for those are O(1), but
> they definitely need to be done at build time.
> 

I have some code for generating these kinds of tables, they just need to
be hooked up.  I will dig it up later today or tomorrow.

	-hpa
