Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:40560 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932979AbcCGXOv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Mar 2016 18:14:51 -0500
Subject: Re: [PATCH v2] sparc64: Add support for Application Data Integrity
 (ADI)
References: <56DDC2B6.6020009@oracle.com> <56DDC3EB.8060909@oracle.com>
 <56DDC776.3040003@oracle.com>
 <20160307.141600.1873883635480850431.davem@davemloft.net>
 <56DDF3C4.7070701@oracle.com>
From: Rob Gardner <rob.gardner@oracle.com>
Message-ID: <56DE0AC3.9070503@oracle.com>
Date: Mon, 7 Mar 2016 15:12:03 -0800
MIME-Version: 1.0
In-Reply-To: <56DDF3C4.7070701@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Khalid Aziz <khalid.aziz@oracle.com>, David Miller <davem@davemloft.net>
Cc: corbet@lwn.net, akpm@linux-foundation.org, dingel@linux.vnet.ibm.com, bob.picco@oracle.com, kirill.shutemov@linux.intel.com, aneesh.kumar@linux.vnet.ibm.com, aarcange@redhat.com, arnd@arndb.de, sparclinux@vger.kernel.org, mhocko@suse.cz, chris.hyser@oracle.com, richard@nod.at, vbabka@suse.cz, koct9i@gmail.com, oleg@redhat.com, gthelen@google.com, jack@suse.cz, xiexiuqi@huawei.com, Vineet.Gupta1@synopsys.com, luto@kernel.org, ebiederm@xmission.com, bsegall@google.com, geert@linux-m68k.org, dave@stgolabs.net, adobriyan@gmail.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20160307231203.wgZvU21aE2d9WLB_8AQUO6JyYx3NnUECyNB0cvqcvhU@z>

On 03/07/2016 01:33 PM, Khalid Aziz wrote:
>
> That is a possibility but limited in scope. An address range covered 
> by a single TTE can have large number of tags. Version tags are set on 
> cacheline. In extreme case, one could set a tag for each set of 
> 64-bytes in a page. Also tags are set completely in userspace and no 
> transition occurs to kernel space, so kernel has no idea of what tags 
> have been set.

   ...
> I have not found a way to query the MMU on tags.
>

To query the tag for a cache line, you just read it back with ldxa and 
ASI_MCD_PRIMARY (ie, asi 0x90), basically the same way you stored the 
tag in the first place.

Rob



