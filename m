Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:23019 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751279AbeCNS6l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Mar 2018 14:58:41 -0400
Subject: Re: [PATCH 1/1 v2] x86: pkey-mprotect must allow pkey-0
References: <1521013574-27041-1-git-send-email-linuxram@us.ibm.com>
 <18b155e3-07e9-5a4b-1f95-e1667078438c@intel.com>
 <20180314171448.GA1060@ram.oc3035372033.ibm.com>
 <5027ca9e-63c8-47ab-960d-a9c4466d7075@intel.com>
 <20180314185452.GB1060@ram.oc3035372033.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <3f7c9ee7-46db-723f-177d-7505d0ac1e41@intel.com>
Date: Wed, 14 Mar 2018 11:58:29 -0700
MIME-Version: 1.0
In-Reply-To: <20180314185452.GB1060@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mingo@redhat.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net, arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com
Message-ID: <20180314185829.F9vC18YFrn4Gz3RJk2mLt2cCOvm66APnXW3HUwp8x_E@z>

On 03/14/2018 11:54 AM, Ram Pai wrote:
>>> (e) it bypasses key-permission checks when assigned.
>> I don't think this is necessary.  I think the only rule we *need* is:
>>
>> 	pkey-0 is allocated implicitly at execve() time.  You do not
>> 	need to call pkey_alloc() to allocate it.
> And can be explicitly associated with any address range ?

Yes, it should ideally be available for use just like any other key when
allocated.
