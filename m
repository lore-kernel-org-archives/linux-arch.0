From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 01/44] arc: Use get_signal() signal_setup_done()
Date: Sat, 22 Mar 2014 12:33:59 +0530
Message-ID: <532D35DF.5020203@synopsys.com>
References: <1393804559-7701-1-git-send-email-richard@nod.at> <1393804559-7701-2-git-send-email-richard@nod.at> <C2D7FE5348E1B147BCA15975FBA2307517FC80@IN01WEMBXA.internal.synopsys.com> <531445A7.1090001@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:37550 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbaCVHEM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 22 Mar 2014 03:04:12 -0400
In-Reply-To: <531445A7.1090001@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

Hi Richard,

On Monday 03 March 2014 02:34 PM, Richard Weinberger wrote:
>> Minor comment below, otherwise 
>> > 
>> > Acked-by: Vineet Gupta <vgupta@synopsys.com>
>> > 
>> > P.S. Since this depends on translate_sig change, I can't possibly take it via ARC
>> > tree.
> I hope we can merge this via Al's signal.git tree.

I don't see the series in linux-next yet so they will they not likely make it into
3.15. correct ?

-Vineet
