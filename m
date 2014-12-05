From: "George Spelvin" <linux@horizon.com>
Subject: Re: [PATCH 1/9] kernel: Provide READ_ONCE and ASSIGN_ONCE
Date: 4 Dec 2014 21:12:17 -0500
Message-ID: <20141205021217.5337.qmail@ns.horizon.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ns.horizon.com ([71.41.210.147]:29505 "HELO ns.horizon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932378AbaLECS6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 4 Dec 2014 21:18:58 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: linux@horizon.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org

> +#define READ_ONCE(p) \
> +	 typeof(p) __val; __read_once_size(&p, &__val, sizeof(__val)); __val; })
> +
> +#define ASSIGN_ONCE(val, p) \
> +	({ typeof(p) __val; __val = val; __assign_once_size(&p, &__val, sizeof(__val)); __val; })

Minor style nit: is it necessary to name a non-pointer variable "p"?
I expect typeof(p) to be a pointer type.

(The other fun style question, which is a lot less minor, is whether
ASSIGN_ONCE should be (src,dst) as above, or (dst,src) like = and
<string.h>.)
