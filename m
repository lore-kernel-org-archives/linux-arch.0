From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/3] mm: optimise pte dirty/accessed bit setting by demand
 based pte insertion
Date: Wed, 5 Sep 2018 17:36:18 -0700
Message-ID: <c4ca50a2-5f85-84bb-65e7-79621f5b4c0a@roeck-us.net>
References: <20180828112034.30875-1-npiggin@gmail.com>
 <20180828112034.30875-4-npiggin@gmail.com>
 <20180905142951.GA15680@roeck-us.net>
 <20180906081802.210984d7@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180906081802.210984d7@roar.ozlabs.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
List-Id: linux-arch.vger.kernel.org

On 09/05/2018 03:18 PM, Nicholas Piggin wrote:
> On Wed, 5 Sep 2018 07:29:51 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> Hi,
>>
>> On Tue, Aug 28, 2018 at 09:20:34PM +1000, Nicholas Piggin wrote:
>>> Similarly to the previous patch, this tries to optimise dirty/accessed
>>> bits in ptes to avoid access costs of hardware setting them.
>>>    
>>
>> This patch results in silent nios2 boot failures, silent meaning that
>> the boot stalls.
>>
>> ...
>> Unpacking initramfs...
>> Freeing initrd memory: 2168K
>> workingset: timestamp_bits=30 max_order=15 bucket_order=0
>> jffs2: version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
>> random: fast init done
>> random: crng init done
>>
>> [no further activity until the qemu session is aborted]
>>
>> Reverting the patch fixes the problem. Bisect log is attached.
> 
> Thanks for bisecting it, I'll try to reproduce. Just qemu with no
> obscure options? Interesting that it's hit nios2 but apparently not
> other archs (yet).
> 

Nothing special. See https://github.com/groeck/linux-build-test/tree/master/rootfs/nios2/.

Guenter
