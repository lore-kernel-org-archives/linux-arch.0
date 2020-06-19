Return-Path: <SRS0=lJ0G=AA=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from a3.inai.de ([88.198.85.195]:37880 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732386AbgFSK2Z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Jun 2020 06:28:25 -0400
Date: Fri, 19 Jun 2020 12:28:08 +0200 (CEST)
From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: [PATCH] linux++, this: rename "struct notifier_block *this"
In-Reply-To: <20200619074631.GA1427@infradead.org>
Message-ID: <nycvar.YFH.7.77.849.2006191217280.9730@n3.vanv.qr>
References: <20200618210645.GB2212102@localhost.localdomain> <20200619074631.GA1427@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-arch@vger.kernel.org, netfilter-devel@vger.kernel.org
Message-ID: <20200619102808.WhsXfmAvpKPjetmltiWilq3wHeC3XZa3LWB18LceNRc@z>

On Friday 2020-06-19 09:46, Christoph Hellwig wrote:

>On Fri, Jun 19, 2020 at 12:06:45AM +0300, Alexey Dobriyan wrote:
>> Rename
>> 	struct notifier_block *this
>> to
>> 	struct notifier_block *nb
>> 
>> "nb" is arguably a better name for notifier block.
>
>But not enough better to cause tons of pointless churn.  Feel free
>to use better naming in new code you write or do significant changes
>to, but stop these pointless renames.

Well, judging from the mention of "linux++" in the subject, I figure 
this is the old discussion of someone trying to make Linux code, or 
parts thereof, work in a C++ environment. Since the patch does not just 
touch headers but .c files, I deduce that there seems to be a project 
trying to build Linux, or a subset thereof, as a C++ program for the fun 
of it. UML could come to mind.

Is it a hot potato? Definitely. But so was IPv6 NAT, and now we have it 
anyway.
