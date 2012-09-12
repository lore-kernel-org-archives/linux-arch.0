From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH 3/3] mm: Introduce HAVE_ARCH_TRANSPARENT_HUGEPAGE
Date: Wed, 12 Sep 2012 14:06:43 -0400
Message-ID: <5050CF33.4000909@tilera.com>
References: <1347382036-18455-1-git-send-email-will.deacon@arm.com> <1347382036-18455-4-git-send-email-will.deacon@arm.com> <20120912153206.GT21579@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:39016 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761020Ab2ILSGo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 12 Sep 2012 14:06:44 -0400
In-Reply-To: <20120912153206.GT21579@dhcp22.suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@suse.cz>
Cc: Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, Steve Capper <steve.capper@arm.com>

On 9/12/2012 11:32 AM, Michal Hocko wrote:
> Makes sense if there are going to be more archs to support THP.

The tile architecture currently supports it in our in-house tree,
though we haven't returned it to the community yet.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
