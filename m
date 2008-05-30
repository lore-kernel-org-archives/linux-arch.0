From: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 11/37] infiniband: use get/put_endian helpers
Date: Thu, 29 May 2008 22:52:11 -0700
Message-ID: <ada1w3knxtg.fsf@cisco.com>
References: <1212092297.28403.113.camel@brick> <adak5hcoir4.fsf@cisco.com>
	<1212099859.28403.149.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sj-iport-3.cisco.com ([171.71.176.72]:27744 "EHLO
	sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164AbYE3FwM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 01:52:12 -0400
In-Reply-To: <1212099859.28403.149.camel@brick> (Harvey Harrison's message of
	"Thu, 29 May 2008 15:24:19 -0700")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Roland Dreier <rolandd@cisco.com>

 > Well, assuming it's wanted, I can send you a sed-based patch instead and
 > a follow-on patch that does the additional codingstyle bits on the
 > changed lines that adds up to this patch.

If you generated the patch with sed + careful codingstyle fixup, that's
OK, no need to resend.

I think the big question is whether this change is worth it -- my
immediate reaction is that it is just churn, but I am only seeing one of
the 37 (?!) patches in the series so maybe there is some merit that I am
unaware of.  Anyway I am happy with whatever Andrew decides based on his
view of the big picture.

 - R.
