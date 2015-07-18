Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37884 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbbGRTLy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 18 Jul 2015 15:11:54 -0400
MIME-Version: 1.0
In-Reply-To: <1436288623-13007-5-git-send-email-emunson@akamai.com>
References: <1436288623-13007-1-git-send-email-emunson@akamai.com> <1436288623-13007-5-git-send-email-emunson@akamai.com>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Sat, 18 Jul 2015 15:11:23 -0400
Message-ID: <CAP=VYLq5=9DCfncJpQizcSbQt1O7VL2yEdzZNOFK+M3pqLpb3Q@mail.gmail.com>
Subject: Re: [PATCH V3 4/5] mm: mmap: Add mmap flag to request VM_LOCKONFAULT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@akamai.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.cz>, Vlastimil Babka <vbabka@suse.cz>, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, linux-arch <linux-arch@vger.kernel.org>, linux-api@vger.kernel.org, cmetcalf@ezchip.com, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Message-ID: <20150718191123.R4D8QBxzLWj_L6pH-SSrenl3wW29hjcGr9LxHnu44-0@z>

On Tue, Jul 7, 2015 at 1:03 PM, Eric B Munson <emunson@akamai.com> wrote:
> The cost of faulting in all memory to be locked can be very high when
> working with large mappings.  If only portions of the mapping will be
> used this can incur a high penalty for locking.
>
> Now that we have the new VMA flag for the locked but not present state,
> expose it  as an mmap option like MAP_LOCKED -> VM_LOCKED.

An automatic bisection on arch/tile leads to this commit:

5a5656f2c9b61c74c15f9ef3fa2e6513b6c237bb is the first bad commit
commit 5a5656f2c9b61c74c15f9ef3fa2e6513b6c237bb
Author: Eric B Munson <emunson@akamai.com>
Date:   Thu Jul 16 10:09:22 2015 +1000

    mm: mmap: add mmap flag to request VM_LOCKONFAULT

Fails with:

In file included from arch/tile/mm/init.c:24:
include/linux/mman.h: In function ‘calc_vm_flag_bits’:
include/linux/mman.h:90: error: ‘MAP_LOCKONFAULT’ undeclared (first
use in this function)
include/linux/mman.h:90: error: (Each undeclared identifier is
reported only once
include/linux/mman.h:90: error: for each function it appears in.)
In file included from arch/tile/mm/mmap.c:21:
include/linux/mman.h: In function ‘calc_vm_flag_bits’:
include/linux/mman.h:90: error: ‘MAP_LOCKONFAULT’ undeclared (first
use in this function)
include/linux/mman.h:90: error: (Each undeclared identifier is
reported only once
include/linux/mman.h:90: error: for each function it appears in.)
In file included from arch/tile/mm/fault.c:24:
include/linux/mman.h: In function ‘calc_vm_flag_bits’:
include/linux/mman.h:90: error: ‘MAP_LOCKONFAULT’ undeclared (first
use in this function)
include/linux/mman.h:90: error: (Each undeclared identifier is
reported only once
include/linux/mman.h:90: error: for each function it appears in.)
In file included from arch/tile/mm/hugetlbpage.c:27:
include/linux/mman.h: In function ‘calc_vm_flag_bits’:
include/linux/mman.h:90: error: ‘MAP_LOCKONFAULT’ undeclared (first
use in this function)
include/linux/mman.h:90: error: (Each undeclared identifier is
reported only once
include/linux/mman.h:90: error: for each function it appears in.)
make[1]: *** [arch/tile/mm/hugetlbpage.o] Error 1

http://kisskb.ellerman.id.au/kisskb/buildresult/12465365/

Paul.
--
