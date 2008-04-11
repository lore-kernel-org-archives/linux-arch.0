Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:55124 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbYDLHKe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 12 Apr 2008 03:10:34 -0400
Received: by ug-out-1314.google.com with SMTP id z38so56038ugc.16
        for <linux-arch@vger.kernel.org>; Sat, 12 Apr 2008 00:10:32 -0700 (PDT)
Date: Sat, 12 Apr 2008 00:22:38 +0400
From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [PATCH 1/2] kernel: add common infrastructure for unaligned
	access
Message-ID: <20080411202238.GB9108@cvg>
References: <1207885137.22001.86.camel@brick>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1207885137.22001.86.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20080411202238.tUHa21YxZgscLlWv8smufPw2vMsHIrx3L8hRrw1wook@z>

[Harvey Harrison - Thu, Apr 10, 2008 at 08:38:57PM -0700]
[...]
| +
| +static inline void __put_unaligned_be16(u16 val, u8 *p)
| +{
| +	*p++ = val >> 8;
| +	*p++ = val;
| +}
| +
[...]
| +static inline void __put_unaligned_le16(u16 val, u8 *p)
| +{
| +	*p++ = val;
| +	*p++ = val >> 8;
| +}
[...]

Hi Harvey, do we really need second increments? I mean, wouldn't
be better to use *p = val >> 8 and *p << 8?

		- Cyrill -
