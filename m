From: Rob Gardner <rob.gardner@oracle.com>
Subject: Re: [RFC PATCH v3] sparc64: Add support for Application Data
 Integrity (ADI)
Date: Wed, 4 Jan 2017 15:35:13 -0800
Message-ID: <ae0b7d0b-54fa-fa93-3b50-d14ace1b16f5@oracle.com>
References: <1483569999-13543-1-git-send-email-khalid.aziz@oracle.com>
 <6fcaab9f-40fb-fdfb-2c7e-bf21a862ab7c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <6fcaab9f-40fb-fdfb-2c7e-bf21a862ab7c@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: Dave Hansen <dave.hansen@linux.intel.com>, Khalid Aziz <khalid.aziz@oracle.com>, davem@davemloft.net, corbet@lwn.net, arnd@arndb.de, akpm@linux-foundation.org
Cc: hpa@zytor.com, viro@zeniv.linux.org.uk, nitin.m.gupta@oracle.com, chris.hyser@oracle.com, tushar.n.dave@oracle.com, sowmini.varadhan@oracle.com, mike.kravetz@oracle.com, adam.buchbinder@gmail.com, minchan@kernel.org, hughd@google.com, kirill.shutemov@linux.intel.com, keescook@chromium.org, allen.pais@oracle.com, aryabinin@virtuozzo.com, atish.patra@oracle.com, joe@perches.com, pmladek@suse.com, jslaby@suse.cz, cmetcalf@mellanox.com, paul.gortmaker@windriver.com, mhocko@suse.com, jmarchan@redhat.com, lstoakes@gmail.com, 0x7f454c46@gmail.com, vbabka@suse.cz, tglx@linutronix.de, mingo@redhat.com, dan.j.williams@intel.com, iamjoonsoo.kim@lge.com, mgorman@techsingularity.net, vdavydov.dev@gmail.com, hannes@cmpxchg.org, namit@vmware.com, linux-doc@vger.kernel.org, linux-kernel@vger.kerne
List-Id: linux-arch.vger.kernel.org

On 01/04/2017 03:27 PM, Dave Hansen wrote:
> On 01/04/2017 02:46 PM, Khalid Aziz wrote:
>> This patch extends mprotect to enable ADI (TSTATE.mcde), enable/disable
>> MCD (Memory Corruption Detection) on selected memory ranges, enable
>> TTE.mcd in PTEs, return ADI parameters to userspace and save/restore ADI
>> version tags on page swap out/in.
> I'm a bit confused why we need all the mechanics with set_swp_pte_at().
> For pkeys, for instance, all of the PTEs under a given VMA share a pkey.
>   When swapping something in, we just get the pkey out of the VMA and
> populate the PTE.
>
> ADI doesn't seem to have a similar restriction.  The feature is turned
> on or off at a VMA granularity, but we do not (or can enforce that all
> pages under a given VMA must share a tag.
>
> But this leads to an interesting question: is the tag associated with
> the (populated?) pte, or the virtual address?  Can you have tags
> associated with non-present addresses?  What's the mechanism that clears
> the tags at munmap() or MADV_FREE time?
>
> Is the tag storage a precious resource?  Can it be exhausted?


Tags are stored in physical memory, so there is no "tag storage" that 
can be exhausted.

Tags are not cleared at all when memory is freed, but rather, lazily 
(and automatically) cleared when memory is allocated.


Rob

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
