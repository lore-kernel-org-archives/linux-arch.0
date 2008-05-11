From: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] Make for_each_cpu_mask a bit smaller
Date: Sun, 11 May 2008 08:57:57 -0500
Message-ID: <20080511085757.b68c1a48.pj@sgi.com>
References: <20080511135039.GA3286@mailshack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay2.sgi.com ([192.48.171.30]:37689 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751938AbYEKN56 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 11 May 2008 09:57:58 -0400
In-Reply-To: <20080511135039.GA3286@mailshack.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander van Heukelum <heukelum@mailshack.com>
Cc: akpm@linux-foundation.org, mingo@elte.hu, tglx@linutronix.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, heukelum@fastmail.fm, travis@sgi.com

Alexander wrote:
> Each use of the for_each_cpu_mask
> constuct then becomes a few bytes smaller. 

Looks good, at first glance.

Could you include Mike Travis <travis@sgi.com> on
the CC list for this work?  He's been having
fun lately with cpumasks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.940.382.4214
