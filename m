From: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] Make for_each_cpu_mask a bit smaller
Date: Sun, 11 May 2008 09:14:03 -0500
Message-ID: <20080511091403.a75f5b78.pj@sgi.com>
References: <20080511135039.GA3286@mailshack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay2.sgi.com ([192.48.171.30]:47603 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753748AbYEKOOF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 11 May 2008 10:14:05 -0400
In-Reply-To: <20080511135039.GA3286@mailshack.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander van Heukelum <heukelum@mailshack.com>
Cc: akpm@linux-foundation.org, mingo@elte.hu, tglx@linutronix.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, heukelum@fastmail.fm, travis@sgi.com

Alexander wrote:
> This patch
> changes for_each_cpu_mask to use only one function: a newly
> introduced find_next_cpu.

I believe that it's for_each_cpu_mask which is newly introduced,
not find_next_cpu ... just a typo, granted.

Any chance that you could make the same change to nodemask.h?
Where practical, I like to keep cpumask.h and nodemask.h the same.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.940.382.4214
