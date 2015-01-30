From: Andrey Ryabinin <a.ryabinin@samsung.com>
Subject: Re: [PATCH v10 15/17] kernel: add support for .init_array.*
 constructors
Date: Fri, 30 Jan 2015 20:21:16 +0300
Message-ID: <54CBBD8C.8080907@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1422544321-24232-1-git-send-email-a.ryabinin@samsung.com>
 <1422544321-24232-16-git-send-email-a.ryabinin@samsung.com>
 <20150129151301.006abdbcf9e0dd136dd6ed2f@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:63065 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468AbbA3RV1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jan 2015 12:21:27 -0500
In-reply-to: <20150129151301.006abdbcf9e0dd136dd6ed2f@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, Konstantin Serebryany <kcc@google.com>, Dmitry Chernenkov <dmitryc@google.com>, Andrey Konovalov <adech.fo@gmail.com>, Yuri Gribov <tetra2005@gmail.com>, Konstantin Khlebnikov <koct9i@gmail.com>, Sasha Levin <sasha.levin@oracle.com>, Christoph Lameter <cl@linux.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Dave Hansen <dave.hansen@intel.com>, Andi Kleen <andi@firstfloor.org>, x86@kernel.org, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, "open list:GENERIC INCLUDE/A..." <linux-arch@vger.kernel.org>

On 01/30/2015 02:13 AM, Andrew Morton wrote:
> On Thu, 29 Jan 2015 18:11:59 +0300 Andrey Ryabinin <a.ryabinin@samsung.com> wrote:
> 
>> KASan uses constructors for initializing redzones for global
>> variables. Actually KASan doesn't need priorities for constructors,
>> so they were removed from GCC 5.0, but GCC 4.9.2 still generates
>> constructors with priorities.
> 
> I don't understand this changelog either.  What's wrong with priorities
> and what is the patch doing about it?  More details, please.
> 

Currently kernel ignore constructors with priorities (e.g. .init_array.00099).
Kernel understand only constructors with default priority ( .init_array ).

This patch adds support for constructors with priorities.

For kernel image we put pointers to constructors between __ctors_start/__ctors_end
and do_ctors() will call them.

For modules  - .init_array.* sections merged into .init_array section.
Module code properly handles constructors in .init_array section.
