Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54005 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934329AbeFYOH4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Jun 2018 10:07:56 -0400
Date: Mon, 25 Jun 2018 16:07:54 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: why do we still need bootmem allocator?
Message-ID: <20180625140754.GB29102@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20180625140754.46wmNuNf27mwgVj9S5Dnn3BlsWr72QJmFsrQmkv91-I@z>

Hi,
I am wondering why do we still keep mm/bootmem.c when most architectures
already moved to nobootmem. Is there any fundamental reason why others
cannot or this is just a matter of work? Btw. what really needs to be
done? Btw. is there any documentation telling us what needs to be done
in that regards?
-- 
Michal Hocko
SUSE Labs
