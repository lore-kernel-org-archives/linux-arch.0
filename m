From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Fix generic hugetlb pte check return type.
Date: Wed, 02 Oct 2013 19:59:27 -0400 (EDT)
Message-ID: <20131002.195927.381972750426724578.davem@davemloft.net>
References: <20131002.142509.1450460988268165850.davem@davemloft.net>
	<alpine.DEB.2.02.1310021531030.18461@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:51732 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034Ab3JBX72 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 2 Oct 2013 19:59:28 -0400
In-Reply-To: <alpine.DEB.2.02.1310021531030.18461@chino.kir.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rientjes@google.com
Cc: sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

From: David Rientjes <rientjes@google.com>
Date: Wed, 2 Oct 2013 15:34:48 -0700 (PDT)

> On Wed, 2 Oct 2013, David Miller wrote:
> 
> Acked-by: David Rientjes <rientjes@google.com>
> 
>> ---
>> 
>> Anyone mind if I push this through the sparc tree?
>> 
> 
> Makes sense since it's the only arch that appears affected.

Ok, thanks for reviewing.
