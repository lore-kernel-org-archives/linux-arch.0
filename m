From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 4/6v3] byteorder: wire up arches to use new headers
Date: Wed, 28 May 2008 13:21:44 -0700
Message-ID: <1FE6DD409037234FAB833C420AA843EC016FFBC4@orsmsx424.amr.corp.intel.com>
References: <1212003182.5964.29.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29213 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752669AbYE1UWc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 May 2008 16:22:32 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1212003182.5964.29.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>

> diff --git a/include/asm-ia64/byteorder.h b/include/asm-ia64/byteorder.h
>
> -static __inline__ __attribute_const__ __u64
> -__ia64_swab64 (__u64 x)
> +#define __LITTLE_ENDIAN
> +
> +static inline __attribute_const__ __u64 __arch_swab64(__u64 x)

You've changed the name of this routine from __ia64_swab64
to __arch_swab64 here.

...

But down below you still use the old name (twice):

> 	return __ia64_swab64(x) >> 32;

> 	return __ia64_swab64(x) >> 48;

Changing these calls to use the new name gets the build a lot further, but
it still dies for me at:

  CC [M]  fs/cifs/connect.o
In file included from include/linux/ipv6.h:202,
                 from fs/cifs/connect.c:26:
include/linux/tcp.h:72: error: braced-group within expression allowed only inside a function
include/linux/tcp.h:72: error: enumerator value for `TCP_FLAG_CWR' not integer constant
include/linux/tcp.h:73: error: syntax error before '&' token
include/linux/tcp.h:74: error: syntax error before '&' token
include/linux/tcp.h:75: error: syntax error before '&' token
include/linux/tcp.h:76: error: syntax error before '&' token
include/linux/tcp.h:77: error: syntax error before '&' token
include/linux/tcp.h:78: error: syntax error before '&' token
include/linux/tcp.h:79: error: syntax error before '&' token
include/linux/tcp.h:80: error: syntax error before '&' token
include/linux/tcp.h:81: error: syntax error before '&' token
make[2]: *** [fs/cifs/connect.o] Error 1
make[1]: *** [fs/cifs] Error 2


-Tony
