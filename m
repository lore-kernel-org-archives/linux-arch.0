From: Meelis Roos <mroos@linux.ee>
Subject: Re: DISCONTIGMEM is deprecated
Date: Tue, 23 Apr 2019 19:49:57 +0300
Message-ID: <25cabb7c-9602-2e09-2fe0-cad3e54595fa@linux.ee>
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
 <0100016a461809ed-be5bd8fc-9925-424d-9624-4a325a7a8860-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0100016a461809ed-be5bd8fc-9925-424d-9624-4a325a7a8860-000000@email.amazonses.com>
Content-Language: et-EE
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Lameter <cl@linux.com>
Cc: Mel Gorman <mgorman@techsingularity.net>, Andrew Morton <akpm@linux-foundation.org>, Mikulas Patocka <mpatocka@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-parisc@vger.kernel.org, linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

>> ia64 (looks complicated ...)
> 
> Well as far as I can tell it was not even used 12 or so years ago on
> Itanium when I worked on that stuff.

My notes tell that on UP ia64 (RX2620), !NUMA was broken with both
SPARSEMEM and DISCONTIGMEM. NUMA+SPARSEMEM or !NUMA worked. Even
NUMA+DISCONTIGMEM worked, that was my config on 2-CPU RX2660.

-- 
Meelis Roos
