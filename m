From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHv1 000/211] unicore32 architecture support
Date: Thu, 09 Dec 2010 15:05:06 +0100
Message-ID: <4D00E212.9080001@kernel.org>
References: <01ca01cb9783$7818c3f0$684a4bd0$@mprc.pku.edu.cn> <4D00A672.9050906@kernel.org> <alpine.LFD.2.00.1012091443580.2653@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59314 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756902Ab0LIOFU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 9 Dec 2010 09:05:20 -0500
In-Reply-To: <alpine.LFD.2.00.1012091443580.2653@localhost6.localdomain6>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/09/2010 02:49 PM, Thomas Gleixner wrote:
>> * Patches should be split according to logical steps of changes, not
>>   per-file.
>>
>> * Patches should be bisectable.  IOW, after applying upto any patch in
>>   the series, the tree should be buildable and working.
> 
> That does not work for a new architecture. There is nothing to bisect.

Sure, but at least it shouldn't introduce build scripts first which
wouldn't work at all.

>> * When posting a patch series, especially one as large as 211, please
>>   make the mails for the actual patches replies to the head message.
>>   Don't post it as 212 separate messages or replies to the immediate
>>   previous patch.
>>
>> So, in short, if you're adding a whole new arch, just post it as a
>> single patch or a series of several patches if it requires changes
>> outside of the specific arch subtree.
> 
> Crap. a single patch is a major PITA for review. It's even worse than
> 211 per file patches.

Cut the crap.  A single patch may not be perfect for reviewing but
archs are often merged as a single giant patch as bisection is
meaningless anyway.

-- 
tejun
