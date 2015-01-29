Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:59168 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759214AbbA2XND (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jan 2015 18:13:03 -0500
Date: Thu, 29 Jan 2015 15:13:01 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 15/17] kernel: add support for .init_array.*
 constructors
Message-ID: <20150129151301.006abdbcf9e0dd136dd6ed2f@linux-foundation.org>
In-Reply-To: <1422544321-24232-16-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
	<1422544321-24232-1-git-send-email-a.ryabinin@samsung.com>
	<1422544321-24232-16-git-send-email-a.ryabinin@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrey Ryabinin <a.ryabinin@samsung.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, Konstantin Serebryany <kcc@google.com>, Dmitry Chernenkov <dmitryc@google.com>, Andrey Konovalov <adech.fo@gmail.com>, Yuri Gribov <tetra2005@gmail.com>, Konstantin Khlebnikov <koct9i@gmail.com>, Sasha Levin <sasha.levin@oracle.com>, Christoph Lameter <cl@linux.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Dave Hansen <dave.hansen@intel.com>, Andi Kleen <andi@firstfloor.org>, x86@kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, "open list:GENERIC INCLUDE/A..." <linux-arch@vger.kernel.org>
Message-ID: <20150129231301.8KSx_W0pbLv-QlHAnXxR52qKSxqQUuWWtt8OOFwRv2U@z>

On Thu, 29 Jan 2015 18:11:59 +0300 Andrey Ryabinin <a.ryabinin@samsung.com> wrote:

> KASan uses constructors for initializing redzones for global
> variables. Actually KASan doesn't need priorities for constructors,
> so they were removed from GCC 5.0, but GCC 4.9.2 still generates
> constructors with priorities.

I don't understand this changelog either.  What's wrong with priorities
and what is the patch doing about it?  More details, please.


