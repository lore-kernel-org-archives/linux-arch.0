Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:40145 "EHLO
	resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752449AbbDQMRq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Apr 2015 08:17:46 -0400
Date: Fri, 17 Apr 2015 07:17:42 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
Subject: Re: [RFC PATCH v2 02/11] slab: add private memory allocator header
 for arch/lib
In-Reply-To: <1429263374-57517-3-git-send-email-tazaki@sfc.wide.ad.jp>
Message-ID: <alpine.DEB.2.11.1504170716380.20800@gentwo.org>
References: <1427202642-1716-1-git-send-email-tazaki@sfc.wide.ad.jp> <1429263374-57517-1-git-send-email-tazaki@sfc.wide.ad.jp> <1429263374-57517-3-git-send-email-tazaki@sfc.wide.ad.jp>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hajime Tazaki <tazaki@sfc.wide.ad.jp>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Jekka Enberg <penberg@kernel.org>, Javid Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Jndrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Rusty Russell <rusty@rustcorp.com.au>, Ryo Nakamura <upa@haeena.net>, Christoph Paasch <christoph.paasch@gmail.com>, Mathieu Lacage <mathieu.lacage@gmail.com>, libos-nuse@googlegroups.com
Message-ID: <20150417121742.HOZGiEYQDWIJyL5hMCrJHey3O1ybU9l_sVT50z1CG6o@z>

On Fri, 17 Apr 2015, Hajime Tazaki wrote:

> add header includion for CONFIG_LIB to wrap kmalloc and co. This will
> bring malloc(3) based allocator used by arch/lib.

Maybe add another allocator insteadl? SLLB which implements memory
management using malloc()?
