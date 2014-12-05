From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/9] kernel: Provide READ_ONCE and ASSIGN_ONCE
Date: Fri, 05 Dec 2014 10:19:30 +0100
Message-ID: <548178A2.9050409@de.ibm.com>
References: <20141205021217.5337.qmail@ns.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141205021217.5337.qmail@ns.horizon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: George Spelvin <linux@horizon.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

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
