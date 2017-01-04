Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:18053 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbdADXpz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jan 2017 18:45:55 -0500
Subject: Re: [RFC PATCH v3] sparc64: Add support for Application Data
 Integrity (ADI)
References: <1483569999-13543-1-git-send-email-khalid.aziz@oracle.com>
 <6fcaab9f-40fb-fdfb-2c7e-bf21a862ab7c@linux.intel.com>
 <ae0b7d0b-54fa-fa93-3b50-d14ace1b16f5@oracle.com>
 <d234fb8b-965f-d966-46fe-965478fdf7cb@linux.intel.com>
From: Rob Gardner <rob.gardner@oracle.com>
Message-ID: <8612e7db-97c5-f757-0aae-24c3acedbc29@oracle.com>
Date: Wed, 4 Jan 2017 15:44:56 -0800
MIME-Version: 1.0
In-Reply-To: <d234fb8b-965f-d966-46fe-965478fdf7cb@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>, Khalid Aziz <khalid.aziz@oracle.com>, davem@davemloft.net, corbet@lwn.net, arnd@arndb.de, akpm@linux-foundation.org
Cc: hpa@zytor.com, viro@zeniv.linux.org.uk, nitin.m.gupta@oracle.com, chris.hyser@oracle.com, tushar.n.dave@oracle.com, sowmini.varadhan@oracle.com, mike.kravetz@oracle.com, adam.buchbinder@gmail.com, minchan@kernel.org, hughd@google.com, kirill.shutemov@linux.intel.com, keescook@chromium.org, allen.pais@oracle.com, aryabinin@virtuozzo.com, atish.patra@oracle.com, joe@perches.com, pmladek@suse.com, jslaby@suse.cz, cmetcalf@mellanox.com, paul.gortmaker@windriver.com, mhocko@suse.com, jmarchan@redhat.com, lstoakes@gmail.com, 0x7f454c46@gmail.com, vbabka@suse.cz, tglx@linutronix.de, mingo@redhat.com, dan.j.williams@intel.com, iamjoonsoo.kim@lge.com, mgorman@techsingularity.net, vdavydov.dev@gmail.com, hannes@cmpxchg.org, namit@vmware.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org, Khalid Aziz <khalid@gonehiking.org>
Message-ID: <20170104234456.K2zE_oo-ZCpnyL4bgKkO2ji63I6G0WwBPJkgfhB5q3k@z>

On 01/04/2017 03:40 PM, Dave Hansen wrote:
> On 01/04/2017 03:35 PM, Rob Gardner wrote:
>> Tags are not cleared at all when memory is freed, but rather, lazily
>> (and automatically) cleared when memory is allocated.
> What does "allocated" mean in this context?  Physical or virtual? What
> does this do, for instance?

The first time a virtual page is touched by a process after the malloc, 
the kernel does clear_user_page() or something similar, which zeroes the 
memory. At the same time, the memory tags are cleared.

Rob


>
> 	ptr = malloc(PAGE_SIZE);
> 	set_tag(ptr, 14);
> 	madvise(ptr, PAGE_SIZE, MADV_FREE);
> 	printf("tag: %d\n", get_tag(ptr));
> 	free(ptr);
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

