Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fallback-mx.in-berlin.de ([192.109.42.17]:55388 "EHLO
	hirscho.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423385AbXD3XKF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Apr 2007 19:10:05 -0400
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	by fallback-mx.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id l3UMP7vl009422
	for <linux-arch@vger.kernel.org>; Tue, 1 May 2007 00:25:07 +0200
Message-ID: <46366B36.70906@s5r6.in-berlin.de>
Date: Tue, 01 May 2007 00:18:30 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
Subject: Re: condingstyle, was Re: utrace comments
References: <20061127165138.GA2991@lst.de>	 <20070430040213.BF9901801A4@magilla.sf.frob.com>	 <20070430091121.GC31397@infradead.org>	 <20070430100917.439ebfc8.akpm@linux-foundation.org> <a781481a0704301142sfec317cu8213750c9ab84416@mail.gmail.com>
In-Reply-To: <a781481a0704301142sfec317cu8213750c9ab84416@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Satyam Sharma <satyam.sharma@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Roland McGrath <roland@redhat.com>, Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Satyam Sharma wrote:
[...]
> The rationale is to make the operator prominent and thus make
> the structure of a complex multi-line compound conditional expression more
> readable and obvious at first glance itself. For example, consider:
> 
>     if (veryverylengthycondition1 &&
>         smallcond2 &&
>         (conditionnumber3a ||
>         condition3b)) {
>         ...
>     }
> 
> versus
> 
>     if (veryverylengthycondition1
>         && smallcond2
>         && (conditionnumber3a
>             || condition3b)) {
>         ...
>     }
> 
> ?
> 
> Latter wins, doesn't it?

I find the latter more sensible too, even though I used the former
myself until recently (because I didn't knew better).
-- 
Stefan Richter
-=====-=-=== -=-= ----=
http://arcgraph.de/sr/
