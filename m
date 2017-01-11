From: Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 0/4] Application Data Integrity feature introduced by
 SPARC M7
Date: Wed, 11 Jan 2017 10:13:54 -0800
Message-ID: <11d20dac-2c0f-6e9a-7f98-3839c749adb6@linux.intel.com>
References: <cover.1483999591.git.khalid.aziz@oracle.com>
 <621cfed0-3e56-13e6-689a-0637bce164fe@linux.intel.com>
 <f70cd704-f486-ed5c-7961-b71278fc8f9a@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:64433 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932818AbdAKSN6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Jan 2017 13:13:58 -0500
In-Reply-To: <f70cd704-f486-ed5c-7961-b71278fc8f9a@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Khalid Aziz <khalid.aziz@oracle.com>, davem@davemloft.net, corbet@lwn.net, arnd@arndb.de, akpm@linux-foundation.org
Cc: hpa@zytor.com, viro@zeniv.linux.org.uk, nitin.m.gupta@oracle.com, chris.hyser@oracle.com, tushar.n.dave@oracle.com, sowmini.varadhan@oracle.com, mike.kravetz@oracle.com, adam.buchbinder@gmail.com, minchan@kernel.org, hughd@google.com, kirill.shutemov@linux.intel.com, keescook@chromium.org, allen.pais@oracle.com, aryabinin@virtuozzo.com, atish.patra@oracle.com, joe@perches.com, pmladek@suse.com, jslaby@suse.cz, cmetcalf@mellanox.com, paul.gortmaker@windriver.com, mhocko@suse.com, jmarchan@redhat.com, lstoakes@gmail.com, 0x7f454c46@gmail.com, vbabka@suse.cz, tglx@linutronix.de, mingo@redhat.com, dan.j.williams@intel.com, iamjoonsoo.kim@lge.com, mgorman@techsingularity.net, vdavydov.dev@gmail.com, hannes@cmpxchg.org, namit@vmware.com, linux-doc@vger.kernel.org, linux-kernel@vger.kerne

On 01/11/2017 08:56 AM, Khalid Aziz wrote:
> On 01/11/2017 09:33 AM, Dave Hansen wrote:
>> On 01/11/2017 08:12 AM, Khalid Aziz wrote:
>>> A userspace task enables ADI through mprotect(). This patch series adds
>>> a page protection bit PROT_ADI and a corresponding VMA flag
>>> VM_SPARC_ADI. VM_SPARC_ADI is used to trigger setting TTE.mcd bit in the
>>> sparc pte that enables ADI checking on the corresponding page.
>>
>> Is there a cost in the hardware associated with doing this "ADI
>> checking"?  For instance, instead of having this new mprotect()
>> interface, why not just always set TTE.mcd on all PTEs?
> 
> There is no performance penalty in the MMU to check tags, but if
> PSTATE.mcd bit is set and TTE.mcde is set, the tag in VA must match what
> was set on the physical page for all memory accesses.

OK, then I'm misunderstanding the architecture again.

For memory shared by two different processes, do they have to agree on
what the tags are, or can they differ?

> Potential for side
> effects is too high in such case and would require kernel to either
> track tags for every page as they are re-allocated or migrated, or scrub
> pages constantly to ensure we do not get spurious tag mismatches. Unless
> there is a very strong reason to blindly set TTE.mcd on every PTE, I
> think the risk of instability is too high without lot of extra code.

Ahh, ok.  That makes sense.  Clearing the tags is expensive.  We must
either clear tags or know the previous tags of the memory before we
access it.

Are any of the tags special?  Do any of them mean "don't do any
checking", or similar?
