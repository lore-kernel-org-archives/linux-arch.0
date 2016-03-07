Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:53297 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607AbcCGTWv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Mar 2016 14:22:51 -0500
Date: Mon, 07 Mar 2016 14:22:45 -0500 (EST)
Message-ID: <20160307.142245.846579748692522977.davem@davemloft.net>
Subject: Re: [PATCH v2] sparc64: Add support for Application Data Integrity
 (ADI)
From: David Miller <davem@davemloft.net>
In-Reply-To: <CALCETrVNM7ZcN7WnmLRMDqGrcYXn9xYWJfjMVwFLdiQS63-TcA@mail.gmail.com>
References: <56DDC47C.8010206@linux.intel.com>
	<56DDCAD3.3090106@oracle.com>
	<CALCETrVNM7ZcN7WnmLRMDqGrcYXn9xYWJfjMVwFLdiQS63-TcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: luto@amacapital.net
Cc: khalid.aziz@oracle.com, dave.hansen@linux.intel.com, rob.gardner@oracle.com, corbet@lwn.net, akpm@linux-foundation.org, dingel@linux.vnet.ibm.com, bob.picco@oracle.com, kirill.shutemov@linux.intel.com, aneesh.kumar@linux.vnet.ibm.com, aarcange@redhat.com, arnd@arndb.de, sparclinux@vger.kernel.org, mhocko@suse.cz, chris.hyser@oracle.com, richard@nod.at, vbabka@suse.cz, koct9i@gmail.com, oleg@redhat.com, gthelen@google.com, jack@suse.cz, xiexiuqi@huawei.com, Vineet.Gupta1@synopsys.com, luto@kernel.org, ebiederm@xmission.com, bsegall@google.com, geert@linux-m68k.org, dave@stgolabs.net, adobriyan@gmail.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20160307192245.lj1_mNOH9VI-AFtdO4zoKd3A4_lrwO-jSt8MDUir0Yk@z>

From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 7 Mar 2016 10:53:23 -0800

> x86 has an upcoming feature called protection keys.  A page of virtual
> memory has a protection key, which is a number from 0 through 16.  The
> master copy is in the PTE, i.e. page table entry, which is a
> software-managed data structure in memory and is exactly the thing
> that Linux calls "pte".  The processor can cache that value in the TLB
> (translation lookaside buffer), which is a hardware cache that caches
> PTEs.  On access to a page of virtual memory, the processor does a
> certain calculation involving a new register called PKRU and the
> protection key and may deny access.

ADI is similar, except the "keys" (or "tags") are stored externally
rather than in the PTEs.  A bit in the PTE is used to enable tag match
checking.

The tags live in an external table, which is populated by ASI store
instructions.  The location of the table is implementation specific,
it could be hypervisor or CPU managed, but if stored in memory it is
to a region of memory accessible only to the hypervisor at best.

Khalid, maybe you should share notes with the folks working on x86
protection keys.
