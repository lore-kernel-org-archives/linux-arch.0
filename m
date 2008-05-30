From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Fri, 30 May 2008 08:01:02 +0200
Message-ID: <483F981E.3040004@cosmosbay.com>
References: <20080530035620.587204923@sgi.com>	<20080529215827.b659d032.akpm@linux-foundation.org>	<Pine.LNX.4.64.0805292159360.12107@schroedinger.engr.sgi.com> <20080529222143.5d7aa1e5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2f.orange.fr ([80.12.242.151]:3023 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753998AbYE3K2A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 06:28:00 -0400
In-Reply-To: <20080529222143.5d7aa1e5.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <clameter@sgi.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Mike Travis <travis@sgi.com>

Andrew Morton a =E9crit :
>
> It was just an example.  There will be others.
>
> 	tcp_v4_md5_do_add
> 	->tcp_alloc_md5sig_pool
> 	  ->__tcp_alloc_md5sig_pool
>
> does an alloc_percpu for each md5-capable TCP connection.  I think - =
it
> doesn't matter really, because something _could_.  And if something
> _does_, we're screwed.
>  =20
Last time I took a look on this stuff, this was a percpu allocation for=
=20
all connections, not for each TCP session.
(It should be static, instead of dynamic )

Really, percpu allocations are currently not frequent at all.

vmalloc()/vfreee() are way more frequent and still use a list.
