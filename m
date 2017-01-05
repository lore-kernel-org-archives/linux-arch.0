From: Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: [RFC PATCH v3] sparc64: Add support for Application Data
 Integrity (ADI)
Date: Wed, 4 Jan 2017 17:26:08 -0700
Message-ID: <92d55a69-b400-8461-53a1-d505de089700@oracle.com>
References: <1483569999-13543-1-git-send-email-khalid.aziz@oracle.com>
 <6fcaab9f-40fb-fdfb-2c7e-bf21a862ab7c@linux.intel.com>
 <ae0b7d0b-54fa-fa93-3b50-d14ace1b16f5@oracle.com>
 <d234fb8b-965f-d966-46fe-965478fdf7cb@linux.intel.com>
 <8612e7db-97c5-f757-0aae-24c3acedbc29@oracle.com>
 <2c0502d0-20ef-44ac-db5b-7f651a70b978@linux.intel.com>
 <ba9c4de2-cec1-1c88-82c9-24a524eb7948@oracle.com>
 <db31d324-a1ae-7450-0e54-ad98da205773@linux.intel.com>
 <5a0270ea-b29a-0751-a27f-2412a8588561@oracle.com>
 <7532a1d6-6562-b10b-dacd-931cb2a9e536@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <7532a1d6-6562-b10b-dacd-931cb2a9e536@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: Dave Hansen <dave.hansen@linux.intel.com>, Rob Gardner <rob.gardner@oracle.com>, davem@davemloft.net, corbet@lwn.net, arnd@arndb.de, akpm@linux-foundation.org
Cc: hpa@zytor.com, viro@zeniv.linux.org.uk, nitin.m.gupta@oracle.com, chris.hyser@oracle.com, tushar.n.dave@oracle.com, sowmini.varadhan@oracle.com, mike.kravetz@oracle.com, adam.buchbinder@gmail.com, minchan@kernel.org, hughd@google.com, kirill.shutemov@linux.intel.com, keescook@chromium.org, allen.pais@oracle.com, aryabinin@virtuozzo.com, atish.patra@oracle.com, joe@perches.com, pmladek@suse.com, jslaby@suse.cz, cmetcalf@mellanox.com, paul.gortmaker@windriver.com, mhocko@suse.com, jmarchan@redhat.com, lstoakes@gmail.com, 0x7f454c46@gmail.com, vbabka@suse.cz, tglx@linutronix.de, mingo@redhat.com, dan.j.williams@intel.com, iamjoonsoo.kim@lge.com, mgorman@techsingularity.net, vdavydov.dev@gmail.com, hannes@cmpxchg.org, namit@vmware.com, linux-doc@vger.kernel.org, linux-kernel@vger.kerne
List-Id: linux-arch.vger.kernel.org

On 01/04/2017 05:14 PM, Dave Hansen wrote:
> On 01/04/2017 04:05 PM, Rob Gardner wrote:
>>> What if two different small pages have different tags and khugepaged
>>> comes along and tries to collapse them?  Will the page be split if a
>>> user attempts to set two different tags inside two different small-page
>>> portions of a single THP?
>>
>> The MCD tags operate at a resolution of cache lines (64 bytes). Page
>> sizes don't matter except that each virtual page must have a bit set in
>> its TTE to allow MCD to be enabled on the page. Any page can have many
>> different tags, one for each cache line.
>
> Is an "MCD tag" the same thing as a "ADI version tag"?
>
> The thing that confused me here is that we're taking an entire page of
> "ADI version tags" and stuffing them into a swap pte (in
> set_swp_pte_at()).  Do we somehow have enough space in a swap pte on
> sparc to fit PAGE_SIZE/64 "ADI version tag"s in there?

No, we do not have space to stuff PAGE_SIZE/64 version tags in swap pte. 
There is enough space for just one tag per page. DaveM had suggested 
doing this since the usual case is for a task to set one tag per page 
even though MMU does not require it. I have implemented this as first 
pass to start a discussion and get feedback on whether rest of the 
swapping implementation and other changes look right, hence the patch is 
"RFC". If this all looks good, I can expand swapping support in a 
subsequent patch or iteration of this patch to allocate space in 
mm_context_t possibly to store per cacheline tags. I am open to any 
other ideas on storing this larger number of version tags.

Thanks,
Khalid

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
