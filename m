From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 00/76] Synopsys ARC Linux kernel Port
Date: Sat, 19 Jan 2013 22:15:13 -0800
Message-ID: <50FB8B71.6050207@zytor.com>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:38920 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793Ab3ATGPX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 20 Jan 2013 01:15:23 -0500
In-Reply-To: <1358511930-7424-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de

On 01/18/2013 04:24 AM, Vineet Gupta wrote:
> This patchset based off-of 3.8-rc4, adds the Linux kernel port to ARC700
> processor family (750D and 770D) from Synopsys. I would be greatful for
> further review and feedback.

One thing: ARC, as I understand it, is a whole family of architectures, 
which mostly have in common their origin at Synopsys.  Can we make this 
arch/arc700 since that is what it is?

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
