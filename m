From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Subject: Re: mmap hw behavior
Date: Wed, 08 Jul 2009 11:06:24 -0700 (PDT)
Message-ID: <20090708.110624.104984745.davem@davemloft.net>
References: <4A54D14F.9090101@petalogix.com>
	<20090708.103520.193697491.davem@davemloft.net>
	<4A54DF6F.1010405@petalogix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ltp-list-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4A54DF6F.1010405-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ltp-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ltp-list-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: michal.simek-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ltp-list-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org, mingo-X9Un+BFzKDI@public.gmane.org
List-Id: linux-arch.vger.kernel.org

From: Michal Simek <michal.simek-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org>
Date: Wed, 08 Jul 2009 20:03:27 +0200

> David Miller wrote:
>> From: Michal Simek <michal.simek-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org>
>> Date: Wed, 08 Jul 2009 19:03:11 +0200
>>
>>   
>>> When I call mmap for that open file with pointer to calloc place
>>> (first parameter, + length zero) it should be one tlb invalidation
>>> for calloc and new tlb which connect open file.  We check it and we
>>> don't have any tlb invalidation that's why I think that kernel do
>>> different thigs.  Or is it there any copying? Or anything different?
>>>     
>>
>> There is no need to tlb flush the calloc area unless that memory area
>> is actually touched by the user application and thus the page is
>> faulted in.
>>   
> That calloc area is filled by any value (in that test). Is it mean that
> for this case when calloc area is touched
> there must be tlb invalidation + remapping?

Yes, if the calloc area is written to by the application, there
should be a tlb flush when the mmap() overrides that virtual region
with a different mapping.

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
