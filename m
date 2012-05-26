From: David Miller <davem@davemloft.net>
Subject: Re: Mostly portable strnlen_user()
Date: Sat, 26 May 2012 01:59:18 -0400 (EDT)
Message-ID: <20120526.015918.1684150862174101826.davem@davemloft.net>
References: <CA+55aFxukJSo7srOcfedqCSz1wiZhjz4=F8Tj96=uOqWxYqq+A@mail.gmail.com>
	<20120526.004459.1494543364832806830.davem@davemloft.net>
	<CA+55aFxLLDuUK+Pde_F=gweYgyLzJQLrgU-2iZAo+FbXus+Njw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:55657 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab2EZF7W (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 26 May 2012 01:59:22 -0400
In-Reply-To: <CA+55aFxLLDuUK+Pde_F=gweYgyLzJQLrgU-2iZAo+FbXus+Njw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-arch@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 May 2012 22:06:31 -0700

>> diff --git a/arch/sparc/include/asm/word-at-a-time.h b/arch/sparc/include/asm/word-at-a-time.h
>> new file mode 100644
>> index 0000000..b522cc3
>> --- /dev/null
>> +++ b/arch/sparc/include/asm/word-at-a-time.h
>> @@ -0,0 +1 @@
>> +#include <asm-generic/word-at-a-time.h>
> 
> This part *should* be unnecessary, I already did the
> 
>    generic-y += word-at-a-time.h
> 
> in arch/sparc/include/asm/Kbuild. Can you verify? Or did something go wrong?

Aha, I see, yes it does work without adding the sparc header.
