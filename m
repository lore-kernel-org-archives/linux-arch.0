From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC][PATCH 0/3] gcc work-around and math128
Date: Tue, 24 Apr 2012 10:22:28 -0700
Message-ID: <4F96E154.2060100@zytor.com>
References: <20120424161039.293018424@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:35932 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756668Ab2DXRWj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 Apr 2012 13:22:39 -0400
In-Reply-To: <20120424161039.293018424@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@gmail.com>

On 04/24/2012 09:10 AM, Peter Zijlstra wrote:
> 
> So far its just mult, add and cmp for u128, no divisions quite yet. I realize
> that on 32bit archs mult_u128 will result in like 8 multiplication
> instructions that's still nowhere near the most expensive thing ever.
> 

Please add shifts, at the very least.

	-hpa
