Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:49122 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbcCGVLq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Mar 2016 16:11:46 -0500
Subject: Re: [PATCH v2] sparc64: Add support for Application Data Integrity
 (ADI)
References: <56DDDA31.9090105@oracle.com>
 <CALCETrXXU0fs2ezq+Wn_kr4dZTO=0RJmt6b=XBSA-wM7W_9j9A@mail.gmail.com>
 <56DDE783.8090009@oracle.com>
 <20160307.155810.587016604208120674.davem@davemloft.net>
From: Khalid Aziz <khalid.aziz@oracle.com>
Message-ID: <56DDEE17.5030401@oracle.com>
Date: Mon, 7 Mar 2016 14:09:43 -0700
MIME-Version: 1.0
In-Reply-To: <20160307.155810.587016604208120674.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: luto@amacapital.net, corbet@lwn.net, akpm@linux-foundation.org, dingel@linux.vnet.ibm.com, bob.picco@oracle.com, kirill.shutemov@linux.intel.com, aneesh.kumar@linux.vnet.ibm.com, aarcange@redhat.com, arnd@arndb.de, sparclinux@vger.kernel.org, rob.gardner@oracle.com, mhocko@suse.cz, chris.hyser@oracle.com, richard@nod.at, vbabka@suse.cz, koct9i@gmail.com, oleg@redhat.com, gthelen@google.com, jack@suse.cz, xiexiuqi@huawei.com, Vineet.Gupta1@synopsys.com, luto@kernel.org, ebiederm@xmission.com, bsegall@google.com, geert@linux-m68k.org, dave@stgolabs.net, adobriyan@gmail.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20160307210943.OvfpYRAbDJKhXOYZ-qj01CCya6ZtIquw7dZhUqH_WLo@z>

On 03/07/2016 01:58 PM, David Miller wrote:
> From: Khalid Aziz <khalid.aziz@oracle.com>
> Date: Mon, 7 Mar 2016 13:41:39 -0700
>
>> Shared data may not always be backed by a file. My understanding is
>> one of the use cases is for in-memory databases. This shared space
>> could also be used to hand off transactions in flight to other
>> processes. These transactions in flight would not be backed by a
>> file. Some of these use cases might not use shmfs even. Setting ADI
>> bits at virtual address level catches all these cases since what backs
>> the tagged virtual address can be anything - a mapped file, mmio
>> space, just plain chunk of memory.
>
> Frankly the most interesting use case to me is simply finding bugs
> and memory scribbles, and for that we're want to be able to ADI
> arbitrary memory returned from malloc() and friends.
>
> I personally see ADI more as a debugging than a security feature,
> but that's just my view.
>

I think that is a very strong use case. It can be a very effective tool 
for debugging especially when it comes to catching wild writes.

--
Khalid
