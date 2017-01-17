Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:56302 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbdAQEwY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Jan 2017 23:52:24 -0500
Date: Mon, 16 Jan 2017 23:42:13 -0500 (EST)
Message-ID: <20170116.234213.651609572218128435.davem@davemloft.net>
Subject: Re: [PATCH v4 0/4] Application Data Integrity feature introduced
 by SPARC M7
From: David Miller <davem@davemloft.net>
In-Reply-To: <621cfed0-3e56-13e6-689a-0637bce164fe@linux.intel.com>
References: <cover.1483999591.git.khalid.aziz@oracle.com>
        <621cfed0-3e56-13e6-689a-0637bce164fe@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dave.hansen@linux.intel.com
Cc: khalid.aziz@oracle.com, corbet@lwn.net, arnd@arndb.de, akpm@linux-foundation.org, hpa@zytor.com, viro@zeniv.linux.org.uk, nitin.m.gupta@oracle.com, chris.hyser@oracle.com, tushar.n.dave@oracle.com, sowmini.varadhan@oracle.com, mike.kravetz@oracle.com, adam.buchbinder@gmail.com, minchan@kernel.org, hughd@google.com, kirill.shutemov@linux.intel.com, keescook@chromium.org, allen.pais@oracle.com, aryabinin@virtuozzo.com, atish.patra@oracle.com, joe@perches.com, pmladek@suse.com, jslaby@suse.cz, cmetcalf@mellanox.com, paul.gortmaker@windriver.com, mhocko@suse.com, jmarchan@redhat.com, lstoakes@gmail.com, 0x7f454c46@gmail.com, vbabka@suse.cz, tglx@linutronix.de, mingo@redhat.com, dan.j.williams@intel.com, iamjoonsoo.kim@lge.com, mgorman@techsingularity.net, vdavydov.dev@gmail.com, hannes@cmpxchg.org, namit@vmware.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org
Message-ID: <20170117044213.amfZfFlK39lbB0XM59sPDTF_wkjq42bGzU6g8DGT3DI@z>

From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 11 Jan 2017 08:33:30 -0800

> Is there a cost in the hardware associated with doing this "ADI
> checking"?  For instance, instead of having this new mprotect()
> interface, why not just always set TTE.mcd on all PTEs?

If we did this then for every page mapped into userspace we'd have
to explicitly set all of the tags to zero, otherwise we'd get TAG
mismatch exceptions.

That would be like clearing the every mapped anonymous page twice, or
worse.
