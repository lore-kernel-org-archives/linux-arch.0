Return-Path: <manfred@colorfullife.com>
Received: from dbl.q-ag.de ([213.172.117.3]:7315 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S270059AbUERFE0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 18 May 2004 01:04:26 -0400
Message-ID: <40A99944.8030500@colorfullife.com>
Date: Tue, 18 May 2004 07:04:04 +0200
From: Manfred Spraul <manfred@colorfullife.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Allow arch override for kmem_bufctl_t
References: <40A60984.1070202@colorfullife.com> <20040517141635.55101363.davem@redhat.com> <20040517212528.GY6484@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040517212528.GY6484@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@debian.org>
Cc: "David S. Miller" <davem@redhat.com>, akpm@digeo.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Matthew Wilcox wrote:

>On Mon, May 17, 2004 at 02:16:35PM -0700, David S. Miller wrote:
>  
>
>>Just out of curiosity, which arch knowingly has the problem?
>>    
>>
>
>I think it's ARM ...
>
>  
>
I thought it was sparc and perhaps alpha, but I was wrong: it was a 
general comment from Mark Hemment (May 2000):

> Making s_free a short will really hurt performance.  So to does short 
> bufctls.  Don't worry too much about wasting a little memory (internal 
> fragmentation) for performance.  "shorts" are a performance hit (more 
> so on some architectures - Pentium Pros and definetly on true RISC).


--
    Manfred
