Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.cyber.ee ([193.40.6.72]:51355 "EHLO mx2.cyber.ee"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1727831AbfDWQuF
 (ORCPT <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Apr 2019 12:50:05 -0400
Subject: Re: DISCONTIGMEM is deprecated
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
 <0100016a461809ed-be5bd8fc-9925-424d-9624-4a325a7a8860-000000@email.amazonses.com>
From: Meelis Roos <mroos@linux.ee>
Message-ID: <25cabb7c-9602-2e09-2fe0-cad3e54595fa@linux.ee>
Date: Tue, 23 Apr 2019 19:49:57 +0300
MIME-Version: 1.0
In-Reply-To: 
 <0100016a461809ed-be5bd8fc-9925-424d-9624-4a325a7a8860-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christopher Lameter <cl@linux.com>
Cc: Mel Gorman <mgorman@techsingularity.net>, Andrew Morton <akpm@linux-foundation.org>, Mikulas Patocka <mpatocka@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-parisc@vger.kernel.org, linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20190423164957.-vAeROUobu8fP3JNcm5V7ODRlN9cu1aU6KxuNCcOov4@z>

>> ia64 (looks complicated ...)
> 
> Well as far as I can tell it was not even used 12 or so years ago on
> Itanium when I worked on that stuff.

My notes tell that on UP ia64 (RX2620), !NUMA was broken with both
SPARSEMEM and DISCONTIGMEM. NUMA+SPARSEMEM or !NUMA worked. Even
NUMA+DISCONTIGMEM worked, that was my config on 2-CPU RX2660.

-- 
Meelis Roos
