Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:13985 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936417AbdAEAEW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 4 Jan 2017 19:04:22 -0500
Subject: Re: [RFC PATCH v3] sparc64: Add support for Application Data
 Integrity (ADI)
References: <1483569999-13543-1-git-send-email-khalid.aziz@oracle.com>
 <6fcaab9f-40fb-fdfb-2c7e-bf21a862ab7c@linux.intel.com>
 <ae0b7d0b-54fa-fa93-3b50-d14ace1b16f5@oracle.com>
 <d234fb8b-965f-d966-46fe-965478fdf7cb@linux.intel.com>
 <8612e7db-97c5-f757-0aae-24c3acedbc29@oracle.com>
 <2c0502d0-20ef-44ac-db5b-7f651a70b978@linux.intel.com>
 <ba9c4de2-cec1-1c88-82c9-24a524eb7948@oracle.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <db31d324-a1ae-7450-0e54-ad98da205773@linux.intel.com>
Date: Wed, 4 Jan 2017 16:01:09 -0800
MIME-Version: 1.0
In-Reply-To: <ba9c4de2-cec1-1c88-82c9-24a524eb7948@oracle.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Khalid Aziz <khalid.aziz@oracle.com>, Rob Gardner <rob.gardner@oracle.com>, davem@davemloft.net, corbet@lwn.net, arnd@arndb.de, akpm@linux-foundation.org
Cc: hpa@zytor.com, viro@zeniv.linux.org.uk, nitin.m.gupta@oracle.com, chris.hyser@oracle.com, tushar.n.dave@oracle.com, sowmini.varadhan@oracle.com, mike.kravetz@oracle.com, adam.buchbinder@gmail.com, minchan@kernel.org, hughd@google.com, kirill.shutemov@linux.intel.com, keescook@chromium.org, allen.pais@oracle.com, aryabinin@virtuozzo.com, atish.patra@oracle.com, joe@perches.com, pmladek@suse.com, jslaby@suse.cz, cmetcalf@mellanox.com, paul.gortmaker@windriver.com, mhocko@suse.com, jmarchan@redhat.com, lstoakes@gmail.com, 0x7f454c46@gmail.com, vbabka@suse.cz, tglx@linutronix.de, mingo@redhat.com, dan.j.williams@intel.com, iamjoonsoo.kim@lge.com, mgorman@techsingularity.net, vdavydov.dev@gmail.com, hannes@cmpxchg.org, namit@vmware.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org, Khalid Aziz <khalid@gonehiking.org>
Message-ID: <20170105000109.fptxOlf0aMdTQ3WYJV3gjZ3lzC2HziUzV6gx46yoSAA@z>

On 01/04/2017 03:58 PM, Khalid Aziz wrote:
>> How does this all work with large pages?
> 
> It works with large pages the same way as normal sized pages. The TTE
> for a large page also will have the mcd bit set in it and tags are set
> and referenced the same way.

But does the user setting the tags need to know what the page size is?

What if two different small pages have different tags and khugepaged
comes along and tries to collapse them?  Will the page be split if a
user attempts to set two different tags inside two different small-page
portions of a single THP?
