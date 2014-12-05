Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112]:41300 "EHLO
	e06smtp16.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbaLEJTq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Dec 2014 04:19:46 -0500
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Fri, 5 Dec 2014 09:19:44 -0000
Message-ID: <548178A2.9050409@de.ibm.com>
Date: Fri, 05 Dec 2014 10:19:30 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/9] kernel: Provide READ_ONCE and ASSIGN_ONCE
References: <20141205021217.5337.qmail@ns.horizon.com>
In-Reply-To: <20141205021217.5337.qmail@ns.horizon.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: George Spelvin <linux@horizon.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org
Message-ID: <20141205091930.156_IWSSYr90ystN3nveLM_pK5lmNuCqiAR60CzlBuo@z>

Am 05.12.2014 um 03:12 schrieb George Spelvin:
>> +#define READ_ONCE(p) \
>> +	 typeof(p) __val; __read_once_size(&p, &__val, sizeof(__val)); __val; })
>> +
>> +#define ASSIGN_ONCE(val, p) \
>> +	({ typeof(p) __val; __val = val; __assign_once_size(&p, &__val, sizeof(__val)); __val; })
> 
> Minor style nit: is it necessary to name a non-pointer variable "p"?
> I expect typeof(p) to be a pointer type.

v might be better.
> 
> (The other fun style question, which is a lot less minor, is whether
> ASSIGN_ONCE should be (src,dst) as above, or (dst,src) like = and
> <string.h>.)

I tend to prefer dst, src, but Linus used src, dst in his proposal - so I used that.



