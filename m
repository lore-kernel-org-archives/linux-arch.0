From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHSET] percpu: generalize first chunk allocators and improve
 lpage NUMA support
Date: Sat, 04 Jul 2009 08:14:21 +0900
Message-ID: <4A4E90CD.6070905@kernel.org>
References: <1245850216-31653-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44714 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752434AbZGCXPC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 3 Jul 2009 19:15:02 -0400
In-Reply-To: <1245850216-31653-1-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, andi@firstfloor.org, hpa@zytor.com, tglx@linutronix.de, cl@linux-foundation.org, akpm@linux-fo

Tejun Heo wrote:
> Hello,
> 
> This patchset is combination of the following two patchsets.
> 
> [1] x86,percpu: generalize 4k and lpage allocator
> [2] percpu: teach lpage allocator about NUMA

Alpha changes from linus#master pulled into #for-next and this
patchset has been published in #for-next on top of that.

Thanks.

-- 
tejun
