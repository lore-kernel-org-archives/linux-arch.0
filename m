From: Richard Weinberger <richard@nod.at>
Subject: Re: [RFC PATCH v2 02/11] slab: add private memory allocator header
 for arch/lib
Date: Fri, 17 Apr 2015 14:44:35 +0200
Message-ID: <55310033.1060108@nod.at>
References: <1427202642-1716-1-git-send-email-tazaki@sfc.wide.ad.jp> <1429263374-57517-1-git-send-email-tazaki@sfc.wide.ad.jp> <1429263374-57517-3-git-send-email-tazaki@sfc.wide.ad.jp> <alpine.DEB.2.11.1504170716380.20800@gentwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:65277 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753127AbbDQMoq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Apr 2015 08:44:46 -0400
In-Reply-To: <alpine.DEB.2.11.1504170716380.20800@gentwo.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux.com>, Hajime Tazaki <tazaki@sfc.wide.ad.jp>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Jekka Enberg <penberg@kernel.org>, Javid Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Jndrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org, Jeff Dike <jdike@addtoit.com>, Rusty Russell <rusty@rustcorp.com.au>, Ryo Nakamura <upa@haeena.net>, Christoph Paasch <christoph.paasch@gmail.com>, Mathieu Lacage <mathieu.lacage@gmail.com>, libos-nuse@googlegroups.com

Am 17.04.2015 um 14:17 schrieb Christoph Lameter:
> On Fri, 17 Apr 2015, Hajime Tazaki wrote:
> 
>> add header includion for CONFIG_LIB to wrap kmalloc and co. This will
>> bring malloc(3) based allocator used by arch/lib.
> 
> Maybe add another allocator insteadl? SLLB which implements memory
> management using malloc()?

Yeah, that's a good idea.

Hajime, another question, do you really want a malloc/free backend?
I'm not a mm expert, but does malloc() behave exactly as the kernel
counter parts?

In UML we allocate a big file on the host side, mmap() it and give this mapping
to the kernel as physical memory such that any kernel allocator can work with it.

Thanks,
//richard
