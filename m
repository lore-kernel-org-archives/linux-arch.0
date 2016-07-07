Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outbound-smtp03.blacknight.com ([81.17.249.16]:57236 "EHLO
	outbound-smtp03.blacknight.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750990AbcGGOrY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jul 2016 10:47:24 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
	by outbound-smtp03.blacknight.com (Postfix) with ESMTPS id 2C56F2F809E
	for <linux-arch@vger.kernel.org>; Thu,  7 Jul 2016 14:47:23 +0000 (UTC)
Date: Thu, 7 Jul 2016 15:47:21 +0100
From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH 0/9] [REVIEW-REQUEST] [v4] System Calls for Memory
 Protection Keys
Message-ID: <20160707144721.GA11498@techsingularity.net>
References: <20160707124719.3F04C882@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20160707124719.3F04C882@viggo.jf.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave@sr71.net>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, arnd@arndb.de, hughd@google.com, viro@zeniv.linux.org.uk
Message-ID: <20160707144721.dh9qJfanR68Lm3uQA6XSss4RwH_WhYWA605FyUACkKw@z>

On Thu, Jul 07, 2016 at 05:47:19AM -0700, Dave Hansen wrote:
> I'm resending these because Ingo has said that he'd "love to have
> some high level MM review & ack for these syscall ABI extensions."
> The only changes to the code in months have been in the selftests.
> So, if anyone has been putting off taking a look at these, I'd
> appreciate a look now.
> 

I took a look at the patches other than the self-tests and the
documentation. I did not see any major problems other than thinking
there is a lot of ways for userspace to shoot itself in the foot and
lose the protection pkeys is meant to give.

That said, consider the review to be unreliable on the grounds I haven't
followed pkeys development and this is my first time looking in its
general direction.

-- 
Mel Gorman
SUSE Labs
