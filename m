From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 0/3] mm/mmap.c: don't unmap the overlapping VMA(s)
Date: Mon, 4 Apr 2016 17:26:43 +0200
Message-ID: <570287B3.6050903@suse.cz>
References: <1459624654-7955-1-git-send-email-kwapulinski.piotr@gmail.com>
 <20160404073100.GA10272@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58745 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbcDDP0t (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 4 Apr 2016 11:26:49 -0400
In-Reply-To: <20160404073100.GA10272@dhcp22.suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>, Piotr Kwapulinski <kwapulinski.piotr@gmail.com>
Cc: akpm@linux-foundation.org, mtk.manpages@gmail.com, cmetcalf@mellanox.com, arnd@arndb.de, viro@zeniv.linux.org.uk, mszeredi@suse.cz, dave@stgolabs.net, kirill.shutemov@linux.intel.com, mingo@kernel.org, dan.j.williams@intel.com, dave.hansen@linux.intel.com, koct9i@gmail.com, hannes@cmpxchg.org, jack@suse.cz, xiexiuqi@huawei.com, iamjoonsoo.kim@lge.com, oleg@redhat.com, gang.chen.5i5j@gmail.com, aarcange@redhat.com, aryabinin@virtuozzo.com, rientjes@google.com, denc716@gmail.com, toshi.kani@hpe.com, ldufour@linux.vnet.ibm.com, kuleshovmail@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org

On 04/04/2016 09:31 AM, Michal Hocko wrote:
> On Sat 02-04-16 21:17:31, Piotr Kwapulinski wrote:
>> Currently the mmap(MAP_FIXED) discards the overlapping part of the
>> existing VMA(s).
>> Introduce the new MAP_DONTUNMAP flag which forces the mmap to fail
>> with ENOMEM whenever the overlapping occurs and MAP_FIXED is set.
>> No existing mapping(s) is discarded.
>
> You forgot to tell us what is the use case for this new flag.

Exactly. Also, returning ENOMEM is strange, EINVAL might be a better 
match, otherwise how would you distinguish a "geunine" ENOMEM from 
passing a wrong address?
