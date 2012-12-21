From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 2/2] ARC: provide optimal __get_user_fn()
Date: Fri, 21 Dec 2012 10:03:43 +0530
Message-ID: <50D3E6A7.4050803@synopsys.com>
References: <1353422297-29079-1-git-send-email-vgupta@synopsys.com> <1353422297-29079-3-git-send-email-vgupta@synopsys.com> <201211201551.43791.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hermes.synopsys.com ([198.182.44.81]:34147 "EHLO
	hermes.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab2LUEeU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Dec 2012 23:34:20 -0500
In-Reply-To: <201211201551.43791.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 20 November 2012 09:21 PM, Arnd Bergmann wrote:
> On Tuesday 20 November 2012, Vineet.Gupta1@synopsys.com wrote:
>> From: Vineet Gupta <vgupta@synopsys.com>
>>
>> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> 
> Yes, this looks good to me.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 

Can you please also ACK the asm-generic bits of this series [PATCH 1/2]

Thx,
-Vineet
