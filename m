From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v3 44/44] fs: imgdafs: Add IMG DAFS filesystem for metag
Date: Mon, 28 Jan 2013 13:28:18 +0000
Message-ID: <51067CF2.6020200@imgtec.com>
References: <1357831872-29451-1-git-send-email-james.hogan@imgtec.com> <1357831872-29451-45-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:15521 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755982Ab3A1NaD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Jan 2013 08:30:03 -0500
In-Reply-To: <1357831872-29451-45-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: James Hogan <james.hogan@imgtec.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab@redhat.com>, Cesar Eduardo Barros <cesarb@cesarb.net>, Joe Perches <joe@perches.com>, "David S. Miller" <davem@davemloft.net>, linux-fsdevel@vger.kernel.org

Hi Al,

On 10/01/13 15:31, James Hogan wrote:
> Add the IMG Debug Adapter File System (DAFS) for metag, which uses
> SWITCH operations to communicate with a file server on a host computer
> via a JTAG debug adapter.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
> Cc: Cesar Eduardo Barros <cesarb@cesarb.net>
> Cc: Joe Perches <joe@perches.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-fsdevel@vger.kernel.org

If this looks okay please could you Ack it. If it's okay with you I'll
include it in the Meta patchset for v3.9.

Thanks
James
