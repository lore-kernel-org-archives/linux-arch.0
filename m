Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:33960 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937101AbdAFRCK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jan 2017 12:02:10 -0500
Date: Fri, 06 Jan 2017 12:02:04 -0500 (EST)
Message-ID: <20170106.120204.927644401352332269.davem@davemloft.net>
Subject: Re: [RFC PATCH v3] sparc64: Add support for Application Data
 Integrity (ADI)
From: David Miller <davem@davemloft.net>
In-Reply-To: <b761e7a9-6f64-e8cb-334a-a49528e95cdf@linux.intel.com>
References: <f33f2c3c-4ec5-423c-5d13-a4b9ab8f7a95@linux.intel.com>
        <cae91a3b-27f2-4008-539e-153d66fc03ae@oracle.com>
        <b761e7a9-6f64-e8cb-334a-a49528e95cdf@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dave.hansen@linux.intel.com
Cc: khalid.aziz@oracle.com, mhocko@kernel.org, rob.gardner@oracle.com, corbet@lwn.net, arnd@arndb.de, akpm@linux-foundation.org, hpa@zytor.com, viro@zeniv.linux.org.uk, nitin.m.gupta@oracle.com, chris.hyser@oracle.com, tushar.n.dave@oracle.com, sowmini.varadhan@oracle.com, mike.kravetz@oracle.com, adam.buchbinder@gmail.com, minchan@kernel.org, hughd@google.com, kirill.shutemov@linux.intel.com, keescook@chromium.org, allen.pais@oracle.com, aryabinin@virtuozzo.com, atish.patra@oracle.com, joe@perches.com, pmladek@suse.com, jslaby@suse.cz, cmetcalf@mellanox.com, paul.gortmaker@windriver.com, jmarchan@redhat.com, lstoakes@gmail.com, 0x7f454c46@gmail.com, vbabka@suse.cz, tglx@linutronix.de, mingo@redhat.com, dan.j.williams@intel.com, iamjoonsoo.kim@lge.com, mgorman@techsingularity.net, vdavydov.dev@gmail.com, hannes@cmpxchg.org, namit@vmware.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org, khalid@gonehiking.org
Message-ID: <20170106170204.wPn1ohOv_4b731iw5R1GtYcsQEgJs5r0IVqLPkBAYcA@z>

From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 6 Jan 2017 08:55:03 -0800

> Actually, that reminds me...  How does your code interface with ksm?  Or
> is there no interaction needed since you're always working on virtual
> addresses?

This reminds me, I consider this feature potentially extremely useful for
kernel debugging.  So I would like to make sure we don't implement anything
in a way which would preclude that in the long term.
