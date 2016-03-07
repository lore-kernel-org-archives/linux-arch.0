Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:26999 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494AbcCGTqs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Mar 2016 14:46:48 -0500
Subject: Re: [PATCH v2] sparc64: Add support for Application Data Integrity
 (ADI)
References: <56DDC47C.8010206@linux.intel.com> <56DDCAD3.3090106@oracle.com>
 <CALCETrVNM7ZcN7WnmLRMDqGrcYXn9xYWJfjMVwFLdiQS63-TcA@mail.gmail.com>
 <20160307.142245.846579748692522977.davem@davemloft.net>
From: Khalid Aziz <khalid.aziz@oracle.com>
Message-ID: <56DDDA78.2070106@oracle.com>
Date: Mon, 7 Mar 2016 12:46:00 -0700
MIME-Version: 1.0
In-Reply-To: <20160307.142245.846579748692522977.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>, luto@amacapital.net
Cc: dave.hansen@linux.intel.com, rob.gardner@oracle.com, corbet@lwn.net, akpm@linux-foundation.org, dingel@linux.vnet.ibm.com, bob.picco@oracle.com, kirill.shutemov@linux.intel.com, aneesh.kumar@linux.vnet.ibm.com, aarcange@redhat.com, arnd@arndb.de, sparclinux@vger.kernel.org, mhocko@suse.cz, chris.hyser@oracle.com, richard@nod.at, vbabka@suse.cz, koct9i@gmail.com, oleg@redhat.com, gthelen@google.com, jack@suse.cz, xiexiuqi@huawei.com, Vineet.Gupta1@synopsys.com, luto@kernel.org, ebiederm@xmission.com, bsegall@google.com, geert@linux-m68k.org, dave@stgolabs.net, adobriyan@gmail.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20160307194600.sOS2AP2SicWSSkhh7Pq0RBzvRqpdyJ0ZLPkZ2DvRV7M@z>

On 03/07/2016 12:22 PM, David Miller wrote:
> Khalid, maybe you should share notes with the folks working on x86
> protection keys.
>

Good idea. Sparc ADI feature is indeed similar to x86 protection keys 
sounds like.

Thanks,
Khalid
