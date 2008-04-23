From: Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
Date: Wed, 23 Apr 2008 10:46:49 -0400
Message-ID: <480F4BD9.8090003@rtr.ca>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-2-git-send-email-jens.axboe@oracle.com> <480E70ED.3030701@rtr.ca> <20080423072432.GX12774@kernel.dk> <480F3CBC.60305@rtr.ca> <20080423135110.GO12774@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755712AbYDWOrD@vger.kernel.org>
In-Reply-To: <20080423135110.GO12774@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@suse.de, torvalds@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

Jens Axboe wrote:
> On Wed, Apr 23 2008, Mark Lord wrote:
>..
>> The second bug, is that for the halt case at least,
>> nobody waits for the other CPU to actually halt
>> before continuing.. so we sometimes enter the shutdown
>> code while other CPUs are still active.
>>
>> This causes some machines to hang at shutdown,
>> unless CPU_HOTPLUG is configured and takes them offline
>> before we get here.
> 
> I'm guessing there's a reason it doesn't pass '1' as the last argument,
> because that would fix that issue?
..

Undoubtedly -- perhaps the called CPU halts, and therefore cannot reply.  :)

But some kind of pre-halt ack, perhaps plus a short delay by the caller
after receipt of the ack, would probably suffice to kill that bug.

But I really haven't studied this code enough to know,
other than that it historically has been a sticky area
to poke around in.

Cheers
 
