From: Marc Gauthier <marc@tensilica.com>
Subject: RE: [PATCH 20/21] xtensa: Use generic posix_types.h
Date: Thu, 16 Feb 2012 09:45:28 -0800
Message-ID: <522C1DF17AF50042AD8AE87F7887BD3D0217D187A2@exch.hq.tensilica.com>
References: <1328677745-20121-21-git-send-email-hpa@zytor.com>
 <1328677745-20121-1-git-send-email-hpa@zytor.com>
 <3289.1329399779@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailgw.tensilica.com ([65.119.96.134]:50631 "EHLO
	mailgw.tensilica.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab2BPSHC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Feb 2012 13:07:02 -0500
In-Reply-To: <3289.1329399779@redhat.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Chris Zankel <chris@zankel.net>

David Howells wrote:
> Xtensa exports __FD_SET() and co. to userspace under some
> circumstances,
> therefore this patch potentially breaks the userspace ABI.

Thanks for noticing.
Looks like that happens for non GNU C compilers only.
Which doesn't make sense as the only non-GNU compiler we use
does have a GNU compatible front-end, and I don't see any
reason why this particular header would do something differently.

I suspect we simply copied this from another architecture.

(Note that the relevant C libraries have compatible definitions,
so I don't think userspace breaks in any case.)

So the patch looks like the right thing to do.
We'll find out soon enough, but I'd say go ahead with the patch.

Thanks,
-Marc

Acked-by:  Marc Gauthier <marc@tensilica.com>



> David
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
