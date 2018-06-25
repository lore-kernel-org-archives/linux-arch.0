From: Michal Hocko <mhocko@kernel.org>
Subject: why do we still need bootmem allocator?
Date: Mon, 25 Jun 2018 16:07:54 +0200
Message-ID: <20180625140754.GB29102@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mm@kvack.org
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi,
I am wondering why do we still keep mm/bootmem.c when most architectures
already moved to nobootmem. Is there any fundamental reason why others
cannot or this is just a matter of work? Btw. what really needs to be
done? Btw. is there any documentation telling us what needs to be done
in that regards?
-- 
Michal Hocko
SUSE Labs
