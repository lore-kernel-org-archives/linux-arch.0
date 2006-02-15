Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:43153 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422902AbWBOHDB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Feb 2006 02:03:01 -0500
Message-ID: <43F2C7B6.3020102@yahoo.com.au>
Date: Wed, 15 Feb 2006 17:18:30 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: [Fwd: Re: [PATCH] madvise MADV_DONTFORK/MADV_DOFORK]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Hugh Dickins <hugh@veritas.com>
List-ID: <linux-arch.vger.kernel.org>

Forwarding to linux-arch. Please pipe up on lkml, or send patches
to fix your arch (either way, before 2.6.16!!) if you disagree.

To me it would be more logical if the numbering was made densely
packed on all architectures even if that means MADV_DONTFORK /
DOFORK aren't consistently numbered throughout (why should they
get special treatment?).

Nick

-------- Original Message --------
Subject: Re: [PATCH] madvise MADV_DONTFORK/MADV_DOFORK
Date: Tue, 14 Feb 2006 22:09:34 -0800
From: Roland Dreier <rdreier@cisco.com>

     Nick> May I ask, what is the rationale for ignoring the apparent
     Nick> conventions of all architectures? For example parisc, you
     Nick> appear to even go contrary to the comment.

Looking through include/asm-*/mman.h, I have to agree.  The parisc
example seemly especially bad, as (in addition to being in the
reserved range as Nick notes) the DONTFORK/DOFORK values are stuck in
a block with the page size values instead of the previous block where
they seem more sensible.  However, in other files like the alpha
version, where the rest of the values are in decimal, the hex defines
look rather jarring.

Michael, what led you to choose 0x30 and 0x31 for the two new values?
It does seem that keeping them uniform across architectures is a
reasonable thing to do, but as far as I can tell the values 9 and 10
are unused on all architectures, and have the added merit of not
falling in the parisc reserved range.

Do we still have a chance to change this?

  - R.

-- 
Send instant messages to your online friends http://au.messenger.yahoo.com 
