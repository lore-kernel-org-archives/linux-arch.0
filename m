From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 06/20] early_res: seperate common memmap func from e820.c
 to fw_memmap.c
Date: Mon, 22 Mar 2010 15:14:18 -0700
Message-ID: <4BA7EBBA.5000103@kernel.org>
References: <4BA6EA62.1030603@kernel.org>	 <20100321.210023.209981130.davem@davemloft.net>	 <4BA6F1F6.3070102@kernel.org>	 <20100321.213350.176660494.davem@davemloft.net>	 <20100322092809.GA20607@elte.hu>	 <20100322113026.GA11526@brick.ozlabs.ibm.com>	 <20100322130530.GC12475@elte.hu> <1269291846.8599.81.camel@pasglop>	 <20100322212013.GB25254@elte.hu> <1269294769.8599.88.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56705 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755517Ab0CVWPd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2010 18:15:33 -0400
In-Reply-To: <1269294769.8599.88.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, tglx@linutronix.de, hpa@zytor.com, jbarnes@virtuousgeek.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 03/22/2010 02:52 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2010-03-22 at 22:20 +0100, Ingo Molnar wrote:
>>
>> So no arguments from me at all about the code quality aspects - i just wanted 
>> to highlight the huge amount of non-trivial work Yinghai has invested into 
>> this already, with little external help, and that if possible it would be nice 
>> to minimize the upsetting of related x86 code if possible. Please help him out 
>> with more specific suggestions about how the two memory allocation spaces 
>> could be unified best, to serve the needs of all these architectures - if you 
>> have some spare time. 
> 
> Why not start by unifying the APIs to it, while keeping the
> implementation in the arch for now ? That would be a good first step and
> would give us a good idea of what kind of requirements all the archs
> have since to some extent those requirements need to be represented in
> this API.


current early_res has

reserve/free/find

and don't have alloc, because it is equal to find + reserve.
all the find related will subtract reserved area already.
   and it use start/end (goal/limit) and it will honor goal.

extern void reserve_early(u64 start, u64 end, char *name);
extern void reserve_early_overlap_ok(u64 start, u64 end, char *name);
extern void free_early(u64 start, u64 end);
void free_early_partial(u64 start, u64 end);
extern void early_res_to_bootmem(u64 start, u64 end);

void reserve_early_without_check(u64 start, u64 end, char *name);
u64 find_early_area(u64 ei_start, u64 ei_last, u64 start, u64 end,
                         u64 size, u64 align);
u64 find_early_area_size(u64 ei_start, u64 ei_last, u64 start,
                         u64 *sizep, u64 align);
u64 find_fw_memmap_area(u64 start, u64 end, u64 size, u64 align);
u64 get_max_mapped(void);
int get_free_all_memory_range(struct range **rangep, int nodeid);
 
lmd has:
reserve/free/alloc
and it does have lmb_find, but that doesn't subtract reserved area.

also lmb_alloc doesn't take goal. and only have limit there.


YH
