From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 0/3] mm/mmap.c: don't unmap the overlapping VMA(s)
Date: Mon, 4 Apr 2016 09:31:01 +0200
Message-ID: <20160404073100.GA10272@dhcp22.suse.cz>
References: <1459624654-7955-1-git-send-email-kwapulinski.piotr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1459624654-7955-1-git-send-email-kwapulinski.piotr@gmail.com>
Sender: owner-linux-mm@kvack.org
To: Piotr Kwapulinski <kwapulinski.piotr@gmail.com>
Cc: akpm@linux-foundation.org, mtk.manpages@gmail.com, cmetcalf@mellanox.com, arnd@arndb.de, viro@zeniv.linux.org.uk, mszeredi@suse.cz, dave@stgolabs.net, kirill.shutemov@linux.intel.com, vbabka@suse.cz, mingo@kernel.org, dan.j.williams@intel.com, dave.hansen@linux.intel.com, koct9i@gmail.com, hannes@cmpxchg.org, jack@suse.cz, xiexiuqi@huawei.com, iamjoonsoo.kim@lge.com, oleg@redhat.com, gang.chen.5i5j@gmail.com, aarcange@redhat.com, aryabinin@virtuozzo.com, rientjes@google.com, denc716@gmail.com, toshi.kani@hpe.com, ldufour@linux.vnet.ibm.com, kuleshovmail@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat 02-04-16 21:17:31, Piotr Kwapulinski wrote:
> Currently the mmap(MAP_FIXED) discards the overlapping part of the
> existing VMA(s).
> Introduce the new MAP_DONTUNMAP flag which forces the mmap to fail
> with ENOMEM whenever the overlapping occurs and MAP_FIXED is set.
> No existing mapping(s) is discarded.

You forgot to tell us what is the use case for this new flag.
-- 
Michal Hocko
SUSE Labs

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
